# TYPESCRIPT INSTRUCTIONS (The "How")
Version: 1.0.0
Parent: /master_standards.md

## Relationship to Standards
This file provides the TypeScript-specific implementation ("How") for the global master standards defined in `/master_standards.md` ("What"). It serves as the entry point for all TypeScript-related code generation tasks.

## Purpose
Provide TypeScript-specific implementation details for the Global Standards.

## Reference Map
| Standard | TypeScript Implementation File |
| :--- | :--- |
| **Coding Style** | `coding_standards.md` |
| **Testing** | `testing_standards.md` |
| **Security** | `security_standards.md` |
| **CI/CD** | `ops_standards.md` |
| **Documentation** | `documentation_standards.md` |
| **Frontend** | `frontend_standards.md` |
| **Examples** | `example_standards.md` |
| **Forbidden** | `forbidden_standards.md` |

## TypeScript Persona

- **Version**: TypeScript 5.0+
- **Runtime**: Node.js LTS (v20+)
- **Typing**: Strict (`"strict": true` in `tsconfig.json`)
- **Validation**: Zod (runtime validation)

## Quick Start for Agents

When asked to write TypeScript code:

1. Read `/master_standards.md` for the plan.
2. Read `languages/typescript/coding_standards.md` for style.
3. Read `languages/typescript/example_standards.md` for templates.
4. Check `languages/typescript/forbidden_standards.md` before finalizing.
