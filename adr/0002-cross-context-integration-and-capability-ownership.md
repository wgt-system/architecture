# ADR-0002 — Cross-Context Integration and Capability Ownership

- **Status:** Accepted
- **Date:** 2026-08-13

## Context

`wgt-system` contains independently owned bounded contexts that need to integrate across devices without merging their business domains. As more contexts are added, generic infrastructure must not be silently reimplemented inside each service.

The system needs an explicit rule for contract ownership, integration/presentation ownership, generic delivery ownership, and what to do when an existing generic capability is insufficient.

## Decision

1. Bounded contexts integrate through explicit provider-owned contracts. Provider/domain contexts retain authority over the meaning and versioning of their business contracts.
2. Wiiii Got This owns cross-platform service/capability integration and device/platform presentation semantics. Integrated presentation does not transfer foreign business ownership to WGT.
3. Generic durable opaque cross-device delivery is owned by Conveyance. Conveyance transports generic opaque delivery state and must not interpret foreign business payloads.
4. Domain-specific publication, commands, authority, merge, conflict, and reconciliation semantics remain with the bounded context that owns the affected domain.
5. New services must consult the Capability Catalog before introducing generic cross-context infrastructure.
6. If an accepted system capability is conceptually the correct owner but does not satisfy a concrete requirement, the requirement returns to the System Architecture Control Plane. A business service must not silently create a competing generic subsystem.
7. No bounded context integrates by directly accessing another context's database, importing its domain classes, sharing persistence entities, or using a shared business-logic library that bypasses the published boundary.

## Consequences

- A new business service can reuse Conveyance for an accepted delivery mode without adding business knowledge to Conveyance.
- Wiiii Got This can provide a coherent Windows/iPhone experience while provider contexts remain authoritative.
- Bidirectional synchronization cannot be designed from transport first; the domain owner must define change, authority, merge, conflict, and reconciliation semantics first.
- New generic delivery modes, shared infrastructure capabilities, or ownership changes require explicit system architecture decisions rather than accidental duplication.
- The architecture does not require every network call to use Conveyance and does not require every bounded context to be a network service.

## Rejected alternatives

### Put generic relay infrastructure inside Wiiii Got This

Rejected because shared delivery infrastructure is not automatically an integration/presentation subdomain.

### Let every business service build its own generic relay

Rejected as the default because it duplicates delivery/security infrastructure and fragments the system into incompatible synchronization stacks.

### Make Conveyance own generic business-object synchronization

Rejected because business change, conflict, merge, and authority semantics are domain-specific and remain with the owning bounded context.
