# TYPESCRIPT INSTRUCTIONS (The "How")
Version: 1.0.0
Parent: /master_instructions.md

## Relationship to Standards
This file provides the TypeScript-specific implementation ("How") for the global master instructions defined in `/master_instructions.md` ("What"). It serves as the entry point for all TypeScript-related code generation tasks.

## Purpose
Provide TypeScript-specific implementation details for the Global Standards.

## Reference Map
| Standard | TypeScript Implementation File |
| :--- | :--- |
| **Coding Style** | `coding_standards.md` |
| **Testing** | `testing_implementation.md` |
| **Security** | `security_implementation.md` |
| **CI/CD** | `ci_cd_implementation.md` |
| **Documentation** | `documentation_implementation.md` |
| **Examples** | `examples.md` |
| **Forbidden** | `forbidden_patterns.md` |

## TypeScript Persona
- **Version**: TypeScript 5.0+
- **Runtime**: Node.js LTS (v20+)
- **Typing**: Strict (`"strict": true` in `tsconfig.json`)
- **Validation**: Zod (runtime validation)

## Quick Start for Agents
When asked to write TypeScript code:
1.  Read `/master_instructions.md` for the plan.
2.  Read `languages/typescript/coding_standards.md` for style.
3.  Read `languages/typescript/examples.md` for templates.
4.  Check `languages/typescript/forbidden_patterns.md` before finalizing.
