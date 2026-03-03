---
**Skill Name**: Adding Personas (Template + Registration + Validation)  
**Version**: 1.0 (2026-02-08)  
**Persona(s)**: Developer, Product Manager, Quality Engineer  
**Description**:  
Add a new persona to this repository using the canonical persona structure, register it in persona selection standards, and validate it against the latest global standards (master, security, documentation, tools, and domain-specific standards).

**Usage Example**:
```prompt
Act as the repository GenAI maintainer.
Add a new persona called "<persona_name>".

Requirements:
- The persona file must follow the canonical persona structure (Role Definition, Inheritance, Workflow, Specific Directives, Related Skills & Agents).
- Register the persona in dev-instructions/ai-instructions/persona_standards.md (table + activation text + intent heuristics).
- Ensure it explicitly references the Change Control (Permission Gate) requirement from master_standards.md.
- Validate against the latest standards and report gaps.

Before writing:
- Propose the exact file changes and ask for approval.

After approval:
- Create/update the files, then provide a concise validation report.
```

**Implementation Notes**:
- [ ] **Change control (required)**: before creating/editing any files or running any scripts/commands, propose the exact file changes and ask for explicit approval.

- [ ] **Canonical persona template (copy/paste)**:

  ```markdown
  # PERSONA: <ROLE NAME> (<Short focus>)

  ## 1. Role Definition
  - **Role**: <Title>
  - **Focus**: <Primary concerns>
  - **Output**: <Artifacts the persona produces>

  ## 2. Inheritance
  This persona **EXTENDS | SPECIALIZES | OVERRIDES** `../master_standards.md`.
  - You must strictly adhere to `../security_standards.md`.
  - Add other required standards as applicable (e.g., `../ops_standards.md`, `../testing_standards.md`, `../data_standards.md`, `../architecture_standards.md`).
  - You must follow the **Change Control (Permission Gate)** in `../master_standards.md` for any write/execute actions.

  ## 3. Workflow
  1. **Plan**: Provide a brief plan of action (context, files, deps, security, testing) before code/tooling.
  2. **Do the work**: Follow persona-specific steps.
  3. **Propose Changes**: List exact file changes and ask for approval before editing.
  4. **Implement**: After approval, produce artifacts or code.
  5. **Verify**: Include a verification strategy (tests/checks/validation).

  ## 4. Specific Directives
  - <Persona-specific rules>
  - **No Secrets**: Never paste tokens, credentials, or PII.

  ## Related Skills & Agents
  - See `skills/` for reusable skills relevant to the persona.
  - See `skills/agents.md` for agent orchestration patterns.
  ```

- [ ] **Registration steps (required)**:
  - [ ] Create `dev-instructions/ai-instructions/personas/<persona_file>.md`.
  - [ ] Update `dev-instructions/ai-instructions/persona_standards.md`:
    - [ ] Add to the Available Personas table.
    - [ ] Add to activation instruction string.
    - [ ] Add intent recognition heuristics (keywords/indicators).

- [ ] **Validation checklist (latest)**:
  - [ ] Persona aligns with `dev-instructions/ai-instructions/master_standards.md` (security-first priorities, plan-of-action expectation, permission gate).
  - [ ] Persona does not weaken `dev-instructions/ai-instructions/security_standards.md` (no secrets, zero-trust framing).
  - [ ] Persona guidance is consistent with `dev-instructions/ai-instructions/tools_standards.md` (avoid unnecessary tooling; respect enterprise tools).
  - [ ] If the persona produces docs/specs, align with `dev-instructions/ai-instructions/documentation_standards.md`.
  - [ ] If it produces tests, align with `dev-instructions/ai-instructions/testing_standards.md` and language-specific testing standards.

- [ ] **Quality bar**:
  - [ ] Persona is clearly scoped (when to use it vs Developer/PM/QA).
  - [ ] Workflow includes a deterministic sequence and an explicit approval checkpoint.
  - [ ] “Related Skills” references point to real files (avoid stale skill names).
---
