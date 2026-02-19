"""
jira2mdtable.py

Generates a Markdown table from JIRA ticket JSON files.

- Reads all JSON files in ai-agile/01_source-material/jira/
- Outputs a Markdown file in ai-agile/02_generated_materials/jira/
- --title: report title (default: "Jira Report - {PROJECTNAME}")
- --fields: comma-separated list of fields (default: id,title,assigneeDisplayName,Status,LastUpdated,LastComment)
"""
import os
import json
import argparse
from pathlib import Path
from datetime import datetime

def parse_args():
        parser = argparse.ArgumentParser(
                description="""
Generate a Markdown table from JIRA ticket JSON files.

Filtering usage:
    --filter supports <, >, <=, >=, =, != for any field, including date fields (as strings).
    Example: --filter "resolutiondate<2026-01-01"
        - Includes only issues where resolutiondate is before 2026-01-01 (string comparison).
        - Supported operators: =, !=, <, >, <=, >=
    Multiple filters: specify --filter multiple times, all must match.
        Example: --filter "Status=Done" --filter "resolutiondate<2026-01-01"
    Note: Date fields must be in a comparable string format (YYYY-MM-DD or full ISO timestamp).
    Filtering is case-sensitive and string-based.
"""
        )
        parser.add_argument('--title', type=str, default=None, help='Title for the Markdown report')
        parser.add_argument('--fields', type=str, default='id,title,assigneeDisplayName,Status,Priority,LastUpdated,LastComment', help='Comma-separated list of fields to include')
        parser.add_argument('--filter', action='append', default=[], help='Filter issues by field value, e.g. --filter "Status=Done". Can be used multiple times.')
        parser.add_argument('--output', type=str, default=None, help='Output Markdown file path (default: auto-named)')
        parser.add_argument('--write-mode', type=str, choices=['overwrite', 'append'], default='overwrite', help='Write mode for output file: overwrite (default) or append')
        return parser.parse_args()

def extract_field(issue, field):
    # Support dot notation for nested fields
    def get_nested(d, path):
        for part in path.split('.'):
            if isinstance(d, dict):
                d = d.get(part, None)
            else:
                return ''
            if d is None:
                return ''
        return d

    # Map field names to JIRA JSON structure
    if field == 'id':
        return issue.get('id', '')
    if field == 'title':
        return issue.get('fields', {}).get('summary', '')
    if field == 'assigneeDisplayName':
        assignee = issue.get('fields', {}).get('assignee', {})
        if assignee is None:
            return ''
        return assignee.get('displayName', '')
    if field == 'Status':
        return issue.get('fields', {}).get('status', {}).get('name', '')
    if field == 'Priority':
        return issue.get('fields', {}).get('priority', {}).get('name', '')
    if field == 'LastUpdated':
        return issue.get('fields', {}).get('updated', '')
    if field == 'LastComment':
        comments = issue.get('fields', {}).get('comment', {}).get('comments', [])
        if comments:
            last = comments[-1]
            body = last.get('body', '')
            def extract_adf_text(adf):
                if isinstance(adf, str):
                    return adf
                if isinstance(adf, dict):
                    if adf.get('type') == 'text':
                        return adf.get('text', '')
                    if 'content' in adf:
                        return ''.join(extract_adf_text(child) for child in adf['content'])
                if isinstance(adf, list):
                    return ''.join(extract_adf_text(child) for child in adf)
                return ''
            text = extract_adf_text(body)
            author = last.get('author', {}).get('displayName', '')
            date = last.get('created', '')
            # Format date to YYYY-MM-DD if possible
            date_str = ''
            if date:
                try:
                    from datetime import datetime
                    date_str = datetime.fromisoformat(date.replace('Z', '+00:00')).date().isoformat()
                except Exception:
                    date_str = date
            if author or date_str:
                return f"{text} [{author}, {date_str}]".strip()
            return text
        return ''
    # Dot notation fallback: try nested fields
    if '.' in field:
        return get_nested(issue, field) or get_nested(issue.get('fields', {}), field)
    # Fallback: try top-level, then fields
    return issue.get(field, issue.get('fields', {}).get(field, ''))
    # Map field names to JIRA JSON structure
    if field == 'id':
        return issue.get('id', '')
    if field == 'title':
        return issue.get('fields', {}).get('summary', '')
    if field == 'assigneeDisplayName':
        return issue.get('fields', {}).get('assignee', {}).get('displayName', '')
    if field == 'Status':
        return issue.get('fields', {}).get('status', {}).get('name', '')
    if field == 'LastUpdated':
        return issue.get('fields', {}).get('updated', '')
    if field == 'LastComment':
        comments = issue.get('fields', {}).get('comment', {}).get('comments', [])
        if comments:
            last = comments[-1]
            body = last.get('body', '')
            def extract_adf_text(adf):
                if isinstance(adf, str):
                    return adf
                if isinstance(adf, dict):
                    if adf.get('type') == 'text':
                        return adf.get('text', '')
                    if 'content' in adf:
                        return ''.join(extract_adf_text(child) for child in adf['content'])
                if isinstance(adf, list):
                    return ''.join(extract_adf_text(child) for child in adf)
                return ''
            text = extract_adf_text(body)
            author = last.get('author', {}).get('displayName', '')
            date = last.get('created', '')
            # Format date to YYYY-MM-DD if possible
            date_str = ''
            if date:
                try:
                    from datetime import datetime
                    date_str = datetime.fromisoformat(date.replace('Z', '+00:00')).date().isoformat()
                except Exception:
                    date_str = date
            if author or date_str:
                return f"{text} [{author}, {date_str}]".strip()
            return text
        return ''
    # Fallback: try top-level, then fields
    return issue.get(field, issue.get('fields', {}).get(field, ''))

