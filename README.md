# AI Coding Standards & Instructions

This serves as the **minimum viable foundation** for any development team to immediately bootstrap AI-assisted development with consistent, enterprise-grade standards. Rather than each team reinventing coding guidelines from scratch, this repository provides a battle-tested framework that can be copied into any project to instantly enable AI agents with professional-level architectural knowledge and security awareness.

**It is expected that Development leads, with their teams, take responsibility for evolving these prompts to best align with the team's culture and coding standards, learning as you go.**

## 🎯 Purpose

The goal of this project is to ensure that all AI-generated code:

1. Adheres to a consistent **"Senior Principal Engineer & Security Architect"** persona.
2. Follows strict **Security > Reliability > Maintainability > Performance** priorities.
3. Implements specific language idioms and tooling configurations defined by the team.

## 📂 Repository Structure

The core documentation is located in `dev-instructions/`.

```text
coding-standards/
├── README.md                   # This file
└── dev-instructions/           # The knowledge base for AI
    ├── master_standards.md     # 🚀 ENTRY POINT: Persona & Workflow
    ├── ai-context.json         # Machine-readable context map
    ├── llms.txt                # Text-based index for LLM prompting
    ├── architecture_standards.md
    ├── security_standards.md
    ├── ... (other global standards)
    └── languages/              # Language-specific implementations ("How")
        ├── python/
        └── typescript/
```

## 🚀 How to Use

### Project Setup

To implement these standards in your application:

1. Copy the entire `dev-instructions/` folder into the **root level** of your project repository.
2. Ensure that `dev-instructions/master_standards.md` is accessible.
3. Commit these files to your version control system. This ensures the "brain" travels with the codebase.

### For AI Agents (Context Loading)

When starting a new session with an AI coding assistant, provide the following context:

1. **Primary Instruction**: "Adopt the persona and standards defined in `dev-instructions/master_standards.md`."
2. **Reference**: Point the AI to `dev-instructions/llms.txt` or `dev-instructions/ai-context.json` to understand the available documentation map.

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
2. **Language Changes**: Edit files in `dev-instructions/languages/<lang>/` for syntax or tool-specific updates.
