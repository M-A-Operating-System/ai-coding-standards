import argparse
import json
from pathlib import Path

def load_ai_agile_config(ai_agile_root=None):
    """Load ai-agile.json config from the given root or auto-detect."""
    cwd = Path.cwd()
    if ai_agile_root:
        ai_agile_root = Path(ai_agile_root).expanduser().resolve()
    else:
        ai_agile_root = None
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
        return json.load(f), ai_agile_root

def main():
    parser = argparse.ArgumentParser(description='Generate a Markdown pivot table from git_activity.json.')
    parser.add_argument('--row-field', required=True, help='Field for table rows')
    parser.add_argument('--column-field', required=True, help='Field for table columns')
    parser.add_argument('--summary', required=True, choices=['count', 'sum', 'average', 'max', 'min'], help='Aggregation type')
    parser.add_argument('--summary-field', help='Field to aggregate (required for sum, average, max, min)')
    parser.add_argument('--source', help='Source folder (default: config)')
    parser.add_argument('--output', help='Output Markdown file')
    parser.add_argument('--filter', action='append', help='Filter in the form key=value or key~substring (can be used multiple times)')
    parser.add_argument('--title', help='Markdown H1 title for the report')
    parser.add_argument('--ai-agile-root', dest='ai_agile_root', default=None, help='Path to ai-agile root containing ai-agile.json (optional override)')
    parser.add_argument('--rowtotal', dest='rowtotal', action='store_true', default=True, help='Include row totals (default: on)')
    parser.add_argument('--no-rowtotal', dest='rowtotal', action='store_false', help='Disable row totals')
    parser.add_argument('--columntotal', dest='columntotal', action='store_true', default=True, help='Include column totals (default: on)')
    parser.add_argument('--no-columntotal', dest='columntotal', action='store_false', help='Disable column totals')
    args = parser.parse_args()

    config, ai_agile_root = load_ai_agile_config(args.ai_agile_root)
    git_folder = config['process']['steps']['SourceMaterial']['subfolders']['git']
    # Find all *-activity.json files in the git source-materials folder
    if args.source:
        git_dir = Path(args.source)
    else:
        git_dir = (ai_agile_root / git_folder)
    activity_files = list(git_dir.glob('*-activity.json'))
    if not activity_files:
        raise FileNotFoundError(f"No *-activity.json files found in {git_dir}")
    gen_folder = config['process']['steps']['GeneratedMaterials']['folder']
    output_dir = (ai_agile_root / gen_folder / 'git').resolve()
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = Path(args.output) if args.output else (output_dir / 'git_activity_pivot.md')

    # Merge all activity files, annotating with repo name
    commits = []
    pulls = []
    commit_files = {}
    for afile in activity_files:
        repo_name = afile.stem.replace('-activity', '')
        with open(afile, 'r', encoding='utf-8') as f:
            data = json.load(f)
        for c in data.get('commits', []):
            c['repo'] = repo_name
            commits.append(c)
        for pr in data.get('pull_requests', []):
            pr['repo'] = repo_name
            pulls.append(pr)
        commit_files.update(data.get('commit_files', {}))

    # Filtering (not implemented in detail, placeholder for future)
    # TODO: Implement --filter logic for git data if needed

    # Build pivot data
    from collections import defaultdict
    pivot = defaultdict(lambda: defaultdict(list))
    row_keys = set()
    col_keys = set()
    # Map field names to data
    def get_field(obj, field):
        # Support dot notation for nested fields, e.g., author.login or commit.author.name
        parts = field.split('.')
        val = obj
        for part in parts:
            if isinstance(val, dict):
                val = val.get(part, None)
            else:
                return ''
        if val is None:
            # Special cases for legacy field names
            if field == 'author':
                if 'commit' in obj:
                    return obj.get('commit', {}).get('author', {}).get('name', '')
                if 'user' in obj:
                    return obj.get('user', {}).get('login', '')
            if field == 'type':
                return obj.get('type', 'commit' if 'sha' in obj else 'pull_request')
            return ''
        return val

    # Collect row/col keys and build pivot
    for c in commits:
        row_val = get_field(c, args.row_field)
        col_val = get_field(c, args.column_field) if args.column_field != 'type' else 'commits'
        row_keys.add(row_val)
        col_keys.add(col_val)
        if args.summary == 'count':
            pivot[row_val][col_val].append(1)
        elif args.summary_field:
            val = c.get(args.summary_field, 0)
            try:
                val = float(val)
            except Exception:
                val = 0
            pivot[row_val][col_val].append(val)
    for pr in pulls:
        row_val = get_field(pr, args.row_field)
        col_val = get_field(pr, args.column_field) if args.column_field != 'type' else 'pull_requests'
        row_keys.add(row_val)
        col_keys.add(col_val)
        if args.summary == 'count':
            pivot[row_val][col_val].append(1)
        elif args.summary_field:
            val = pr.get(args.summary_field, 0)
            try:
                val = float(val)
            except Exception:
                val = 0
            pivot[row_val][col_val].append(val)

    row_keys = sorted(row_keys, key=lambda x: (str(x).lower() if x is not None else ''))
    col_keys = sorted(col_keys, key=lambda x: (str(x).lower() if x is not None else ''))

    def aggregate(values, summary):
        if summary == 'count':
            return sum(values)
        if summary == 'sum':
            return sum(values)
        if summary == 'average':
            return sum(values) / len(values) if values else 0
        if summary == 'max':
            return max(values) if values else 0
        if summary == 'min':
            return min(values) if values else 0
        return ''

    # Markdown table with summary row/col for count
    lines = []
    if args.title:
        lines.append(f'# {args.title}\n')
    header = f'| {args.row_field} \\ {args.column_field} | ' + ' | '.join(str(c) for c in col_keys)
    header += ' | Total |'
    lines.append(header)
    sep = '|---|' + '|'.join(['---'] * len(col_keys)) + '|---|'
    lines.append(sep)
    col_totals = [0] * len(col_keys)
    grand_total = 0
    for r in row_keys:
        row = [str(r)]
        row_total = 0
        for i, c in enumerate(col_keys):
            agg = aggregate(pivot[r][c], args.summary)
            row.append(str(agg))
            if args.summary == 'count':
                try:
                    val = int(agg)
                except Exception:
                    val = 0
                col_totals[i] += val
                row_total += val
        row.append(str(row_total) if args.summary == 'count' else '')
        if args.summary == 'count':
            grand_total += row_total
        lines.append('| ' + ' | '.join(row) + ' |')
    # Always add summary row for count
    if args.summary == 'count':
        total_row = ['Total'] + [str(t) for t in col_totals] + [str(grand_total)]
        lines.append('| ' + ' | '.join(total_row) + ' |')
    md = '\n'.join(lines)

    # Always write to output_path (resolved from args.output or default)
    with open(str(output_path), 'w', encoding='utf-8') as f:
        f.write(md + '\n')
    print(f"Markdown pivot written to {output_path}")

if __name__ == '__main__':
    main()
