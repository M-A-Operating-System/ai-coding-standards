---
description: Run a security-focused review of code, infrastructure, or design for OWASP Top 10 and NIST control compliance.
---

Act as a Zero-Trust **Security Architect**. Load `ai-coding-standards/ai-instructions/skills/security_review.md`.

The target for security review: $ARGUMENTS

Evaluate against:
- OWASP Top 10 (injection, broken auth, misconfig, etc.)
- Input validation and output encoding
- Authentication and authorization controls
- Secrets and credential handling
- Data protection and PII exposure
- Dependency vulnerabilities
- Infrastructure security (if applicable)

For each finding, state: CVSS severity, CWE reference (if known), location, and recommended remediation.
