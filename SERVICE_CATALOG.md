# Service Catalog

## Purpose

This is a **design-time architecture catalog** of accepted system bounded contexts/services. It is not a runtime service registry and is not consumed by application code.

Detailed domain rules, exact schemas, implementation decisions, and release truth remain in each owning repository.

## Wiiii Got This

- **Canonical name:** Wiiii Got This
- **Repository:** <https://github.com/wgt-system/wiiii-got-this>
- **Role:** cross-platform integration/presentation bounded context.
- **Primary ownership:** devices/platforms, service/capability integration, availability/compatibility interpretation, integration configuration, navigation/invocation, and WGT-native platform/device presentation.
- **Does not own:** Vocation or Illumination business semantics; Orientation's geospatial/spatial-research semantics; foreign persistence; generic durable relay merely because it is shared.
- **Major system-facing relationships:** consumes provider-owned Published/Application Contracts through WGT integration adapters; composes Orientation's generic geospatial capabilities with provider-owned data for presentation; may use Conveyance for accepted cross-device delivery scenarios.
- **Source links:** [Domain Vision](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/10_ARCHITECTURE.md), [Foreign Context Alignment](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/23_FOREIGN_CONTEXT_ALIGNMENT.md), [ADRs](https://github.com/wgt-system/wiiii-got-this/tree/dev/docs/adr).
- **Current maturity note:** Windows Vocation Opportunity Overview integration is accepted; Apple runtime/provider readiness remains governed by WGT/provider gates.

## Vocation

- **Canonical name:** Vocation
- **Repository:** <https://github.com/wgt-system/vocation>
- **Role:** local-first personal job-market bounded context.
- **Primary ownership:** opportunities, postings, companies, observations, assessments, decisions, groups/waves, application cases, private application-material metadata, Vocation research/prompt/import semantics, and Vocation publication semantics.
- **System-facing contracts/capabilities:** `Published Opportunity Overview 1.0`; `Published Map Projection 1.0`.
- **Relationship:** WGT consumes Vocation-owned contracts; Vocation may consume Orientation's generic geospatial capabilities while retaining Work Location/Precision and job-market authority; generic map/geocoding/routing capability is not Vocation-owned; Conveyance may carry opaque protected published data without Vocation becoming transport-aware.
- **Source links:** [Domain Vision](https://github.com/wgt-system/vocation/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/vocation/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/vocation/blob/dev/docs/10_ARCHITECTURE.md), [Cross-device Publication ADR](https://github.com/wgt-system/vocation/blob/dev/docs/adr/0010-wgt-cross-device-read-publication.md), [Opportunity Overview schema](https://github.com/wgt-system/vocation/blob/dev/schemas/published-opportunity-overview-v1.schema.json), [Map Projection schema](https://github.com/wgt-system/vocation/blob/dev/schemas/published-map-projection-v1.schema.json).
- **Current maturity note:** both listed Published Contracts are frozen/implemented on `dev`; exact schemas remain Vocation-owned.

## Illumination

- **Canonical name:** Illumination
- **Repository:** <https://github.com/wgt-system/illumination>
- **Role:** local-first personal-learning bounded context.
- **Primary ownership:** Learning Items, reference solutions, hints, decks, Reviews, learning assessment/state, repetition scheduling, study sessions, progress, learning-content prompt/import semantics, and future domain-specific synchronization/reconciliation semantics.
- **Relationship:** WGT is the primary Windows/iPhone presentation through explicit Illumination-owned boundaries.
- **System-facing contract status:** no speculative concrete WGT synchronization contract is frozen merely because cross-device delivery infrastructure exists.
- **Source links:** [Domain Vision](https://github.com/wgt-system/illumination/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/illumination/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/illumination/blob/dev/docs/10_ARCHITECTURE.md), [ADRs](https://github.com/wgt-system/illumination/tree/dev/docs/adr).
- **Current maturity note:** V1 local runtime architecture is accepted; future synchronization must first define Illumination-owned domain semantics.

## Conveyance

- **Canonical name:** Conveyance
- **Repository:** <https://github.com/wgt-system/conveyance>
- **Role:** generic Synchronization/Relay bounded context.
- **Primary ownership:** generic durable opaque delivery, Channels/Envelopes, Current Object semantics, sequencing/revision/epoch/CAS mechanics, delivery persistence, and accepted technical delivery/trust mechanisms.
- **Does not own:** foreign business semantics, foreign reconciliation, WGT presentation, or provider contract authority.
- **System-facing capability:** Current Object delivery.
- **Source links:** [Domain Vision](https://github.com/wgt-system/conveyance/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/conveyance/blob/dev/docs/06_CONTEXT_MAP.md), [Contracts](https://github.com/wgt-system/conveyance/blob/dev/docs/08_CONTRACTS.md), [Architecture](https://github.com/wgt-system/conveyance/blob/dev/docs/10_ARCHITECTURE.md), [Current Object ADR](https://github.com/wgt-system/conveyance/blob/dev/docs/adr/0003-channel-and-current-object-v1.md), [Security Interoperability Gate](https://github.com/wgt-system/conveyance/blob/dev/docs/adr/0007-crypto-and-mtls-interoperability-gate.md), [Security Interoperability Profile](https://github.com/wgt-system/conveyance/blob/dev/docs/15_SECURITY_INTEROP_PROFILE.md).
- **Current maturity note:** Current Object/local-test baseline is available. Production security remains Conveyance-owned and gated; Go/Windows interoperability evidence is complete, while the real physical iPhone interoperability gate remains open. See Conveyance's current readiness documentation for exact evidence and status.

## Orientation

- **Canonical name:** Orientation
- **Repository:** <https://github.com/wgt-system/orientation>
- **Role:** local-first personal spatial exploration and mobility bounded context; also the reusable generic geospatial capability owner.
- **Primary ownership:** Discover, Explore, Navigate and generic Current Location; Orientation-owned personal spatial research/collections and provenance when introduced by accepted slices; spatial scenes/features/layers; map rendering lifecycle; basemap/provider integration; clustering/selection; place discovery; geocoding/reverse geocoding; routing and route geometry/directions; future provider-neutral transit/shared-mobility/multimodal semantics; Orientation-specific research prompt/import contracts.
- **Does not own:** Vocation Work Location/Precision or job-market semantics; Illumination learning semantics; WGT shell/device permissions/platform composition; Conveyance delivery; foreign authoritative persistence; or a generic LLM/prompt execution platform.
- **Relationship:** Orientation is independently usable. Providers may also consume generic Orientation results for their own interpretation; WGT may compose provider-owned spatial data with Orientation for product presentation. Rich provider-owned spatial projections and external resources are allowed without transferring their business meaning.
- **Prompt/import boundary:** Orientation's spatial-research prompts and structured imports remain Orientation-owned. Similar Vocation/Illumination workflows do not create a generic prompt service by default; see system ADR-0004.
- **Source links:** [Domain Vision](https://github.com/wgt-system/orientation/blob/dev/docs/01_DOMAIN_VISION.md), [Product Direction](https://github.com/wgt-system/orientation/blob/dev/docs/16_PRODUCT_DIRECTION.md), [Context Map](https://github.com/wgt-system/orientation/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/orientation/blob/dev/docs/10_ARCHITECTURE.md), [ADRs](https://github.com/wgt-system/orientation/tree/dev/docs/adr).
- **Current maturity note:** v0.3.0 is released and accepted (2026-08-17), providing map/current-location, place search/reverse geocoding, Valhalla-backed DRIVING/CYCLING/WALKING routing and route rendering. The next product direction is the first persistent standalone spatial-research/discovery workflow.
