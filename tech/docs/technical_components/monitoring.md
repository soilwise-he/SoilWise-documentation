# Monitoring

!!! component-header "Important Links"
    **Current version:**

    **Project:** [Usasge statistics](https://github.com/soilwise-he/usage-statistics)

All components and services of the SWR are monitored at different levels to ensure robust operations and security of the system. There will be a central monitoring service for all components that are part of the SWR.

In particular, monitoring needs to fulfill the following requirements:

- For each node, its general state and resource utilisation (RAM, CPU, Volumes) shall be monitored.
- For each container, its general state, e.g. resource consumption (RAM, CPU, Volumes, Transfer, Uptime) shall be monitored.
- For each service, there shall be a health check that can be used to test if the service is responsive and functional, e.g. after a restart.
- If issues that cannot be recovered from automatically occur or which lead to a longer-term degradation of services, messages shall be sent to the operators via channels such as Slack, PagerDuty, or Jira.
- The monitoring system shall provide availability statistics.
- The monitoring system should provide usage statistics.
- The monitoring system may provide a UI element that can be embedded into other components to make usage transparent.
- The monitoring system should provide a dashboard to help system operators with understanding the state of the SWR and to debug incidents, including possible security incidents.
- The monitoring system shall collect warning and error logs to provide guidance for system administrators.
- The monitoring system shall offer the possibility to filter logged interactions based on the https status code, e.g. to identify 404's or 500's.

## System context and implementation hints for monitoring

- Monitoring connects with: all modules
- Technologies used: Grafana, Portainer, Prometheus
- External intgrations: Jira, Slack, PagerDuty, ... 
