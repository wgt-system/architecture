# Capability Catalog

## Purpose

This catalog answers a system-design question before implementation begins:

> Does the system already have an accepted owner for this capability?

A capability being useful to several applications does **not** automatically make it part of Wiiii Got This or justify a new bounded context. Generic infrastructure may belong to another accepted context; repeated mechanics may remain local or become shared libraries without transferring domain ownership.

Product role is separate from capability ownership. A bounded context can be a first-class product, a shared capability provider, or both. Proposed ADR-0007 records that distinction for WGT product composition.

## Accepted capabilities

| Capability | Kind | Owner | Status / boundary |
| --- | --- | --- | --- |
| Cross-platform service/capability integration and presentation | Integration/platform | Wiiii Got This | Accepted. WGT owns device/platform suitability, availability interpretation, integration configuration, navigation/invocation, Atlas/product composition, and WGT-native presentation without taking foreign business ownership. |
| WGT-level service identity, registration/discovery, and capability availability | Integration/platform | Wiiii Got This | Accepted within the WGT bounded context. This is **not** a universal runtime Service Registry product. |
| Generic durable opaque cross-device delivery | Generic infrastructure | Conveyance | Accepted owner. Conveyance is a Shared Infrastructure Capability Provider, not a peer end-user product. Reuse it when durable asynchronous cross-device delivery is actually required. |
| Current Object delivery | Generic infrastructure | Conveyance | Accepted and implemented baseline: one current Envelope per Channel with atomic compare-and-swap and no product-visible history. Production cross-device use requires a durable network-reachable relay/runtime plus accepted security/trust integration. |
| Job-market research/import/publication semantics | Domain capability | Vocation | Vocation owns prompt/research bundle meaning, job-market state and publication versioning. Current accepted published contracts include Published Opportunity Overview 1.0 and Published Map Projection 1.0. Vocation remains a First-class Product Provider rather than being represented merely by these integration capabilities. |
| Learning content/import/review/scheduling semantics | Domain capability | Illumination | Illumination owns learning-content generation/import semantics, Learning Items, review/assessment, repetition scheduling and learning-state transitions. Illumination is a First-class Product Provider. |
| Personal spatial research, exploration and mobility | Domain capability | Orientation | Orientation is independently authoritative for its own personal spatial-research/discovery state and mobility workflows. Orientation is a First-class Product Provider. |
| Generic geospatial capability (discover, explore, navigate, current location) | Generic capability | Orientation | Accepted owner for generic spatial scenes/features, map rendering, provider integration, geocoding, routing and current-location representation. Orientation is therefore also a Generic Capability Provider; consuming this capability does not require consuming its full Product Surface. |
| Domain-specific prompt generation and structured import semantics | Domain capability | Bounded context owning the resulting data | Prompt wording, requested fields, versioned schema, validation, provenance and import translation stay with Vocation, Illumination, Orientation or another owning context. Similar prompt/JSON mechanics do not imply a shared bounded context. |
| Domain-specific merge, conflict, authority, and reconciliation semantics | Domain capability | Bounded context owning the affected domain | Never transferred to WGT or Conveyance merely because transport is shared. |
| Personal device/platform integration and presentation semantics | Integration/platform | Wiiii Got This | WGT-owned; transport/server control must not silently become business-domain authority. |

## Product role and visibility guidance

Capability ownership and Atlas visibility are not the same thing.

- A provider-local capability may remain a narrow Published/Application Contract without becoming a global first-level destination.
- A shared capability provider may be visible contextually as common infrastructure connected to its actual consumers.
- Repository/process/microservice topology does not determine the end-user product hierarchy.
- WGT may progressively disclose capabilities at closer zoom/focus while keeping first-class Product Providers as the primary navigable product areas.

This is presentation guidance only; architecture ownership remains authoritative.

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

If accepted later, such an execution provider would normally be a shared/specialist Capability Provider unless it independently grows a substantial end-user product workflow. It must not become a first-class Atlas product merely because it is a separate microservice.

## Conveyance decision guidance

### Use Conveyance when

- durable cross-device delivery is required;
- producer and consumer may not be online simultaneously;
- the business payload can remain opaque to the server;
- the owning domain defines the payload and authority semantics;
- an accepted Conveyance delivery mode satisfies the required generic delivery behavior.

When all three first-class products eventually require this behavior, the intended architecture is to reuse Conveyance as shared generic delivery infrastructure rather than create Vocation-, Illumination-, and Orientation-specific relay stacks.

That does not imply identical domain synchronization semantics or identical payloads.

### Current product dispositions

- **Vocation:** current concrete proof uses WGT plus Conveyance for protected asynchronous cross-device delivery of a Vocation publication.
- **Illumination:** likely consumer when cross-device learning state is accepted, but Illumination must first define its own publication/replication and merge/reconciliation semantics.
- **Orientation:** ordinary map/routing/geocoding work does not require Conveyance; persistent Orientation-owned personal state may use it when asynchronous cross-device delivery is required and an accepted delivery mode fits.

### Server/relay consequence

If a producing device may be offline while another device retrieves data, local-only peer-to-peer invocation cannot satisfy the requirement by itself. Production Conveyance therefore needs a durable network-reachable relay/runtime (or equivalent accepted remote deployment).

That relay:

- stores/transports opaque protected envelopes;
- may carry independent channels for multiple product domains;
- does not become authoritative for Vocation, Illumination, or Orientation business data;
- does not create a shared domain database;
- does not define merge/conflict/reconciliation semantics.

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
| Generic LLM/research execution gateway | Not accepted | Domain prompt/import semantics remain with their owners. Raise a system decision only when a concrete shared execution/credential/queue/research-tooling requirement exists. If later accepted, classify its product role separately from its process/repository topology. |
| Shared document/PDF/OCR processing provider | Not accepted as a system bounded context | Keep specialist implementation provider-local/library/sidecar unless concrete cross-context reuse, isolation, lifecycle, security, or deployment requirements justify a shared capability owner. |
| Ordered/change-stream delivery | Not accepted as a current Conveyance mode | If a concrete domain requires it, raise a system architecture decision before implementing generic transport. |
| Generic bidirectional synchronization semantics | Not accepted | Domain change/merge/reconciliation semantics cannot be genericized by default. Define domain semantics first, then evaluate transport. |

## Catalog maintenance rule

Add an entry only when ownership is accepted or an unresolved capability is important enough to prevent accidental duplication. Do not turn this file into an inventory of every internal service feature.
