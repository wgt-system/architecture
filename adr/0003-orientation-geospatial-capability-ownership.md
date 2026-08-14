# ADR-0003: Orientation geospatial capability ownership

- **Status:** Accepted
- **Date:** 2026-08-14

## Context

The system has generic map, geocoding and spatial interaction duplication across provider
contexts and WGT. Discover, Explore, Navigate and generic Current Location form one coherent
capability boundary, while provider business semantics remain distinct.

## Decision

Accept **Orientation** as the fifth system bounded context and generic geospatial capability
owner. Orientation owns generic spatial scenes/features/layers, renderer lifecycle,
basemap/provider integration, clustering/selection, concrete place discovery, geocoding,
reverse geocoding, routing, route geometry/distance/duration/directions, and current-position
representation.

Vocation retains Work Location/Precision and job-market meaning; Illumination retains learning
meaning; WGT retains product shell, navigation, platform/device permission and presentation;
Conveyance retains durable opaque delivery. Orientation does not own foreign authoritative
persistence or provider business semantics.

Providers may consume Orientation results when interpreting them. WGT may compose provider-owned
data with Orientation for presentation. Rich provider-owned spatial projections, marker details,
and external resources are explicitly allowed; their meaning remains with the provider. The
historical Vocation URL-free Map Projection 1.0 is not a system invariant, and its closed schema
must be superseded by a versioned successor rather than mutated in place.

One bounded context/repository may contain a Java/Maven backend, a TypeScript/MapLibre map
surface, and an adapter to external upstream Valhalla C++. This decision does not require one
process, a network service, or a remote microservice, and does not justify separate
Cartography/Routing/Discovery repositories.

## Consequences

- Generic map/geocoder/routing duplication becomes migration debt after Orientation replacement gates pass.
- Vocation and WGT migration work remains in those owning repositories and is not performed here.
- Provider contracts remain provider-owned and consumers use explicit adapters/contracts.
- Orientation's reference host is a validation surface, not the WGT product UI.

## Rejected alternatives

- **WGT owns all generic maps:** would couple reusable geospatial semantics to product shell and platform presentation.
- **Vocation owns generic maps:** would transfer job-domain concerns to a provider context and cannot serve Illumination or other consumers cleanly.
- **Shared map helper/library only:** would leave geocoding, routing, provider policy and lifecycle ownership fragmented.
- **Immediate separate map/geocoder/router bounded contexts:** speculative decomposition without separate ownership or lifecycle scenarios.
- **Mandatory remote Orientation microservice:** confuses bounded context with network topology and adds availability/deployment coupling without a concrete requirement.
