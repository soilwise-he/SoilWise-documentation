# GIT versioning system

All aspects of the SoilWise repository can be managed through the SoilWise GIT repository. 
This allows all members of the Soil mission and EUSO community to provide feedback or contribute to any of the aspects.

## Documentation

Documentation is maintained in the markdown format and deployed as html or pdf.

## Source code

Software libraries tailored or developed in the scope of SoilWise are maintained through the GIT repository.

## Container build scripts/deployments

SoilWis is based on an orchestrated set of container deployments. Both the definitions of the containers as well as the orchestration of those containers are maintained through Git.

## Harvester definitions

The configuration of the endpoint to be harvested, filters to apply and the interval are stored in a Git repository. If the process runs as a CI-CD pipeline, then also the logs of each run are available in Git.

## Authored and harvested metadata

Metadata created in SWR as well as metadata imported from external sources are stored in Git, so a full history of each record is available and users can suggest changes to existing metadata.

## Validation rules

Rules (ATS/ETS) applied to metadata (and data) validation are stored in a git repository.

## ETL configuration

Alignments to be applied to source to be standardised and/or harmonised are stored on a git repository, so users can try the alignment locally or contribute to its development.

## Backlog / discussions

Roadmap discussion, backlog and issue management are part of the Git repository. Users can flag issues on existing components, documentation or data, which can then be followed up by the participants.

## Release management

Releases of the components and infrastructure are managed from Git a repository, so users understand the status of a version and can download the packages. The release process is managed in an automated way through CI-CD pipelines.

## Organizational

- connections with: CI-CD, kubernetes, catalog, ETL, QA QC, role definitions
- technologies used: Git
- responsible person: WE
- participating: ISRIC
