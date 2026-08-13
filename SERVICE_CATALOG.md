# Service Catalog

## Purpose

This is a **design-time architecture catalog** of accepted system bounded contexts/services. It is not a runtime service registry and is not consumed by application code.

Detailed domain rules, exact schemas, implementation decisions, and release truth remain in each owning repository.

## Wiiii Got This

- **Canonical name:** Wiiii Got This
- **Repository:** <https://github.com/wgt-system/wiiii-got-this>
- **Role:** cross-platform integration/presentation bounded context.
- **Primary ownership:** devices/platforms, service/capability integration, availability/compatibility interpretation, integration configuration, navigation/invocation, and WGT-native platform/device presentation.
- **Does not own:** Vocation or Illumination business semantics; foreign persistence; generic durable relay merely because it is shared.
- **Major system-facing relationships:** consumes provider-owned Published/Application Contracts through WGT integration adapters; may use Conveyance for accepted cross-device delivery scenarios.
- **Source links:** [Domain Vision](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/10_ARCHITECTURE.md), [Foreign Context Alignment](https://github.com/wgt-system/wiiii-got-this/blob/dev/docs/23_FOREIGN_CONTEXT_ALIGNMENT.md), [ADRs](https://github.com/wgt-system/wiiii-got-this/tree/dev/docs/adr).
- **Current maturity note:** Windows Vocation Opportunity Overview integration is accepted; Apple runtime/provider readiness remains governed by WGT/provider gates.

## Vocation

- **Canonical name:** Vocation
- **Repository:** <https://github.com/wgt-system/vocation>
- **Role:** local-first personal job-market bounded context.
- **Primary ownership:** opportunities, postings, companies, observations, assessments, decisions, groups/waves, application cases, private application-material metadata, and Vocation publication semantics.
- **System-facing contracts/capabilities:** `Published Opportunity Overview 1.0`; `Published Map Projection 1.0`.
- **Relationship:** WGT consumes Vocation-owned contracts; Conveyance may carry opaque protected published data without Vocation becoming transport-aware.
- **Source links:** [Domain Vision](https://github.com/wgt-system/vocation/blob/dev/docs/01_DOMAIN_VISION.md), [Context Map](https://github.com/wgt-system/vocation/blob/dev/docs/06_CONTEXT_MAP.md), [Architecture](https://github.com/wgt-system/vocation/blob/dev/docs/10_ARCHITECTURE.md), [Cross-device Publication ADR](https://github.com/wgt-system/vocation/blob/dev/docs/adr/0010-wgt-cross-device-read-publication.md), [Opportunity Overview schema](https://github.com/wgt-system/vocation/blob/dev/schemas/published-opportunity-overview-v1.schema.json), [Map Projection schema](https://github.com/wgt-system/vocation/blob/dev/schemas/published-map-projection-v1.schema.json).
- **Current maturity note:** both listed Published Contracts are frozen/implemented on `dev`; exact schemas remain Vocation-owned.

## Illumination

- **Canonical name:** Illumination
- **Repository:** <https://github.com/wgt-system/illumination>
- **Role:** local-first personal-learning bounded context.
- **Primary ownership:** Learning Items, reference solutions, hints, decks, Reviews, learning assessment/state, repetition scheduling, study sessions, progress, and future domain-specific synchronization/reconciliation semantics.
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
- **Current maturity note:** v0.1.0 is the local/test Current Object baseline. Production security is not approved until the owning repository records a full interoperability PASS; the real physical iPhone gate is still outstanding at bootstrap time.
