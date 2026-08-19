# ADR-0006: Cross-Platform Product Surface, Runtime, and Packaging Policy

- Status: Proposed
- Date: 2026-08-19
- Tracks: #11

## Context

ADR-0005 accepted provider-owned Product Surfaces as a first-class WGT integration shape while preserving bounded-context ownership. It intentionally did not decide how those products and their authoritative runtimes are built, packaged, started, upgraded, or made available across every WGT target platform.

The required WGT product platforms are:

- Windows;
- macOS;
- Linux;
- iOS/iPadOS;
- Android.

The current first-class providers are materially polyglot:

- **Illumination** is a .NET/Avalonia bounded context. Its current `Illumination.Desktop` application can remain a Standalone/Admin/Dev Host, while issue #54 defines extraction of a reusable Illumination-owned Product Surface for normal consumer workflows.
- **Vocation** currently packages a Python >= 3.13 application runtime with FastAPI, SQLAlchemy, Alembic and Uvicorn, plus a separately built React/TypeScript/Vite Product UI. That implementation is already substantial and is not a rewrite candidate merely because WGT itself is .NET.
- **Orientation** currently uses Java 25 / Spring Boot / SQLite JDBC for its backend and a separate TypeScript/Vite/MapLibre product/map UI. Its full Discover / Explore / Navigate product remains distinct from its narrow reusable geospatial/embed capability.

The current desktop implementation shape is not sufficient evidence for mobile. In particular, desktop process topologies such as `python -> uvicorn` or a Java/Spring sidecar cannot simply be copied to iOS. Python 3.13 supports iOS by embedding the interpreter inside an application bundle rather than by installing or launching a normal `python` executable. The current Vocation dependencies and application topology still require provider-specific compatibility evidence before that is a supported runtime.

Likewise, a rendering or UI framework must not silently decide authoritative runtime ownership. A specialist capability may have strong reasons to use Python, C++, Rust, JavaScript, a routing engine, or another technology without forcing the complete first-class product/core into that technology.

The architecture therefore needs a release-oriented rule that answers, before a new first-class service becomes entrenched:

> How does the product surface, authoritative runtime, persistence, specialist capability set, and WGT host relationship build, package, upgrade, and run on every supported WGT platform?

## Decision

### 1. Treat Product Surface, Host, authoritative Runtime, and specialist Capability as distinct architecture concerns

Use these terms consistently:

- **Product Surface**: provider-owned presentation of a substantial provider-specific consumer workflow, as accepted by ADR-0005.
- **Standalone/Admin/Dev Host**: a provider-owned executable shell used to run, administer, diagnose, or develop a Product Surface outside WGT. A host is not automatically the Product Surface itself.
- **Authoritative Runtime**: the provider-owned code and persistence boundary that owns business/domain semantics and authoritative local state for the bounded context.
- **Specialist Capability**: a bounded technical capability whose implementation technology is chosen for that capability's needs, such as PDF extraction, OCR/ML, research workers, routing, geocoding, or media processing.
- **WGT Host Adapter**: WGT-owned device/platform integration that locates or starts an accepted provider runtime, hosts an accepted Product Surface artifact, handles transitions/readiness/failure isolation, and preserves the ownership boundary.

These concepts may live in one repository and may ship in one application bundle. They are not required to be separate microservices, processes, repositories, or network services.

### 2. First-class product architecture is portable-first; specialist technology is capability-scoped

For a new first-class bounded context, the default design pressure is:

```text
portable first-class product / authoritative runtime
        ↓ explicit capability boundary
specialist capability / specialist runtime
```

This is a decision rule, not a mandate for one language or framework.

The main language/runtime of a first-class bounded context must not be selected solely because one specialist capability is easiest in that technology. Conversely, an existing mature provider must not be rewritten solely to satisfy stylistic technology uniformity.

When a specialist capability needs different technology, choose among:

1. an internal module;
2. an in-process native/library boundary;
3. a provider-owned sidecar;
4. a separate bounded context;
5. an optional remote capability.

Promote a capability to a separate process, bounded context, or remote service only when ownership, isolation, independent deployment, security, scaling, or genuine reuse justifies that boundary. Technology difference alone is insufficient.

### 3. Every first-class service requires a five-platform runtime and packaging disposition

Before a new first-class service architecture is accepted, its architecture record must explicitly classify all five required platform families:

