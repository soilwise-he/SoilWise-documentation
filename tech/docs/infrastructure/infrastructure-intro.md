# Introduction

This section describes the general hardware infrastructure and deployment pipelines used for the SWR. It is, as of the delivery of this initial version of the technical documentation, a prototype pipeline and hardware environment that shall continously be improved as required to fir the needs of the project.

During the develop of Phase I, the assumption is:
- There is no production environment.
- There is a central staging environment.
- The central staging environment is deployed on a single hardware node of sufficient capacity. This hardware node will be provided by weTransform.
- In addition to the hardware node, the staging environment also includes an offsite backup capacity, such as a storage box, that is operated in a different physical location.
- There is no central dev/test environment. Each organisation is responsible for their own dev/test environments.
- The deployment and orchestration configuration for this phase should be stored as YAML in a github repository and shall use docker swarm mode.
- Deployments to the central staging environment are done through GitHub Actions (or through a Jenkins or GitLab instance provided by weTransform or other partners). This still has to be decided.
- For each component, there shall be separate build processes managed by the responsible partners that result in the built images being made accessible through a hub (e.g. dockerhub)

After completion of Phase I, a production environment will be added. It will be dimensioned according to expected loads.

After completion of Phase II, the staging and production environments may switch to a kubernetes based orchestration mode if it is deemed necessary and advantageous at that point in time. kubernetes does add significant complexity and requires substantial experience and maintenace to render benefits.
