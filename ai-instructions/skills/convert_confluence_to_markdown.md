# Skill: convert_confluence_to_markdown

## Purpose
Convert Confluence storage-format pages (.xhtml/.html) in ai-agile/01_source-material/confluence to clean markdown using the repo-standard script.

## Directory Locations
- All input and output directory paths are automatically derived from the ai-agile/ai-agile.json config file in the ai-agile root folder.
- No additional settings or manual directory configuration are required; the script and skill use the config values directly.
- Example: input = ai-agile/01_source-material/confluence/{host}/, output = ai-agile/02_generated_materials/canonical-requirements/{host}/ (or as specified in config).

## Tooling
- Must use: dev-instructions/scripts/confluence2md.py
- Input and output directories are determined by ai-agile.json config (source-material/confluence and generated-materials/canonical-requirements).

## Workflow
1. Confirm ai-agile/01_source-material/confluence contains content.
2. Warn user: running this skill will overwrite any existing markdown files in ai-agile/02_generated_materials/canonical-requirements.
3. Run confluence2md.py once, specifying the input directory (as configured in ai-agile.json); it will process all .xhtml/.html files recursively.
4. Save markdown output in canonical-requirements folder, matching host/pageId structure.

## Standards
- Preserve headings, tables, code blocks, and links.
- Remove Confluence-specific markup.
- Ensure markdown is readable and ready for further requirements processing.

## Safety
- Always confirm overwrite with user before running.
- Log all files converted and overwritten.

## Definition of Complete
- For every .xhtml (or .html) Confluence page in ai-agile/01_source-material/confluence/{host}/, there must be a corresponding .md markdown file in ai-agile/02_generated_materials/canonical-requirements/{host}/.
- The conversion is only considered complete when all source pages have matching markdown outputs.
- Any missing or outdated markdown files should be flagged for re-conversion.

---
This skill is mandatory for all Confluence-to-markdown conversions in this repo.
