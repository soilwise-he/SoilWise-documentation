# GIT versioning system

All aspects of the SoilWise repository can be managed through the [SoilWise GitHub](https://github.com/soilwise-he) repository. 
This allows all members of the Mission Soil and EUSO community to provide feedback or contribute to any of the aspects.

## Documentation

Documentation is maintained in the markdown format using [McDocs](https://www.mkdocs.org/) and deployed as html or pdf using GitHub Pages.

An interactive preview of architecture diagrams is also maintained and published using GitHub Pages.

## Source code

Software libraries tailored or developed in the scope of SoilWise are maintained through the GitHub repository.

## Container build scripts/deployments

SoilWise is based on an orchestrated set of container deployments. Both the definitions of the containers as well as the orchestration of those containers are maintained through Git.

## Harvester definitions

The configuration of the endpoint to be harvested, filters to apply and the interval is stored in a GitHub repository. If the process runs as a CI-CD pipeline, then the logs of each run are also available in Git.

## Authored and harvested metadata

Metadata created in SWR, as well as metadata imported from external sources, are stored in GitHub, so a full history of each record is available, and users can suggest changes to existing metadata.

## Validation rules

Rules (ATS/ETS) applied to metadata (and data) validation are stored in a git repository.

## ETL configuration

Alignments to be applied to the source to be standardised and/or harmonised are stored on a git repository, so users can try the alignment locally or contribute to its development.

## Backlog / discussions

Roadmap discussion, backlog and issue management are part of the GitHub repository. Users can flag issues on existing components, documentation or data, which can then be followed up by the participants.

## Release management

Releases of the components and infrastructure are managed from a GitHub repository, so users understand the status of a version and can download the packages. The release process is managed in an automated way through CI-CD pipelines.

