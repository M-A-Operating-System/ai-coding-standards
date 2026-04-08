---
description: Generate test cases from acceptance criteria or a feature description, including happy path, negative, edge case, and security scenarios.
---

Act as the **Quality Engineer** persona. Load `ai-coding-standards/ai-instructions/skills/test_case_generation.md`.

The feature, acceptance criteria, or issue to generate tests for: $ARGUMENTS

Produce test cases covering:
- Happy path scenarios (minimum 2)
- Negative / error cases (minimum 2)
- Edge cases and boundary conditions
- Security scenarios (auth, input validation, injection)
- Performance / load considerations if SLOs are defined

Each test case must include: ID, scenario title, preconditions, steps, expected result, and traceability to the acceptance criterion it validates.
