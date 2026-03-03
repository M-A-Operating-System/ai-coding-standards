def github_headers(token):
    """Return headers for GitHub API requests using the provided token."""
    return {
        'Authorization': f'Bearer {token}',
        'Accept': 'application/vnd.github.v3+json',
        'User-Agent': 'ai-agile-git-activity-script'
    }


import argparse
import requests
import json
from pathlib import Path
import hashlib
import os
from datetime import datetime

"""
download_gitActivity.py

Downloads commit, pull request, and code change activity from a GitHub repository using the GitHub REST API.
- Uses config/secrets for authentication (standards-compliant)
- Accepts repository name and date range as arguments
- Downloads commits, pull requests, and changed files
- Saves results as JSON for further analysis
"""
def load_config():
    import os
    import sys
    from os.path import expanduser
    # 1. Environment variable
    env_path = os.environ.get('AI_AGILE_USER_CONFIG')
    if env_path and Path(env_path).exists():
        print(f"[DEBUG] Loading config from AI_AGILE_USER_CONFIG: {env_path}")
        with open(env_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    # 2. User home ~/.ai-agile/ai-agile.json
    user_home_path = Path(expanduser('~')) / '.ai-agile' / 'ai-agile.json'
    if user_home_path.exists():
        print(f"[DEBUG] Loading config from user home: {user_home_path}")
        with open(user_home_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    print("[ERROR] No ai-agile secrets config found in AI_AGILE_USER_CONFIG or ~/.ai-agile/ai-agile.json", file=sys.stderr)
    sys.exit(1)

def select_git_token(config, owner):
    git_accounts = config.get('secrets', {}).get('git', [])
    print("[DEBUG] Available git accounts:")
    for acct in git_accounts:
        t = acct.get('type')
        token = acct.get('GITHUB_TOKEN')
        token_hash = hashlib.sha256(token.encode('utf-8')).hexdigest()[:12] if token else None
        print(f"  - type: {t}, token hash: {token_hash}")
    selected = None
    for acct in git_accounts:
        acct_type = acct.get('type', '')
        if acct_type == owner or acct_type == 'personal':
            selected = acct
            break
    if not selected and git_accounts:
        selected = git_accounts[0]
    if selected:
        token = selected.get('GITHUB_TOKEN')
        token_hash = hashlib.sha256(token.encode('utf-8')).hexdigest()[:12] if token else None
        print(f"[DEBUG] Selected git account type: {selected.get('type')}, token hash: {token_hash}")
        return token
    print("[DEBUG] No matching git account found for owner/type:", owner)
    return None

def fetch_commits(owner, repo, since, until, headers):
    url = f'https://api.github.com/repos/{owner}/{repo}/commits'
    params = {'since': since, 'until': until, 'per_page': 100}
    commits = []
    while url:
        resp = requests.get(url, headers=headers, params=params)
        resp.raise_for_status()
        commits.extend(resp.json())
        url = resp.links.get('next', {}).get('url')
        params = None  # Only needed for first request
    return commits

def fetch_pull_requests(owner, repo, since, until, headers):
    url = f'https://api.github.com/repos/{owner}/{repo}/pulls'
    params = {'state': 'all', 'sort': 'updated', 'direction': 'desc', 'per_page': 100}
    pulls = []
    while url:
        resp = requests.get(url, headers=headers, params=params)
        resp.raise_for_status()
        for pr in resp.json():
            updated = pr['updated_at']
            if since <= updated <= until:
                pulls.append(pr)
        url = resp.links.get('next', {}).get('url')
        params = None
    return pulls

def fetch_commit_files(owner, repo, sha, headers):
    url = f'https://api.github.com/repos/{owner}/{repo}/commits/{sha}'
    resp = requests.get(url, headers=headers)
    resp.raise_for_status()
    return resp.json().get('files', [])

def main():


    parser = argparse.ArgumentParser(description='Download GitHub activity (commits, PRs, code changes) for one or all repos.')
    parser.add_argument('--repo', required=False, help='GitHub repo in owner/repo format (if omitted, process all in ai-agile.json)')
    parser.add_argument('--since', required=False, help='Start date (YYYY-MM-DD). Defaults to 12 months ago.')
    parser.add_argument('--until', required=False, help='End date (YYYY-MM-DD). Defaults to today.')
    parser.add_argument('--output', required=False, help='Output JSON file (overrides folder logic, only if --repo is given)')
    parser.add_argument('--out-dir', dest='out_dir', default=None, help='Output directory for downloaded activity (overrides ai-agile.json)')
    parser.add_argument('--ai-agile-root', dest='ai_agile_root', default=os.environ.get('AI_AGILE_ROOT'), help='Path to ai-agile root containing ai-agile.json (optional override)')
    args = parser.parse_args()

    # Set default dates if not provided
    today = datetime.utcnow().date()
    if not args.until:
        until = today
    else:
        until = datetime.strptime(args.until, '%Y-%m-%d').date()
    if not args.since:
        since = until.replace(year=until.year - 1)
    else:
        since = datetime.strptime(args.since, '%Y-%m-%d').date()
    since_str = since.strftime('%Y-%m-%d')
    until_str = until.strftime('%Y-%m-%d')

    config = load_config()

    # Robust ai-agile root and output folder resolution
    cwd = Path.cwd()
    ai_agile_root = Path(args.ai_agile_root).expanduser().resolve() if args.ai_agile_root else None
    if not ai_agile_root:
        # Try to find ai-agile root up the directory tree
        cur = cwd
        for _ in range(8):
            if (cur / "ai-agile.json").exists():
                ai_agile_root = cur
                break
            if (cur / "ai-agile" / "ai-agile.json").exists():
                ai_agile_root = cur / "ai-agile"
                break
            if cur.parent == cur:
                break
            cur = cur.parent
    if not ai_agile_root:
        raise RuntimeError("Could not locate ai-agile root. Set --ai-agile-root or run from within the repository.")

    ai_agile_json_path = ai_agile_root / "ai-agile.json"
    if not ai_agile_json_path.exists():
        raise RuntimeError(f"Expected ai-agile.json at {ai_agile_json_path}, but it was not found.")

    # Always load repo locations from project-local ai-agile/ai-agile.json
    project_ai_agile_json_path = Path(__file__).parent.parent.parent / 'ai-agile' / 'ai-agile.json'
    print(f"[DEBUG] Project ai-agile.json path: {project_ai_agile_json_path}")
    if not project_ai_agile_json_path.exists():
        raise RuntimeError(f"Expected project ai-agile.json at {project_ai_agile_json_path}, but it was not found.")
    with open(project_ai_agile_json_path, 'r', encoding='utf-8') as f:
        project_ai_agile_cfg = json.load(f)
    git_folder = project_ai_agile_cfg['process']['steps']['SourceMaterial']['subfolders']['git']
    if args.repo:
        repo_list = [args.repo]
    else:
        raw_repos = project_ai_agile_cfg.get('git',{}).get('repositories',[])
        print(f"[DEBUG] Raw repositories from project config: {raw_repos}")
        repo_list = [r.split('github.com/',1)[-1].replace('.git','') for r in raw_repos]
    print(f"[DEBUG] Full repo_list: {repo_list}")
    for idx, repo_full in enumerate(repo_list):
        print(f"[DEBUG] Processing repo {idx+1}/{len(repo_list)}: {repo_full}")
        owner, repo = repo_full.split('/')
        print(f"[DEBUG] Looking for git token for repo owner: {owner}")
        token = select_git_token(config, owner)
        if not token:
            print(f"[ERROR] No GITHUB_TOKEN found for owner/type {owner} in git secrets array, skipping {repo_full}")
            continue
        headers = github_headers(token)
        since_iso = f'{since_str}T00:00:00Z'
        until_iso = f'{until_str}T23:59:59Z'

        if args.output and args.repo:
            output_path = Path(args.output)
        else:
            if args.out_dir:
                out_dir = Path(args.out_dir).expanduser().resolve()
            else:
                out_dir = (ai_agile_root / git_folder).resolve()
            out_dir.mkdir(parents=True, exist_ok=True)
            output_path = out_dir / f'{repo}-activity.json'
        print(f"[DEBUG] Using output path: {output_path}")

        print(f'Fetching commits for {repo_full} from {args.since} to {args.until}...')
        commits = fetch_commits(owner, repo, since_iso, until_iso, headers)
        print(f'Found {len(commits)} commits.')

        print(f'Fetching pull requests for {repo_full}...')
        pulls = fetch_pull_requests(owner, repo, since_iso, until_iso, headers)
        print(f'Found {len(pulls)} pull requests.')

        print('Fetching changed files for each commit...')
        commit_files = {}
        for c in commits:
            sha = c['sha']
            # Add commit_week field (ISO year-week)
            date_str = c.get('commit', {}).get('author', {}).get('date')
            if date_str:
                try:
                    dt = datetime.fromisoformat(date_str.replace('Z', '+00:00'))
                    c['commit_week'] = f"{dt.isocalendar().year}-W{dt.isocalendar().week:02d}"
                except Exception:
                    c['commit_week'] = ''
            else:
                c['commit_week'] = ''
            commit_files[sha] = fetch_commit_files(owner, repo, sha, headers)

        # Add pr_week field to each pull request (ISO year-week)
        for pr in pulls:
            # Use created_at or updated_at if available
            date_str = pr.get('created_at') or pr.get('updated_at')
            if date_str:
                try:
                    dt = datetime.fromisoformat(date_str.replace('Z', '+00:00'))
                    pr['pr_week'] = f"{dt.isocalendar().year}-W{dt.isocalendar().week:02d}"
                except Exception:
                    pr['pr_week'] = ''
            else:
                pr['pr_week'] = ''
        result = {
            'commits': commits,
            'pull_requests': pulls,
            'commit_files': commit_files
        }
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(result, f, indent=2)
        print(f'Activity written to {output_path}')
    # End for

    # Robust ai-agile root and output folder resolution
    cwd = Path.cwd()
    ai_agile_root = Path(args.ai_agile_root).expanduser().resolve() if args.ai_agile_root else None
    if not ai_agile_root:
        # Try to find ai-agile root up the directory tree
        cur = cwd
        for _ in range(8):
            if (cur / "ai-agile.json").exists():
                ai_agile_root = cur
                break
            if (cur / "ai-agile" / "ai-agile.json").exists():
                ai_agile_root = cur / "ai-agile"
                break
            if cur.parent == cur:
                break
            cur = cur.parent
    if not ai_agile_root:
        raise RuntimeError("Could not locate ai-agile root. Set --ai-agile-root or run from within the repository.")

    ai_agile_json_path = ai_agile_root / "ai-agile.json"
    if not ai_agile_json_path.exists():
        raise RuntimeError(f"Expected ai-agile.json at {ai_agile_json_path}, but it was not found.")

    with open(ai_agile_json_path, 'r', encoding='utf-8') as f:
        ai_agile_cfg = json.load(f)
    git_folder = ai_agile_cfg['process']['steps']['SourceMaterial']['subfolders']['git']

    # Output path logic
    if args.output:
        output_path = Path(args.output)
    else:
        if args.out_dir:
            out_dir = Path(args.out_dir).expanduser().resolve()
        else:
            out_dir = (ai_agile_root / git_folder).resolve()
        out_dir.mkdir(parents=True, exist_ok=True)
        # Use <repo>_activity.json as default filename
        output_path = out_dir / f'{repo}_activity.json'
    print(f"[DEBUG] Using output path: {output_path}")

    print(f'Fetching commits for {args.repo} from {args.since} to {args.until}...')
    commits = fetch_commits(owner, repo, since_iso, until_iso, headers)
    print(f'Found {len(commits)} commits.')

    print(f'Fetching pull requests for {args.repo}...')
    pulls = fetch_pull_requests(owner, repo, since_iso, until_iso, headers)
    print(f'Found {len(pulls)} pull requests.')

    print('Fetching changed files for each commit...')
    commit_files = {}
    for c in commits:
        sha = c['sha']
        commit_files[sha] = fetch_commit_files(owner, repo, sha, headers)

    result = {
        'commits': commits,
        'pull_requests': pulls,
        'commit_files': commit_files
    }
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(result, f, indent=2)
    print(f'Activity written to {output_path}')

if __name__ == '__main__':
    main()
