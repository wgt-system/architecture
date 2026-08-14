# Architecture Model

## Purpose

This directory contains a derived design-time visualization of the accepted system
architecture. It is not normative, is not consumed at runtime, and does not imply that a
represented Bounded Context is a process, network service, container, repository, or
deployment unit.

The C4 System Landscape level is used here to visualize accepted system-wide Bounded
Context boundaries. This does not change the DDD rule that a Bounded Context does not
automatically correspond to a process, network service, or deployment.

## Current views

- `SystemLandscape` — the accepted five-context system landscape and its major system-facing relationships.
- Detailed service-internal architecture remains in the respective service repositories.

### Normative/system model

[`model/workspace.dsl`](workspace.dsl) is the system-wide derived visualization. The
system architecture source documents and ADRs remain authoritative.

### Unified preview workspace

[`model/hub/workspace.dsl`](hub/workspace.dsl) is a design-time navigation layer that
aggregates service-owned zoom fragments without owning their internal semantics. It
currently exposes `SystemLandscape` and the accepted WGT `WgtContainers` detail view.
The Hub prefers direct Landscape-to-service-detail navigation; System Context Views are
only introduced when they provide distinct architectural information. Vocation,
Illumination, and Conveyance zooms will follow only after their own acceptance.

## Source-of-truth rule

The normative system-wide sources remain:

- [`../ARCHITECTURE_PRINCIPLES.md`](../ARCHITECTURE_PRINCIPLES.md)
- [`../SYSTEM_CONTEXT.md`](../SYSTEM_CONTEXT.md)
- [`../CAPABILITY_CATALOG.md`](../CAPABILITY_CATALOG.md)
- [`../SERVICE_CATALOG.md`](../SERVICE_CATALOG.md)
- [`../INTEGRATION_POLICY.md`](../INTEGRATION_POLICY.md)
- [`../adr/`](../adr/)

If the model conflicts with normative Architecture Control Plane documentation or ADRs,
treat the model as drift. Correct the model or report the contradiction to the Control
Plane; never infer a new architecture decision from the diagram.

## Local usage

The supported local workflow uses the official `structurizr/structurizr` Docker image from
this directory:

```powershell
docker run --rm -v "P:\wgt-system\architecture\model:/usr/local/structurizr" structurizr/structurizr validate -w workspace.dsl
docker run --rm -v "P:\wgt-system\architecture\model:/usr/local/structurizr" structurizr/structurizr inspect -w workspace.dsl
docker run --rm -d --name wgt-architecture-structurizr -p 127.0.0.1:18080:8080 -v "P:\wgt-system\architecture\model:/usr/local/structurizr" structurizr/structurizr local
```

The Architecture Portal is the primary human-facing hub. Its Zensical site embeds the
Structurizr Static export as model visualization; Structurizr is not the portal shell.
Docker and Structurizr are not runtime dependencies of the WGT system. The host binding
is intentionally local-only; the service is not exposed on `0.0.0.0`.

Structurizr may create a `workspace.json` while running locally. It may contain layout
information and should be versioned only when deliberate manual layout is being retained;
incidental generated output is not part of this initial model.

The generated portal and Structurizr export live under `.build/` and are not versioned.
