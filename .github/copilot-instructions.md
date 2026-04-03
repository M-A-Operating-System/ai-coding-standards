# Copilot instructions

Read `ai-instructions/llms.txt` — it is the complete map of all standards, routing rules, personas, skills, and agents for this repo.

Before any implementation task, read `ai-instructions/master_standards.md` (global rules and Design First Gate) and `ai-instructions/pdlc_standards.md` (issue tracking, work item types, and tag systems).

Before modifying any file, propose the exact changes and wait for explicit approval.

## Big picture
- `ai-instructions/`: source-of-truth AI standards + scripts
- `ai-agile/`: sandbox workspace where synced source material and generated artifacts live

## Mandatory context loading (use these files, not generic advice)
1. Persona routing + behavior rules: `ai-instructions/persona_standards.md`
2. Global rules: `ai-instructions/master_standards.md`
3. Forbidden patterns: `ai-instructions/forbidden_standards.md`
4. If you need a map: `ai-instructions/llms.txt` and `ai-instructions/ai-context.json`

## Structure you must preserve
- Root standards (“what”): `ai-instructions/*.md`
- Language standards (“how”): `ai-instructions/languages/<lang>/*.md`
- Personas: `ai-instructions/personas/`
- If you move/rename standards files, update `ai-instructions/ai-context.json`

## Confluence synchronization (project-specific workflow)
- Scripts (preferred):
  - Download: `scripts/download_confluence.py`
  - Upload: `scripts/upload_confluence.py`
- Config discovery: `ai-agile/ai-agile.json` defines the source-material folder and the Confluence subfolder.
- The Confluence config folder must contain:
  - `.env` (local only; NEVER commit) with `CONF_EMAIL`, `CONF_TOKEN`, `BASE_URL`
  - `confluence.config` with `BaseUrl`, `PageId`

```powershell
python "scripts\download_confluence.py" --no-attachments
python "scripts\upload_confluence.py" --dry-run
```

## Change control (repo rule)
Before modifying files or running write/execute actions: propose the exact changes (files + brief bullets) and wait for explicit approval.
