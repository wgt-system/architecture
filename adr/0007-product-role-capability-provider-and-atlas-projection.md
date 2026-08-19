# ADR-0007: Product Roles, Shared Capability Providers, and WGT Atlas Projection

- Status: Proposed
- Date: 2026-08-19
- Tracks: #11

## Context

The system architecture currently uses `service` and `bounded context` correctly for ownership, but those terms are too coarse for product composition and WGT Atlas presentation.

A repository, process, microservice, bounded context, or deployable runtime is not automatically a first-class end-user product. Conversely, a first-class product may also provide reusable generic capabilities to other bounded contexts.

This distinction has become concrete with the current system:

- **Vocation**, **Illumination**, and **Orientation** are independently meaningful end-user product areas with substantial provider-owned workflows/Product Surfaces.
- **Orientation** additionally owns reusable generic geospatial capabilities consumed by other product contexts.
- **Conveyance** owns generic durable opaque cross-device delivery, but does not own an end-user product workflow comparable to Vocation, Illumination, or Orientation.
- future shared technical capabilities such as generic prompt execution, document/PDF processing, OCR/ML, or other specialist runtimes may be justified without becoming first-class product destinations.

The WGT Atlas must therefore not expose repository/process topology as if it were product topology. A graph that attaches every bounded context directly and equally to WGT incorrectly implies that every service is a peer end-user product.

The same distinction matters for cross-device architecture. Conveyance is intentionally transport-only. It can serve multiple domains while remaining ignorant of their business semantics, but the domain owner still owns publication, authority, merge, conflict, reconciliation, and business meaning.

## Decision

### 1. Classify system-facing bounded contexts by product role

Use these system-level roles where product composition or architecture policy needs the distinction:

#### First-class Product Provider

A bounded context that owns a substantial end-user workflow which can be entered as an independently meaningful product area inside WGT.

A First-class Product Provider may own:

- an authoritative runtime and persistence boundary;
- a provider-owned Product Surface;
- provider-owned application/published contracts;
- domain-local capabilities/features;
- generic capabilities that other contexts may consume.

Current classification:

- Vocation — First-class Product Provider;
- Illumination — First-class Product Provider;
- Orientation — First-class Product Provider and Generic Capability Provider.

#### Shared Capability Provider

A bounded context whose system role is primarily to provide reusable technical/infrastructure capability to one or more products rather than to present a substantial end-user product workflow of its own.

Current classification:

- Conveyance — Shared Infrastructure Capability Provider for durable opaque cross-device delivery.

A Shared Capability Provider is still an independent bounded context when ownership justifies that boundary. This role does not make it subordinate in domain authority; it only distinguishes product composition from implementation/service topology.

#### Dual-role Provider

A bounded context may be both a First-class Product Provider and a Generic Capability Provider.

Orientation is the current concrete example:

- full Discover / Explore / Navigate product;
- reusable generic geospatial/map/routing capabilities for other bounded contexts.

Consumers of a generic capability must not depend on the provider's full Product Surface merely because the provider is also a first-class product.

### 2. Capability is not synonymous with visible global product destination

A provider may publish application or integration capabilities without each capability becoming a first-level Atlas destination.

For example, Vocation currently exposes narrow integration capabilities such as Opportunity Overview and Map Projection. These remain valid provider-owned integration boundaries. They do not imply that the user should experience Vocation as a collection of peer global capability nodes instead of as a coherent product.

The product may present those semantics as local features, districts, landmarks, tools, or progressively disclosed detail according to WGT-owned presentation design.

The architecture remains authoritative for ownership and relationships; WGT owns the user-facing spatial projection.

### 3. Repository, process, runtime, and microservice boundaries do not determine Atlas/product hierarchy

Do not infer first-class product status from any of:

- a separate Git repository;
- a separate process/container;
- a separate language/runtime;
- a server deployment;
- an independently versioned package;
- a separate bounded context alone.

Likewise, do not hide a genuine first-class product merely because it currently runs in-process or is bundled with WGT.

Product hierarchy is based on end-user product meaning and accepted capability relationships, not deployment topology.

### 4. WGT Atlas projects product and capability meaning, not infrastructure diagrams

WGT owns the Atlas projection and visual metaphor under ADR-0005.

The semantic projection should follow these rules:

- WGT Core is the containing product/system hub rather than a provider peer;
- First-class Product Providers are primary navigable product regions/destinations;
- Shared Capability Providers appear in relation to the products/capabilities that actually consume them, not automatically as equal first-level product destinations;
- provider-local capabilities may appear only at closer zoom/focus when that improves comprehension;
- shared capabilities may appear as common infrastructure connected to several consuming products;
- actual runtime/microservice topology remains available through diagnostics/technical views when useful, but it is not the default end-user world model.

A presentation theme may render these semantics with settlements, districts, facilities, transport infrastructure, machinery, abstract nodes, or another WGT-owned visual language. The metaphor must not change the underlying ownership/relationship semantics.

### 5. Conveyance is shared delivery infrastructure, not a peer product

