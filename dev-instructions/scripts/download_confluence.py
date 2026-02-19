import os
import sys
import argparse
import datetime
import hashlib
import re
import json
from urllib.parse import urlparse
from pathlib import Path
from typing import Dict, Any, Optional

import requests


def _get_env_timeout(default: float = 15.0) -> float:
    """Parse CONFLUENCE_HTTP_TIMEOUT from environment, returning default on error."""
    # value = os.environ.get("CONFLUENCE_HTTP_TIMEOUT")
    # Try to get timeout from user config, else use default
    from os.path import expanduser
    import json
    user_config_path = os.path.join(expanduser('~'), '.ai-agile', 'ai-agile.json')
    value = None
    try:
        with open(user_config_path, 'r', encoding='utf-8') as f:
            user_config = json.load(f)
            value = user_config.get('confluence', {}).get('timeout')
    except Exception:
        value = None
    if value is None:
        return default
    try:
        return float(value)
    except Exception:
        return default


DEFAULT_TIMEOUT = _get_env_timeout(15.0)
REQUEST_TIMEOUT = DEFAULT_TIMEOUT


def _safe_get(dct: Dict[str, Any], path: list, default: Any = None) -> Any:
    cur: Any = dct
    for key in path:
        if not isinstance(cur, dict):
            return default
        cur = cur.get(key)
    return cur if cur is not None else default


def _normalize_base_url(base_url: str) -> str:
    return (base_url or "").strip().rstrip("/").lower()


def _iter_user_config_candidates() -> list[Path]:
    """Return candidate locations for a user-home ai-agile.json.

    Order:
    1) AI_AGILE_USER_CONFIG (explicit)
    2) ~/.ai-agile/ai-agile.json
    3) ~/ai-agile.json
    4) %APPDATA%/ai-agile/ai-agile.json (Windows)
    """
    out: list[Path] = []
    explicit = None  # No longer using environment variable; set to None
    if explicit:
        out.append(Path(explicit).expanduser())

    home = Path.home()
    out.append(home / ".ai-agile" / "ai-agile.json")
    out.append(home / "ai-agile.json")

    appdata = None  # No longer using APPDATA for config discovery
    if appdata:
        out.append(Path(appdata) / "ai-agile" / "ai-agile.json")

    seen: set[str] = set()
    deduped: list[Path] = []
    for p in out:
        key = str(p)
        if key in seen:
            continue
        seen.add(key)
        deduped.append(p)
    return deduped


def _load_json(path: Path) -> Dict[str, Any]:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        raise RuntimeError(f"Invalid JSON in {path}: {e}") from e


def _load_user_config() -> Dict[str, Any]:
    for p in _iter_user_config_candidates():
        try:
            if p.exists() and p.is_file():
                return _load_json(p)
        except Exception:
            continue
    return {}


def _extract_confluence_base_url_and_page_id(page_url: str) -> tuple[str, str]:
    parsed = urlparse(page_url)
    if not parsed.scheme or not parsed.netloc:
        raise ValueError(f"Invalid Confluence page URL (missing scheme/host): {page_url}")

    base_url = f"{parsed.scheme}://{parsed.netloc}".rstrip("/")

    # Typical Confluence Cloud URL: /wiki/spaces/<spaceKey>/pages/<pageId>
    m = re.search(r"/pages/(?P<id>\d+)", parsed.path)
    if not m:
        raise ValueError(f"Could not parse pageId from URL path: {parsed.path}")
    page_id = m.group("id")

    return base_url, page_id


