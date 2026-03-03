"""
jira2mdpivot.py

Generates a Markdown pivot table from JIRA JSON files.
- Parameters:
    --row-field: Field for table rows
    --column-field: Field for table columns
    --summary: Aggregation (sum, average, max, min) on a numeric field
    --summary-field: The field to aggregate (required for summary)
    --source: Source folder (optional, default: config)
    --output: Output Markdown file (optional)

Example:
    python jira2mdpivot.py --row-field priority --column-field status --summary count
    python jira2mdpivot.py --row-field assignee --column-field status --summary sum --summary-field timeoriginalestimate
"""
import argparse
import json
from pathlib import Path
from collections import defaultdict
import statistics

def get_config_source_folder():
    with open('ai-agile/ai-agile.json', 'r', encoding='utf-8') as f:
        config = json.load(f)
    repo_root = Path('.')
    ai_agile_root = Path(config['basePaths']['aiAgileRoot'].replace('<REPO_ROOT>', str(repo_root)))
    source_material_folder = config['process']['steps']['SourceMaterial']['folder']
    jira_src = ai_agile_root / source_material_folder / 'jira'
    return jira_src

from datetime import datetime

def extract_field(issue, field):
    fields = issue.get('fields', {})
    if field == 'resolvedWeek':
        # Use resolutiondate, fallback to updated
        date_str = fields.get('resolutiondate') or fields.get('updated')
        if not date_str:
            return ''
        try:
            # Accepts '2026-02-18T16:55:14.613-0500' or similar
            dt = datetime.strptime(date_str[:19], '%Y-%m-%dT%H:%M:%S')
        except Exception:
            try:
                dt = datetime.strptime(date_str[:10], '%Y-%m-%d')
            except Exception:
                return ''
        return f"{dt.isocalendar()[0]}-W{dt.isocalendar()[1]:02d}"
    v = fields.get(field)
    # For people fields, use displayName
    if field == 'assignee':
        if isinstance(v, dict) and 'displayName' in v:
            return v['displayName']
        return 'Unassigned'
    if isinstance(v, dict) and 'displayName' in v:
        return v['displayName']
    # For nested dicts, try 'name', 'key', 'summary'
    if isinstance(v, dict):
        for k in ('name', 'key', 'summary'):
            if k in v:
                return v[k]
        return str(v)
    return v

def aggregate(values, summary):
    if summary == 'count':
        return len(values)
    if not values:
        return ''
    if summary == 'sum':
        return sum(values)
    if summary == 'average':
        return round(statistics.mean(values), 2)
    if summary == 'max':
        return max(values)
    if summary == 'min':
        return min(values)
    return ''

