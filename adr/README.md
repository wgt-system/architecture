# System Architecture Decision Records

This directory contains ADRs whose scope is genuinely system-wide.

## Put an ADR here when the decision

- affects ownership or interaction between multiple bounded contexts;
- establishes an organization-wide architecture rule;
- assigns or changes ownership of a generic system capability;
- changes a system-wide integration boundary.

## Keep an ADR in the service repository when the decision concerns

- internal persistence technology;
- internal frameworks or package layout;
- aggregate/entity design;
- local API implementation detail;
- service-specific domain behavior;
- service-specific deployment detail that does not change the system boundary.

A service ADR may have system consequences. If those consequences change system ownership/policy, record the system decision here and link back to the provider source rather than copying its implementation detail.

## ADR format

Each ADR should state:

- status;
- context;
- decision;
- consequences;
- rejected alternatives when they materially clarify the boundary.

Current records:

- [ADR-0001 — System Architecture Repository](0001-system-architecture-repository.md)
- [ADR-0002 — Cross-Context Integration and Capability Ownership](0002-cross-context-integration-and-capability-ownership.md)
- [ADR-0003 — Orientation Geospatial Capability Ownership](0003-orientation-geospatial-capability-ownership.md)
- [ADR-0004 — Orientation Product Autonomy and Domain-Owned Prompt/Import Semantics](0004-orientation-product-autonomy-and-prompt-ownership.md)
- [ADR-0005 — Provider-Owned Product Surfaces in Wiiii Got This](0005-wgt-provider-owned-product-surfaces.md)
- [ADR-0006 — Cross-Platform Product Surface, Runtime, and Packaging Policy](0006-cross-platform-product-runtime-packaging-policy.md) *(Proposed)*
- [ADR-0007 — Product Roles, Shared Capability Providers, and WGT Atlas Projection](0007-product-role-capability-provider-and-atlas-projection.md) *(Proposed)*
