import os
import json
from pathlib import Path
from datetime import datetime, timedelta
from collections import defaultdict

# Configurable paths
GIT_ACTIVITY_DIR = Path('ai-agile/01_source-material/git')
REPORT_PATH = Path('ai-agile/02_generated_materials/git/weekly_git_status_report.md')

# Get current ISO week
today = datetime.utcnow().date()
current_year, current_week, _ = today.isocalendar()
current_week_str = f"{current_year}-W{current_week:02d}"

# Helper: load all activity files
def load_git_activity():
    commits, prs = [], []
    for file in GIT_ACTIVITY_DIR.glob('*-activity.json'):
        with open(file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        repo = file.stem.replace('-activity', '')
        for c in data.get('commits', []):
            c['repo'] = repo
            commits.append(c)
        for pr in data.get('pull_requests', []):
            pr['repo'] = repo
            prs.append(pr)
    return commits, prs

def filter_by_week(items, week_field, week_str):
    return [i for i in items if i.get(week_field) == week_str]

def pivot_table(items, row_field, col_field, summary_field=None):
    rows, cols = set(), set()
    table = defaultdict(lambda: defaultdict(int))
    for i in items:
        # Robust user extraction: try author.login, then author.name, then committer.login, then committer.name
        row = i.get('author', {}).get('login')
        if not row:
            row = i.get('author', {}).get('name')
        if not row:
            row = i.get('committer', {}).get('login')
        if not row:
            row = i.get('committer', {}).get('name')
        if not row:
            row = ''
        col = i.get(col_field, '')
        rows.add(row)
        cols.add(col)
        table[row][col] += 1
    rows, cols = sorted(rows), sorted(cols)
    return rows, cols, table

def render_table(rows, cols, table, row_label, col_label):
    lines = [f"| {row_label} \\ {col_label} | " + " | ".join(cols) + " | Total |",
             "|---|" + "|".join(['---'] * len(cols)) + "|---|"]
    for r in rows:
        vals = [table[r][c] for c in cols]
        total = sum(vals)
        lines.append(f"| {r} | " + " | ".join(str(v) for v in vals) + f" | {total} |")
    col_totals = [sum(table[r][c] for r in rows) for c in cols]
    lines.append(f"| Total | " + " | ".join(str(v) for v in col_totals) + f" | {sum(col_totals)} |")
    return "\n".join(lines)

def get_last_n_weeks(n):
    weeks = []
    dt = today
    for _ in range(n):
        y, w, _ = dt.isocalendar()
        weeks.append(f"{y}-W{w:02d}")
        dt -= timedelta(days=7)
    return list(reversed(weeks))

def main():
    commits, prs = load_git_activity()
    # --- PRs by user and repo (current week) ---
    pr_this_week = filter_by_week(prs, 'pr_week', current_week_str)
    pr_rows, pr_cols, pr_table = pivot_table(pr_this_week, 'author.login', 'repo')
    pr_section = "## Pull Requests by User and Repository (This Week)\n\n" + render_table(pr_rows, pr_cols, pr_table, 'User', 'Repo')
    # --- Commits by user and repo (current week) ---
    commit_this_week = filter_by_week(commits, 'commit_week', current_week_str)
    commit_rows, commit_cols, commit_table = pivot_table(commit_this_week, 'author.login', 'repo')
    commit_section = "## Commits by User and Repository (This Week)\n\n" + render_table(commit_rows, commit_cols, commit_table, 'User', 'Repo')
    # --- 8-week trend: Commits ---
    weeks = get_last_n_weeks(8)
    trend_rows, trend_cols, trend_table = pivot_table([c for c in commits if c.get('commit_week') in weeks], 'author.login', 'commit_week')
    trend_cols = weeks  # force order
    trend_section = "## Commits per User per Week (Last 8 Weeks)\n\n" + render_table(trend_rows, trend_cols, trend_table, 'User', 'Week')
    # --- 8-week trend: PRs ---
    pr_trend_rows, pr_trend_cols, pr_trend_table = pivot_table([p for p in prs if p.get('pr_week') in weeks], 'author.login', 'pr_week')
    pr_trend_cols = weeks
    pr_trend_section = "## PRs per User per Week (Last 8 Weeks)\n\n" + render_table(pr_trend_rows, pr_trend_cols, pr_trend_table, 'User', 'Week')
    # --- Write report ---
    report = f"""# Weekly Git Status Report\n\n{pr_section}\n\n{commit_section}\n\n{trend_section}\n\n{pr_trend_section}\n"""
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    with open(REPORT_PATH, 'w', encoding='utf-8') as f:
        f.write(report)
    print(f"Markdown report written to {REPORT_PATH}")

if __name__ == '__main__':
    main()
