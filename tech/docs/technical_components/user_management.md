# User Management and Access Control

!!! component-header "Info"
    **Identity Provider:** [Keycloak](https://www.keycloak.org/)

    **Access point:** <https://wwww.id.soilwise.wetransform.eu>

    **Admin console:** <https://wwww.id-admin.soilwise.wetransform.eu>

## Overview

User and organisation management, authorisation and authentication are cross-cutting concerns of the SoilWise Catalogue. Authentication and authorisation are handled through a [Keycloak](https://www.keycloak.org/) instance operated by weTransform, which acts as the central OpenID Connect (OIDC) identity provider for SWC components. Keycloak maps provider roles to internal application roles (e.g. Keycloak role `Redakteur` → hale-connect role `themeManager`) and manages user-to-organisation assignments.

The **general model** is that:

- a user shall be a member of at least one organisation.
- a user may have at least one role in every organisation that they are a member of.
- a user always acts in the context of one of their roles in one organisation (similar to GitHub contexts).
- organisations can be hierarchical, and user roles may be inherited from a parent organisation.

## Functionality

### Sign-up

User self-registration is disabled. Accounts are provisioned by administrators. For every registered user, an account is created in one of three ways:

1. **Automatically**, by providing an authentication token from a trusted authentication service containing the necessary user and organisation information (e.g. through a [DAPS](https://github.com/International-Data-Spaces-Association/IDS-G/blob/main/Components/IdentityProvider/DAPS/README.md)).
2. **Manually**, through self-registration (may only be available for users from certain domains and/or for certain roles, currently disabled).
3. **Through superuser registration**; the user receives an activation link and must set a password to complete registration.

### Authentication

Certain functionalities of the SWC are available to anonymous users, but functions that edit any system state (data, configuration, metadata) require an authenticated user. Keycloak serves as the central OIDC provider, issuing tokens that are validated by downstream services. The Keycloak client ID used is `hale-connect`, using the implicit OIDC flow. Users are assigned to the root organisation (ID `3`, "Datenportal"). Auto-login is disabled; users must explicitly log in.

Other supported authentication mechanisms include OAuth, SAML 2.0, and Active Directory via Keycloak identity brokering.

### Authorisation

Every component checks whether an authenticated user may invoke a desired action based on that user's roles in their organisation. The user interface also performs authorisation to avoid offering actions a given user may not invoke.

The internal role model follows a five-tier structure:

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

### hale-connect (Data Portal)

Login is via Keycloak OIDC. An nginx reverse proxy enforces authentication on all protected routes by validating tokens against the **user-service** (via a `/validate-auth` proxy endpoint). The user-service is the central authentication, role, and organisation management service. User self-registration is disabled; accounts are provisioned by administrators (admin contact: `admin+soilwise@wetransform.to`).

### Admin Console (resources-admin)

The Admin Console (resources-admin) at [`data.soilwise.wetransform.eu`](https://data.soilwise.wetransform.eu/#/home) is a resource management admin dashboard. Access is restricted to authenticated users with appropriate roles, backed by the same user-service and Keycloak integration as the data portal.

### Soil Companion

The Soil Companion currently uses a single-user demo authentication mechanism internal to its own service (session-based, via a `/login` endpoint). Integration with the central Keycloak instance is not yet implemented. This is a known limitation and a candidate for a future iteration.

### Other Components (*update after migration!*)

The following components handle authentication outside of the central Keycloak integration:

- **Solr API** — search index, protected by HTTP Basic Auth (not Keycloak-integrated)
- **SoilWise Catalogue (pycsw)** — public read access; authentication required only for user engagement features (feedback)
- **Virtuoso SPARQL endpoint** — managed separately; authentication configuration is outside this deployment (see [soilwise-he infrastructure](https://github.com/soilwise-he))
- **Linky (Link Liveliness Assessment)** — managed separately; see the [link-liveliness-assessment](https://github.com/soilwise-he/link-liveliness-assessment) project

## Technology

### Keycloak

[Keycloak](https://www.keycloak.org/) is the central identity provider for SWC components. Deployment details vary by environment (the dev setup uses a Docker image at `quay.io/keycloak/keycloak:26.5.2`; the production Kubernetes deployment is managed via Terraform in a separate infrastructure repository). Keycloak provides:

- OIDC-based single sign-on for all authenticated components
- Identity brokering (OAuth, SAML 2.0, Active Directory)
- Role and organisation mapping
- Admin console at `https://<keycloak_host>/auth/admin`

Note that Keycloak may serve multiple realms and clients across SWC components (e.g. a `hale-connect` client for the data portal, and separate realm/client configurations for other components such as Superset in the Kubernetes deployment).

### user-service

The [hale connect user service](https://haleconnect.com/swagger/) provides central user, role, and organisation management. It validates authentication tokens from Keycloak and enforces role-based access control across all connected components.

## Planned Work

### EU Login Integration

[EU Login](https://ecas.ec.europa.eu/) (the European Commission's authentication service, formerly ECAS) is planned as a replacement or additional identity provider alongside Keycloak in a future iteration. This would lower the barrier for European public sector users and align with eIDAS-based identity verification. No implementation has been started yet.

### Further Iteration Goals

- Integrate EU Login / eIDAS as an authoritative identity provider
- Integrate Soil Companion authentication with the central Keycloak instance
- Update remaining components to accept tokens generated by the central infrastructure
- Evaluate multi-factor authentication (e.g. authenticator app) as a second factor
- Facilitate connector-based access to data space resources using the authentication and authorisation mechanisms
