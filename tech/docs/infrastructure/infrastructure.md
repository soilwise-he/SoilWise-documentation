# Infrastructure

!!! component-header "Info"

    **IaC tooling:** [OpenTofu](https://opentofu.org/) (Terraform-compatible)

    **Cluster provider:** Hetzner Cloud (Kubernetes, `hcloud-volumes` storage class)

    **Repositories:** [k8s-soilwise](https://github.com/soilwise-he/k8s-soilwise) (Kubernetes deployments), [soilwise-he](https://github.com/soilwise-he) (source code, documentation, CI/CD)

## Overview

The SoilWise Catalogue (SWC) runs on a Kubernetes cluster hosted on Hetzner Cloud. All SWC components are deployed as containers, with infrastructure managed as code using OpenTofu. Two environments are maintained: **test** and **production**, both deployed from the same repository with environment-specific variable files.


## Environments

The SWC maintains two Kubernetes environments deployed from a single OpenTofu codebase:

| | Test | Production |
|---|---|---|
| **Workspace** | `default` | `prod` |
| **Namespace** | `soilwise` | `soillive` |
| **Purpose** | Integration testing, development | Live service |
| **Configuration** | `config/test.tfvars` | `config/prod.tfvars` |

Both environments use the same container images and OpenTofu modules. Environment-specific configuration (hostnames, secrets, feature flags) is managed through separate `.tfvars` files. State is stored remotely in an S3 backend.

<!--
The data-portal production environment is hosted separately at `data.soilwise.wetransform.eu`.
-->

## Containerization

All SWC components are compiled into container images and deployed to the Kubernetes cluster. Images are published to the GitHub Container Registry (`ghcr.io/soilwise-he/*`) or pulled from upstream registries (Docker Hub, Quay.io) for third-party components.

### Container Inventory

| Service | Image |
|---|---|
| PostGIS | `postgis/postgis` |
| Virtuoso | `openlink/virtuoso-opensource-7` |
| SOLR | `ghcr.io/soilwise-he/soilwise-solr` |
| Search API | `ghcr.io/soilwise-he/search-api` |
| Search UI | `ghcr.io/soilwise-he/search-ui` |
| Linky (LLA) | `ghcr.io/soilwise-he/link-liveliness-assessment` |
| Harvesters | `ghcr.io/soilwise-he/harvesters` |
| Keycloak | `keycloakx` Helm chart |
| Superset | variable (`superset_image` per tfvars) |
| Redis (Superset) | `redis` |

### Resource Sizing

| Service | CPU (request / limit) | Memory (request / limit) | Persistent Storage |
|---|---|---|---|
| SOLR | 2 / 4 cores | 4 Gi / 8 Gi | 2× 3 Gi PVC |
| Search API | 2000m / 4000m | 1 Gi / 2 Gi | — |
| Search UI | 125m / 500m | 256 Mi / 512 Mi | — |
| Linky | 250m / 500m | 256 Mi / 512 Mi | — |
| Virtuoso | 256m / 1000m | 128 Mi / 1024 Mi | 1 Gi PVC |
| PostGIS | — | — | 10 Gi PVC |
| Superset | — | — | 5 Gi PVC |

Services without explicit CPU/memory requests rely on Kubernetes namespace defaults. All persistent volumes use the `hcloud-volumes` storage class.

### Components to migrate

The following components are part of the SWC but are deployed and managed outside the k8s-soilwise repository:

| Component | Managed by | Notes |
|---|---|---|
| data portal (user-service, kelvin-auth, resources-admin) | weTransform | Separate Kubernetes deployment |
| Monitoring stack (Grafana, Prometheus, Loki) | weTransform | Separate setup based on helm charts |
| pycsw (Catalogue backend) | WUR | Deployed on WUR k8s cluster |
| Soil Companion | WUR | Deployed on WUR k8s cluster |
| Knowledge Graph | WUR | Deployed on WUR k8s cluster |
| Metadata augmentation components | WUR | Deployed on WUR k8s cluster |
| Tabular soil data annotation | DOMG - VL O | Hosted on Streamlit Cloud |
| Translation service, VocView | Separate repos | Not in k8s-soilwise |

### Operational Notes

- **Update strategy** — Most services use `Recreate`, meaning brief downtime occurs during redeployment. This is related to that the default storage class volume cannot be mounted to multiple nodes and could otherwise block updates. Only Linky and Virtuoso use `RollingUpdate` for zero-downtime updates.
- **Health checks** — Kubernetes liveness probes are configured on service deployments (e.g. Solr API) for automated health checking. Resource limits and requests feed into cluster-level monitoring.

## CI/CD Pipeline

Deployments are automated via GitHub Actions:

| Trigger | Action |
|---|---|
| `push` to `main` | Auto-deploy to both test and production |
| `pull_request` | Plan only (no apply) |
| Weekly (Sunday 07:00 UTC) | Drift detection — opens or updates GitHub issues if infrastructure state has diverged from code |

The pipeline uses OpenTofu with the S3 remote backend for state management. Deployment applies changes to both environments sequentially.

## Harvest Scheduling

Metadata harvesting is managed through Argo CronWorkflows, all scheduled on Sundays with staggered start times to avoid resource contention.

Harvester tasks are configured in the k8s-soilwise repository.

INSPIRE metadata validation for INSPIRE related metadata entries is managed similary to the harvester tasks and publishes results directly to the database.

## Git & Source Code Management

All aspects of the SoilWise project are managed through the [SoilWise GitHub organisation](https://github.com/soilwise-he):

- **Source code** — Software libraries and components developed or tailored for SoilWise
- **Infrastructure as Code** — OpenTofu modules, Kubernetes manifests, and environment configuration in [k8s-soilwise](https://github.com/soilwise-he/k8s-soilwise)
- **Documentation** — Maintained in Markdown using [MkDocs](https://www.mkdocs.org/), deployed via GitHub Pages
- **Container build scripts** — Dockerfiles and CI/CD workflows producing images published to `ghcr.io`
- **Harvester definitions** — Endpoint configuration, filters, schedules, and CI/CD pipeline logs
- **Authored and harvested metadata** — Stored in Git for full history tracking and community contributions
- **Validation rules** — ATS/ETS rules for metadata and data validation
- **ETL configuration** — Transformation alignments stored in Git for local testing and collaborative development
- **Backlog and discussions** — Roadmap, issue tracking, and user feedback via GitHub Issues and Discussions
- **Release management** — Automated releases through CI/CD pipelines with semantic versioning

Architecture diagrams are maintained and published interactively via GitHub Pages at the [SoilWise architecture](https://gh-pages.soilwise-architecture.pages.dev/) site.