def _get_site_creds(user_cfg: Dict[str, Any], base_url: str) -> tuple[str, str]:
    """Return (email, token) for a site baseUrl from user-home secrets."""
    want = _normalize_base_url(base_url)
    sites = _safe_get(user_cfg, ["secrets", "confluence", "sites"], [])
    if isinstance(sites, list):
        for site in sites:
            if not isinstance(site, dict):
                continue
            site_base = site.get("baseUrl")
            if isinstance(site_base, str) and _normalize_base_url(site_base) == want:
                email = site.get("email")
                token = site.get("token")
                if isinstance(email, str) and email.strip() and isinstance(token, str) and token.strip():
                    return email.strip(), token.strip()

    # Fallback: environment variables for single-site use
    # Read from ~/.ai-agile/ai-agile.json instead of environment variables
    from os.path import expanduser
    import json
    user_config_path = os.path.join(expanduser('~'), '.ai-agile', 'ai-agile.json')
    with open(user_config_path, 'r', encoding='utf-8') as f:
        user_config = json.load(f)
    env_base = user_config.get('confluence', {}).get('baseUrl')
    env_email = user_config.get('confluence', {}).get('email')
    env_token = user_config.get('confluence', {}).get('token')
    if env_base and _normalize_base_url(env_base) == want and env_email and env_token:
        return env_email.strip(), env_token.strip()

    raise RuntimeError(
        f"No Confluence credentials found for {base_url}. "
        "Add an entry to user-home ai-agile.json secrets.confluence.sites[] or set BASE_URL/CONF_EMAIL/CONF_TOKEN."
    )

def redact_headers_for_debug(headers: Dict[str, str]) -> Dict[str, str]:
    """Return a copy of headers with secrets masked for debug logging."""
    redacted = dict(headers or {})
    auth = redacted.get("Authorization")
    if auth:
        try:
            scheme, _val = auth.split(" ", 1)
            redacted["Authorization"] = f"{scheme} [REDACTED]"
        except Exception:
            redacted["Authorization"] = "[REDACTED]"
    return redacted

def load_env(env_path: Path) -> Dict[str, str]:
    """
    Load Confluence credentials from .ai-agile/ai-agile.json in the user's home directory.
    Returns a dictionary of key-value pairs.
    """
    env = {}
    if env_path.exists():
        for line in env_path.read_text().splitlines():
            if line.strip().startswith("#") or "=" not in line:
                continue
            k, v = line.split("=", 1)
            env[k.strip()] = v.strip()
    return env

def load_config(config_path: Path) -> Dict[str, str]:
    """
    Load configuration from a confluence.config file.
    Returns a dictionary of key-value pairs.
    """
    config = {}
    if config_path.exists():
        for line in config_path.read_text().splitlines():
            if line.strip().startswith("#") or "=" not in line:
                continue
            k, v = line.split("=", 1)
            config[k.strip()] = v.strip()
    return config

def get_auth_header(email: str, token: str) -> Dict[str, str]:
    """
    Create HTTP headers for Basic Auth using email and API token.
    Returns a dictionary suitable for requests headers.
    """
    import base64
    pair = f"{email}:{token}"
    b64 = base64.b64encode(pair.encode()).decode()
    return {"Authorization": f"Basic {b64}", "Accept": "application/json"}


def get_page(base_url: str, page_id: str, headers: Dict[str, str]) -> Any:
    """
    Fetch a Confluence page by ID using the REST API.
    Returns the page JSON object.
    """
    url = f"{base_url}/wiki/rest/api/content/{page_id}?expand=body.storage,version,ancestors,space"
    if hasattr(get_page, 'verbose') and get_page.verbose:
        print(f"[DEBUG] GET PAGE URL: {url}")
        print(f"[DEBUG] HEADERS: {redact_headers_for_debug(headers)}")
    resp = requests.get(url, headers=headers, timeout=REQUEST_TIMEOUT)
    resp.raise_for_status()
    return resp.json()

def _add_linebreaks_after_tags(xhtml: str, newline: str = "\n") -> str:
    """Insert line breaks after select closing HTML tags to improve readability.
    Does not alter semantics; operates purely on text formatting.

    Tags targeted: p, li, tr, td, th, h1-h6, pre, blockquote.
    """
    if not xhtml:
        return xhtml
    # Match closing tags (case-insensitive)
    pattern = re.compile(r"(</(?:p|li|tr|td|th|h[1-6]|pre|blockquote|div|table)>)", re.IGNORECASE)
    return pattern.sub(r"\1" + newline, xhtml)