| Platform | Required disposition |
| --- | --- |
| Windows | local/in-process, local sidecar, bundled native/runtime artifact, or explicitly remote/replicated topology |
| macOS | same classification, with signing/notarization implications identified |
| Linux | same classification, including distribution/runtime dependencies where material |
| iOS/iPadOS | embedded/in-process or explicitly remote/replicated topology; no assumption of desktop subprocess semantics |
| Android | embedded/in-process, packaged service/runtime, or explicitly remote/replicated topology |

A disposition can be `planned/not yet implemented`, but it must be technically credible and must identify the unresolved validation gate. `We will solve mobile later` is not an accepted architecture disposition.

A service does not need one identical process topology on every platform. It must preserve the same provider ownership and supported business capability set unless a concrete platform constraint makes a capability unavailable.

### 4. Local-first is an authority property, not a ban on networking

`Local-first` means the accepted authority, offline behavior, and privacy contract are explicit. It does not mean that every technical operation must execute in the same process or that remote capabilities can never exist.

For each capability that may execute remotely, the provider must define:

- what data leaves the device;
- whether the remote execution is optional or required;
- whether authoritative state remains local or is replicated;
- offline behavior;
- encryption/trust expectations;
- failure and retry semantics;
- whether the result is advisory, derived, or authoritative.

Private documents and other sensitive provider data must not be sent to a remote capability merely because mobile packaging is difficult.

A remote service is not an architectural escape hatch for an otherwise unresolved first-class mobile runtime.

### 5. Sidecars are a packaging/runtime choice, not a domain boundary

A sidecar may remain inside the provider bounded context when it exists only to execute provider-owned implementation technology.

WGT may supervise a provider sidecar only through a provider-specific host adapter and only for host concerns such as:

- locate/start;
- readiness;
- attach/reuse;
- retry/failure isolation;
- stopping only processes that WGT itself started.

WGT does not acquire the sidecar's business semantics, persistence, or API ownership.

Desktop sidecars are not automatically portable to iOS/iPadOS. A mobile implementation may require embedding, static linking, a platform service, or a provider-approved remote/replicated topology while preserving the same bounded-context authority.

### 6. Product Surface technology is independent from authoritative runtime technology

A Product Surface may be native, Avalonia/.NET, browser/HTML/JavaScript, MapLibre-backed, or another provider-owned artifact accepted for the target platform.

The existence of a React/TypeScript Product Surface does not require a JavaScript authoritative runtime. The existence of a MapLibre UI does not require a Java authoritative runtime. A .NET host does not require every provider to become .NET.

A coherent WGT product family should first share product-level design contracts where useful:

- typography tokens;
- spacing/density;
- theme and surface/elevation semantics;
- motion/reduced-motion semantics;
- accessibility expectations;
- host entry/exit behavior;
- loading/failure isolation expectations.

Those contracts must not become a universal executable UI/plugin language without repeated implementation evidence and a separate Architecture Control Plane decision.

### 7. Current provider dispositions

These are architecture dispositions for the current code, not promises of physical platform support that has not been tested.

#### WGT

- WGT owns Atlas, WGT composition/navigation, integration/device/platform state, global appearance/accessibility, transitions, and Product Surface hosting.
- Avalonia/.NET is the current WGT client direction because it targets all five required platform families.
- Atlas rendering remains a WGT-owned presentation concern. The current production investigation may use Avalonia custom drawing/composition without changing provider ownership.
- Adoption of Unity or another scene technology would require a separate evidence-based integration decision; it is not implied by this ADR.

#### Illumination

- Illumination remains .NET-owned across Domain/Application/Infrastructure.
- Normal Study/Decks/Library/Generate/Import/Insights consumer workflows should move toward a reusable **Illumination-owned Product Surface** rather than being independently recreated in WGT.
- `Illumination.Desktop` may remain a Standalone/Admin/Dev Host and may host the same reusable Product Surface.
- Admin/debug chrome may remain host-specific.
- Mobile support requires real packaging/device evidence for the resulting provider-owned Product Surface and runtime; no mobile capability reduction is accepted merely for convenience.

#### Vocation

- The current Python 3.13/FastAPI/SQLAlchemy runtime remains the authoritative implementation baseline. No rewrite is approved by this ADR.
- The existing React/TypeScript/Vite UI remains a valid provider-owned Product Surface baseline.
- The current desktop loopback/sidecar topology may remain a desktop implementation shape where packaged and validated.
- iOS/iPadOS must not launch a desktop-style `python.exe -> uvicorn` subprocess. Python 3.13 embedded mode is a technically real candidate, but Vocation's complete dependency/runtime compatibility must be validated before accepting it.
- Android likewise requires an explicit packaged runtime decision and device evidence.
- If embedded Python proves operationally unsuitable for the authoritative mobile runtime, evaluate a deliberate portable-core migration or provider-approved replicated/remote topology. Such a migration must preserve Vocation semantics and be justified against the cost/risk of rewriting a mature product.
- Python remains fully valid for specialist capabilities such as research workers or document/PDF processing even if the authoritative first-class core changes later.

