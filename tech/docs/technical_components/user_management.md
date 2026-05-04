# User Management and Access Control

!!! component-header "Info"
    **Identity Provider:** [Keycloak](https://www.keycloak.org/)

    **Access point (Test system):** <https://id.soilwise.wetransform.eu/>

    **Admin console (Test system):** <https://id-admin.soilwise.wetransform.eu/>

## Overview

User and organisation management, authorisation and authentication are cross-cutting concerns of the SoilWise Catalogue. Authentication and authorisation are handled through a [Keycloak](https://www.keycloak.org/) instance operated by weTransform, which acts as the central OpenID Connect (OIDC) identity provider for SWC components. Keycloak manages roles and user-to-organisation assignments.

## Functionality

### Sign-up

User self-registration is disabled. Accounts are provisioned by administrators. For every registered user, an account is created in one of three ways:

1. **Automatically**, by providing an authentication token from a trusted authentication service containing the necessary user and organisation information (e.g. through a [DAPS](https://github.com/International-Data-Spaces-Association/IDS-G/blob/main/Components/IdentityProvider/DAPS/README.md)).
2. **Manually**, through self-registration (may only be available for users from certain domains and/or for certain roles, currently disabled).
3. **Through superuser registration**; the user receives an activation link and must set a password to complete registration.

### Authentication

Certain functionalities of the SWC are available to anonymous users, but functions that edit any system state (data, configuration, metadata) require an authenticated user. Keycloak serves as the central OIDC provider, issuing tokens that are validated by downstream services. Clients can be configured in Keycloak to facilitate the authentication in the different applications.

Other supported authentication mechanisms include OAuth, SAML 2.0, and Active Directory via Keycloak identity brokering.

### Authorisation

Every component checks whether an authenticated user may invoke a desired action based on that user's roles in their organisation. The user interface also performs authorisation to avoid offering actions a given user may not invoke.

As an example, the internal role model for the `hale-connect` application follows a five-tier structure:

| Role | Description |
| --- | --- |
| `anonymous` | Unauthenticated access; read-only access to public resources |
| `basicUser` | May read and edit their own user profile, and read organisation information |
| `dataManager` | May perform CRUD operations on data within their organisation scope |
| `themeManager` | Granted read access to publication theme configurations in own and parent organisations |
| `orgAdmin` | Full administrative access within an organisation scope |

Roles are defined using privileges: a role may `read`, `edit`, or `delete` certain resource types. Roles may be inherited from parent organisations in the hierarchy.

## Components Requiring Authentication

The following SWC components require user authentication:

### Soil Companion

The Soil Companion currently uses a single-user demo authentication mechanism internal to its own service (session-based, via a `/login` endpoint). Integration with the central Keycloak instance is not yet implemented. This is a known limitation and a candidate for a future iteration.

### Other Components

The following components handle authentication outside of the central Keycloak integration:

- **Solr API** — search index, protected by HTTP Basic Auth (not Keycloak-integrated)
- **SoilWise Catalogue (pycsw)** — public read access; authentication required only for user engagement features (feedback)
- **Virtuoso SPARQL endpoint** — managed separately; authentication configuration is outside this deployment (see [soilwise-he infrastructure](https://github.com/soilwise-he))
- **Linky (Link Liveliness Assessment)** — managed separately; see the [link-liveliness-assessment](https://github.com/soilwise-he/link-liveliness-assessment) project
- **Solr Search Engine** — direct access at `https://solr.soilwise.wetransform.eu/` requires authentication. The Search API (which queries Solr) is a separate service; direct Solr access is restricted to administrative use.
- **Data & Knowledge Administration Console (Superset)** — access at `https://superset.soilwise.wetransform.eu/` requires authentication via a dedicated Keycloak realm and client. Used for metadata validation reports and catalogue content statistics.

## Technology

### Keycloak

[Keycloak](https://www.keycloak.org/) is the central identity provider for SWC components. Deployment details vary by environment (the dev setup uses a Docker image at `quay.io/keycloak/keycloak:26.5.2`; the production Kubernetes deployment is managed via Terraform in a separate infrastructure repository). Keycloak provides:

- OIDC-based single sign-on for all authenticated components
- Identity brokering (OAuth, SAML 2.0, Active Directory)
- Role and organisation mapping
- Admin console at `https://<keycloak_host>/auth/admin`

Note that Keycloak may serve multiple realms and clients across SWC components (e.g. a `hale-connect` client (named for historical reasons) for the data portal, and separate realm/client configurations for other components such as Superset in the Kubernetes deployment).

## Planned Work

### EU Login Integration

[EU Login](https://ecas.ec.europa.eu/) (the European Commission's authentication service, formerly ECAS) is planned as a replacement or additional identity provider alongside Keycloak in a future iteration. This would lower the barrier for European public sector users and align with eIDAS-based identity verification. Implementation scope and SoilWise role in this process is under discussions with the JRC.

### Further Iteration Goals

- Integrate EU Login / eIDAS as an authoritative identity provider
- Integrate Soil Companion authentication with the central Keycloak instance
- Update remaining components to accept tokens generated by the central infrastructure
- Evaluate multi-factor authentication (e.g. authenticator app) as a second factor
- Facilitate connector-based access to data space resources using the authentication and authorisation mechanisms