def get_attachments(base_url: str, page_id: str, headers: Dict[str, str]) -> list:
    """
    Fetch all attachments for a Confluence page by ID.
    Returns a list of attachment JSON objects.
    """
    url = f"{base_url}/wiki/rest/api/content/{page_id}/child/attachment?limit=100"
    if hasattr(get_attachments, 'verbose') and get_attachments.verbose:
        print(f"[DEBUG] GET ATTACHMENTS URL: {url}")
        print(f"[DEBUG] HEADERS: {redact_headers_for_debug(headers)}")
    resp = requests.get(url, headers=headers, timeout=REQUEST_TIMEOUT)
    resp.raise_for_status()
    return resp.json().get("results", [])

def get_children(base_url: str, page_id: str, headers: Dict[str, str]) -> Any:
    """
    Fetch all child pages for a Confluence page by ID.
    Returns a list of child page JSON objects.
    """
    url = f"{base_url}/wiki/rest/api/content/{page_id}/child/page?limit=100"
    if hasattr(get_children, 'verbose') and get_children.verbose:
        print(f"[DEBUG] GET CHILDREN URL: {url}")
        print(f"[DEBUG] HEADERS: {redact_headers_for_debug(headers)}")
    resp = requests.get(url, headers=headers, timeout=REQUEST_TIMEOUT)
    resp.raise_for_status()
    return resp.json().get("results", [])


