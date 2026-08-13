# System Architecture Principles

## Purpose and authority

These are the durable system-wide architecture principles for `wgt-system`. They govern ownership and system boundaries without prescribing service-internal design or deployment topology.

For accepted capability owners, consult [CAPABILITY_CATALOG.md](CAPABILITY_CATALOG.md). For concrete cross-context rules and decision models, consult [INTEGRATION_POLICY.md](INTEGRATION_POLICY.md). For context relationships and design-time service facts, consult [SYSTEM_CONTEXT.md](SYSTEM_CONTEXT.md) and [SERVICE_CATALOG.md](SERVICE_CATALOG.md).

Each bounded-context repository remains authoritative for its own domain semantics, exact Published/Application Contracts, aggregate and application semantics, internal architecture, persistence, local ADRs, technology/runtime decisions, and release/readiness state.

## Principles

1. **Domain ownership comes before topology.** DDD and capability ownership determine boundaries before repositories, processes, containers, networks, or deployment products.
2. **A bounded context is not a deployment prescription.** It is not automatically a microservice, network service, process, container, or repository.
3. **Service decomposition follows real boundaries.** Split services only for a genuine ownership or capability boundary and justified lifecycle, availability, security, scaling, platform, or fault-isolation needs—not to manufacture a target topology.
4. **Domain owners retain authority.** Each bounded context owns its domain semantics and authoritative-state semantics.
5. **Integration crosses explicit provider-owned boundaries.** Providers own the meaning and versioning of their Published/Application Contracts; consumers adapt without depending on provider internals.
6. **Published boundaries cannot be bypassed.** Shared databases, cross-context ORM or domain imports, shared persistence models, and shared business-logic libraries must not replace explicit contracts.
7. **Technical handling does not transfer ownership.** Presentation, transport, caching, replication, process co-location, and deployment leave domain ownership with the originating bounded context.
8. **Wiiii Got This owns integration and presentation semantics.** It owns device/platform integration and presentation, not the foreign business domains it presents.
9. **Conveyance owns generic durable opaque delivery.** It does not own foreign publication, command, authority, merge, conflict, or reconciliation semantics, and foreign business payloads remain opaque to it.
10. **Domain-specific distributed-state rules stay with the domain owner.** The owner of the affected domain defines publication, command, authority, merge, conflict, and reconciliation semantics before transport is selected.
11. **Existing capability ownership is checked first.** Consult the Capability Catalog before proposing generic cross-context infrastructure.
12. **Capability gaps return to the control plane.** If the conceptually correct owner exists but lacks required semantics, return the concrete requirement to the System Architecture Control Plane instead of building a competing subsystem.
13. **Local-first is not local-only.** Optional servers, relay, replication, or remote access may support a local-first domain when the domain owner explicitly defines their semantics.
14. **Remote infrastructure is not domain authority by default.** A server or remote copy does not make remotely stored state authoritative or authorize readable remote persistence.
15. **Architecture follows concrete scenarios.** Do not create speculative APIs, schemas, services, capabilities, or infrastructure for hypothetical future needs.
16. **The architecture repository is design-time only.** It is the System Architecture Control Plane, not a fifth bounded context, runtime service, package, registry, configuration source, or application dependency.
