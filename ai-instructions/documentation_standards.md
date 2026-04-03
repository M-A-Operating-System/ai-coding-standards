# Documentation Standards (The "What")
Applies to: All Codebases

## 1. Code Documentation
- **Why, not What**: Comments should explain rationale, not syntax.
- **Public API**: All public interfaces must be documented.
- **Function Documentation**: Every function/method must include an inline docstring describing its purpose, all input parameters (with types and expected values), and return values.
- **Input Variables**: All input variables and arguments must be clearly documented for type, expected values, and rationale.

## 2. Architecture Decision Records (ADRs)
- **Mandatory**: Significant decisions must be recorded in `docs/adr/`.
- **Format**: Context, Decision, Consequences, Alternatives.

## 3. README Requirements
- **Top Level**: Purpose, Quick Start, Test Instructions, CI Status.
- **Module Level**: Intent and Public API surface.

## 4. API Documentation
- **Generated**: Docs should be auto-generated from code/contracts (OpenAPI).
- **Up-to-date**: CI must verify docs are in sync with code.

## 5. Product Documentation Requirements

Product documentation is the authoritative design record. It must be kept in a content system (Confluence, Notion, GitHub Wiki, or equivalent) and is the source of truth for all implementation.

### Pre-flight: Enhancement Work Items
Before any Enhancement work item may enter implementation, the product documentation page for the affected area **must** satisfy:

| Requirement | Check |
|-------------|-------|
| Page exists and is linked in the issue | ✅ |
| User stories written ("As a / I want / So that") | ✅ |
| Acceptance criteria in Gherkin (Given/When/Then) — min. 2 happy path, 2 negative | ✅ |
| All requirements are specifiable (unambiguous) | ✅ |
| All requirements are testable (a failing test can be derived) | ✅ |
| Design sign-off recorded (approver, date) | ✅ |

### Bug Fix Rule
Bug fixes must **not** alter the product documentation. The approved design is the reference; the code is broken, not the design. If investigation reveals the design is genuinely wrong, reclassify as Enhancement and complete the PDLC design phases before writing any code.

### Documentation Drift Prevention
- Code review checklists must include a documentation sync check.
- CI should fail on merges if API contracts diverge from OpenAPI specs.
- Quarterly review: audit product documentation pages against current implementation.