def save_page(page: Dict[str, Any], out_dir: Path, base_url: str, headers: Dict[str, str], verbose: bool = False, attachments: list = None, download_attachments: bool = True, linebreak_mode: str = "none"):
    """
    Save a Confluence page as an .xhtml file with front-matter metadata.
    Optionally download attachments and images to the output directory.
    """
    title = page.get("title", "untitled")
    page_id = page.get("id")
    xhtml = page.get("body", {}).get("storage", {}).get("value", "")
    version = page.get("version", {}).get("number", "")
    space = page.get("space", {}).get("key", "")
    # Sanitize title: replace invalid chars, trim, limit length
    safe_title = re.sub(r'[\\/:*?"<>|]', '-', title).strip()
    if len(safe_title) > 120:
        safe_title = safe_title[:120]
    file_name = f"{space}-{page_id}-{safe_title}.xhtml"
    file_path = out_dir / file_name

    # Download attachments if enabled
    if download_attachments and attachments:
        for att in attachments:
            att_title = att.get('title', 'attachment')
            att_id = att.get('id', '')
            att_ext = Path(att_title).suffix or ''
            att_safe_title = re.sub(r'[\\/:*?"<>|]', '-', att_title).strip()
            if len(att_safe_title) > 120:
                att_safe_title = att_safe_title[:120]
            att_file_name = f"{space}-{page_id}-{att_safe_title}"
            att_file_path = out_dir / att_file_name
            att_url = att.get('_links', {}).get('download')
            if att_url:
                try:
                    # Ensure /wiki is present before /download/attachments
                    if att_url.startswith('/download/'):
                        wiki_base = base_url.rstrip('/') + '/wiki'
                        full_url = wiki_base + att_url
                    else:
                        full_url = base_url.rstrip('/') + att_url
                    if verbose:
                        print(f"[DEBUG] DOWNLOAD ATTACHMENT URL: {full_url}")
                        print(f"[DEBUG] HEADERS: {redact_headers_for_debug(headers)}")
                    resp = requests.get(full_url, headers=headers, timeout=REQUEST_TIMEOUT)
                    resp.raise_for_status()
                    att_file_path.write_bytes(resp.content)
                    if verbose:
                        print(f"Downloaded attachment: {att_file_path}")
                except Exception as e:
                    print(f"Failed to download attachment {att_title}: {e}")

    # Download images (from <ac:image> tags)
    if download_attachments and attachments:
        for img_match in re.findall(r'<ac:image[^>]*>(.*?)</ac:image>', xhtml, re.DOTALL):
            src_match = re.search(r'<ri:attachment ri:filename=\"([^\"]+)\"', img_match)
            if src_match:
                img_filename = src_match.group(1)
                img_safe_title = re.sub(r'[\\/:*?"<>|]', '-', img_filename).strip()
                if len(img_safe_title) > 120:
                    img_safe_title = img_safe_title[:120]
                img_file_name = f"{space}-{page_id}-{img_safe_title}"
                img_file_path = out_dir / img_file_name
                # Try to find the attachment in page attachments
                for att in attachments:
                    if att.get('title') == img_filename:
                        att_url = att.get('_links', {}).get('download')
                        if att_url:
                            try:
                                # Ensure /wiki is present before /download/attachments
                                if att_url.startswith('/download/'):
                                    wiki_base = base_url.rstrip('/') + '/wiki'
                                    full_url = wiki_base + att_url
                                else:
                                    full_url = base_url.rstrip('/') + att_url
                                if verbose:
                                    print(f"[DEBUG] DOWNLOAD IMAGE URL: {full_url}")
                                    print(f"[DEBUG] HEADERS: {redact_headers_for_debug(headers)}")
                                resp = requests.get(full_url, headers=headers, timeout=REQUEST_TIMEOUT)
                                resp.raise_for_status()
                                img_file_path.write_bytes(resp.content)
                                if verbose:
                                    print(f"Downloaded image: {img_file_path}")
                            except Exception as e:
                                print(f"Failed to download image {img_filename}: {e}")

    # Optional formatting for readability (preserve original for hashing/metrics)
    output_xhtml = xhtml
    if linebreak_mode and linebreak_mode.lower() == "tags":
        try:
            output_xhtml = _add_linebreaks_after_tags(output_xhtml)
        except Exception as _fmt_err:
            # Fail-safe: if formatting fails, fall back to original
            output_xhtml = xhtml

    # Source URL
    url = None
    links = page.get('_links') or page.get('links')
    if links:
        if 'webui' in links:
            url = base_url + links['webui']
        elif 'self' in links:
            url = links['self']

    # Retrieved timestamp
    retrieved = datetime.datetime.now().isoformat()
    # Format
    fmt = 'xhtml'
    # Content hash (MD5)
    content_hash = hashlib.md5(xhtml.encode('utf-8')).hexdigest() if xhtml else ''
    # Output hash (MD5) of the saved XHTML including readability line breaks
    output_hash = hashlib.md5(output_xhtml.encode('utf-8')).hexdigest() if output_xhtml else ''

    # Macro counts
    def macro_counts(content):
        import re
        structured_macro = len(re.findall(r'<ac:structured-macro', content))
        image = len(re.findall(r'<ac:image', content))
        link = len(re.findall(r'<ac:link', content))
        return structured_macro, image, link
    macro_structured_macro, macro_image, macro_link = macro_counts(xhtml)

    existing_meta: Dict[str, str] = {}
    if file_path.exists():
        try:
            existing_text = file_path.read_text(encoding="utf-8")
            if existing_text.startswith("---"):
                parts = existing_text.split("---", 2)
                if len(parts) >= 3:
                    for line in parts[1].strip().splitlines():
                        if ":" in line:
                            key, value = line.split(":", 1)
                            existing_meta[key.strip()] = value.strip()
        except Exception as parse_err:
            if verbose:
                print(f"[DEBUG] Failed to parse front matter for {file_path}: {parse_err}")

    if (
        existing_meta.get("output_hash") == output_hash
        and existing_meta.get("content_hash") == content_hash
        and existing_meta.get("version") == str(version)
    ):
        if verbose:
            print(f"No changes detected for {file_path}, skipping write.")
        return

    front_matter = (
        f"---\n"
        f"source: {url}\n"
        f"confluence_id: {page_id}\n"
        f"space: {space}\n"
        f"version: {version}\n"
        f"retrieved: {retrieved}\n"
        f"format: {fmt}\n"
        f"content_hash: {content_hash}\n"
        f"macro_structured_macro: {macro_structured_macro}\n"
        f"macro_image: {macro_image}\n"
        f"macro_link: {macro_link}\n"
        f"output_hash: {output_hash}\n"
        f"---\n"
    )
    file_path.write_text(front_matter + output_xhtml, encoding="utf-8")
    if verbose:
        print(f"Saved: {file_path} (Title: {title})")

