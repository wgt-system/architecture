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

Initial records:

- [ADR-0001 — System Architecture Repository](0001-system-architecture-repository.md)
- [ADR-0002 — Cross-Context Integration and Capability Ownership](0002-cross-context-integration-and-capability-ownership.md)
- [ADR-0003 — Orientation Geospatial Capability Ownership](0003-orientation-geospatial-capability-ownership.md)
