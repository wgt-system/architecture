# New Service / Bounded Context Checklist

Use this checklist before accepting a new `wgt-system/<service>` bounded context or substantial system-facing capability.

## A. Domain

- [ ] What business/domain capability does this bounded context own?
- [ ] Why is it a distinct bounded context rather than an internal module of an existing one?
- [ ] What does it explicitly **not** own?

## B. Authority

- [ ] Which state is authoritative here?
- [ ] Is the bounded context local-first, remote-first, or mixed?
- [ ] What data may be replicated, cached, published, or stored remotely?
- [ ] What data must remain local or otherwise constrained?

## C. Existing system capabilities

- [ ] Have we checked `CAPABILITY_CATALOG.md`?
- [ ] Does Wiiii Got This already own the integration/presentation concern?
- [ ] Does Conveyance already own the required generic delivery concern?
- [ ] Is another accepted bounded context the actual owner?
- [ ] Are we about to duplicate a generic capability only because the new service is being developed independently?

## D. Integration

- [ ] Which explicit contracts does this bounded context provide?
- [ ] Which contracts does it consume?
- [ ] Who owns the meaning/versioning of each contract?
- [ ] Is each Published Contract transport-independent unless transport semantics genuinely belong in it?
- [ ] Is an adapter or Anticorruption Layer required?
- [ ] Are direct foreign database/domain-class dependencies absent?

## E. Cross-device semantics

If cross-device behavior is required, classify it before choosing transport:

- [ ] read-only snapshot publication?
- [ ] command forwarding?
- [ ] replicated state?
- [ ] ordered changes?
- [ ] bidirectional synchronization?
- [ ] merge/reconciliation?

Do not choose a relay, queue, stream, database, or protocol before these semantics are understood.

## F. Conveyance decision

**Does an accepted Conveyance delivery mode satisfy the generic delivery requirement?**

If **yes**:

- [ ] reuse Conveyance through the correct client/integration boundary;
- [ ] keep the business payload opaque to Conveyance;
- [ ] keep publication, command, authority, merge, conflict, and reconciliation semantics with the domain owner.

If **no**:

- [ ] do **not** create a private generic relay inside the new business service;
- [ ] raise the concrete requirement to the System Architecture Control Plane;
- [ ] decide explicitly whether Conveyance should gain another generic mode, another existing capability applies, or a separate infrastructure component is justified.

## G. Runtime

- [ ] Do we actually need another network service?
- [ ] Does this bounded context need to be independently deployable?
- [ ] Would an in-process adapter or local out-of-process boundary be sufficient?
- [ ] Are repository/process/container boundaries being derived from real lifecycle, availability, security, scaling, or platform requirements rather than from domain nouns?

## H. Documentation after acceptance

- [ ] Add/update the bounded context in `SERVICE_CATALOG.md`.
- [ ] Add accepted system capability ownership to `CAPABILITY_CATALOG.md` when applicable.
- [ ] Update `SYSTEM_CONTEXT.md` if a system-level relationship changed.
- [ ] Create a system ADR only when the decision is genuinely system-wide.
- [ ] Add the standard WGT System Architecture section to the new repository's `AGENTS.md`.
- [ ] Keep exact domain schemas and internal architecture in the owning service repository.