def main():
    args = parse_args()
    fields = [f.strip() for f in args.fields.split(',')]
    import re
    filters = []
    for f in args.filter:
        # Support <, <=, >, >=, !=, =
        op_match = re.match(r'(.+?)(<=|>=|!=|=|<|>)(.+)', f)
        if op_match:
            key = op_match.group(1).strip()
            op = op_match.group(2)
            value = op_match.group(3).strip()
            filters.append((key, value, op))
        else:
            # fallback to eq
            if '=' in f:
                key, value = f.split('=', 1)
                filters.append((key.strip(), value.strip(), '='))
    # Load ai-agile.json to get sourceMaterials location
    config_path = Path('ai-agile/ai-agile.json')
    with open(config_path, 'r', encoding='utf-8') as f:
        config = json.load(f)
    repo_root = Path('.')
    ai_agile_root = Path(config['basePaths']['aiAgileRoot'].replace('<REPO_ROOT>', str(repo_root)))
    source_material_folder = config['process']['steps']['SourceMaterial']['folder']
    jira_dir = ai_agile_root / source_material_folder / 'jira'
    out_dir = ai_agile_root / config['process']['steps']['GeneratedMaterials']['folder'] / 'jira'
    out_dir.mkdir(parents=True, exist_ok=True)
    issues = []
    project_name = None
    for file in jira_dir.glob('*.json'):
        with open(file, 'r', encoding='utf-8') as f:
            issue = json.load(f)
            # Filtering logic
            include = True
            for key, value, op in filters:
                field_val = str(extract_field(issue, key))
                if op == '=' and field_val != value:
                    include = False
                    break
                if op == '!=' and field_val == value:
                    include = False
                    break
                if op == '<' and not (field_val < value):
                    include = False
                    break
                if op == '>' and not (field_val > value):
                    include = False
                    break
                if op == '<=' and not (field_val <= value):
                    include = False
                    break
                if op == '>=' and not (field_val >= value):
                    include = False
                    break
            if include:
                issues.append(issue)
                if not project_name and 'key' in issue:
                    project_name = issue['key'].split('-')[0]
    if not project_name:
        project_name = 'JIRA'
    title = args.title or f"Jira Report - {project_name}"
    md_lines = [f"## {title}", '', '| ' + ' | '.join(fields) + ' |', '| ' + ' | '.join(['---'] * len(fields)) + ' |']
    for idx, issue in enumerate(issues):
        row = [str(extract_field(issue, field)) for field in fields]
        md_lines.append('| ' + ' | '.join(row) + ' |')
    # Always ensure two blank lines after the table for extra separation
    if len(md_lines) > 0 and md_lines[-1] != '':
        md_lines.append('')
    md_lines.append('')
    if args.output:
        out_file = Path(args.output)
    else:
        out_file = out_dir / f"{project_name}_jira_report.md"
    mode = 'a' if args.write_mode == 'append' else 'w'
    with open(out_file, mode, encoding='utf-8') as f:
        f.write('\n'.join(md_lines))
    print(f"Markdown report written to {out_file} (mode: {args.write_mode})")

if __name__ == "__main__":
    main()
