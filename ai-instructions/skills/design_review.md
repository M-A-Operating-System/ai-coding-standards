---
**Skill Name**: Design Review & Sign-off Gate  
**Version**: 1.0 (2026-04-02)  
**Persona(s)**: Product Manager, Developer, Quality Engineer  
**Description**:  
Validate that a work item has passed the AI PDLC Design Phase gate before any implementation begins. Checks issue tracker reference, product documentation completeness, requirement quality (specifiable + testable), and sign-off status. Produces a pass/fail gate report with a clear list of blockers.

**Usage Example**:
```prompt
Act as the Product Manager persona.
Run a design review gate check for issue [ISSUE-ID].
Return:
1) PASS or FAIL (with overall gate status)
2) Design completeness checklist — each item ✅ or ❌ with explanation
3) Requirement quality check — are all requirements specifiable and testable?
4) List of blockers (if any) that must be resolved before implementation
5) Recommended next action
```

**Gate Checklist** (all must be ✅ to pass):
- [ ] Issue/ticket ID confirmed and linked
- [ ] Product documentation page exists and is referenced in the issue
- [ ] User stories written in "As a / I want / So that" format
- [ ] Acceptance criteria in Given/When/Then (Gherkin) format — min. 2 happy path, 2 negative
- [ ] All requirements are specifiable (unambiguous, precise, no vague thresholds)
- [ ] All requirements are testable (a failing test can be written before implementation)
- [ ] API contract documented (if applicable)
- [ ] Data model documented (if applicable)
- [ ] NFRs defined (performance SLOs, security constraints, reliability targets)
- [ ] Risk assessment completed or explicitly waived by approver
- [ ] ADR written for significant architectural decisions
- [ ] Issue status = "Design Approved" (or user has stated explicit approval in this session)

**Work Item Classification Check**:
- If the request is a **Bug**: confirm the product design covers the expected behavior. If not, reclassify as Enhancement and fail the gate.
- If the request is an **Enhancement**: confirm product documentation has been updated. If not, fail the gate.

**Implementation Notes**:
- [ ] Never allow implementation to proceed if this gate fails — surface all blockers explicitly.
- [ ] If requirements are ambiguous, invoke `clarifying_questions.md` before continuing.
- [ ] If requirements are incomplete, invoke `missing_requirements.md` to enumerate gaps.
- [ ] If acceptance criteria are missing, invoke `acceptance_criteria_gherkin.md` to produce them.
- [ ] Change control: if this skill produces files (spec pages, ADRs, updated user stories), propose the file list and ask for approval before creating.
- [ ] Related to: requirements_gathering, missing_requirements, acceptance_criteria_gherkin, risk_assessment, pdlc_standards.md
---
