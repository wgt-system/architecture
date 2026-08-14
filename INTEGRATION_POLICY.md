# Cross-Context Integration Policy

## Scope

These are binding system-level integration policies for accepted and future `wgt-system` bounded contexts.

## Policies

1. **Bounded-context ownership is preserved across integration.** Presentation, transport, caching, replication, or process co-location does not transfer business ownership.
2. **The provider owns the meaning and versioning of its Published Contract.** Consumers adapt to that explicit boundary rather than depending on provider internals.
3. **Consumers do not import provider domain classes.** Boundary DTOs/contracts are not shared domain entities.
4. **No cross-context direct database access.** One bounded context never reads or writes another bounded context's tables as an integration mechanism.
5. **No shared persistence models as integration contracts.** Shared ORM entities or database schemas must not become cross-context APIs.
6. **No shared business-logic library may bypass a published boundary.** Reuse does not justify hidden domain coupling.
7. **Transport must not silently become domain authority.** Moving or storing data does not assign business truth to the transport owner.
8. **Wiiii Got This may integrate and present foreign capabilities without owning their business semantics.** WGT owns its device/platform integration and presentation decisions.
9. **Conveyance may deliver opaque protected payloads without owning foreign domain semantics.** Adding a new domain must not require Conveyance to understand that domain's objects.
10. **Domain-specific merge, conflict, authority, and reconciliation semantics remain with the owning bounded context.** Generic transport cannot invent them.
11. **Existing generic capabilities must be checked before adding duplicate infrastructure.** Consult the Capability Catalog first.
12. **A missing generic capability triggers an architecture decision, not a silent competing subsystem.** If the existing owner is conceptually correct but insufficient, return the requirement to the System Architecture Control Plane.
13. **Local-first does not mean “never use a server.”** Optional servers/relay infrastructure are compatible with local authority when the domain says so.
14. **A server does not imply that readable authoritative domain state belongs remotely.** Data authority and deployment topology are separate decisions.
15. **Cross-device replication, upload, or caching of foreign data requires explicit semantics from the owning bounded context.** Technical feasibility is not authorization.
16. **Published Contracts should remain transport-independent unless transport semantics are genuinely part of the provider contract.** HTTP, IPC, files, or Conveyance are adapters/topology unless the contract explicitly says otherwise.
17. **Do not create speculative APIs or schemas merely to reserve future integration.** Concrete scenarios must justify semantics before contracts are frozen.
18. **Orientation owns generic geospatial capability.** Consumers adapt provider-owned data into generic spatial scenes/results; Orientation does not acquire foreign business semantics or authoritative persistence.
19. **Provider/WGT composition is explicit.** A provider may call Orientation and interpret the result; WGT may compose provider-owned data with Orientation for presentation. Rich spatial projections and external resources are permitted when the provider remains authoritative for their meaning.
20. **Bounded context, repository, runtime artifact, and network service are distinct.** Orientation may contain Java/Maven, TypeScript/MapLibre, and external Valhalla integration without requiring separate repositories, microservices, or a remote Orientation service.

## Design-time Service Catalog vs runtime Service Registry

**Service Catalog** in this repository means design-time architecture documentation: what bounded contexts exist, what they own, and where their authoritative specifications live.

A **runtime Service Registry** is runtime discovery technology or a runtime domain capability. Examples might include Consul, Kubernetes service discovery, or a future dedicated WGT-system registry.

The existence of this repository creates **no requirement** for a runtime registry, Kubernetes, Consul, or another discovery product.

## Cross-device decision model

### Case A — same-device/local integration

```text
Provider Published/Application Contract
    -> WGT or another local consumer
```

Conveyance may be unnecessary. Prefer the simplest boundary that preserves ownership.

### Case B — cross-device read snapshot

```text
Domain provider
    -> provider-owned Published Contract
    -> WGT/client integration
    -> client-side protection
    -> Conveyance Current Object
    -> WGT/client on another device
    -> verify/decrypt
    -> validate provider contract
```

This matches the accepted Vocation read direction. It is not a universal pattern for domains that require different semantics.

### Case C — bidirectional/domain-changing synchronization

The owning bounded context must first define:

- command/change semantics;
- ordering requirements;
- authority rules;
- merge behavior;
- conflict behavior;
- reconciliation.

Only then decide whether an accepted Conveyance delivery mode can transport the required opaque information. Conveyance must not invent these domain semantics.

### Case D — required generic transport semantics do not exist

Do **not** default to:

```text
my-service/internal/relay
```

Raise the requirement to the System Architecture Control Plane. The result may be to extend Conveyance with another generic delivery mode, reuse another accepted capability, or justify a genuinely separate component.
