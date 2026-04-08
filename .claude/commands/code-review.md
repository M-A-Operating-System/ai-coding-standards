---
description: Perform a structured code review against the project coding standards, security rules, and acceptance criteria.
---

Act as the **Quality Engineer** persona. Load `ai-coding-standards/ai-instructions/skills/code_review.md`.

The code or PR to review: $ARGUMENTS

Apply the full code review checklist covering:
- Architecture compliance (`architecture_standards.md`)
- Security validation (`security_standards.md`, OWASP Top 10)
- Code quality and maintainability
- Test coverage and quality
- Documentation completeness
- Traceability to acceptance criteria

For each finding, state: severity (BLOCKER / MAJOR / MINOR / INFO), location, and recommended fix.