def download_tree(base_url: str, root_id: str, headers: Dict[str, str], out_dir: Path, max_depth: int = 5, depth: int = 0, seen=None, download_attachments: bool = True, linebreak_mode: str = "none"):
    """
    Recursively download a Confluence page and its descendants up to max_depth.
    Saves each page and optionally its attachments/images.
    """
    if seen is None:
        seen = set()
    if root_id in seen or depth > max_depth:
        return
    seen.add(root_id)
    # Propagate verbose flag to all functions
    if hasattr(download_tree, 'verbose') and download_tree.verbose:
        get_page.verbose = True
        get_attachments.verbose = True
        get_children.verbose = True
    else:
        get_page.verbose = False
        get_attachments.verbose = False
        get_children.verbose = False
    page = get_page(base_url, root_id, headers)
    attachments = get_attachments(base_url, root_id, headers) if download_attachments else []
    save_page(page, out_dir, base_url, headers, verbose=download_tree.verbose if hasattr(download_tree, 'verbose') else False, attachments=attachments, download_attachments=download_attachments, linebreak_mode=linebreak_mode)
    for child in get_children(base_url, root_id, headers):
        download_tree(base_url, child["id"], headers, out_dir, max_depth, depth + 1, seen, download_attachments=download_attachments, linebreak_mode=linebreak_mode)



