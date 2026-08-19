# Service Catalog

## Purpose

This is a **design-time architecture catalog** of accepted system bounded contexts/services. It is not a runtime service registry and is not consumed by application code.

Detailed domain rules, exact schemas, implementation decisions, and release truth remain in each owning repository.

Product role is intentionally separate from service/deployment topology. A bounded context, repository, process, or server runtime is not automatically a first-class end-user product. Proposed ADR-0007 records the current Product Provider / Shared Capability Provider distinction used by WGT product composition.

## Wiiii Got This

- **Canonical name:** Wiiii Got This
- **Repository:** <https://github.com/wgt-system/wiiii-got-this>
- **Role:** cross-platform integration/presentation bounded context and containing product/system host.
- **Product role:** WGT Core / product host. WGT is not a provider peer inside its own Atlas.
- **Primary ownership:** devices/platforms, service/capability integration, availability/compatibility interpretation, integration configuration, navigation/invocation, Atlas/product composition, and WGT-native platform/device presentation.
- **Does not own:** Vocation or Illumination business semantics; Orientation's geospatial/spatial-research semantics; foreign persistence; generic durable relay merely because it is shared.
- **Major system-facing relationships:** consumes provider-owned Published/Application Contracts through WGT integration adapters; hosts accepted provider-owned Product Surfaces; composes Orientation's generic geospatial capabilities with provider-owned data for presentation; uses Conveyance through accepted client/integration boundaries for durable cross-device delivery scenarios.
- **Source links:** [Domain Vision](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/10_ARCHITECTURE.md), [Foreign Context Alignment](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/23_FOREIGN_CONTEXT_ALIGNMENT.md), [ADRs](https://github.com/wgt-system/wiiii-got-this/tree/dev/docs/adr).
- **Current maturity note:** Windows Vocation Opportunity Overview integration is accepted; Apple runtime/provider readiness remains governed by WGT/provider gates.

## Vocation

- **Canonical name:** Vocation
- **Repository:** <https://github.com/wgt-system/vocation>
- **Role:** local-first personal job-market bounded context.
- **Product role:** First-class Product Provider.
- **Primary ownership:** opportunities, postings, companies, observations, assessments, decisions, groups/waves, application cases, private application-material metadata, Vocation research/prompt/import semantics, and Vocation publication semantics.
- **System-facing contracts/capabilities:** `Published Opportunity Overview 1.0`; `Published Map Projection 1.0`.
- **Relationship:** WGT can enter the full Vocation Product Surface and also consume narrow Vocation-owned contracts for WGT-specific compositions; Vocation may consume Orientation's generic geospatial capabilities while retaining Work Location/Precision and job-market authority; generic map/geocoding/routing capability is not Vocation-owned; Conveyance may carry opaque protected published data without Vocation becoming transport-aware.
- **Cross-device disposition:** Vocation provides the current concrete asynchronous cross-device proof: WGT protects a Vocation publication client-side and uses Conveyance to deliver it while the publishing PC may be offline. Vocation remains authoritative for publication meaning and does not acquire a direct runtime dependency on Conveyance.
- **Source links:** [Domain Vision](https://github.com/wgt-system/vocation/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/vocation/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/vocation/blob/dev/docs/10_ARCHITECTURE.md), [Cross-device Publication ADR](https://github.com/wgt-system/vocation/blob/dev/docs/adr/0010-wgt-cross-device-read-publication.md), [Opportunity Overview schema](https://github.com/wgt-system/vocation/blob/dev/schemas/published-opportunity-overview-v1.schema.json), [Map Projection schema](https://github.com/wgt-system/vocation/blob/dev/schemas/published-map-projection-v1.schema.json).
- **Current maturity note:** both listed Published Contracts are frozen/implemented on `dev`; exact schemas remain Vocation-owned.

## Illumination

- **Canonical name:** Illumination
- **Repository:** <https://github.com/wgt-system/illumination>
- **Role:** local-first personal-learning bounded context.
- **Product role:** First-class Product Provider.
- **Primary ownership:** Learning Items, reference solutions, hints, decks, Reviews, learning assessment/state, repetition scheduling, study sessions, progress, learning-content prompt/import semantics, and future domain-specific synchronization/reconciliation semantics.
- **Relationship:** WGT is the containing product for normal integrated use through explicit Illumination-owned Product Surface/application boundaries; Illumination remains independently authoritative for learning semantics and state.
- **Cross-device disposition:** when durable asynchronous learning-state availability across devices is required, Conveyance is the accepted generic delivery owner to evaluate/reuse. Illumination must first define its own publication/replication, authority, merge/conflict, and reconciliation semantics; Conveyance does not provide those domain rules.
- **System-facing contract status:** no speculative concrete WGT synchronization contract is frozen merely because cross-device delivery infrastructure exists.
- **Source links:** [Domain Vision](https://github.com/wgt-system/illumination/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/illumination/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/illumination/blob/dev/docs/10_ARCHITECTURE.md), [ADRs](https://github.com/wgt-system/illumination/tree/dev/docs/adr).
- **Current maturity note:** V1 local runtime architecture is accepted; future synchronization must first define Illumination-owned domain semantics.

## Conveyance

- **Canonical name:** Conveyance
- **Repository:** <https://github.com/wgt-system/conveyance>
- **Role:** generic Synchronization/Relay bounded context.
- **Product role:** Shared Infrastructure Capability Provider, **not** a first-class peer end-user product like Vocation, Illumination, or Orientation.
- **Primary ownership:** generic durable opaque delivery, Channels/Envelopes, Current Object semantics, sequencing/revision/epoch/CAS mechanics, delivery persistence, and accepted technical delivery/trust mechanisms.
- **Does not own:** foreign business semantics, foreign reconciliation, WGT presentation, or provider contract authority.
- **System-facing capability:** Current Object delivery.
- **Deployment consequence:** asynchronous cross-device delivery while producer and consumer are not simultaneously online requires a durable network-reachable Conveyance relay/runtime (or equivalent accepted remote deployment). The current loopback runtime is local/test evidence only. One production Conveyance deployment may carry opaque independent channels for several product domains without creating shared domain storage or authority.
- **Atlas consequence:** Conveyance should be projected as shared delivery infrastructure related to actual consumers/cross-device scenarios, not automatically as an equal first-level product destination.
- **Source links:** [Domain Vision](https://github.com/wgt-system/conveyance/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/conveyance/blob/dev/docs/06_CONTEXT_MAP.md), [Contracts](https://github.com/wgt-system/conveyance/blob/dev/docs/08_CONTRACTS.md), [Architecture](https://github.com/wgt-system/conveyance/blob/dev/docs/10_ARCHITECTURE.md), [Current Object ADR](https://github.com/wgt-system/conveyance/blob/dev/docs/adr/0003-channel-and-current-object-v1.md), [Security Interoperability Gate](https://github.com/wgt-system/conveyance/blob/dev/docs/adr/0007-crypto-and-mtls-interoperability-gate.md), [Security Interoperability Profile](https://github.com/wgt-system/conveyance/blob/dev/docs/15_SECURITY_INTEROP_PROFILE.md).
- **Current maturity note:** Current Object/local-test baseline is available. Production security remains Conveyance-owned and gated; Go/Windows interoperability evidence is complete, while the real physical iPhone interoperability gate remains open. See Conveyance's current readiness documentation for exact evidence and status.

## Orientation

- **Canonical name:** Orientation
- **Repository:** <https://github.com/wgt-system/orientation>
- **Role:** local-first personal spatial exploration and mobility bounded context; also the reusable generic geospatial capability owner.
- **Product role:** First-class Product Provider **and** Generic Capability Provider (dual role).
- **Primary ownership:** Discover, Explore, Navigate and generic Current Location; Orientation-owned personal spatial research/collections and provenance when introduced by accepted slices; spatial scenes/features/layers; map rendering lifecycle; basemap/provider integration; clustering/selection; place discovery; geocoding/reverse geocoding; routing and route geometry/directions; future provider-neutral transit/shared-mobility/multimodal semantics; Orientation-specific research prompt/import contracts.
- **Does not own:** Vocation Work Location/Precision or job-market semantics; Illumination learning semantics; WGT shell/device permissions/platform composition; Conveyance delivery; foreign authoritative persistence; or a generic LLM/prompt execution platform.
- **Relationship:** Orientation is independently usable through its own Product Surface. Providers may also consume generic Orientation results for their own interpretation; WGT may compose provider-owned spatial data with Orientation for product presentation. Consuming Orientation's generic capability does not require embedding or depending on the full Orientation product.
- **Cross-device disposition:** map rendering, geocoding, routing, and ordinary local provider work do not inherently require Conveyance. If persistent Orientation-owned personal state must be available asynchronously across devices, Conveyance is the accepted generic delivery owner to evaluate/reuse while Orientation retains authority and any merge/reconciliation semantics.
- **Prompt/import boundary:** Orientation's spatial-research prompts and structured imports remain Orientation-owned. Similar Vocation/Illumination workflows do not create a generic prompt service by default; see system ADR-0004.
- **Source links:** [Domain Vision](https://github.com/wgt-system/orientation/blob/dev/docs/01_DOMAIN_VISION.md), [Product Direction](https://github.com/wgt-system/orientation/blob/dev/docs/16_PRODUCT_DIRECTION.md), [Context Map](https://github.com/wgt-system/orientation/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/orientation/blob/dev/docs/10_ARCHITECTURE.md), [ADRs](https://github.com/wgt-system/orientation/tree/dev/docs/adr).
- **Current maturity note:** v0.3.0 is released and accepted (2026-08-17), providing map/current-location, place search/reverse geocoding, Valhalla-backed DRIVING/CYCLING/WALKING routing and route rendering. The next product direction is the first persistent standalone spatial-research/discovery workflow.
