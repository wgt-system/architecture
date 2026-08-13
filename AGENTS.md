# AGENTS.md

## Purpose

This repository is the **System Architecture Control Plane** for `wgt-system`.

It owns system-level architecture meaning: bounded-context relationships, cross-context capability ownership, integration policy, system ADRs, and bootstrap rules for new contexts.

It is not a runtime service, shared library, or implementation repository.

## Source-of-truth discipline

Before changing a system-facing statement:

1. inspect the current affected service repositories, normally their active `dev` architecture state;
2. read the relevant provider-owned contracts and ADRs;
3. distinguish system-level ownership from service-internal semantics;
4. record contradictions instead of silently reconciling them;
5. prefer links plus concise stable facts over copying service specifications.

This repository is authoritative for system-level ownership and policy. Service repositories remain authoritative for their domain semantics, exact Published Contract schemas, internal architecture, and service-specific release/readiness state.

Within this repository, `ARCHITECTURE_PRINCIPLES.md` is authoritative for durable system-wide principles. `CAPABILITY_CATALOG.md` records accepted generic capability ownership, `INTEGRATION_POLICY.md` defines concrete cross-context rules, and `SYSTEM_CONTEXT.md` plus `SERVICE_CATALOG.md` record context relationships and design-time service facts. These documents complement rather than replace provider-owned specifications.

## Cross-project safety

Normal write scope from this control plane is **only `wgt-system/architecture`**.

Other `wgt-system` repositories may be read to resolve system boundaries, but must not be edited opportunistically from this context. If alignment work is required, record an external alignment finding and move that work to the owning repository's control plane.

Do not create issues, milestones, labels, commits, metadata changes, branch changes, or documentation edits in another repository unless the user explicitly authorizes crossing that project boundary.

## Architecture rules

- Check `CAPABILITY_CATALOG.md` before proposing generic cross-context infrastructure.
- Preserve bounded-context ownership across presentation, transport, caching, replication, and deployment.
- Do not introduce cross-context database access, shared domain entities, or shared business-logic libraries that bypass published contracts.
- Provider contexts own the meaning and versioning of their Published Contracts.
- Wiiii Got This owns cross-platform integration/presentation semantics, not foreign business domains.
- Conveyance owns generic durable opaque cross-device delivery, not foreign publication/command/merge/conflict/reconciliation semantics.
- If an existing generic owner is conceptually correct but lacks required semantics, return to the System Architecture Control Plane rather than creating a competing subsystem silently.
- Do not create speculative system capabilities, schemas, or deployment components without a concrete scenario.
- DDD ownership comes before repository, process, container, and network topology.

## ADR placement

Create a system ADR here only when a decision:

- changes ownership or interaction across multiple bounded contexts;
- establishes an organization-wide architecture rule;
- assigns or changes a generic system capability owner; or
- changes a system-wide integration boundary.

Keep service-specific technology, persistence, aggregate, local API, and domain-behavior ADRs in the owning service repository.

## Branch model

- `main` is accepted stable system architecture.
- `dev` is ongoing/proposed architecture work.

Do not introduce release tags merely to version documentation.

## Runtime dependency prohibition

No application or service runtime may depend on this repository as a package, configuration service, registry, or runtime source of truth.