#### Orientation

- The current Java 25/Spring Boot/SQLite backend remains valid implementation evidence for desktop/server execution; this ADR does not rewrite it.
- The current TypeScript/Vite/MapLibre Product UI is a separate presentation concern and does not make Java mandatory for the product core.
- The existing Java/Spring process topology is not yet an accepted iOS/iPadOS or Android authoritative runtime topology.
- Orientation must choose and validate a mobile provider runtime strategy before claiming five-platform first-class support. Options may include a portable authoritative core, platform-specific provider runtime, or an explicitly justified replicated/remote authority model.
- Generic map/routing/geospatial capabilities remain separable from the full Orientation Product Surface. Specialist routing engines may use appropriate technology without moving Orientation business ownership.

### 8. Compatibility metadata is required, but it is not a universal plugin protocol

Each first-class provider release that WGT can host must expose enough provider-owned compatibility metadata for build/release validation.

At minimum, the release model must be able to answer:

- provider/service identity;
- provider release/version;
- Product Surface artifact/version where independently versioned;
- authoritative runtime artifact/version where independently versioned;
- supported WGT host platform/architecture combinations;
- published/application contract compatibility versions used by the WGT adapter;
- whether the provider runtime is in-process, bundled, sidecar, externally installed, or remote/replicated for that platform;
- whether a provider artifact is part of the signed WGT application bundle.

This metadata may initially be provider-specific and build-time. The architecture does **not** define arbitrary runtime plugin discovery, downloaded executable providers, or one universal provider manifest schema.

A common manifest schema may be proposed only after concrete provider integrations show stable repeated fields and lifecycle semantics.

### 9. Define when a provider change requires a WGT rebuild/release

A WGT application rebuild is required when an accepted platform package changes anything that is statically part of, linked into, signed with, or host-adapted by the WGT application, including:

- an in-process Product Surface binary/library update bundled with WGT;
- an embedded provider runtime update bundled with WGT;
- a provider asset/browser bundle that ships inside the WGT application package;
- WGT host-adapter code or permissions/entitlements;
- a provider contract change that requires a different WGT adapter;
- platform packaging/signing changes.

A WGT rebuild is not inherently required when a separately released provider runtime or remote capability changes behind a compatible provider-owned boundary and the installed WGT host adapter remains compatible.

However, independent upgradeability must be a real packaging property. A loopback sidecar that is copied into the WGT installer is still part of the WGT release even if it runs in another process.

### 10. Physical platform evidence is part of acceptance

CI can prove compile/test/packaging properties. It cannot prove that a runtime topology actually behaves correctly on a target device.

A first-class platform claim requires physical or platform-appropriate runtime evidence for at least:

- startup/attach;
- persistence authority;
- Product Surface entry/return;
- offline behavior expected by the product contract;
- permissions/network behavior;
- lifecycle/background/foreground behavior where applicable;
- provider failure isolation;
- upgrade/compatibility behavior when independently versioned artifacts exist.

Simulator/emulator evidence can supplement but does not replace required real-device evidence where platform behavior materially differs.

### 11. New-service runtime gate

A proposal for a new first-class WGT service must answer before its core stack is treated as durable:

1. What owns domain/business semantics and authoritative persistence?
2. What is the provider-owned Product Surface, if the service is rich enough to need one?
3. What is the Standalone/Admin/Dev Host, if any?
4. What is the runtime/packaging disposition on Windows, macOS, Linux, iOS/iPadOS, and Android?
5. Which specialist capabilities use different technology, and why?
6. Are those capabilities internal modules, libraries, sidecars, separate bounded contexts, or remote capabilities?
7. What data can leave the device and under what authority/privacy contract?
8. Which provider changes require a WGT rebuild/release?
9. What compatibility metadata and version gates are required?
10. What CI and physical-platform evidence will establish support?

Failure to answer one of these questions does not automatically block exploratory implementation, but it blocks treating the chosen first-class runtime topology as an accepted long-term architecture.

## Current evidence snapshot

This ADR is based on current provider code rather than language preference:

