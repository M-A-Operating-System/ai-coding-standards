# Architecture Principles (The "What")
Applies to: All Backend Services

## Purpose
Define the architecture expectations using the Five-View Architecture Framework.

## 1. Application View
- **Design First**: All API contracts, data models, and UX flows must be defined in product documentation and approved (PDLC Phase 3 Sign-Off) before any implementation is generated.
- **APIs First**: Design API contracts (OpenAPI, Proto, GraphQL Schema) before implementation.
- **Data Model First**: ERD or schema defined before any migration or persistence code is written.
- **UX Flows First**: User journeys and wireframes documented before any UI component is built.
- **Traceability**: Every implemented endpoint, schema change, and UI component must trace back to a documented and approved product requirement.
- **Protocol Selection**:
  - REST for resource-oriented public APIs.
  - gRPC for internal high-performance microservices.
  - GraphQL for flexible client-driven queries.
- **Versioning**: Explicit versioning in path or header is mandatory.

## 2. Development View
- **Bounded Contexts**: One service = one bounded context.
- **Reproducible Builds**: Builds must be deterministic and contain a manifest/SBOM.
- **Local Dev**: `docker-compose` or equivalent for local emulation.

## 3. Security View
- **Zero Trust**: Validate and authenticate every request.
- **Least Privilege**: Services should have minimal permissions.
- **Threat Modeling**: Required for new services (STRIDE).

## 4. Infrastructure View
- **IaC**: Infrastructure as Code is mandatory (Terraform, Bicep, etc.).
- **Immutable**: Prefer replacing instances over mutating them.
- **Segmentation**: VPC segmentation and private subnets for data.

## 5. Sizing & Performance View
- **SLOs**: Define Latency and Throughput objectives.
- **Resilience**:
  - Retries with exponential backoff.
  - Circuit breakers for external calls.
  - Bulkheads to prevent cascading failures.

## Event-Driven Guidelines
- **Explicit Contracts**: Events must have schemas (Avro, JSON Schema).
- **Idempotency**: Consumers must handle duplicate events gracefully.
