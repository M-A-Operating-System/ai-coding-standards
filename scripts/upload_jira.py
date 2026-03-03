"""
upload_jira.py

Uploads (creates/updates) JIRA issues from local JSON files if their checksum differs from the remote version.
- Reads JIRA credentials from ~/.ai-agile/ai-agile.json (secrets.jira)
- Reads project config from repo ai-agile/ai-agile.json
- For each local JIRA JSON file in ai-agile/01_source-material/jira/:
    - Fetches the remote issue by key (if exists)
    - Compares checksums (local vs. remote)
    - If different or not found, uploads (creates/updates) the issue
- Uses JIRA REST API v3
"""
import os
import json
import requests
from pathlib import Path

def load_user_config():
    from os.path import expanduser
    user_config_path = os.path.join(expanduser('~'), '.ai-agile', 'ai-agile.json')
    with open(user_config_path, 'r', encoding='utf-8') as f:
        return json.load(f)

def compute_checksum(issue):
    issue_copy = dict(issue)
    issue_copy.pop('checksum', None)
    return __import__('hashlib').sha256(json.dumps(issue_copy, sort_keys=True, separators=(",", ":")).encode('utf-8')).hexdigest()

def fetch_remote_issue(base_url, email, token, issue_key):
    url = f"{base_url}/rest/api/3/issue/{issue_key}"
    auth = (email, token)
    headers = {"Accept": "application/json"}
    resp = requests.get(url, auth=auth, headers=headers)
    if resp.status_code == 404:
        return None
    resp.raise_for_status()
    return resp.json()

def update_remote_issue(base_url, email, token, issue_key, fields):
    url = f"{base_url}/rest/api/3/issue/{issue_key}"
    auth = (email, token)
    headers = {"Accept": "application/json", "Content-Type": "application/json"}
    resp = requests.put(url, auth=auth, headers=headers, data=json.dumps({"fields": fields}))
    resp.raise_for_status()
    return resp.json()

def create_remote_issue(base_url, email, token, fields):
    url = f"{base_url}/rest/api/3/issue"
    auth = (email, token)
    headers = {"Accept": "application/json", "Content-Type": "application/json"}
    resp = requests.post(url, auth=auth, headers=headers, data=json.dumps({"fields": fields}))
    resp.raise_for_status()
    return resp.json()

def main():
    user_config = load_user_config()
    jira_cfg = user_config.get('secrets', {}).get('jira', {})
    email = jira_cfg.get('email')
    token = jira_cfg.get('token')
    base_url = jira_cfg.get('baseUrl')
    if not all([email, token, base_url]):
        raise EnvironmentError("Missing JIRA credentials in ~/.ai-agile/ai-agile.json under 'secrets'.")
    jira_dir = Path('ai-agile/01_source-material/jira')
    for file in jira_dir.glob('*.json'):
        with open(file, 'r', encoding='utf-8') as f:
            local_issue = json.load(f)
        issue_key = local_issue.get('key')
        local_checksum = local_issue.get('checksum')
        if not issue_key or not local_checksum:
            print(f"Skipping {file.name}: missing key or checksum.")
            continue
        print(f"Processing {issue_key}...")
        remote = fetch_remote_issue(base_url, email, token, issue_key)
        remote_checksum = None
        if remote:
            remote_checksum = compute_checksum(remote)
        if not remote:
            print(f"  Issue does not exist remotely. Creating...")
            create_remote_issue(base_url, email, token, local_issue['fields'])
            print(f"  Created {issue_key}.")
        elif local_checksum != remote_checksum:
            print(f"  Checksum differs. Updating...")
            update_remote_issue(base_url, email, token, issue_key, local_issue['fields'])
            print(f"  Updated {issue_key}.")
        else:
            print(f"  No changes for {issue_key}.")

if __name__ == "__main__":
    main()