- `wgt-system/vocation` `dev` at `db2bff7f67df7781cda14000bb9d10c8bae10ae3` declares Python `>=3.13` with FastAPI, SQLAlchemy, Alembic and Uvicorn in `pyproject.toml`, while `frontend/package.json` separately builds React/TypeScript/Vite.
- `wgt-system/orientation` `dev` at `7d57108d907651db531cd9760f8ecc3988a28b8e` declares Java 25 / Spring Boot / SQLite JDBC in `backend/pom.xml`, while `map/package.json` separately builds the TypeScript/Vite/MapLibre UI.
- `wgt-system/illumination` `dev` at `b766f78a333f94d004db481c1805bd43adb9a5e5` still contains Domain/Application/Infrastructure/Desktop projects; issue #54 tracks extraction of the reusable provider-owned Product Surface.
- CPython 3.13 documents iOS as an embedded-interpreter environment rather than a desktop executable/subprocess environment: <https://docs.python.org/3.13/using/ios.html>.
- Current Avalonia documentation lists Windows, macOS, Linux, iOS/iPadOS, and Android as supported targets, with support tiers and .NET requirements that vary by OS version: <https://docs.avaloniaui.net/docs/supported-platforms>.
- Spring Boot 4.1 documents a standard Java/servlet/native-image runtime model; the current Orientation Spring Boot process is therefore treated as desktop/server evidence until Orientation records and validates a mobile topology: <https://docs.spring.io/spring-boot/system-requirements.html>.

External framework documentation is evidence about technical feasibility, not evidence that a WGT/provider build has been packaged or physically validated on that platform.

## Consequences

- WGT remains polyglot without making runtime choice arbitrary.
- First-class product/runtime portability is considered before a service becomes difficult to move, rather than after desktop implementation is complete.
- Mature existing providers are preserved unless a rewrite has concrete cross-platform, packaging, maintenance, or authority benefits that exceed migration risk.
- Specialist technologies can be used aggressively behind explicit provider-owned boundaries without dictating the whole product stack.
- Product UI consistency can improve independently from runtime-language convergence.
- Mobile is not a reduced edition by default.
- iOS/iPadOS and Android are explicit architecture targets, not later add-ons.
- Local-first/privacy semantics remain explicit even when a capability is remote.
- Build-time compatibility metadata becomes necessary, while universal plugin/runtime discovery remains deferred.
- A process boundary no longer implies a bounded-context boundary, and a shared application bundle no longer implies shared domain ownership.

## Rejected alternatives

### Standardize every first-class service on .NET

Rejected. It would force unnecessary rewrites of mature polyglot providers and confuses product-family consistency with implementation-language uniformity.

### Standardize every first-class service on web technology

Rejected. Browser presentation can be an excellent Product Surface technology, but it does not solve authoritative runtime, native/mobile packaging, persistence, or specialist capability requirements.

### Keep every current desktop runtime topology unchanged on every platform

Rejected. iOS in particular invalidates assumptions about normal executable/subprocess topology, and mobile lifecycle/packaging constraints require deliberate provider decisions.

### Make every specialist capability a microservice

Rejected. Technology difference alone is not a service boundary. It adds deployment and ownership complexity without necessarily creating independent semantics or reuse.

### Move difficult mobile capabilities to a server by default

Rejected. That can silently violate local-first, privacy, offline, authority, and cost expectations.

### Define one universal provider runtime/Product Surface plugin contract now

Rejected by the same evidence rule as ADR-0005. Current providers still have materially different hosting and runtime needs. Commonality should be extracted only after repeated concrete implementations.

### Rewrite Vocation or Orientation immediately

Rejected. This ADR establishes the evaluation and acceptance gate; it does not pre-decide that the current implementations cannot be packaged successfully or that a rewrite is cheaper than embedding/adapting them.

## Follow-up

- Illumination #54: extract and validate the reusable Illumination-owned Product Surface while retaining Standalone/Admin/Dev Host responsibilities where appropriate.
- Vocation: record a provider-owned runtime ADR comparing embedded Python, deliberate portable-core migration, and replicated/remote options against the real dependency graph and five-platform requirements.
- Orientation: record a provider-owned runtime ADR for the Java/Spring authoritative backend versus mobile alternatives without conflating that choice with MapLibre/TypeScript presentation.
- WGT #49: keep provider process lifecycle supervision provider-specific and validate start/reuse/cleanup physically on desktop.
- WGT #51: keep Atlas renderer technology a WGT presentation decision and do not use it to dictate provider Product Surface/runtime technology.
- After at least two concrete cross-platform provider packaging implementations, reassess whether a common build-time compatibility manifest has enough repeated evidence to standardize.
