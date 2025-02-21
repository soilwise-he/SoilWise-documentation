# Introduction

This section describes the general hardware infrastructure and deployment pipelines used for the SWR. As of the delivery of this initial version of the technical documentation, a prototype pipeline and hardware environment shall continuously be improved as required to fit the needs of the project.

For the development of **First project iteration cycle**, we defined the following criteria:

- There is no production environment.
- There is a distributed staging environment, with each partner deploying their solutions to their specific hardware.
- All of the hardware nodes used in the staging environment include an offsite backup capacity, such as a storage box, that is operated in a different physical location.
- There is no central dev/test environment. Each organisation is responsible for its own dev/test environments.
- The deployment and orchestration configuration for this iteration should be stored as YAML in a GitHub repository.
- Deployments to the distributed staging environment are done preferably through GitHub Actions or through alternative pipelines, such as a Jenkins or GitLab instance provided by weTransform or other partners.
- For each component, there shall be separate build processes managed by the responsible partners that result in the built images being made accessible through a hub (e.g. dockerhub)

## Work completed - Iteration 1

The Soilwise infrastructure uses components provided by Github. Github components are used to:

- Administer and assign to roles the different Soilwise users.
- Register, prioritise and assign tasks.
- Store source code of software artifacts.
- Author documentation.
- Run CI/CD pipelines.
- Collect user feedback.

During the iteration, the following components have been deployed:

on infrastructure provided by **Wageningen University & Research**:

- A PostGreSQL database on the PostGreSQL cluster.
- A number of repositories at the WUR Gitlab instance, including CI/CD pipelines to run metadata harvesters.
- A range of services deployed on the WUR k8s cluster, with their configuration stored on Gitlab. Container images are stored on the WUR Harbor repository.
- Usage logs monitored through the WUR instance of Splunk.
- Availability monitoring provided by Uptimerobot.com.


on **WeTransform cloud infrastructure**:

- a k8s deployment of the Hale Connect stack has been installed and configured. This instance can provide user management and has been integrated with the GitHub repository <https://github.com/soilwise-he/Soilwise-credentials>. The stack provides [Transformation](../technical_components/transformation.md) and [Validation](../technical_components/metadata_validation.md) capabilities.


## Future work - Iteration 2

The main objective of iteration 2 is to reorganise the orchestration of the different components, so all components can be centrally accessed and monitored.  
 
The integrations will, whereever feasible, build on API's which are standardised by W3C, OGC or de facto standards, such as Open API or GraphQL. 

The intent of the consortium is to set up a distributed architecture, with the staging and production environment in an overall kubernetes-based orchestration mode if it is deemed necessary and advantageous at that point in time.
