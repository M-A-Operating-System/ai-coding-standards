# CLAUDE.md

@ai-coding-standards/ai-instructions/persona_standards.md
@ai-coding-standards/ai-instructions/master_standards.md
@ai-coding-standards/ai-instructions/forbidden_standards.md
@ai-coding-standards/ai-instructions/pdlc_standards.md
@ai-coding-standards/ai-instructions/architecture_standards.md
@ai-coding-standards/ai-instructions/security_standards.md
@ai-coding-standards/ai-instructions/testing_standards.md
@ai-coding-standards/ai-instructions/ops_standards.md
@ai-coding-standards/ai-instructions/documentation_standards.md
@ai-coding-standards/ai-instructions/api_standards.md
@ai-coding-standards/ai-instructions/frontend_standards.md
@ai-coding-standards/ai-instructions/data_standards.md
@ai-coding-standards/ai-instructions/tools_standards.md
@ai-coding-standards/ai-instructions/common_scenarios.md

For language-specific standards, routing rules, skills, and agents see `ai-coding-standards/ai-instructions/llms.txt`.

---

## 1. Mandatory context (always loaded)

@ai-coding-standards/ai-instructions/persona_standards.md
@ai-coding-standards/ai-instructions/master_standards.md
@ai-coding-standards/ai-instructions/forbidden_standards.md
@ai-coding-standards/ai-instructions/pdlc_standards.md
@ai-coding-standards/ai-instructions/architecture_standards.md
@ai-coding-standards/ai-instructions/security_standards.md
@ai-coding-standards/ai-instructions/testing_standards.md
@ai-coding-standards/ai-instructions/ops_standards.md
@ai-coding-standards/ai-instructions/documentation_standards.md
@ai-coding-standards/ai-instructions/api_standards.md
@ai-coding-standards/ai-instructions/frontend_standards.md
@ai-coding-standards/ai-instructions/data_standards.md
@ai-coding-standards/ai-instructions/tools_standards.md
@ai-coding-standards/ai-instructions/common_scenarios.md

---

## 2. Language standards (load ONLY for the language being worked on)

Detect the language from the files in scope, then load the matching entry point and any relevant sub-files.

| Language | Entry point | Sub-files |
|----------|------------|-----------|
| **Python** | `ai-coding-standards/ai-instructions/languages/python/master_standards.md` | `coding_standards.md`, `testing_standards.md`, `security_standards.md`, `api_standards.md`, `ops_standards.md`, `documentation_standards.md`, `forbidden_standards.md`, `example_standards.md` |
| **TypeScript / JavaScript** | `ai-coding-standards/ai-instructions/languages/typescript/master_standards.md` | `coding_standards.md`, `testing_standards.md`, `security_standards.md`, `frontend_standards.md`, `ops_standards.md`, `documentation_standards.md`, `forbidden_standards.md`, `example_standards.md` |
| **PowerShell** | `ai-coding-standards/ai-instructions/languages/powershell/master_standards.md` | `coding_standards.md`, `testing_standards.md`, `security_standards.md`, `ops_standards.md`, `documentation_standards.md`, `forbidden_standards.md` |
| **Git / GitHub Actions** | *(no master_standards)* | `ops_how.md`, `architecture_how.md`, `api_how.md`, `data_how.md`, `documentation_how.md` |

All sub-files are under `ai-coding-standards/ai-instructions/languages/<lang>/`.

---

## 3. Personas

Activate a persona by stating: *"Act as the [name] persona."*
Default (unspecified): **Developer**.

Files: `ai-coding-standards/ai-instructions/personas/<role>.md`

| Persona | File | Use for |
|---------|------|---------|
| Developer | `developer.md` | Code, architecture, debugging |
| Product Manager | `product_manager.md` | Requirements, user stories, docs |
| Quality Engineer | `quality_engineer.md` | Tests, QA, security audit |
| DevOps Engineer | `devops_engineer.md` | CI/CD, pipelines, observability |
| Cloud Engineer | `cloud_engineer.md` | Cloud infra, IaC, networking |
| Data Scientist | `data_scientist.md` | Data analysis, ML pipelines |
| Project Manager | `project_manager.md` | Delivery planning, milestones |

---

## 4. Skills

Reusable prompt patterns. Load the relevant file when the task matches.

Directory: `ai-coding-standards/ai-instructions/skills/`

| Skill | File | Use for |
|-------|------|---------|
| Design review gate | `design_review.md` | Validate design sign-off before implementation |
| Requirements gathering | `requirements_gathering.md` | Elicit and structure requirements |
| Clarifying questions | `clarifying_questions.md` | Resolve ambiguity in requirements |
| Missing requirements | `missing_requirements.md` | Find gaps in a spec |
| Acceptance criteria | `acceptance_criteria_gherkin.md` | Write Gherkin Given/When/Then scenarios |
| Canonical requirements JSON | `canonical_requirements_json.md` | Structure requirements as machine-readable JSON |
| Code review | `code_review.md` | Structured code review checklist |
| Test case generation | `test_case_generation.md` | Generate test cases from requirements |
| Security review | `security_review.md` | Security-focused review |
| Risk assessment | `risk_assessment.md` | Identify and score delivery risks |
| Ops readiness | `ops_readiness.md` | Pre-deployment readiness check |
| Documentation quality | `documentation_quality.md` | Review and improve docs |
| Confluence sync | `confluence_sync.md` | Sync content to/from Confluence |
| Convert Confluence to Markdown | `convert_confluence_to_markdown.md` | Convert Confluence pages to Markdown |
| Adding personas | `adding_personas.md` | Create new persona definition files |
| Create skills | `create_skills.md` | Create new skill prompt files |
| README quality | `readme.md` | Review and improve README files |

---

## 5. Agents

Multi-step agent orchestration patterns.

File: `ai-coding-standards/ai-instructions/skills/agents.md`

---

## 6. Hooks

Claude Code hooks for this submodule (tool permissions, deny-lists):

File: `ai-coding-standards/.claude/settings.json`
