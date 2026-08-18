# ADR-0005: Provider-Owned Product Surfaces in Wiiii Got This

- Status: Accepted
- Date: 2026-08-18

## Context

Wiiii Got This is evolving from a conventional application shell toward the WGT Atlas: a WGT-owned product-composition surface over independently owned bounded contexts and capabilities.

The first concrete WGT integrations intentionally used narrow provider-owned Published Contracts and WGT-native presentation. That remains appropriate for WGT-specific cross-service compositions and bounded read surfaces. It becomes problematic, however, if the same rule is applied to the complete product experience of rich bounded contexts.

Three concrete services now create this pressure:

- **Vocation** already has a substantial provider-owned React/FastAPI product surface and owns the complete job-market workflow. Rebuilding that workflow in WGT would duplicate presentation behavior and increase pressure for WGT to understand Vocation-specific interaction semantics.
- **Illumination** is a local .NET capability runtime whose accepted architecture already identifies WGT as its primary Windows/iPhone end-user presentation while retaining Illumination ownership of learning semantics and state.
- **Orientation** is independently useful as a Discover / Explore / Navigate product and already distinguishes its full standalone browser application from its deliberately narrow reusable Embed Host for generic map composition.

WGT service-local ADR-0009 currently establishes WGT-native executable presentation as the default and states that WGT is not normally a container for foreign application UIs. That decision was sound for the first narrow integration slices but does not address full-service capability parity without duplicate UI implementations.

The product requirement is:

> A supported WGT client should expose the real useful product capability of an integrated service rather than an intentionally reduced WGT-specific or mobile-specific subset, while preserving bounded-context ownership.

Platform-specific composition and effects may differ. Business capability must not be arbitrarily removed merely because a service is accessed through WGT or from a smaller device.

## Decision

### 1. Distinguish WGT-owned composition from provider-owned product presentation

WGT owns:

- the Atlas and other WGT-level navigation/composition;
- integration identity, enablement and capability availability presentation;
- device/platform host behavior;
- cross-service composition that is genuinely a WGT product concern;
- transitions between the Atlas and focused service experiences;
- WGT-global presentation settings and accessibility/effect policy;
- host-level loading, failure isolation and lifecycle behavior.

A provider bounded context may own a **Product Surface** that presents a substantial provider-specific workflow when duplicating that workflow in WGT would be wasteful or ownership-blurring.

A Product Surface does not transfer domain ownership to WGT and does not allow WGT to bypass provider contracts/application boundaries.

### 2. WGT-native presentation remains valid and important

This decision does not replace WGT-native presentation with WebViews or provider UI everywhere.

Use WGT-native presentation when:

- the experience is a WGT-specific composition;
- a bounded provider read/command contract maps naturally to an existing WGT presentation primitive;
- the interaction is intentionally small and does not recreate a rich provider application;
- platform-native presentation provides clear product value without duplicating the provider's whole UI.

The current narrow Vocation Opportunity Overview / Map composition work remains valid as integration evidence and as possible WGT-specific surfaces. It must not be interpreted as requiring WGT to rebuild the complete Vocation product.

### 3. Provider-owned Product Surfaces are an accepted integration shape when justified by a concrete rich service

A provider-owned Product Surface may be:

- a statically shipped native presentation component;
- a statically shipped browser/HTML/JavaScript surface hosted by WGT;
- another explicitly accepted provider-owned presentation artifact compatible with the target WGT platform.

The artifact and its integration boundary are provider-owned. WGT owns the host adapter and the way that surface enters/exits the WGT product experience.

This is not arbitrary third-party plugin execution. Executable provider integration support may still require a signed WGT application release, especially on iPhone.

### 4. Do not define one universal UI/plugin protocol yet

The first concrete provider integrations differ materially:

- Vocation naturally suggests a Windows-hosted provider web surface backed by its local provider runtime;
- Illumination naturally suggests a statically bundled .NET/native presentation contribution over its local in-process capability runtime;
- Orientation naturally suggests its provider-owned browser product for full Orientation while retaining the narrow generic Embed Host for map composition.

These differences are legitimate polyglot architecture.

WGT must first implement concrete provider-specific hosts and observe repeated host semantics. Only then may the Architecture Control Plane accept a common `Product Surface`, `Presentation Contribution`, or `Service Host` contract.

Do not create a universal mini-HTML, mini-Flutter, arbitrary declarative UI language, downloaded executable plugin framework, or common provider business API merely to make the integrations look uniform.

### 5. Host boundaries preserve ownership

A WGT Product Surface host must not:

