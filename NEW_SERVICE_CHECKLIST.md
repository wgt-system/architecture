# New Service / Bounded Context Checklist

Use this checklist before accepting a new `wgt-system/<service>` bounded context or substantial system-facing capability.

## A. Domain

- [ ] What business/domain capability does this bounded context own?
- [ ] Why is it a distinct bounded context rather than an internal module of an existing one?
- [ ] What does it explicitly **not** own?

## B. Product role

Classify product meaning separately from repository/process topology.

- [ ] Is this a First-class Product Provider, Shared Capability Provider, Dual-role Provider, or neither?
- [ ] If it is a First-class Product Provider, what substantial end-user workflow makes it independently meaningful inside WGT?
- [ ] If it is a Shared Capability Provider, which concrete products/capabilities consume it?
- [ ] If it is dual-role, which full product workflow and which generic capabilities are deliberately separate?
- [ ] Are we accidentally treating a repository, process, microservice, or bounded context as a peer end-user product merely because it is independently deployed?
- [ ] Does it need a provider-owned Product Surface, or only a capability/application boundary?
- [ ] How should WGT project this role without exposing unnecessary implementation topology?

## C. Authority

- [ ] Which state is authoritative here?
- [ ] Is the bounded context local-first, remote-first, or mixed?
- [ ] What data may be replicated, cached, published, or stored remotely?
- [ ] What data must remain local or otherwise constrained?

## D. Existing system capabilities

- [ ] Have we checked `CAPABILITY_CATALOG.md`?
- [ ] Does Wiiii Got This already own the integration/presentation concern?
- [ ] Does Conveyance already own the required generic delivery concern?
- [ ] Is another accepted bounded context the actual owner?
- [ ] Are we about to duplicate a generic capability only because the new service is being developed independently?

## E. Integration

- [ ] Which explicit contracts does this bounded context provide?
- [ ] Which contracts does it consume?
- [ ] Who owns the meaning/versioning of each contract?
- [ ] Is each Published Contract transport-independent unless transport semantics genuinely belong in it?
- [ ] Is an adapter or Anticorruption Layer required?
- [ ] Are direct foreign database/domain-class dependencies absent?

## F. Cross-device semantics

If cross-device behavior is required, classify it before choosing transport:

- [ ] read-only snapshot publication?
- [ ] command forwarding?
- [ ] replicated state?
- [ ] ordered changes?
- [ ] bidirectional synchronization?
- [ ] merge/reconciliation?

Do not choose a relay, queue, stream, database, or protocol before these semantics are understood.

## G. Conveyance decision

**Does an accepted Conveyance delivery mode satisfy the generic delivery requirement?**

If **yes**:

- [ ] reuse Conveyance through the correct client/integration boundary;
- [ ] keep the business payload opaque to Conveyance;
- [ ] keep publication, command, authority, merge, conflict, and reconciliation semantics with the domain owner;
- [ ] if producer and consumer may not be online simultaneously, identify the durable network-reachable Conveyance relay/runtime deployment and its trust/security gate;
- [ ] ensure one shared Conveyance deployment/channel model can be reused where appropriate instead of creating one relay stack per product.

If **no**:

- [ ] do **not** create a private generic relay inside the new business service;
- [ ] raise the concrete requirement to the System Architecture Control Plane;
- [ ] decide explicitly whether Conveyance should gain another generic mode, another existing capability applies, or a separate infrastructure component is justified.

## H. Runtime and packaging

For a First-class Product Provider, answer the complete target-platform topology **before** the authoritative stack is treated as durable.

- [ ] What is the authoritative runtime and persistence boundary?
- [ ] What is the provider-owned Product Surface?
- [ ] What is the optional Standalone/Admin/Dev Host?
- [ ] Windows runtime/packaging disposition defined?
- [ ] macOS runtime/packaging disposition defined?
- [ ] Linux runtime/packaging disposition defined?
- [ ] iOS/iPadOS runtime/packaging disposition defined without assuming desktop subprocess semantics?
- [ ] Android runtime/packaging disposition defined?
- [ ] Which specialist capabilities use a different technology, and why?
- [ ] Are specialist capabilities internal modules, in-process libraries, provider-owned sidecars, separate bounded contexts, or remote capabilities for a real reason?
- [ ] What data may leave the device for remote capabilities?
- [ ] Which provider changes require a WGT rebuild/sign/release?
- [ ] What compatibility metadata/version gates are required?
- [ ] What CI and physical-device/runtime evidence will establish support?

For every bounded context/capability proposal:

- [ ] Do we actually need another network service?
- [ ] Does this bounded context need to be independently deployable?
- [ ] Would an in-process adapter or local out-of-process boundary be sufficient?
- [ ] Are repository/process/container boundaries being derived from real lifecycle, availability, security, scaling, reuse, or platform requirements rather than from domain nouns?

## I. Documentation after acceptance

- [ ] Add/update the bounded context and its product role in `SERVICE_CATALOG.md`.
- [ ] Add accepted system capability ownership to `CAPABILITY_CATALOG.md` when applicable.
- [ ] Update `SYSTEM_CONTEXT.md` if a system-level relationship changed.
- [ ] Create a system ADR only when the decision is genuinely system-wide.
- [ ] Add the standard WGT System Architecture section to the new repository's `AGENTS.md`.
- [ ] Keep exact domain schemas and internal architecture in the owning service repository.
