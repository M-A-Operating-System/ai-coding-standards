# GitHub Copilot Instructions for `dev-prompts`

You are an expert AI development assistant working in the `dev-prompts` repository. This project focuses on defining, managing, and distributing enterprise-grade AI coding standards and integrating them with Atlassian Confluence.

## 🏗 Project Architecture & Structure

This repository is divided into two main components:

1.  **`dev-instructions/` (Core Product)**:
    *   Contains the "Source of Truth" for AI coding standards.
    *   **Structure**:
        *   `ai-instructions/`: Markdown files defining rules (Security, Architecture, etc.).
        *   `ai-instructions/personas/`: Role definitions (Developer, PM, QA).
        *   `scripts/`: Automation for Confluence sync (`download_confluence.py`, `upload_confluence.py`).
    *   **Key File**: `ai-instructions/ai-context.json` maps standards to files.

2.  **`ai-agile/` (Workspace/Usage)**:
    *   Represents a "user" environment where standards are applied.
    *   Stores downloaded Confluence content in `01_source-material/confluence/`.
    *   Contains local configuration (`.env`, `confluence.config`).

## 💻 Developer Workflows

### 0. Change Control (Required)
*   Before modifying files or running write/execute actions, first propose the exact changes (files + brief bullets) and ask for explicit approval.
*   Only apply changes after the user confirms (unless the user explicitly asked you to proceed immediately).

### 1. Confluence Synchronization
*   **Scripts**: Located in `dev-instructions/scripts/`.
*   **Preferred scripts**:
    *   Download: `dev-instructions/scripts/download_confluence.py`
    *   Upload: `dev-instructions/scripts/upload_confluence.py`
*   **Config discovery**:
    *   `ai-agile/ai-agile.json` defines the SourceMaterial folder and the Confluence subfolder.
    *   The Confluence config folder must contain `.env` and `confluence.config`.
*   **Configuration**:
    *   `confluence.config`: Defines `BaseUrl` and `PageId`.
    *   `.env`: Defines `CONF_EMAIL`, `CONF_TOKEN` (API Key), `BASE_URL`.

### 2. Standards Management
*   **"What" vs. "How"**:
    *   **Root Standards** (`dev-instructions/ai-instructions/*.md`): Universal principles (e.g., "Validate all inputs").
    *   **Language Standards** (`dev-instructions/ai-instructions/languages/<lang>/*.md`): Implementation details (e.g., "Use Pydantic").
*   **Personas**:
    *   Changes to behavior logic go in `dev-instructions/ai-instructions/persona_standards.md`.
    *   Role-specific prompts go in `dev-instructions/ai-instructions/personas/*.md`.

## 🧩 Project Conventions & Patterns

*   **Persona-Driven Development**: All AI interactions are scoped by a persona (Developer, PM, QA). Reference `persona_standards.md` for logic.
*   **Strict Typing**: Even in scripts (PowerShell), use `[CmdletBinding()]` and typed parameters.
*   **Zero Trust**: Scripts must validate credentials and paths explicitly.
*   **Documentation-First**: Changes to code must be reflected in the corresponding `*_standards.md` file if they establish a new pattern.

## ⚠️ Critical Files & Paths

*   `dev-instructions/ai-instructions/ai-context.json`: **MUST** be updated if files are moved or renamed.
*   `dev-instructions/.github/copilot-instructions.md`: The template instructions distributed to consumers of this project.
*   `.env`: Local development only. **NEVER** commit.

## 🧪 Testing & Validation
*   **Script Testing**: Test PowerShell scripts by running them against the `ai-agile` sandbox.
*   **Prompt Testing**: Validate updated standards by instructing an AI session to "Act as [Persona]" and verifying adherence to the new rules.

## 🚀 Common Commands

```powershell
# Download latest Confluence material (no attachments)
python "dev-instructions\scripts\download_confluence.py" --no-attachments

# Dry-run upload (preview changes)
python "dev-instructions\scripts\upload_confluence.py" --dry-run
```
