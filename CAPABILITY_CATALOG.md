# Capability Catalog

## Purpose

This catalog answers a system-design question before implementation begins:

> Does the system already have an accepted owner for this capability?

A capability being useful to several applications does **not** automatically make it part of Wiiii Got This or justify a new bounded context. Generic infrastructure may belong to another accepted context; repeated mechanics may remain local or become shared libraries without transferring domain ownership.

## Accepted capabilities

| Capability | Kind | Owner | Status / boundary |
| --- | --- | --- | --- |
| Cross-platform service/capability integration and presentation | Integration/platform | Wiiii Got This | Accepted. WGT owns device/platform suitability, availability interpretation, integration configuration, navigation/invocation, and WGT-native presentation without taking foreign business ownership. |
| WGT-level service identity, registration/discovery, and capability availability | Integration/platform | Wiiii Got This | Accepted within the WGT bounded context. This is **not** a universal runtime Service Registry product. |
| Generic durable opaque cross-device delivery | Generic infrastructure | Conveyance | Accepted owner. Use only when durable cross-device delivery semantics are actually required. |
| Current Object delivery | Generic infrastructure | Conveyance | Accepted and implemented baseline: one current Envelope per Channel with atomic compare-and-swap and no product-visible history. |
| Job-market research/import/publication semantics | Domain capability | Vocation | Vocation owns prompt/research bundle meaning, job-market state and publication versioning. Current accepted published contracts include Published Opportunity Overview 1.0 and Published Map Projection 1.0. |
| Learning content/import/review/scheduling semantics | Domain capability | Illumination | Illumination owns learning-content generation/import semantics, Learning Items, review/assessment, repetition scheduling and learning-state transitions. |
| Personal spatial research, exploration and mobility | Domain capability | Orientation | Orientation is independently authoritative for its own personal spatial-research/discovery state and mobility workflows. This is distinct from foreign provider-domain semantics. |
| Generic geospatial capability (discover, explore, navigate, current location) | Generic capability | Orientation | Accepted owner for generic spatial scenes/features, map rendering, provider integration, geocoding, routing and current-location representation. Future transit/shared-mobility/multimodal semantics remain Orientation-owned when explicitly accepted. |
| Domain-specific prompt generation and structured import semantics | Domain capability | Bounded context owning the resulting data | Prompt wording, requested fields, versioned schema, validation, provenance and import translation stay with Vocation, Illumination, Orientation or another owning context. Similar prompt/JSON mechanics do not imply a shared bounded context. |
| Domain-specific merge, conflict, authority, and reconciliation semantics | Domain capability | Bounded context owning the affected domain | Never transferred to WGT or Conveyance merely because transport is shared. |
| Personal device/platform integration and presentation semantics | Integration/platform | Wiiii Got This | WGT-owned; transport/server control must not silently become business-domain authority. |

## Prompt / external-research decision guidance

### Keep prompt/import semantics in the domain when

- the prompt asks for domain-specific facts or content;
- the returned JSON becomes domain-owned state;
- schema/version changes track domain language and workflows;
- validation/provenance rules differ by domain;
- the current execution path is external/manual ChatGPT or equivalent.

This is the current Vocation, Illumination and Orientation situation.

### Shared mechanics do not require a service

Template rendering, copy/export helpers, schema/version display and generic JSON-schema tooling may be shared as libraries/utilities when worthwhile. They do not own the prompt or imported result meaning.

### Reconsider a generic LLM/research execution capability only when

A concrete cross-context operational problem appears, such as:

- central model/API credentials;
- common provider/model selection;
- rate limits/quotas/cost controls;
- queued/background execution;
- shared web-research/citation execution;
- provider failover;
- common execution observability.

That would require an explicit System Architecture decision. It still would not own Vocation/Illumination/Orientation result contracts.

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
| Generic LLM/research execution gateway | Not accepted | Domain prompt/import semantics remain with their owners. Raise a system decision only when a concrete shared execution/credential/queue/research-tooling requirement exists. |
| Ordered/change-stream delivery | Not accepted as a current Conveyance mode | If a concrete domain requires it, raise a system architecture decision before implementing generic transport. |
| Generic bidirectional synchronization semantics | Not accepted | Domain change/merge/reconciliation semantics cannot be genericized by default. Define domain semantics first, then evaluate transport. |

## Catalog maintenance rule

Add an entry only when ownership is accepted or an unresolved capability is important enough to prevent accidental duplication. Do not turn this file into an inventory of every internal service feature.
