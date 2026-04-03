# CLAUDE.md — ai-instructions

> Sub-directory context file. Claude Code loads this automatically when working in `ai-instructions/`.

## Purpose

This directory is the **source-of-truth** for all AI coding standards.  
It contains the "What" (universal principles) and "How" (language-specific implementations).

## File Map

| File | Role |
|------|------|
| `persona_standards.md` | **Entry point** — persona routing and intent heuristics |
| `master_standards.md` | Global rules, security priorities, change control gate |
| `forbidden_standards.md` | Universally banned patterns |
| `llms.txt` | Human-readable map of all standards |
| `ai-context.json` | Machine-readable index — **do not delete** |

## Editing Rules

- Modifying `*.md` = standards change — propose + get approval first
- Renaming/moving any file = **must** update `ai-context.json`
- Adding a language = create `languages/<lang>/master_standards.md` as entry point

## Quick Navigation

- Language standards: `languages/<lang>/master_standards.md`
- Personas: `personas/<role>.md`
- Skills (reusable prompt patterns): `skills/<skill>.md`
- Prompt templates: `prompt_templates/<template>.md`
