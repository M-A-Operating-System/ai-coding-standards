# AI Coding Standards & Instructions

This serves as the **minimum viable foundation** for any development team to immediately bootstrap AI-assisted development with consistent, enterprise-grade standards. Rather than each team reinventing coding guidelines from scratch, this repository provides a battle-tested framework that can be copied into any project to instantly enable AI agents with professional-level architectural knowledge and security awareness.

**It is expected that Development leads, with their teams, take responsibility for evolving these prompts to best align with the team's culture and coding standards, learning as you go.**

## 🎯 Purpose

The goal of this project is to ensure that all AI-generated code and documentation:

1.  **Multi-Persona Support**: Adheres to specialized roles (**Developer**, **Product Manager**, **Quality Engineer**) rather than a generic assistant.
2.  **Strict Standards**: Follows **Security > Reliability > Maintainability > Performance** priorities.
3.  **Context Aware**: Implements specific language idioms and integrates with tooling like Confluence.

## 📂 Repository Structure

The core documentation is located in `dev-instructions/`.

```text
.
├── README.md                   # This file
└── dev-instructions/
    ├── ai-instructions/         # The knowledge base for AI (standards, skills, personas)
    │   ├── llms.txt             # Documentation map / quick routing (start here if lost)
    │   ├── ai-context.json      # Machine-readable context map
    │   ├── persona_standards.md # 🚀 ENTRY POINT: Persona selection + routing
    │   ├── master_standards.md  # Global standards (security-first, plan-of-action, permission gate)
    │   ├── common_scenarios.md  # Situation-based workflows (review/refactor/security/docs/etc.)
    │   ├── security_standards.md
    │   ├── testing_standards.md
    │   ├── ops_standards.md
    │   ├── documentation_standards.md
    │   ├── tools_standards.md
    │   ├── architecture_standards.md
    │   ├── api_standards.md
    │   ├── frontend_standards.md
    │   ├── data_standards.md
    │   ├── forbidden_standards.md
    │   ├── personas/            # 🎭 Role definitions (Developer, PM, QA, Data, DevOps, Cloud, Delivery)
    │   ├── skills/              # Reusable prompt-engineering skills (skill cards)
    │   ├── languages/           # Language-specific “How” (e.g., python, ...)
    │   └── data/                # Database-specific “How” (e.g., postgres, ...)
    └── scripts/                 # Automation tools (e.g., Confluence sync)
        ├── download_confluence.py
        └── upload_confluence.py
```

Notes:
- `ai-instructions/languages/` contains language-specific implementation guidance (the “How”) that supports the global standards (the “What”).
- `ai-instructions/data/` contains database-specific implementation guidance (the “How”) that supports `data_standards.md`.

## 🚀 How to Use

### Project Setup

There are two supported ways to leverage this project. **Either way, `dev-instructions/ai-instructions/` should live in (and ship with) your codebase** so the knowledge and instructions follow your work product.

#### Option 1 (Recommended first): Read-only Git submodule
Use this repository as a **read-only** dependency inside your project, so you can adopt the standards quickly and decide later whether you want to maintain your own fork.

From your project repo root:

```bash
# Add as a submodule (pick either HTTPS or SSH URL)
git submodule add https://github.com/M-A-Operating-System/ai-coding-standards dev-instructions

# Initialize/update submodules on new clones
git submodule update --init --recursive
```

Guidance:
- Treat the submodule as **read-only**: don’t customize it in place.
- Update by bumping the submodule pointer (ideally to a tagged release/known commit).

If you think you want to clone and maintain independently, start with the submodule approach for a sprint or two first—then make the fork/ownership decision with real usage data.

#### Option 2: Clone and maintain independently
Clone this repo into a folder (or copy `dev-instructions/` into your repo) and take ownership of evolving the content.

Guidance:
- Use this if you know you need to tailor standards heavily to your org/tooling.
- Keep the docs under version control and review changes like production code.

### For AI Agents (Context Loading)

When starting a new session with an AI coding assistant, provide the following context:

1.  **Primary Instruction**: "Read `dev-instructions/ai-instructions/persona_standards.md` to map your persona."
2.  **Activation**:
    *   "Act as **Developer**" (Default: Implementation & Architecture)
    *   "Act as **Product Manager**" (Requirements & User Stories)
    *   "Act as **QA**" (Testing & Verification)
  *   "Act as **Data Scientist**" (Data analysis & model/product DS concerns)
  *   "Act as **Project Manager**" (Delivery planning & coordination)
  *   "Act as **DevOps Engineer**" (CI/CD, reliability, observability)
  *   "Act as **Cloud Engineer**" (Cloud architecture, IaC, IAM/networking)

### Confluence Integration

This project includes scripts to sync documentation with Atlassian Confluence:

*   **Download**: `dev-instructions/scripts/download_confluence.py` - Fetches pages as XHTML/HTML to `ai-agile/01_source-material/confluence`.
*   **Upload**: `dev-instructions/scripts/upload_confluence.py` - Pushes updates back to Confluence.

The **Product Manager** persona is trained to use these scripts for requirements gathering.

### The "What" vs. "How" Philosophy

This project separates universal principles from specific implementations:

* **The "What" (Root Docs)**: Universal rules.
  * *Example*: "All external inputs must be validated (Zero Trust)." (`security_standards.md`)
* **The "How" (Language Docs)**: Technical specifics.
  * *Example*: "Use Pydantic V2 `model_validator` for input validation." (`languages/python/coding_standards.md`)

## 🔑 Key Principles

* **Persona**: Senior Principal Engineer & Security Architect.
* **Mindset**: Zero Trust, Fail Fast, Explicit over Implicit.
* **Workflow**: Every task requires a "Plan of Action" covering Context, Files, Dependencies, Security, and Testing before code generation.

## 👮 Governance & Responsibility

It is now a **primary responsibility of the Development Manager** to take ownership of these master prompt files. This includes:

1. **Management**: Regularly reviewing and updating the content to reflect evolving team standards and technology choices.
2. **Alignment**: Ensuring the instructions in `dev-instructions/` accurately represent the architectural and security requirements of the specific application.
3. **Enforcement**: Verifying that the team (and their AI agents) are utilizing these standards during development.

## 🛠 Contributing

1. **Global Changes**: Edit files in `dev-instructions/` for rules that apply to all languages.
2. **Language Changes**: Edit files in `dev-instructions/ai-instructions/languages/<lang>/` for syntax or tool-specific updates.