Conveyance owns generic durable opaque delivery between trusted installations. It does not own foreign business payload semantics or provider synchronization rules.

For asynchronous cross-device operation where the producing device may be offline when another device reads the data, a production Conveyance topology requires a durable network-reachable relay/runtime (or equivalent accepted remote deployment). The current loopback local/test runtime is implementation evidence, not the production cross-device topology.

The client/product side remains responsible for the accepted protection and domain boundary. Conveyance stores/transports opaque protected envelopes.

One Conveyance deployment may carry independent channels for multiple WGT product domains without those domains sharing a database or surrendering authority.

### 6. Current cross-device disposition for the three first-class products

If Vocation, Illumination, and Orientation all require durable asynchronous cross-device availability while remaining local-first, Conveyance is the accepted generic delivery owner to evaluate/reuse rather than creating one relay stack per product.

That does **not** mean all three already have the same accepted synchronization contract.

#### Vocation

The current accepted proof uses WGT plus Conveyance to transport a protected Vocation Published Opportunity Overview while the publishing Windows PC can be offline. Vocation remains transport-independent and authoritative for the published contract.

#### Illumination

Illumination is expected to need cross-device learning state if that becomes a product requirement, but Illumination must first define its own authority, merge/reconciliation, conflict, and publication/replication semantics. Conveyance can provide generic delivery after those semantics exist; it does not define them.

#### Orientation

Orientation does not need Conveyance merely to render maps, route, geocode, or perform ordinary local provider work. If persistent Orientation-owned personal state must become available asynchronously across devices, reuse Conveyance when an accepted delivery mode fits. Orientation retains authority over the spatial data and any merge/reconciliation semantics.

### 7. Future shared capability providers require concrete reuse/ownership evidence

Do not create a new first-class product or bounded context merely because two products use similar code.

A future generic prompt/research execution provider may be justified if a concrete shared operational responsibility appears, for example:

- shared model/provider credentials;
- execution queues/background work;
- common quota/cost control;
- provider failover;
- common research/tool execution;
- cross-context execution observability.

Even then, Vocation/Illumination/Orientation retain ownership of their domain-specific prompt wording, schemas, validation, provenance, and imported result semantics.

Likewise, document/PDF/OCR/ML functionality may remain provider-local specialist code, a library, a sidecar, or become a shared capability provider only when real reuse, isolation, lifecycle, security, or deployment requirements justify that boundary.

### 8. New-service/product proposals must state both bounded-context ownership and product role

Before a new system-facing service is treated as durable architecture, record:

1. what bounded-context/domain or generic capability it owns;
2. whether it is a First-class Product Provider, Shared Capability Provider, Dual-role Provider, or neither;
3. whether it needs a Product Surface;
4. which existing products consume its capabilities;
5. whether the dependency is product-level, capability-level, delivery-only, or implementation-only;
6. how the classification should be projected into WGT without exposing unnecessary infrastructure detail.

The role can evolve when real product scope changes, but the change must be explicit.

## Consequences

- Vocation, Illumination, and Orientation remain primary WGT product destinations.
- Conveyance remains an independent bounded context but is no longer conceptually equivalent to those products in the user-facing product hierarchy.
- Orientation can remain both a full product and the generic geospatial capability owner.
- WGT Atlas can scale through progressive spatial disclosure without mirroring every service/process as a peer node.
- future shared infrastructure can be visible where useful without forcing users to understand microservice topology.
- cross-device product requirements converge on the accepted generic Conveyance owner while keeping domain-specific synchronization semantics with each product.
- a production cross-device Conveyance deployment requires a durable network-reachable relay; local-only loopback execution cannot satisfy asynchronous device delivery by itself.
- no shared database, universal plugin protocol, generic domain synchronization engine, or automatic new microservice is introduced.

## Rejected alternatives

### Treat every bounded context/repository as an equal first-class WGT product

Rejected because service topology and product topology are different concerns. This makes infrastructure such as Conveyance look like a peer end-user application and scales poorly as specialist services appear.

### Hide every shared capability provider completely

Rejected. Important shared dependencies should remain explainable, discoverable, and diagnosable. The rule is progressive/contextual representation, not invisibility.

### Make WGT or Conveyance own generic synchronization semantics for every domain

Rejected. Transport can be generic; merge, conflict, authority, reconciliation, and business semantics remain with the domain owner.

### Turn common prompt/PDF/OCR mechanics into first-class services immediately

Rejected as premature. Promote them only when concrete ownership/reuse/deployment evidence justifies the boundary.

## Relationship to existing decisions

- ADR-0002 remains authoritative for cross-context integration and capability ownership.
- ADR-0003 remains authoritative for Orientation's generic geospatial capability ownership.
- ADR-0004 remains authoritative that domain-specific prompt/import semantics stay with their owning contexts absent a later explicit shared-execution decision.
- ADR-0005 remains authoritative for WGT-owned product composition and provider-owned Product Surfaces.
- ADR-0006 remains the proposed runtime/packaging policy for first-class products and specialist runtimes.

This ADR classifies product roles and Atlas-facing system semantics; it does not define service-internal implementation or a mandatory visual theme.