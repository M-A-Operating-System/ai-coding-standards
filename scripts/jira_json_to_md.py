"""
jira_json_to_md.py

Converts each JIRA JSON file in the sourceMaterials folder to a Markdown file in the generatedMaterials folder.
- Reads ai-agile.json for folder locations.
- For each .json file in sourceMaterials/jira, creates a .md file in generatedMaterials/jira with the same base name.
- The Markdown file contains a simple table of all top-level and fields keys/values.
"""
import json
from pathlib import Path

def get_config_paths():
    with open('ai-agile/ai-agile.json', 'r', encoding='utf-8') as f:
        config = json.load(f)
    repo_root = Path('.')
    ai_agile_root = Path(config['basePaths']['aiAgileRoot'].replace('<REPO_ROOT>', str(repo_root)))
    source_material_folder = config['process']['steps']['SourceMaterial']['folder']
    generated_materials_folder = config['process']['steps']['GeneratedMaterials']['folder']
    jira_src = ai_agile_root / source_material_folder / 'jira'
    jira_out = ai_agile_root / generated_materials_folder / 'jira'
    jira_out.mkdir(parents=True, exist_ok=True)
    return jira_src, jira_out

def json_to_markdown(data):
    fields = data.get('fields', {})

    # 1. Key-Value Table (main fields)
    main_keys = [
        'key', 'id', 'summary', 'status', 'issuetype', 'priority', 'assignee', 'reporter', 'created', 'updated', 'parent', 'project'
    ]
    lines = ['| Field | Value |', '| --- | --- |']
    for k in main_keys:
        v = fields.get(k) if k in fields else data.get(k)
        # Special handling for people fields
        if k in ('assignee', 'reporter') and isinstance(v, dict):
            name = v.get('displayName', '')
            email = v.get('emailAddress', '')
            v = f"{name} <{email}>" if name or email else ''
        elif isinstance(v, dict):
            if 'name' in v:
                v = v['name']
            elif 'key' in v:
                v = v['key']
            elif 'summary' in v:
                v = v['summary']
            else:
                v = str(v)
        lines.append(f'| {k} | {v if v is not None else ""} |')
    lines.append('')

    # 2. Description Section
    desc = fields.get('description')
    def extract_text_from_description(desc):
        if not desc or not isinstance(desc, dict):
            return ''
        out = []
        for block in desc.get('content', []):
            if 'content' in block:
                for c in block['content']:
                    if c.get('type') == 'text':
                        out.append(c.get('text', ''))
            elif block.get('type') == 'text':
                out.append(block.get('text', ''))
        return '\n'.join(out)

    lines.append('## Description\n')
    lines.append(extract_text_from_description(desc) + '\n')

    # 3. Updates Table
    update_fields = ['created', 'updated', 'lastViewed', 'statuscategorychangedate']
    lines.append('## Updates\n')
    lines.append('| Field | Value |')
    lines.append('| --- | --- |')
    for k in update_fields:
        v = fields.get(k, '')
        lines.append(f'| {k} | {v} |')
    lines.append('')


    # 4. Comments Section (as table)
    lines.append('## Comments\n')
    comments = fields.get('comment', {}).get('comments', [])
    if comments:
        lines.append('| Date | Person | Content |')
        lines.append('| --- | --- | --- |')
        def extract_comment_text(body):
            # Atlassian doc format: dict with 'content' list
            if isinstance(body, dict):
                out = []
                for block in body.get('content', []):
                    if 'content' in block:
                        for c in block['content']:
                            if c.get('type') == 'text':
                                out.append(c.get('text', ''))
                    elif block.get('type') == 'text':
                        out.append(block.get('text', ''))
                return ' '.join(out)
            return str(body)
        for c in comments:
            author = c.get('author', {})
            name = author.get('displayName', '')
            email = author.get('emailAddress', '')
            person = f"{name} <{email}>" if name or email else ''
            date = c.get('created', '')
            body = extract_comment_text(c.get('body', ''))
            # Escape newlines and pipes in body for table
            body = str(body).replace('\n', ' ').replace('|', '\\|')
            lines.append(f'| {date} | {person} | {body} |')
    else:
        lines.append('No comments.')
    lines.append('')

    return '\n'.join(lines)

def main():
    jira_src, jira_out = get_config_paths()
    for json_file in jira_src.glob('*.json'):
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        md = json_to_markdown(data)
        md_file = jira_out / (json_file.stem + '.md')
        with open(md_file, 'w', encoding='utf-8') as f:
            f.write(f'# {json_file.stem}\n\n')
            f.write(md)
    print(f"Converted {len(list(jira_src.glob('*.json')))} JIRA JSON files to Markdown.")

if __name__ == '__main__':
    main()
