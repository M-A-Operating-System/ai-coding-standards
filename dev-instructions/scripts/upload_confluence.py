import os
import re
import json
import hashlib
    if '--help' in sys.argv or '-h' in sys.argv:
        print("""
import requests
from pathlib import Path
from typing import Dict, Any

def load_env(env_path: Path) -> Dict[str, str]:
    env = {}
    if env_path.exists():
        for line in env_path.read_text().splitlines():
            if line.strip().startswith("#") or "=" not in line:
                continue
        return
            k, v = line.split("=", 1)
            env[k.strip()] = v.strip()
    return env

def load_config(config_path: Path) -> Dict[str, str]:
    config = {}
    if config_path.exists():
        for line in config_path.read_text().splitlines():
            if line.strip().startswith("#") or "=" not in line:
                continue
            k, v = line.split("=", 1)
            config[k.strip()] = v.strip()
    return config

def get_auth_header(email: str, token: str) -> Dict[str, str]:
    import base64
    pair = f"{email}:{token}"
    b64 = base64.b64encode(pair.encode()).decode()
    return {"Authorization": f"Basic {b64}", "Accept": "application/json"}

def parse_front_matter(content: str):
    lines = content.splitlines()
    front = {}
    body_start = None
    in_front = False
    for i, line in enumerate(lines):
        if line.strip() == '---':
            if not in_front:
                in_front = True
                continue
            else:
                body_start = i + 1
                break
        if in_front:
            m = re.match(r'([^:]+):\s*(.+)', line)
            if m:
                front[m.group(1).strip()] = m.group(2).strip()
    body = '\n'.join(lines[body_start:]) if body_start is not None else ''
    return front, body

def get_macro_counts(content: str):
    return {
        'structured_macro': len(re.findall(r'<ac:structured-macro', content)),
        'image': len(re.findall(r'<ac:image', content)),
        'link': len(re.findall(r'<ac:link', content)),
    }

def get_string_hash(content: str):
    norm = content.replace('\r\n', '\n').strip()
    return hashlib.md5(norm.encode('utf-8')).hexdigest() if norm else ''

def get_page(base_url: str, page_id: str, headers: Dict[str, str]):
    url = f"{base_url}/wiki/rest/api/content/{page_id}?expand=version"
    resp = requests.get(url, headers=headers)
    resp.raise_for_status()
    return resp.json()

def update_page(base_url: str, page_id: str, title: str, body: str, version: int, headers: Dict[str, str]):
    url = f"{base_url}/wiki/rest/api/content/{page_id}"
    payload = {
        "id": page_id,
        "type": "page",
        "title": title,
        "version": {"number": version},
        "body": {"storage": {"value": body, "representation": "storage"}}
    }
    resp = requests.put(url, headers={**headers, "Content-Type": "application/json; charset=utf-8"}, data=json.dumps(payload))
    resp.raise_for_status()
    return resp.json()

def main():
    import sys
    cwd = Path.cwd()
    env = load_env(cwd / ".env")
    config = load_config(cwd / "confluence.config")
    base_url = config.get("BaseUrl") or env.get("BASE_URL") or os.environ.get("BASE_URL")
    email = env.get("CONF_EMAIL") or os.environ.get("CONF_EMAIL")
    token = env.get("CONF_TOKEN") or os.environ.get("CONF_TOKEN")
    source_dir = sys.argv[1] if len(sys.argv) > 1 else cwd
    dry_run = '--dry-run' in sys.argv

    if not all([base_url, email, token]):
        print("Missing credentials: set BASE_URL, CONF_EMAIL, and CONF_TOKEN via .env or environment.")
        return

    headers = get_auth_header(email, token)
    # Test authentication
    try:
        test_url = f"{base_url}/wiki/rest/api/space?limit=1"
        resp = requests.get(test_url, headers=headers)
        resp.raise_for_status()
        print(f"Authenticated with Confluence at {base_url}.")
    except Exception as e:
        print(f"Confluence auth failed: {e}")
        return

    files = list(Path(source_dir).glob("*.xhtml"))
    if not files:
        print(f"No .xhtml files found in '{source_dir}'. Nothing to upload.")
        return
    print(f"Found {len(files)} file(s) to process.")

    for file in files:
        # Extract space name from filename (assumes format: Space-Id-Title.xhtml)
        fname = file.name
        space_name = None
        m = re.match(r'([^-]+)-[0-9]+-', fname)
        if m:
            space_name = m.group(1)
        print(f"\nProcessing file: {file} (Space: {space_name if space_name else 'Unknown'})")
        content = file.read_text(encoding="utf-8")
        meta, body = parse_front_matter(content)
        if not meta or 'confluence_id' not in meta:
            print(f"Skipping file with no front-matter or confluence_id: {file.name}")
            continue
        # Check for content changes using hash
        if 'content_hash' in meta:
            current_hash = get_string_hash(body)
            if current_hash == meta['content_hash']:
                print("  - No changes detected (content hash matches). Skipping.")
                continue
            print("  - Content has changed (hash mismatch). Proceeding with update.")
        else:
            print("  - No content_hash found in front-matter. Proceeding with update.")
        # Warn if macro counts appear reduced compared to original snapshot
        new_counts = get_macro_counts(body)
        orig_structured = int(meta.get('macro_structured_macro', 0))
        orig_image = int(meta.get('macro_image', 0))
        orig_link = int(meta.get('macro_link', 0))
        if orig_structured > 0 and new_counts['structured_macro'] < orig_structured:
            print(f"  - Structured macro count decreased: {new_counts['structured_macro']} vs original {orig_structured}. Verify no macros were lost.")
        if orig_image > 0 and new_counts['image'] < orig_image:
            print(f"  - Image macro count decreased: {new_counts['image']} vs original {orig_image}.")
        if orig_link > 0 and new_counts['link'] < orig_link:
            print(f"  - Link macro count decreased: {new_counts['link']} vs original {orig_link}.")
        try:
            page_id = meta['confluence_id']
            print(f"  - Found Confluence Page ID: {page_id}")
            current_page = get_page(base_url, page_id, headers)
            current_version = current_page['version']['number']
            new_version = current_version + 1
            print(f"  - Current version: {current_version}. Updating to version: {new_version}.")
            if dry_run:
                print(f"  - [DRY RUN] Would update page '{current_page['title']}' (ID: {page_id}) to version {new_version}.")
            else:
                print(f"  - Updating page '{current_page['title']}' (ID: {page_id})...")
                result = update_page(base_url, page_id, current_page['title'], body, new_version, headers)
                print(f"  - Successfully updated. New version is {result['version']['number']}.")
        except Exception as e:
            print(f"Failed to process file {file.name}. Reason: {e}")
    print("\nUpload process finished.")

if __name__ == "__main__":
    main()
