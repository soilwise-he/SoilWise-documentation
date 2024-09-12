# Introduction

This section describes the general hardware infrastructure and deployment pipelines used for the SWR. As of the delivery of this initial version of the technical documentation, a prototype pipeline and hardware environment shall continuously be improved as required to fit the needs of the project.

For the development of **First project iteration cycle**, we defined the following criteria:

- There is no production environment.
- There is a distributed staging environment, with each partner deploying their solutions to their specific hardware.
- All of the hardware nodes used in the staging environment include an offsite backup capacity, such as a storage box, that is operated in a different physical location.
- There is no central dev/test environment. Each organisation is responsible for its own dev/test environments.
- The deployment and orchestration configuration for this iteration should be stored as YAML in a GitHub repository.
- Deployments to the distributed staging environment are done preferavly through GitHub Actions or through alternative pipelines, such as a Jenkins or GitLab instance provided by weTransform or other partners.
- For each component, there shall be separate build processes managed by the responsible partners that result in the built images being made accessible through a hub (e.g. dockerhub)

## Work completed - Iteration 1

During the iteration, the following components have been deployed:
- on WeTransform cloud infrastructure, a k8s deployment of the hale connect stack as been installed and configured. This instance can provide user management and has been integrated with the GitHub repository <https://github.com/soilwise-he/Soilwise-credentials>. The stack provides [Transformation](../technical_components/transformation.md), [Metadata Generation](../technical_components/metadata_augmentation.md#automatic-metadata-generation) and [Validation](../technical_components/metadata_validation.md) capabilities.
- on ...
- on ...

## Future work - Iteration 2

The main objective of iteration 2 is to integrate the different components that have been deployed so far, as well as additional ones. The integrations will, whereever feasible, build on open APIs. We intend to retain the distributed architecture, though the staging and production environments may switch to an overall kubernetes-based orchestration mode if it is deemed necessary and advantageous at that point in time.
