# System Context

## Purpose

This document is the concise system context map for accepted `wgt-system` bounded contexts. It records ownership and integration boundaries, not internal implementation design or deployment topology.

## Visual architecture model

The maintained visual system landscape is defined in
[`model/workspace.dsl`](model/workspace.dsl). It is a derived view of the normative
architecture documented here and elsewhere in the Architecture Control Plane; this
document remains authoritative for the textual system-context semantics.

The model shows major accepted integration relationships. It does not imply that every
interaction uses a network service or Conveyance.

## Wiiii Got This

**Purpose:** cross-platform integration and presentation of independently owned service capabilities.

**Owns system-facing semantics such as:**

- devices and platforms/execution environments;
- service identity at the WGT integration boundary;
- service registration/discovery semantics used by WGT;
- capabilities and capability/service availability;
- integration configuration;
- device/platform-dependent presentation;
- navigation and invocation of published capabilities.

**Does not own:**

- Vocation job-market semantics;
- Illumination learning semantics;
- Orientation spatial-research/geospatial/mobility semantics;
- foreign authoritative data or databases;
- foreign domain classes;
- generic durable relay merely because several applications need it.

**Major relationship:** consumes explicit provider-owned contracts through adapters and provides WGT-owned platform/device integration and presentation. It may also host/compose Orientation capabilities without taking Orientation ownership.

## Vocation

**Purpose:** local-first personal job-market bounded context.

**Owns:** opportunities, postings, companies, research observations, assessments, decisions, groups/waves, application cases, private application-material metadata, Vocation-specific research/prompt/import semantics, publication semantics, and other job-market concepts defined by Vocation.

**Does not own:** WGT device/platform presentation, Orientation generic geospatial/mobility semantics, or generic Conveyance transport/trust persistence.

**Current system-facing contracts:**

- `Published Opportunity Overview 1.0`;
- `Published Map Projection 1.0`.

The canonical schemas and detailed publication semantics remain Vocation-owned.

**Accepted first cross-device read direction:**

```text
Vocation
  -> Vocation-owned Published Contract
  -> WGT Windows integration
  -> client-side protection
  -> Conveyance opaque Current Object delivery
  -> WGT on another device
  -> client-side verification/decryption
  -> validation of the original Vocation Published Contract
```

This flow is a concrete Vocation read pattern, not a universal synchronization rule for every domain.

Vocation may consume Orientation's generic geospatial capabilities, including geocoding, spatial presentation or routing, when required by a concrete scenario. Vocation remains authoritative for Work Location/Precision and all job-market semantics; this relationship does not make generic map, geocoding or routing capability Vocation-owned and does not justify merging the contexts.

## Illumination

**Purpose:** local-first personal-learning bounded context.

**Owns:** learning content, Learning Items, reference solutions, hints, decks, Reviews, learning assessment, learning state, repetition scheduling, study sessions, learning progress, learning-content prompt/import semantics, and future domain-specific synchronization/reconciliation semantics.

**Does not own:** WGT device/platform integration or generic relay infrastructure.

**Major relationship:** WGT is the primary Windows/iPhone presentation. Illumination remains independently authoritative and exposes only explicit Illumination-owned application/published boundaries.

Illumination intentionally has **no frozen speculative cross-device synchronization contract** merely because Conveyance exists. Before bidirectional/domain-changing synchronization, Illumination must define the domain meaning of changes, ordering, authority, merge, conflicts, and reconciliation.

## Conveyance

**Purpose:** generic Synchronization/Relay bounded context for durable cross-device delivery between trusted installations without understanding foreign business payloads.

**Owns generic technical delivery concepts including:**

- opaque Trust Domain and Installation references where required;
- Channels and Envelopes;
- generic sequencing/revision/epoch and compare-and-swap semantics;
- durable delivery persistence;
- generic authorization/security seams;
- opaque protected payload delivery.

**Current accepted delivery mode:** `Current Object` — one logical current Envelope per Channel, atomic replacement, and no product-visible history.

**Does not own:** Vocation objects, Illumination objects, Orientation objects, WGT presentation semantics, or foreign merge/conflict/reconciliation rules.

Production security must not be described as complete until Conveyance records a full passing interoperability gate. The current real-iPhone proof remains the owning repository's gate.

## Orientation

**Purpose:** independently useful local-first personal spatial exploration and mobility bounded context for Discover, Explore, Navigate and Current Location; also the system owner of reusable generic geospatial capability.

**Owns:**

- Orientation-specific personal spatial-research and discovery semantics;
- Orientation-owned imported spatial collections/provenance when accepted by concrete slices;
- Orientation spatial-research prompt/import contracts;
- generic spatial geometry/features/layers and scenes;
- map renderer lifecycle and basemap/tile/style provider integration;
- clustering, selection and hit testing;
- place/POI discovery;
- geocoding and reverse geocoding;
- routing, route geometry, distance/duration and directions;
- generic current-position/accuracy handling;
- future provider-neutral public-transit/shared-mobility/multimodal semantics introduced by explicit slices;
- provider adapters, technical caching, performance and failure behavior.

**Does not own:** Vocation Work Location/Precision or job-market semantics; Illumination learning semantics; WGT product shell/navigation/device permission/trust/platform composition; Conveyance durable delivery; foreign authoritative persistence; or a generic LLM/prompt execution platform.

**Major relationships:** Orientation can be used directly by the user through its own application surface. A provider context may also consume Orientation when interpreting a generic result; WGT may compose provider-owned spatial data with Orientation for presentation. Rich provider-owned spatial projections and external resources do not transfer their business meaning to Orientation.

Orientation's domain-specific external-research prompts and structured import semantics remain Orientation-owned. Vocation and Illumination retain their own prompt/import semantics. Similar prompt-rendering mechanics do not create a shared bounded context; see ADR-0004.

Orientation is one bounded context and repository that may contain multiple runtime artifacts/languages. Valhalla remains an external upstream C++ routing engine behind an Orientation adapter; no separate Cartography, Routing, Discovery, Prompt or mandatory remote Orientation service is implied.

## Domain-specific prompt/import ownership

Several bounded contexts may prepare prompts for external ChatGPT and import structured results. The domain-specific prompt, schema, validation, provenance and translation semantics belong to the context whose data they create/update.

Shared non-semantic helpers may be libraries. A generic LLM/research execution service is not currently accepted; it requires a concrete cross-context operational problem and a separate architecture decision.

## Boundary invariant for future contexts

Adding a new bounded context must **not** require modifying Conveyance merely so Conveyance can understand that context's business objects.

If a new business service requires Conveyance to interpret its domain payload, the boundary is wrong. Conveyance may gain a new **generic delivery mode** only through an explicit system architecture decision; the business meaning remains with the domain owner.

## Strategic DDD rules

- Bounded-context ownership comes before repository, process, container, or network topology.
- One aggregate is not automatically one service.
- One domain noun is not automatically one microservice.
- One bounded context is not automatically one HTTP service.
- Repeated UI/prompt/import mechanics are not automatically a new bounded context.
- Shared infrastructure does not imply shared domain ownership.
- No bounded context reads or writes another bounded context's database.
- No shared ORM/domain entity model crosses bounded contexts.
- Cross-context integration uses explicit provider-owned, versioned contracts.
