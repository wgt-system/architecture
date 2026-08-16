# AGENTS.md

## Purpose

This repository is the **System Architecture Control Plane** for `wgt-system`.

It owns system-level architecture meaning: bounded-context relationships, cross-context capability ownership, integration policy, system ADRs, and bootstrap rules for new contexts.

It is not a runtime service, shared library, or implementation repository.

## Source-of-truth discipline

Before changing a system-facing statement:

1. inspect the current affected service repositories, normally their active `dev` architecture state;
2. read the relevant provider-owned contracts and ADRs;
3. distinguish system-level ownership from service-internal semantics;
4. record contradictions instead of silently reconciling them;
5. prefer links plus concise stable facts over copying service specifications.
6. treat `model/workspace.dsl` as a derived visualization of accepted system architecture,
   not a normative source; if it conflicts with normative Architecture Control Plane
   documentation or ADRs, treat the model as drift and do not infer a new architecture
   decision from the diagram.

This repository is authoritative for system-level ownership and policy. Service repositories remain authoritative for their domain semantics, exact Published Contract schemas, internal architecture, and service-specific release/readiness state.

Within this repository, `ARCHITECTURE_PRINCIPLES.md` is authoritative for durable system-wide principles. `CAPABILITY_CATALOG.md` records accepted generic capability ownership, `INTEGRATION_POLICY.md` defines concrete cross-context rules, and `SYSTEM_CONTEXT.md` plus `SERVICE_CATALOG.md` record context relationships and design-time service facts. These documents complement rather than replace provider-owned specifications.

## Cross-project safety

Normal write scope from this control plane is **only `wgt-system/architecture`**.

Other `wgt-system` repositories may be read to resolve system boundaries, but must not be edited opportunistically from this context. If alignment work is required, record an external alignment finding and move that work to the owning repository's control plane.

Do not create issues, milestones, labels, commits, metadata changes, branch changes, or documentation edits in another repository unless the user explicitly authorizes crossing that project boundary.

## System-wide Git/GitHub execution policy

This policy applies to agent and worker execution across the `wgt-system` repositories unless a repository has a stricter safety rule for a specific operation.

- Use capabilities available in the current control-plane chat directly before delegating equivalent repository or GitHub work to a worker. Delegate only work the current chat cannot perform reliably, such as required local runtime/browser validation when no equivalent tool is available.
- Do not assume the GitHub connector is read-only. Use supported connector write operations directly when they satisfy the task and repository safety rules.
- An authentication or credential-helper failure observed inside an isolated execution environment such as `CodexSandboxOffline` is **not** evidence that the user's normal GitHub authentication is invalid.
- For an explicitly authorized local Git push or `gh` operation, if the isolated environment cannot access the user's credentials, retry the exact authorized operation in the normal user environment using the existing authenticated user session when that environment is available.
- Do **not** start `gh auth login`, a GitHub device flow, token regeneration, Windows Credential Manager changes, credential-helper replacement, or other authentication reconfiguration merely because an isolated sandbox cannot see existing credentials.
- Treat authentication as a real blocker only after the applicable direct connector path and/or the authorized normal-user `git`/`gh` path has actually failed. Report the concrete failing path instead of speculating about credentials.
- Do not spend repeated attempts diagnosing credential state once an authorized normal-user operation succeeds.
- Do not copy this policy into ordinary worker prompts. Workers are expected to read the applicable `AGENTS.md`; prompts should contain only task-specific exceptions or overrides.

## Architecture rules

- Check `CAPABILITY_CATALOG.md` before proposing generic cross-context infrastructure.
- Preserve bounded-context ownership across presentation, transport, caching, replication, and deployment.
- Do not introduce cross-context database access, shared domain entities, or shared business-logic libraries that bypass published contracts.
- Provider contexts own the meaning and versioning of their Published Contracts.
- Wiiii Got This owns cross-platform integration/presentation semantics, not foreign business domains.
- Conveyance owns generic durable opaque cross-device delivery, not foreign publication/command/merge/conflict/reconciliation semantics.
- If an existing generic owner is conceptually correct but lacks required semantics, return to the System Architecture Control Plane rather than creating a competing subsystem silently.
- Do not create speculative system capabilities, schemas, or deployment components without a concrete scenario.
- DDD ownership comes before repository, process, container, and network topology.

## ADR placement

Create a system ADR here only when a decision:

- changes ownership or interaction across multiple bounded contexts;
- establishes an organization-wide architecture rule;
- assigns or changes a generic system capability owner; or
- changes a system-wide integration boundary.

Keep service-specific technology, persistence, aggregate, local API, and domain-behavior ADRs in the owning service repository.

## Branch model

- `main` is accepted stable system architecture.
- `dev` is ongoing/proposed architecture work.

Do not introduce release tags merely to version documentation.

## Runtime dependency prohibition

No application or service runtime may depend on this repository as a package, configuration service, registry, or runtime source of truth.

## Control-Plane / Worker Workflow

- Canonical local path: `P:\wgt-system\architecture`.
- `main` is stable accepted system architecture; `dev` is active architecture work.
- Persistent worker chats are named `Docs #N`; they are execution contexts, not Architecture Authority.
- Workers do not create Architecture Decisions, Issues, Milestones, or scope expansions unless the Control-Plane prompt explicitly requires it.
- GitHub Issues are durable concrete work packages; Milestones group coherent Architecture/tooling initiatives and need not represent semantic-version releases. Do not invent due dates; scope, ordering, and parallelization belong to the Control Plane.
- New worker prompts use `P:\wgt-system\architecture`. Never casually delete or move alternate checkouts; before cleanup, inspect worktree registration, branch, HEAD, remote, dirty state, and unpushed commits.
