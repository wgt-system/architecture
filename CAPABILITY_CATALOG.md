# Capability Catalog

## Purpose

This catalog answers a system-design question before implementation begins:

> Does the system already have an accepted owner for this capability?

A capability being useful to several applications does **not** automatically make it part of Wiiii Got This. Generic infrastructure may belong to another bounded context such as Conveyance.

## Accepted capabilities

| Capability | Kind | Owner | Status / boundary |
| --- | --- | --- | --- |
| Cross-platform service/capability integration and presentation | Integration/platform | Wiiii Got This | Accepted. WGT owns device/platform suitability, availability interpretation, integration configuration, navigation/invocation, and WGT-native presentation without taking foreign business ownership. |
| WGT-level service identity, registration/discovery, and capability availability | Integration/platform | Wiiii Got This | Accepted within the WGT bounded context. This is **not** a universal runtime Service Registry product. |
| Generic durable opaque cross-device delivery | Generic infrastructure | Conveyance | Accepted owner. Use only when durable cross-device delivery semantics are actually required. |
| Current Object delivery | Generic infrastructure | Conveyance | Accepted and implemented baseline: one current Envelope per Channel with atomic compare-and-swap and no product-visible history. |
| Job-market Published Contract semantics | Domain capability | Vocation | Vocation owns meaning/versioning. Current accepted contracts include Published Opportunity Overview 1.0 and Published Map Projection 1.0. |
| Learning review, assessment, repetition scheduling, and learning-state transitions | Domain capability | Illumination | Illumination-owned core domain semantics. |
| Domain-specific merge, conflict, authority, and reconciliation semantics | Domain capability | Bounded context owning the affected domain | Never transferred to WGT or Conveyance merely because transport is shared. |
| Personal device/platform integration and presentation semantics | Integration/platform | Wiiii Got This | WGT-owned; transport/server control must not silently become business-domain authority. |
| Generic geospatial capability (discover, explore, navigate, current location) | Generic capability | Orientation | Accepted owner for generic spatial scenes/features, map rendering, provider integration, geocoding, routing, and current-location representation. Foreign business semantics remain provider-owned. |

## Conveyance decision guidance

### Use Conveyance when

- durable cross-device delivery is required;
- producer and consumer may not be online simultaneously;
- the business payload can remain opaque to the server;
- the owning domain defines the payload and authority semantics;
- an accepted Conveyance delivery mode satisfies the required generic delivery behavior.

### Do not automatically use Conveyance when

- the interaction is local/in-process;
- a direct local provider contract is sufficient;
- the requirement is only ordinary local or direct provider invocation;
- the domain requires semantics Conveyance does not currently implement;
- ordered/event/change-stream behavior is required but no accepted delivery mode provides it;
- the design would require Conveyance to parse or interpret foreign business data.

### If Conveyance is the likely generic owner but is insufficient

**STOP. Do not create a second generic relay inside the business service.**

Return the concrete requirement to the System Architecture Control Plane. The system decision may be to:

- extend Conveyance with another genuinely generic delivery capability;
- reuse another existing system capability; or
- justify a separate infrastructure component because the requirement is materially different.

This rule prevents the system from accumulating one synchronization stack per bounded context.

## Unresolved or hypothetical capabilities

| Capability | Status | Guidance |
| --- | --- | --- |
| Universal runtime Service Registry | Unresolved | WGT currently owns its own registration/discovery semantics. Do not create Consul/Kubernetes-style runtime registry requirements from this design-time catalog. |
| Ordered/change-stream delivery | Not accepted as a current Conveyance mode | If a concrete domain requires it, raise a system architecture decision before implementing generic transport. |
| Generic bidirectional synchronization semantics | Not accepted | Domain change/merge/reconciliation semantics cannot be genericized by default. Define domain semantics first, then evaluate transport. |

## Catalog maintenance rule

Add an entry only when ownership is accepted or an unresolved capability is important enough to prevent accidental duplication. Do not turn this file into an inventory of every internal service feature.
