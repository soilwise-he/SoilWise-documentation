# Containerization

The general assumption of operating and developing the SWR is that we work with a containerised environment. This means that each software component, be it a database or other storage, or a service of soem kind, is compiled into a container image. These images are made available in a hub or repository, so that they can be deployed automatically whenever needed, including to fresh hardware.

The deployment configuration will be implemented as follows:

- **First and Second project iteration cycle:** docker-swarm with a fixed node set
- **Third project iteration cycle:** kubernetes with a dynamic cluster

In both cases, the deployment configuration will handle orchestration, such as scaling up or down services, restarting & recovering unresponsive services, and deploying full or partial updates to the SWR.

## Technology

 - [Docker](https://www.docker.com){target=_blank}
 - [Kubernetes](https://kubernetes.io/){target=_blank}
