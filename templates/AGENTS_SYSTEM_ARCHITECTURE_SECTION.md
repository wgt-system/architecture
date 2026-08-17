## WGT System Architecture

This repository is one bounded context within the `wgt-system` organization.

The system-level architecture source of truth is:

`wgt-system/architecture`

Before introducing any of the following, consult the system Capability Catalog and Integration Policy:

- cross-context integration;
- synchronization or replication;
- generic relay or storage infrastructure;
- service discovery/registry infrastructure;
- shared cross-context infrastructure;
- another system-wide capability.

Do not independently implement a generic capability already owned by another accepted bounded context.

In particular, **generic durable opaque cross-device delivery is owned by Conveyance**.

**Generic geospatial capability is owned by Orientation**, including spatial scenes/features,
map rendering and provider integration, discovery/geocoding, routing, and generic current
location representation. This does not transfer Vocation, Illumination, or other provider
business semantics to Orientation, and does not prescribe a separate process or network service.

This does not transfer domain-specific publication, command, authority, merge, conflict, reconciliation, or business-payload semantics to Conveyance. Those remain owned by the relevant domain bounded context.

If an existing system capability does not satisfy a concrete requirement, return the requirement to the System Architecture Control Plane rather than silently creating a competing subsystem.

Do not make runtime code depend on the architecture repository.
