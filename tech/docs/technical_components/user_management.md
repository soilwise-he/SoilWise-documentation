# User Management and Access Control

User and organisation management, authorisation and authentication are complex, cross-cutting aspects of a system such as the SoilWise repository. Back-end and front-end components need to perform access control for authenticated users. Many organisations already have infrastructures in place, such as an Active Directory or a Single Sign On based on OAuth.

The **general model** we apply is that:

- a user shall be member in at least one organisation.
- a user may have at least one role in every organisation that they are a member of.
- a user always acts in the context of one of their roles in one organisation (similar to Github contexts).
- organisations can be hierarchical, and user roles may be inherited from an organisation higher up in the hierarchy.

The **basic requirements** for the SWR authentication mechanisms are:

- User authentication, and thus, provision of authentication tokens, shall be distributed ("Identity Brokering") and may happen through existing services. Authentication mechanisms that are to be supported include OAuth, SAML 2.0 and Active Directory.
- An authoritative Identity Provider, such as an eIDAS-based one, should be integrated as well.
- There shall be a central service that performs role and organisation mapping for authenticated users. This service also provides the ability to configure roles and to set up organisations and users. This central service furthermore can also provide simple, direct user authentication (username/password-based) for those users who do not bring their own authentication infrastructure.
- There may be different levels of trust establishment based on the specific authentication service used. Higher levels of trust may be required to access critical data or infrastructure.
- SWR services shall use [Keycloak](https://www.keycloak.org/){target=_blank} or [JSON Web Tokens](https://jwt.io/){target=_blank}  for authorization.
- To access SWR APIs, the same rules apply as to access the SWR through the UI.

In later iterations, the authentication and authorisation mechanisms should also be used to facilitate connector-based access to data space resources.

## Sign-up

For every registered user of SWR components, an account is needed. This account can be created in one of three ways:

1. Automatically, by providing an authentication token that was created by a trusted authentication service and that contains the necessary informaiton on the organisation of the user and the intended role (this can e.g. be implemented through using a [DAPS](https://github.com/International-Data-Spaces-Association/IDS-G/blob/main/Components/IdentityProvider/DAPS/README.md){target=_blank})
2. Manually, through self-registration (may only be available for users from certain domains and/or for certain roles)
3. Through superuser registration; in this case the user gets issued an acitivation link and has to set the password to complete registration

## Authentication

Certain functionalities of the SWR will be available to anonymous users, but functions that edit any of the state of the system (data, configuration, metadata) require an authenticated user. The easiest form of authentication is to use the login provided by the SWR itself. This log-in is username-password based. A second factor, e.g. through an authenticator app, may be added after the first iteration.

Other forms of authentication include using an existing token.

## Authorisation

Every component has to check whether an authenticated user may invoke a desired action based on that user's roles in their organisations. To ensure that the User Interface does not offer actions that a given user may not invoke, the user interface shall also perform authorisation.

Roles are generally defined using Privileges: A certain role may, for example, `read` certain resources, they may `edit` or even `delete` them. Here is an example of such a definition:

``` json
  "user": {
    "label": {
      "en": "Registered user",
      "de": "Standardnutzer"
    },
    "resources": {
      "User": {
        "read": true,
        "edit": ["self"]
      },
      "Organisation": {
        "read": true
      }
    }
  },
  "dataManager": {
    "extends": "user",
    "label": {
      "en": "Data manager",
      "de": "Daten-Manager"
    },
    "resources": {
      "Data": {
        "create": ["organisation"],
        "read": ["organisation"],
        "edit": ["organisation"],
        "delete": ["organisation"]
      },
      "Theme": {
        "read": ["organisation", "parentOrg"]
      }
    }
  }
```

Here, a standard `user` may only `read` and `edit` their own `User` profile, and read the informaiton from their organisation. Once a user has been given the role `dataManager`, they may perform any CRUD operation on any `Data` that is in the scope of their `organisation`. They are also granted `read` access to publication `Theme` configurations in their own and any parent organisations.

## Further implementation hints and Technologies

The public cloud [hale connect user service](https://haleconnect.com/swagger/){target=_blank} can be used for central user management.
