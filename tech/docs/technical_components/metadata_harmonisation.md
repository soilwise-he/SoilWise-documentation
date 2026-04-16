# Metadata harmonisation

!!! component-header "Info"
    **Current version:** 0.1.0

    **Technology:** Python

    **Release:** 0.1.0

    **Project repository:** [md-harmonization](https://github.com/soilwise-he/md-harmonization)

## Overview and Scope

The component harmonizes the content as imported by the [Harvester component](./ingestion.md).
A database is populated with the harmonised metadata content.

## Key Features

- harmonizes metadata to a common model
- merges multiple instances of a record to a single entity

## Architecture

The process (scheduled at intervals) runs as a python script in a docker container (on kubernetes cluster). The script connects to the 
database to fetch latest unparsed records and writes the results back to the database. The logs of the process 
can be viewed from the container logs (in grafana).

Container is build at commits in a Github build pipeline and placed in Github container registry.
The repository contains a set of unit tests which run when the container builds.

The core of the module is the [pygeometa library](https://github.com/geopython/pygeometa), which offers harmonization for a number of metadata models.
The harmonized metadata is stored in the pygeometa [MCF model](https://geopython.github.io/pygeometa/reference/mcf/). From the MCF model, relevant 
properties are exported to a relational database model.

| Supported schemas | 
| --- | 
| iso19115-2003 | 
| iso19115-1-2014 |
| Dublin Core |
| schema.org |
| DCAT |
| OpenAire (DataCite) |
| OGCAPI-Records |
| STAC |

## Integrations & Interfaces

Read and write access to the PostGres database.

## Key Architectural Decisions

The pygeometa library has been selected based on its support for many common metadata models in our community.

In case multiple instances of a record are identified, we decided to merge the content. Merging is managed through presence of a property. 
The first property ingested takes precedence. Alternative here could be to favour certain platforms above others, or flag the duplication, 
so an administrator can select the most relevant edition.

## Risks & Limitations

Ingested properties, which are not available in the mcf model, will not be available in the merged record.



