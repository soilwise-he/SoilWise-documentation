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

Both environments use the same container images and OpenTofu modules. Environment-specific configuration (hostnames, secrets, feature flags) is managed through separate `.tfvars` files. State is stored remotely in an S3 backend (`soilwise-tf-state-soilwise-apps`, AWS `eu-central-1`).

<!--
The hale-connect production environment is hosted separately at `data.soilwise.wetransform.eu`.
-->

## Containerization

All SWC components are compiled into container images and deployed to the Kubernetes cluster. Images are published to the GitHub Container Registry (`ghcr.io/soilwise-he/*`) or pulled from upstream registries (Docker Hub, Quay.io) for third-party components.

### Container Inventory

All services run as single-replica Kubernetes deployments. No autoscaling is configured (Keycloak has autoscaling defined but disabled, with a maximum of 4 replicas).

| Service | Image | Version | Update Strategy |
|---|---|---|---|
| PostGIS | `postgis/postgis` | 16-3.5 | Recreate |
| Virtuoso | `openlink/virtuoso-opensource-7` | 7.2.12 | RollingUpdate |
| SOLR | `ghcr.io/soilwise-he/soilwise-solr` | 1.0.17 | Recreate |
| Search API | `ghcr.io/soilwise-he/search-api` | 1.1.71 | Recreate |
| Search UI | `ghcr.io/soilwise-he/search-ui` | variable (per tfvars) | Recreate |
| Linky (LLA) | `ghcr.io/soilwise-he/link-liveliness-assessment` | 1.1.6 | RollingUpdate |
| Harvesters | `ghcr.io/soilwise-he/harvesters` | `latest` (unpinned) | — (CronWorkflow) |
| Keycloak | `keycloakx` Helm chart | 7.1.9 | Recreate |
| Superset | variable (`superset_image` per tfvars) | variable | Recreate |
| Redis (Superset) | `redis` | 7-alpine | Recreate |

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

### Components to migrate (*update after migration!*)

The following components are part of the SWC but are deployed and managed outside the k8s-soilwise repository:

| Component | Managed by | Notes |
|---|---|---|
| hale-connect (data portal, user-service, kelvin-auth, resources-admin) | weTransform | Separate Kubernetes deployment |
| Monitoring stack (Grafana, Prometheus, Loki) | weTransform | Separate Docker-based stack |
| pycsw (Catalogue backend) | WUR | Deployed on WUR k8s cluster |
| Soil Companion | WUR | Deployed on WUR k8s cluster |
| Knowledge Graph | WUR | Deployed on WUR k8s cluster |
| Metadata augmentation components | WUR | Deployed on WUR k8s cluster |
| Harvester CI/CD pipelines | WUR | GitLab runners at WUR |
| Tabular soil data annotation | DOMG - VL O | Hosted on Streamlit Cloud |
| Translation service, VocView | Separate repos | Not in k8s-soilwise |

### Operational Notes

- **Single replica** — All services run with 1 replica. There is no high-availability configuration for any component.
- **Update strategy** — Most services use `Recreate`, meaning brief downtime occurs during redeployment. Only Linky and Virtuoso use `RollingUpdate` for zero-downtime updates.
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

Metadata harvesting is managed through 17 Argo CronWorkflows, all scheduled on Sundays with staggered start times to avoid resource contention. All workflows use the `harvesters:latest` image (see warning above about unpinned tags).

Harvester tasks are configured in the k8s-soilwise repository. Separate harvester CI/CD pipelines also run on the WUR GitLab instance for additional sources.

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

