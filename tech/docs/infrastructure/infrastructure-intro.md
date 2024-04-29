# Introduction

This section describes the general hardware infrastructure and deployment pipelines used for the SWR. As of the delivery of this initial version of the technical documentation, a prototype pipeline and hardware environment shall continuously be improved as required to fit the needs of the project.

During the development of **First project iteration cycle**, the assumption is:

- There is no production environment.
- There is a central staging environment.
- The central staging environment is deployed on a single hardware node of sufficient capacity. This hardware node will be provided by project partner _weTransform_.
- In addition to the hardware node, the staging environment also includes an offsite backup capacity, such as a storage box, that is operated in a different physical location.
- There is no central dev/test environment. Each organisation is responsible for its own dev/test environments.
- The deployment and orchestration configuration for this iteration should be stored as YAML in a GitHub repository.
- Deployments to the central staging environment are done through GitHub Actions (or through a Jenkins or GitLab instance provided by weTransform or other partners). This still has to be decided.
- For each component, there shall be separate build processes managed by the responsible partners that result in the built images being made accessible through a hub (e.g. dockerhub)

After completion of the **First project iteration cycle**, a production environment will be added. It will be dimensioned according to expected loads.

After completion of the **Second project iteration cycle**, the staging and production environments may switch to a kubernetes-based orchestration mode if it is deemed necessary and advantageous at that point in time. Kubernetes does add significant complexity and requires substantial experience and maintenance to render benefits.
