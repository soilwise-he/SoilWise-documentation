# System & Usage Monitoring

!!! info

    **Current version:** Grafana 12.1.1 / Prometheus v2.55.1 / Prometheus LTS v2.18.1

    **Project:** [Usage statistics](https://github.com/soilwise-he/usage-statistics)

## Introduction

### Overview and Scope

All components and services of the SWC are monitored at different levels to ensure robust operations and security of the system. A central monitoring service based on Prometheus and Grafana is deployed to the SoilWise Kubernetes cluster alongside the SWC services.

Monitoring covers:

- Node and container resource utilisation (RAM, CPU, volumes, transfer, uptime)
- Service health checks (liveness and readiness probes)
- Operational alerting via Slack and PagerDuty
- Availability statistics and trend analysis
- Usage statistics for SWC services and the public website
- Log aggregation and filtering by HTTP status code to identify errors (4xx, 5xx)

## Architecture

### System Health Monitoring

Infrastructure and application monitoring is implemented using a Prometheus + Grafana stack.

**Prometheus** (v2.55.1) scrapes metrics from all services, the Kubernetes cluster, and host nodes via Node Exporter (v1.9.1) and kube-state-metrics. A second **Prometheus LTS** instance (v2.18.1) retains metrics for longer periods (currently configured at 4 GB / ~30 days) to support trend analysis and availability reporting.

**Grafana** (v12.1.1) provides the dashboarding layer. User sign-up is disabled, dashboards are provisioned via code (no UI edits), and the admin password is stored in vault. 67 dashboards are provisioned covering:

- Kubernetes cluster health (nodes, volumes, autoscaler)
- Service performance and request metrics (OWS, nginx, Java/Vert.x services)
- Container and pod resource consumption
- Log analysis via Loki (HTTP status codes, error rates, OWS access patterns)
- AWS infrastructure (billing, EFS, S3, ELB)
- Long-term OWS availability statistics

**Alertmanager** (v0.28.1) is configured with Slack notifications for operational alerts. PagerDuty integration is available for critical environments.

**Loki** (v3.4.1) with Promtail (v3.0.0) handles log aggregation. It is enabled optionally per environment and feeds structured log dashboards in Grafana, including filtering by HTTP status code to identify 4xx/5xx errors.

### Usage Monitoring

Usage of the SWC services is tracked at two levels:

**Infrastructure-level usage** is captured through nginx access logs, which record per-request timing, upstream response times, HTTP status codes, and user agent information. These logs are ingested into Loki and visualised in Grafana through dedicated OWS log analysis dashboards. Detailed per-publication, per-service-type OWS metrics are enabled for the SoilWise deployment (`nginx_detailed_ows: true`).

**Website-level usage** of the SoilWise public website is tracked via [Hotjar](https://www.hotjar.com/) and Google Analytics. These are managed separately from the infrastructure monitoring stack and are configured at the website/CMS level.

The hale-connect platform includes built-in usage reporting features (CSV usage reports per organisation, WMS/WFS usage statistics) that can be enabled as feature toggles.

## Technological Stack

| Component | Version | Purpose |
|---|---|---|
| Grafana | 12.1.1 | Dashboards and visualisation |
| Prometheus | v2.55.1 | Metrics collection |
| Prometheus LTS | v2.18.1 | Long-term metric retention (~30 days) |
| Alertmanager | v0.28.1 | Alert routing (Slack, PagerDuty) |
| Loki | 3.4.1 | Log aggregation |
| Promtail | 3.0.0 | Log shipping |
| Node Exporter | v1.9.1 | Host metrics |
| kube-state-metrics | — | Kubernetes cluster metrics |
| Hotjar | — | Website usage analytics (frontend) |
| Google Analytics | — | Website traffic statistics (frontend) |

Grafana data sources configured: Prometheus (default), Prometheus LTS, Loki, CloudWatch.

## Integrations & Interfaces

- **Slack** — Operational alerts via Alertmanager (configured for the SoilWise setup)
- **PagerDuty** — Critical alerts (available, optional per environment)
- **Loki** — Structured log queries accessible from Grafana dashboards
- **nginx** — Access logs feed into Loki for OWS log analysis and HTTP status code filtering
- **Kubernetes** — Liveness probes configured on service deployments (e.g. Solr API) for automated health checking; resource limits/requests (CPU, memory) defined per deployment feed into cluster-level monitoring
