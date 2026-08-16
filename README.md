# We Got This! System Architecture

This repository is the **design-time system architecture source of truth** for the `wgt-system` organization.

It records the architecture **above** individual bounded contexts: system-level context relationships, capability ownership, cross-context integration policy, system ADRs, the service/capability catalogs, and bootstrap rules for future bounded contexts.

> **Before introducing generic cross-context infrastructure, check the [Capability Catalog](CAPABILITY_CATALOG.md).**

## What this repository is

- a concise map of accepted bounded contexts and their relationships;
- the normative system-wide architecture principles;
- a catalog of existing system capabilities and their owners;
- the binding integration policy between bounded contexts;
- the home for architecture decisions that are genuinely system-wide;
- the bootstrap reference for new `wgt-system/<service>` bounded contexts.

## What this repository is not

It is **not**:

- a runtime service or bounded context;
- a shared code library or package dependency;
- a runtime service registry;
- a central business-domain model;
- a shared persistence model;
- a replacement for architecture documentation inside service repositories;
- a dumping ground for service-internal details;
- a requirement for Kubernetes, a service mesh, an event bus, or any other deployment technology.

Runtime code must not depend on this repository.

## Authority and source-of-truth hierarchy

This repository is authoritative for:

- system-wide architecture principles;
- system-level bounded-context relationships;
- cross-context ownership boundaries;
- generic system capability ownership;
- system-wide integration policies;
- system-level ADRs;
- the existence and purpose of accepted system bounded contexts/services;
- new-service bootstrap rules.

Individual service repositories remain authoritative for:

- their domain semantics and domain model;
- aggregates, entities, value objects, and domain rules;
- internal application architecture and persistence;
- exact provider-owned Published Contract schemas and detailed API semantics;
- service-specific ADRs and implementation choices;
- service-specific release and readiness state.

System documents should link to service specifications and record only stable system-facing facts. They must not duplicate whole service specifications.

If this repository and a service repository appear to disagree, do not silently overwrite either side. Determine whether the disagreement concerns system-level ownership or service-internal semantics, record the inconsistency, and reconcile it through the appropriate control plane.

## Current bounded contexts

- [Wiiii Got This](https://github.com/wgt-system/wiiii-got-this) — cross-platform integration and presentation.
- [Vocation](https://github.com/wgt-system/vocation) — local-first personal job market.
- [Illumination](https://github.com/wgt-system/illumination) — local-first personal learning.
- [Conveyance](https://github.com/wgt-system/conveyance) — generic synchronization/relay delivery.
- [Orientation](https://github.com/wgt-system/orientation) — generic geospatial capability: Discover, Explore, Navigate, and Current Location representation.

Each bounded context retains ownership of its business semantics and authoritative state. Integration does not transfer that ownership.

## How to use this repository

Before designing a new bounded context or cross-context feature:

1. Read [ARCHITECTURE_PRINCIPLES.md](ARCHITECTURE_PRINCIPLES.md) for the durable system-wide rules.
2. Read [SYSTEM_CONTEXT.md](SYSTEM_CONTEXT.md) to understand existing ownership boundaries.
3. Check [CAPABILITY_CATALOG.md](CAPABILITY_CATALOG.md) before building generic infrastructure.
4. Follow [INTEGRATION_POLICY.md](INTEGRATION_POLICY.md) for concrete cross-context boundaries and the cross-device decision model.
5. Use [NEW_SERVICE_CHECKLIST.md](NEW_SERVICE_CHECKLIST.md) when introducing a bounded context.
6. Consult [SERVICE_CATALOG.md](SERVICE_CATALOG.md) for system-facing facts and provider source links.
7. Add a system ADR under [`adr/`](adr/) only when the decision is genuinely system-wide.

The Service Catalog is design-time architecture documentation. It must not be treated as runtime discovery data.

## Repository documents

- [System Architecture Principles](ARCHITECTURE_PRINCIPLES.md)
- [System Context](SYSTEM_CONTEXT.md)
- [Architecture Model](model/README.md)
- [Capability Catalog](CAPABILITY_CATALOG.md)
- [Service Catalog](SERVICE_CATALOG.md)
- [Integration Policy](INTEGRATION_POLICY.md)
- [New Service Checklist](NEW_SERVICE_CHECKLIST.md)
- [Agent Rules](AGENTS.md)
- [System ADRs](adr/README.md)
- [Reusable AGENTS section](templates/AGENTS_SYSTEM_ARCHITECTURE_SECTION.md)

## Architecture Portal

The human-facing Architecture Hub is built by Zensical. Its architecture views use
the generated pipeline:

`Structurizr DSL` → `C4-PlantUML export` → `PlantUML SVG` → `Zensical Portal`

Structurizr provides the C4 model, validation, and export; PlantUML renders the
generated SVG; Zensical publishes the human-facing hub. The local portal preview is
available at <http://localhost:18080>. Port `18081` is reserved for the optional raw
Structurizr Local authoring viewer. The `.build/` directory contains generated site
and diagram artifacts and is not versioned.

`PORTAL_BASE_URL` determines the target of generated diagram links. Use
`http://localhost:18080` locally; GitHub Pages will later use
`https://wgt-system.github.io/architecture`. The generated SVGs remain fully derived
from the same Structurizr model.

## Branch model

- `main` — accepted stable system architecture.
- `dev` — ongoing or proposed architecture work.

Architecture evolves through intentional commits and ADRs. Product-style semantic release tags are not required for this repository.
