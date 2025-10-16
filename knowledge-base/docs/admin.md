# SoilWise repository - Administrator guidance

## Quick start

SWR, by design, does not facilitate direct metadata record modification, removal or addition. 
Metadata can be included (and excluded) by adding and refining a system of `harvesters`.
Harvesters are micro-tasks which run at intervals and synchronise the catalogue with remote sources. 
Each harvester task is configured by its type, the endpoint to harvest, the interval and a filter to subset the query.
As an administrator you maintain the harvesters, with the goal to optimize the content of the catalogue.
Administration is managed though an [instance of Gitlab](https://git.wur.nl), running at Wageningen University.

3 distinct activities can be identified

- Schedule and monitor harvester tasks - Task monitoring and scheduling is managed through the gitlab admin interface of the harvester project
- Create and adjust harvester tasks - Configuration for a harvester task is defined within the [CI folder](https://github.com/soilwise-he/harvesters/tree/main/CI) of the harvester repository.
- Create and adjust harvester types - Various catalogue interfaces exist, which each require dedicated code for interaction. The required code is maintained in the harvester repository.

## Schedule and monitor harvester tasks

Harvester tasks run as [scheduled pipelines](https://docs.gitlab.com/ci/pipelines/schedules/) in a gitlab environment.
From the Gitlab webbased user interface you can evaluate previous runs of the harvester tasks, adjust and schedule new tasks.
Make sure you are a member with at least the role `developer` in the `soilwise-he/harvester` gitlab project. 
The gitlab project is a clone of the public [github harvester](https://github.com/soilwise-he/harvesters) project.

## Create and adjust harvester tasks

Configuration for a harvester task is defined within the [CI folder](https://github.com/soilwise-he/harvesters/tree/main/CI) of the harvester repository.
Each file in that folder represents a harvesting task. Notice that each file is referenced from the main [gitlab-ci.yaml](https://github.com/soilwise-he/harvesters/blob/main/.gitlab-ci.yml) file.
Each file typically has 2 entries, one for the develop and one for the production environment. Dedicated harvesters have dedicated parameters, but all include the configuration of the database, 
into which the harvested records are persisted. Some parameters reference Gitlab variables, which are modified separately through the gitlab admin interface

```yaml
# example of use of a gitlab variable
- export POSTGRES_HOST=$POSTGRES_HOST_TEST
```

Most harvesters have a parameter to indicate the endpoint and a filter. The filter typically has a `{key:value}` structure. Notice the quotes around the filter.

```yaml
# example of use of an endpoint and filter configuration
- export HARVEST_URL=https://inspire-geoportal.ec.europa.eu/srv/eng/csw
- export HARVEST_FILTER='[{"th_httpinspireeceuropaeutheme-theme.link":"http://inspire.ec.europa.eu/theme/so"}]'
```

## Create and adjust harvester types

Various catalogue interfaces exist, which each require dedicated code for interaction. The required code is maintained in the harvester repository.

A generic harvester type `CSW` is available for catalogues such as INSPIRE, ISRIC, FAO, EEA, Bonares.
Other repositories use dedicated api's, for which dedicated harvesters are provided, such as Prepsoil, Impact4soil, ESDAC, OpenAire.

Code changes are needed to adjust the operation of a specific harvester.
