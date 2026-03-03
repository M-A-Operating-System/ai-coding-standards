---
**Skill Name**: Code Review  
**Version**: 1.1 (2026-02-03)  
**Persona(s)**: Developer, Quality Engineer  
**Description**:  
Review changes for correctness, security, maintainability, and alignment with standards. Provide actionable feedback and propose minimal, safe fixes.

**Usage Example**:
```prompt
Review the provided change for:
- Correctness and edge cases
- Security (input validation, authz/authn, injection)
- Reliability (timeouts, retries, failure modes)
- Maintainability (clarity, duplication, tests)
Return: Findings, Risk level, Suggested patch list.
```

**Implementation Notes**:
- [ ] Prefer root-cause fixes over surface patches.
- [ ] Call out missing tests and propose focused additions.
- [ ] Flag behavior changes and migration risks.
- [ ] When proposing fixes that require edits, provide a minimal patch list and ask for approval before applying.
- [ ] Related to: security_review, risk_assessment
---
