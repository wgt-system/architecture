# ADR-0004: Orientation product autonomy and domain-owned prompt/import semantics

- **Status:** Accepted
- **Date:** 2026-08-17

## Context

ADR-0003 correctly established Orientation as the system owner of generic geospatial capability. Its wording focused on eliminating duplicated map/geocoding/routing infrastructure across WGT and provider contexts.

The intended Orientation domain is broader: Orientation is also an independently useful personal spatial exploration and mobility application/context. Its future standalone workflows include asking spatial questions, acquiring structured external research, maintaining Orientation-owned spatial collections, exploring results and planning mobility.

Vocation and Illumination already use domain-specific prompt/structured-import workflows. Orientation will use a comparable acquisition pattern for different data and semantics. This raises two architecture questions:

1. whether Orientation should be merged with Vocation because Vocation also has spatial job-market workflows; and
2. whether repeated prompt/JSON mechanics justify a generic prompt/research microservice.

## Decision

### Orientation remains independent

Orientation remains a separate bounded context from Vocation and is explicitly both:

- an independently useful local-first personal spatial exploration/mobility context; and
- the accepted reusable generic geospatial capability owner from ADR-0003.

Vocation owns job-market meaning and lifecycle. Orientation owns generic spatial/mobility semantics plus Orientation-specific personal spatial-research state. Geographic overlap is resolved through explicit integration rather than merging the contexts.

WGT may provide cross-platform presentation/composition for Orientation but does not become owner of Orientation semantics or authoritative state.

### Domain-specific prompt/import semantics stay with the owning context

Prompt templates, requested fields, versioned JSON contracts, validation rules, provenance requirements and import translation belong to the bounded context whose authoritative data they create or update.

Therefore:

- Vocation owns Vocation research/update prompt and bundle semantics;
- Illumination owns learning-content generation prompt and import semantics;
- Orientation owns spatial-research prompt and import semantics.

External ChatGPT/research execution is an external interaction. It is not automatically a `wgt-system` bounded context or service.

No generic prompt/LLM/research microservice is accepted merely because several contexts render prompts and import JSON.

### Shared mechanics may be extracted without moving domain ownership

Non-semantic mechanics such as template rendering, copy/export helpers, schema/version display or generic JSON-schema tooling may be shared as libraries/utilities when duplication makes that useful.

A separate generic execution capability may be proposed later only when a concrete cross-context operational requirement exists, for example:

- centrally managed model/API execution;
- credentials/secrets;
- common rate limits/quotas;
- queued/background execution;
- shared web-research/citation tooling;
- provider failover;
- execution observability/cost controls.

Such a capability requires a new System Architecture decision. Even then, domain prompt/result contracts remain provider-owned.

## Consequences

- Architecture documents must not describe Orientation as infrastructure-only.
- Orientation may legitimately introduce local persistence and a first-class standalone UI for Orientation-owned product state.
- Vocation may consume Orientation geocoding/map/routing while retaining job-market authority.
- A future Vocation route-to-workplace feature is integration, not evidence that the contexts should merge.
- Similar prompt workflows across repositories do not authorize a shared business model or shared import schema.
- Public transit, shared mobility and multimodal navigation remain Orientation capability evolution, not Vocation responsibilities.
- ADR-0003 remains valid for generic geospatial ownership; this ADR clarifies the independent product role and acquisition boundary.

## Rejected alternatives

- **Merge Vocation and Orientation:** job-market and general spatial/mobility questions have different language, state, lifecycle and change drivers. The merger would make Orientation unusable as a clean independent spatial context and pollute Vocation with unrelated mobility/research concerns.
- **Treat Orientation as a shared map service only:** loses the intended standalone spatial-research/mobility product and biases architecture toward current consumers.
- **Create a generic Prompt/Research bounded context now:** the commonality is currently mechanical while meaning, schemas and import rules remain domain-specific.
- **Move prompt semantics into WGT:** WGT owns platform integration/presentation, not foreign domain acquisition contracts.
