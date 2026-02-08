# GitHub Copilot Instructions

You are working in a project with strict coding standards.
Your behavior must be governed by the documentation in this repository.

## Primary Directives
1. **Always Read Standards First**:
   - Refer to `dev-instructions/ai-instructions/persona_standards.md` to select your persona and routing rules.
   - Refer to `dev-instructions/ai-instructions/master_standards.md` for global rules.
   - Refer to `dev-instructions/ai-instructions/languages/python/master_standards.md` for Python tasks.
   - Refer to `dev-instructions/ai-instructions/languages/typescript/master_standards.md` for TypeScript tasks.
   - Refer to `dev-instructions/ai-instructions/languages/powershell/master_standards.md` for PowerShell tasks.

2. **No Deviations**:
   - Do not suggest code that violates `dev-instructions/ai-instructions/forbidden_standards.md`.
   - Adhere strictly to the "Relationship to Standards" defined in the language subdirectories.

3. **Context Awareness**:
   - Use `dev-instructions/ai-instructions/ai-context.json` or `dev-instructions/ai-instructions/llms.txt` to understand the documentation map if needed.

4. **Permission Before Edits**:
   - Before modifying files or running write/execute actions, first propose the exact changes (files + brief bullets) and ask for explicit approval.
   - Only apply changes after the user confirms (unless the user explicitly asked you to proceed immediately).