- read a provider database directly;
- import provider domain classes into WGT Domain/Application code;
- reimplement provider business rules;
- reinterpret transport availability as provider business truth;
- silently grant permissions or network access that the user/provider model does not define;
- make the architecture repository a runtime registry or configuration source.

Provider-specific adapters may depend on explicit provider-owned application/published presentation boundaries according to the existing integration policy.

### 6. Full-service parity is a product target, not a transport shortcut

Desktop, phone landscape and phone portrait may have different layouts, density, effects and interaction composition.

They should expose the same supported provider capability set unless a capability has a genuine platform/runtime requirement that makes it unavailable. `Mobile` alone is not an acceptable reason to create a reduced product edition.

This does not claim that all current providers already have an accepted iPhone runtime topology.

In particular:

- Vocation's current Python/FastAPI local runtime is not an accepted iPhone runtime;
- Orientation's current Java/Spring local backend is not an accepted iPhone runtime;
- full mobile parity for those services therefore requires provider-owned runtime/access/synchronization decisions rather than inflating existing read-only contracts into ad-hoc write APIs.

### 7. Reusable generic capabilities remain separate from full Product Surfaces

A provider can simultaneously be:

1. a full first-class product in WGT; and
2. the owner/provider of a generic capability used by another bounded context.

Orientation is the current concrete example:

- full Orientation product surface for Discover / Explore / Navigate;
- narrow reusable generic map/geospatial capabilities consumed by Vocation or WGT composition.

Embedding the full provider product must not cause foreign contexts to depend on that full UI when a narrower generic contract already exists.

## Acceptance evidence

The first implementation evidence exists on the isolated post-v0.6 WGT Atlas stack:

- WGT keeps Atlas semantics, service/capability/dependency projection and transitions WGT-owned;
- Vocation remains a separately owned provider/runtime;
- the Vocation service node can open the existing provider-owned React/FastAPI product through a Windows WGT `NativeWebView` host;
- the host is provider-specific and accepts only loopback HTTP(S), so no universal plugin mechanism has been introduced;
- existing narrow Vocation Published Contracts remain separate and continue to support WGT-owned composed surfaces;
- the real `vocation.map_projection` -> Orientation relationship remains an explicit WGT composition dependency rather than being inferred from UI artwork;
- Illumination and Orientation can appear as known first-class WGT services without inventing capabilities before their provider-owned WGT boundaries exist.

The exact WGT evidence head `356245f6e126e08fc4fad28a5da3c1660e551a7a` passed repository CI run #131 (`32082551762`): restore, build including Avalonia/XAML compilation, all tests, and transitive package vulnerability audit.

This evidence is sufficient to accept the architectural distinction. It is not evidence that a generic Product Surface host contract exists, nor does it establish iPhone runtime support.

## Consequences

- WGT may remain visually coherent without duplicating every rich provider workflow.
- Provider UI ownership is possible without transferring provider domain authority.
- WGT-native composition remains the default for genuinely WGT-owned cross-service experiences.
- Existing narrow Published Contracts remain valid and do not automatically become full-product APIs.
- Provider-specific presentation hosting may differ by technology.
- A reusable common host contract is deferred until concrete integrations demonstrate stable common semantics.
- WGT service-local ADR-0009 requires follow-up alignment; its earlier blanket wording against foreign application UI is superseded by this decision for justified provider-owned Product Surfaces.
- Vocation, Illumination and Orientation may require their own service-local presentation/runtime decisions to satisfy this model.
- iPhone parity remains a required product direction but cannot be claimed until provider runtime topology and real Apple-device validation exist.

## Rejected alternatives

### Rebuild every provider product natively inside WGT

Rejected as the universal rule because it duplicates rich UI/workflows, increases maintenance cost, and creates pressure for WGT to absorb provider interaction semantics.

### Make every provider a WebView application

Rejected because Illumination and future services may have a more appropriate native/in-process presentation path, and a transport/rendering technology must not become the architecture.

### Define a universal provider UI schema now

Rejected as speculative. We do not yet have enough repeated integrations to know which primitives are genuinely generic.

### Treat WGT as only a launcher to independent applications

Rejected. WGT still owns Atlas, composition, device/platform integration, availability and coherent transitions. Product Surfaces operate inside explicit WGT hosting, not as unrelated external applications.

## Follow-up

- align WGT service-local ADR-0009 with this system decision on the post-v0.6 Atlas lineage;
- define concrete provider-owned WGT presentation/runtime boundaries in Illumination and Orientation before marking those services composed;
- observe those integrations before proposing any reusable generic Product Surface/Service Host contract;
- preserve real-device Apple validation as a separate platform gate.
