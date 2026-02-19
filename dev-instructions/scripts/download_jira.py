def fetch_all_field_ids(base_url, email, token, verbose=False):
    url = f"{base_url}/rest/api/3/field"
    auth = (email, token)
    headers = {"Accept": "application/json"}
    if verbose:
        print(f"[VERBOSE] JIRA API URL (fields): {url}")
    response = requests.get(url, auth=auth, headers=headers)
    response.raise_for_status()
    fields = response.json()
    field_ids = [field['id'] for field in fields if 'id' in field]
    if verbose:
        print(f"[VERBOSE] Found {len(field_ids)} field IDs.")
    return field_ids
"""
download_jira.py

Downloads JIRA tickets for configured projects and stores each as a JSON file in the sourceMaterials folder, named Project-ID-Title.json.

- Reads JIRA credentials and project info from .ai-agile/ai-agile.json in the user's home directory
- Fetches tickets for each configured project
- Stores each ticket as a JSON file: <Project>-<ID>-<Title>.json

Follows repository Python standards.
"""

import hashlib
import os
import json
import requests
from pathlib import Path

# User config path (credentials and project info)
from os.path import expanduser
USER_CONFIG_PATH = os.path.join(expanduser('~'), '.ai-agile', 'ai-agile.json')
# Repo config path (for sourceMaterials location)
REPO_CONFIG_PATH = os.path.join(os.path.dirname(__file__), '..', '..', 'ai-agile', 'ai-agile.json')

def load_user_config():
    with open(USER_CONFIG_PATH, 'r', encoding='utf-8') as f:
        return json.load(f)

def load_repo_config():
    try:
        with open(REPO_CONFIG_PATH, 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        return {}

def sanitize_filename(s):
    return ''.join(c if c.isalnum() or c in (' ', '-', '_') else '_' for c in s).strip()

def fetch_jira_issues(project_key, base_url, email, token, field_ids, verbose=False):
    url = f"{base_url}/rest/api/3/search/jql"
    jql = f"project={project_key} ORDER BY created DESC"
    fields_param = ','.join(field_ids)
    params = {
        "jql": jql,
        "maxResults": 1000,
        "fields": fields_param
    }
    auth = (email, token)
    headers = {"Accept": "application/json"}
    if verbose:
        print(f"[VERBOSE] JIRA API URL: {url}?jql={params['jql']}&maxResults={params['maxResults']}&fields={fields_param}")
    response = requests.get(url, params=params, auth=auth, headers=headers)
    response.raise_for_status()
    data = response.json()
    if verbose:
        print("[VERBOSE] Raw JIRA API response:")
        import pprint
        pprint.pprint(data)
    return data.get('issues', [])

def compute_checksum(issue):
    # Exclude the checksum field itself if present
    issue_copy = dict(issue)
    issue_copy.pop('checksum', None)
    # Use a stable JSON representation
    json_bytes = json.dumps(issue_copy, sort_keys=True, separators=(",", ":")).encode('utf-8')
    return hashlib.sha256(json_bytes).hexdigest()

def save_issue(issue, out_dir, project_key):
    issue_id = issue['key']
    title = issue['fields'].get('summary', 'NoTitle')
    filename = f"{project_key}-{issue_id}-{sanitize_filename(title)}.json"
    filepath = os.path.join(out_dir, filename)
    # Compute checksum and add to issue
    issue_with_checksum = dict(issue)
    issue_with_checksum['checksum'] = compute_checksum(issue)
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(issue_with_checksum, f, indent=2, ensure_ascii=False)


def main():
    user_config = load_user_config()
    repo_config = load_repo_config()
    # Credentials and project info from user config (now under 'secrets' → 'jira')
    jira_cfg = user_config.get('secrets', {}).get('jira', {})
    email = jira_cfg.get('email')
    token = jira_cfg.get('token')
    base_url = jira_cfg.get('baseUrl')
    projects = jira_cfg.get('projects', [])
    verbose = True  # Set to True for now; could be made configurable
    if not all([email, token, base_url]):
        raise EnvironmentError("Missing JIRA credentials in ~/.ai-agile/ai-agile.json under 'secrets'.")
    if not projects:
        raise ValueError("No JIRA projects configured in ~/.ai-agile/ai-agile.json (secrets → jira → projects key).")
    # Source materials path from repo config (default fallback)
    source_dir = repo_config.get('sourceMaterials') or os.path.join('ai-agile', '01_source-material')
    out_dir = os.path.join(source_dir, 'jira')
    Path(out_dir).mkdir(parents=True, exist_ok=True)
    # Fetch all available field IDs from JIRA
    field_ids = fetch_all_field_ids(base_url, email, token, verbose=verbose)
    for project in projects:
        project_key = project.get('key')
        if not project_key:
            continue
        print(f"Fetching issues for project: {project_key}")
        issues = fetch_jira_issues(project_key, base_url, email, token, field_ids, verbose=verbose)
        for issue in issues:
            save_issue(issue, out_dir, project_key)
        print(f"Saved {len(issues)} issues for {project_key}.")

if __name__ == "__main__":
    main()