def main():

    parser = argparse.ArgumentParser(description='Generate a Markdown pivot table from JIRA JSON files.')
    parser.add_argument('--row-field', required=True, help='Field for table rows')
    parser.add_argument('--column-field', required=True, help='Field for table columns')
    parser.add_argument('--summary', required=True, choices=['count', 'sum', 'average', 'max', 'min'], help='Aggregation type')
    parser.add_argument('--summary-field', help='Field to aggregate (required for sum, average, max, min)')
    parser.add_argument('--source', help='Source folder (default: config)')
    parser.add_argument('--output', help='Output Markdown file')
    parser.add_argument('--filter', action='append', help='Filter in the form key=value or key~substring (can be used multiple times)')
    parser.add_argument('--title', help='Markdown H1 title for the report')
    args = parser.parse_args()

    if args.summary != 'count' and not args.summary_field:
        parser.error('--summary-field is required for this summary type')

    # Parse filters (support > and < for dates/numbers)
    filters = []
    if args.filter:
        for f in args.filter:
            if '~' in f:
                k, v = f.split('~', 1)
                filters.append((k.strip(), 'contains', v.strip()))
            elif '>=' in f:
                k, v = f.split('>=', 1)
                filters.append((k.strip(), 'gte', v.strip()))
            elif '<=' in f:
                k, v = f.split('<=', 1)
                filters.append((k.strip(), 'lte', v.strip()))
            elif '>' in f:
                k, v = f.split('>', 1)
                filters.append((k.strip(), 'gt', v.strip()))
            elif '<' in f:
                k, v = f.split('<', 1)
                filters.append((k.strip(), 'lt', v.strip()))
            elif '=' in f:
                k, v = f.split('=', 1)
                filters.append((k.strip(), 'equals', v.strip()))

    def passes_filters(issue):
        fields = issue.get('fields', {})
        for k, op, v in filters:
            val = fields.get(k)
            if isinstance(val, dict) and 'displayName' in val:
                val = val['displayName']
            if isinstance(val, dict):
                for key in ('name', 'key', 'summary'):
                    if key in val:
                        val = val[key]
                        break
            # Date comparison support
            if op in ('gt', 'lt', 'gte', 'lte'):
                # Try to parse as date
                from datetime import datetime
                try:
                    if isinstance(val, str) and 'T' in val:
                        val_dt = datetime.strptime(val[:19], '%Y-%m-%dT%H:%M:%S')
                    else:
                        val_dt = datetime.strptime(str(val)[:10], '%Y-%m-%d')
                    v_dt = datetime.strptime(v[:10], '%Y-%m-%d')
                except Exception:
                    return False
                if op == 'gt' and not (val_dt > v_dt):
                    return False
                if op == 'lt' and not (val_dt < v_dt):
                    return False
                if op == 'gte' and not (val_dt >= v_dt):
                    return False
                if op == 'lte' and not (val_dt <= v_dt):
                    return False
            elif op == 'equals' and str(val) != v:
                return False
            elif op == 'contains' and v not in str(val):
                return False
        return True

    jira_src = Path(args.source) if args.source else get_config_source_folder()
    issues = []
    for json_file in jira_src.glob('*.json'):
        with open(json_file, 'r', encoding='utf-8') as f:
            issue = json.load(f)
            if not filters or passes_filters(issue):
                issues.append(issue)

    # Build pivot data
    pivot = defaultdict(lambda: defaultdict(list))
    row_keys = set()
    col_keys = set()
    print(f"DEBUG: Filters applied: {filters}")
    for issue in issues:
        resolved_week = extract_field(issue, 'resolvedWeek')
        print(f"DEBUG: Issue {issue.get('key')} resolvedWeek={resolved_week}")
        row_val = extract_field(issue, args.row_field)
        col_val = extract_field(issue, args.column_field)
        print(f"DEBUG: Including issue {issue.get('key')} {args.row_field}={row_val} {args.column_field}={col_val}")
        row_keys.add(row_val)
        col_keys.add(col_val)
        if args.summary == 'count':
            pivot[row_val][col_val].append(1)
        else:
            val = extract_field(issue, args.summary_field)
            try:
                val = float(val)
            except (TypeError, ValueError):
                val = None
            if val is not None:
                pivot[row_val][col_val].append(val)

    row_keys = sorted(row_keys, key=lambda x: (str(x).lower() if x is not None else ''))
    col_keys = sorted(col_keys, key=lambda x: (str(x).lower() if x is not None else ''))
    print(f"DEBUG: row_keys after processing: {row_keys}")
    print(f"DEBUG: col_keys after processing: {col_keys}")

    # Markdown table with summary row/col for count
    lines = []
    if args.title:
        lines.append(f'# {args.title}\n')
    lines.append(f'| {args.row_field} \\ {args.column_field} | ' + ' | '.join(str(c) for c in col_keys) + ' | Total |')
    lines.append('|---|' + '|'.join(['---'] * len(col_keys)) + '|---|')
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
    # Add summary row for count
    if args.summary == 'count':
        total_row = ['Total'] + [str(t) for t in col_totals] + [str(grand_total)]
        lines.append('| ' + ' | '.join(total_row) + ' |')
    md = '\n'.join(lines)

    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(md + '\n')
    else:
        print(md)

if __name__ == '__main__':
    main()
