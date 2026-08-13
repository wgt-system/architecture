# ADR-0001 — System Architecture Repository

- **Status:** Accepted
- **Date:** 2026-08-13

## Context

System-level architecture facts currently live across multiple bounded-context repositories. Existing project control planes can reconstruct the system because they already know those repositories, but a new bounded context may not know that a generic capability already exists or which context owns it.

That creates a duplication risk: a new service could independently add relay, synchronization, integration, registry, or other cross-context infrastructure without discovering the accepted owner.

## Decision

Use `wgt-system/architecture` as the durable **design-time** source of truth for:

- system-level bounded-context relationships;
- cross-context ownership boundaries;
- generic system capability ownership;
- system-wide integration policies;
- system ADRs;
- the system service/capability catalogs;
- new-service bootstrap rules.

The repository is not a runtime service, bounded context, package dependency, runtime service registry, central business-domain model, or shared persistence model.

Individual service repositories remain authoritative for their own domain semantics, exact Published Contract schemas, internal application/persistence architecture, service ADRs, and service-specific release/readiness state.

System architecture documents reference provider sources and record concise stable system-facing facts; they do not duplicate whole service specifications.

## Consequences

- New bounded contexts have one deterministic place to discover existing contexts and generic capability owners.
- System-wide decisions become reviewable without centralizing implementation.
- Service repositories retain independent domain and implementation ownership.
- Runtime code must not depend on this repository.
- Apparent inconsistencies between this repository and a service repository are reconciled through the appropriate control plane rather than silently overwritten.

## Rejected alternatives

### Keep all system knowledge only in individual repositories

Rejected because a new bounded context cannot reliably discover capabilities and cross-context ownership it does not already know to search for.

### Centralize all service architecture here

Rejected because it would duplicate provider specifications, weaken bounded-context ownership, and create unnecessary governance overhead.
