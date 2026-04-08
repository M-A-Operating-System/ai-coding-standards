---
description: Run the Design First gate — verify issue reference, work item type, design sign-off, and acceptance criteria before implementation.
---

Load `ai-coding-standards/ai-instructions/skills/design_review.md` and run the full gate checklist for the current task.

The task or issue being reviewed: $ARGUMENTS

Apply every check from the gate. For each check:
- ✅ PASS — state what was confirmed
- ❌ FAIL — state what is missing and which PDLC phase must be completed before proceeding

Do not generate any implementation until all checks pass.
