# Containerization

The general assumption of operating and developing the SWR is that we work with a containerised environment. This means that each software component, be it a database or other storage, or a service of soem kind, is compiled into a container image. These images are made available in a hub or repository, so that they can be deployed automatically whenever needed, including to fresh hardware.

The deployment configuration will be implemented as follows:

- Phase 1 - 2: docker-swarm with a fixed node set
- Phase 3: kubernetes with a dynamic cluster

In both cases, the deployment configuration will handle orchestration, such as scaling up or down services, restarting & recovering unresponsive services, and deploying full or partial updates to the SWR.

- connections with: all modules
- technologies used: Docker, Kubernetes