def load_ai_agile_json(config_path: Path) -> Dict[str, Any]:
    """Load configuration from ai-agile.json file."""
    if not config_path.exists():
        return {}
    try:
        return json.loads(config_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        raise RuntimeError(f"Invalid JSON in {config_path}: {e}") from e


def _get_confluence_rel_from_ai_agile_json(cfg: Dict[str, Any]) -> str:
    """Return a relative path (from ai-agile root) to the confluence config folder."""
    process = cfg.get("process") if isinstance(cfg, dict) else None
    if isinstance(process, dict):
        steps = process.get("steps")
        if isinstance(steps, dict):
            source_step = steps.get("SourceMaterial")
            if isinstance(source_step, dict):
                subfolders = source_step.get("subfolders")
                if isinstance(subfolders, dict):
                    confluence = subfolders.get("confluence")
                    if isinstance(confluence, str) and confluence.strip():
                        return confluence.strip()
                folder = source_step.get("folder")
                if isinstance(folder, str) and folder.strip():
                    return f"{folder.strip().rstrip('/')}/confluence"

    paths = cfg.get("paths") if isinstance(cfg, dict) else None
    if isinstance(paths, dict):
        source_material = paths.get("source_material")
        if isinstance(source_material, str) and source_material.strip():
            return f"{source_material.strip().rstrip('/')}/confluence"

    return "01_source-material/confluence"

def _find_ai_agile_root(start: Path, max_up: int = 8) -> Optional[Path]:
    """Find the ai-agile root directory (the directory that contains ai-agile.json).
    Handles cases where you're in repo root, dev-instructions/scripts, etc."""
    cur = start
    for _ in range(max_up):
        # Case 1: ai-agile.json in this folder
        if (cur / "ai-agile.json").exists():
            return cur
        # Case 2: ai-agile/ai-agile.json beneath this folder
        if (cur / "ai-agile" / "ai-agile.json").exists():
            return cur / "ai-agile"
        if cur.parent == cur:
            break
        cur = cur.parent
    return None


def main():
    """
    Main entry point: auto-detects config locations so you can run from anywhere
    (including dev-instructions/scripts) without cd'ing manually. Arguments
    allow overrides but are optional.
    """
    cwd = Path.cwd()

    parser = argparse.ArgumentParser(add_help=True)
    # Accept legacy-style -OutDir while also supporting --out-dir
    parser.add_argument('-OutDir', '--out-dir', dest='out_dir', default=None, help='Output directory for downloaded pages')
    parser.add_argument('--ai-agile-root', dest='ai_agile_root', default=os.environ.get('AI_AGILE_ROOT'), help='Path to ai-agile root containing ai-agile.json')
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--attachments', dest='attachments', action='store_true', default=None, help='Enable downloading attachments/images')
    group.add_argument('--no-attachments', dest='attachments', action='store_false', default=None, help='Disable downloading attachments/images')
    parser.add_argument('--verbose', action='store_true', help='Enable verbose debug output')
    parser.add_argument('--linebreaks', dest='linebreaks', choices=['none', 'tags'], default=os.environ.get('LINEBREAKS', 'none'), help='Insert line breaks after select closing tags for readability (default: none)')
    parser.add_argument('--timeout', type=float, default=DEFAULT_TIMEOUT, help='HTTP timeout (seconds) for Confluence requests (default: %(default)s)')
    args = parser.parse_args()

    ai_agile_root: Optional[Path]
    if args.ai_agile_root:
        ai_agile_root = Path(args.ai_agile_root).expanduser().resolve()
    else:
        ai_agile_root = _find_ai_agile_root(cwd)

    if ai_agile_root is None:
        raise RuntimeError("Could not locate ai-agile root. Set AI_AGILE_ROOT or run from within the repository.")

    ai_agile_json_path = ai_agile_root / 'ai-agile.json'
    if not ai_agile_json_path.exists():
        raise RuntimeError(
            f"Expected ai-agile.json at {ai_agile_json_path}, but it was not found. "
            "Run dev-instructions/scripts/initialize.py or create ai-agile/ai-agile.json manually."
        )

    ai_agile_cfg = load_ai_agile_json(ai_agile_json_path)
    confluence_rel = _get_confluence_rel_from_ai_agile_json(ai_agile_cfg)
    confluence_dir = (ai_agile_root / confluence_rel).resolve()
    confluence_dir.mkdir(parents=True, exist_ok=True)

    out_dir = Path(args.out_dir).expanduser().resolve() if args.out_dir else confluence_dir
    out_dir.mkdir(parents=True, exist_ok=True)

    integration = _safe_get(ai_agile_cfg, ["integrations", "confluence"], {})
    pages = _safe_get(integration, ["pages"], {})
    parent_urls = _safe_get(pages, ["parentPageUrls"], [])
    if not isinstance(parent_urls, list) or not parent_urls:
        raise RuntimeError(
            "No Confluence parent pages configured. Set integrations.confluence.pages.parentPageUrls in ai-agile/ai-agile.json."
        )

    max_depth = _safe_get(pages, ["maxDepth"], 50)
    if not isinstance(max_depth, int):
        max_depth = 50

    cfg_include_attachments = _safe_get(integration, ["download", "includeAttachments"], True)
    if args.attachments is None:
        download_attachments = bool(cfg_include_attachments)
    else:
        download_attachments = bool(args.attachments)

    verbose = args.verbose or os.environ.get('VERBOSE', '0') == '1'
    download_tree.verbose = verbose

    global REQUEST_TIMEOUT
    REQUEST_TIMEOUT = max(args.timeout, 0.1)

    user_cfg = _load_user_config()

    # Download each configured parent URL (supports multiple sites)
    for page_url in parent_urls:
        if not isinstance(page_url, str) or not page_url.strip():
            continue
        base_url, page_id = _extract_confluence_base_url_and_page_id(page_url)
        email, token = _get_site_creds(user_cfg, base_url)
        headers = get_auth_header(email, token)

        host = urlparse(page_url).netloc
        site_out_dir = out_dir / host
        site_out_dir.mkdir(parents=True, exist_ok=True)

        # De-dupe across roots per-site
        seen: set[str] = set()
        download_tree(base_url.rstrip('/'), page_id, headers, site_out_dir, max_depth=max_depth, seen=seen, download_attachments=download_attachments, linebreak_mode=args.linebreaks)

if __name__ == "__main__":
        main()
