---
**Skill Name**: Requirements Gathering  
**Version**: 1.1 (2026-02-03)  
**Persona(s)**: Product Manager, Developer  
**Description**:  
Elicit requirements in a structured way (users, goals, constraints, edge cases, non-functional requirements) and turn them into unambiguous functional statements.

**Usage Example**:
```prompt
Act as a Technical PM.
1) Identify primary user(s) and goals
2) Capture inputs/outputs and business rules
3) List explicit assumptions and constraints
4) Produce acceptance criteria and open questions
```

**Implementation Notes**:
- [ ] Capture business rules as “If/Then” statements.
- [ ] Include NFRs: security, reliability/SLA, performance, auditability.
- [ ] Always include edge cases (suspended user, missing data, retries, partial failure).
- [ ] If requirements imply changes to repo artifacts (new specs, updates to docs), propose the file list and ask for approval before creating/editing files.
- [ ] Related to: acceptance_criteria_gherkin, clarifying_questions
---
