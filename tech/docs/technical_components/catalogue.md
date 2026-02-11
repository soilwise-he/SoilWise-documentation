# Metadata Catalogue

!!! component-header "Info"
    **Current version:** 

    **Technology:** [Apache Solr](https://solr.apache.org/), [React](https://react.dev/), [pycsw](https://pycsw.org/)

    **Project:** [Catalogue UI](TBD); [Solr](TBD); [pycsw](https://github.com/geopython/pycsw)

    **Access point:** <https://client.soilwise-he.containers.wur.nl/catalogue/search>

## Introduction

### Overview and Scope

The Metadata Catalogue is a central piece of the architecture, giving access to individual metadata records. In the catalogue domain, various effective metadata catalogues are developed around the standards issued by the OGC, the [Catalogue Service for the Web](https://www.ogc.org/standard/cat/){target=_blank} (CSW) and the [OGC API Records](https://ogcapi.ogc.org/records/){target=_blank}, Open Archives Initiative (OAI-PMH), W3C (DCAT), FAIR science (Datacite) and Search Engine community (schema.org). For our first project iteration we've selected the pycsw software, which supports most of these standards. In the second iteration pycsw continues to provide standardized APIs, however to improve search performance and user experience, it was supplemented by [Apache Solr](https://solr.apache.org/) and [React](https://react.dev/) frontend. 

### Intended Audience

The SoilWise Metadata Catalogue targets the following user groups:

- **Soil scientists and researchers** working with European soil health data and seeking catalogued knowledge, publications, and datasets.
- **Living Labs' data scientists** working with European soil health data and seeking catalogued knowledge, publications, and datasets.
- **Mission Soil Project Data Managers** searching for datasets published by other Mission Soil Projects, or veryfiing if their published data are recognized by SoilWise (EUSO).
- **Policy Makers** working with European soil health data and seeking catalogued knowledge, publications, and datasets.

### Key Features

The SoilWise Metadata Catalogue adopts a **React frontend**, focusing on:

1. **Paginated search results** - 10 results are displayed per page in alphabetical order, in the form of overview table comprising preview of resource type, title, abstract, date and preview.
2. **Fulltext search** - + autocomplete
3. **Resource type filter** - enabling to filter out certain types of resources, e.g. journal articles, datasets, reports, software.
4. **Term filter** - enabling to filter out resources containing certain keywords, resources published by specific projects, etc.
5. **Date filter** - enabling to filter out resources based on their creation, or revision date
6. **Spatial filter** - enabling to filter out resources based on their spatial extent using countries or regions, drawn bounding box, vicinity of user's location, or by searching for geographical names.
7. **Display records' detail** - After clicking result's table item, a record's detail is displayed at unique URL address to facilitate sharing. Record's detail currently comprises: record's type tag,full title, full abstract, keywords' tags, preview of record's geographical extent, record's preview image, if available, information about relevant HE funding project, list of source repositories,- indication of link availability, see [Link liveliness assessment](./metadata_augmentation.md#link-liveliness-assessment), last update date, all other record's items...
8. **Resource preview** - 3 types of preview are currently supported: (1) Display resource geographical extent, which is available in the record's detail, as well in the search results list. (2) Display of a graphic preview (thumbnail) in case it is advertised in metadata. (3) Map preview of OGC:WMS services advertised in metadata enables standard simple user interaction (zoom, changing layers).
9. **Display results of metadata augmentation** - Results of metadata augmentation are stored on a dedicated database table. The results are merged into the harvested content during publication to the catalogue. At the moment it is not possible to differentiate between original and augmented content. For next iterations we aim to make this distinction more clear.
10. **Display links of related information** - Download of data "as is" is currently supported through the links section from the harvested repository. Note, "interoperable data download" has been only a proof-of-concept in the first iteration phase, i.e. is not integrated into the SoilWise Catalogue. Download of knowledge source "as is" is currently supported through the links section from the harvested repository.

The SoilWise Metadata Catalogue adopts a **Apache Solr backend**, focusing on:

1. 


In order to interact with the many relevant data communities, SoilWise aims to support a range of catalogue standards through **pycsw backend**:

1. **Catalogue Service for the Web** - Catalogue service for the web (CSW) is a standardised pattern to interact with (spatial) catalogues, maintained by OGC. <https://repository.soilwise-he.eu/cat/csw>

2. **OGC API - Records** - OGC is currently in the process of adopting a revised edition of its catalogue standards. The new standard is called OGC API - Records. OGC API - Records is closely related to Spatio Temporal Asset Catalogue (STAC), a community standard in the Earth Observation community. <https://repository.soilwise-he.eu/cat/openapi>

3. **Protocol for metadata harvesting (oai-pmh)** - The open archives initiative has defined a common protocol for metadata harvesting (oai-pmh), which is adopted by many catalogue solutions, such as Zenodo, OpenAire, CKAN. The oai-pmh endpoint of Soilwise can be harvested by these repositories. <https://repository.soilwise-he.eu/cat/oaipmh>

4. **Schema.org annotations** - Annotiations using [schema.org/Dataset](https://schema.org/Dataset) ontology enable search engines to harvest metadata in a structured way. [Example](https://validator.schema.org/#url=https%3A%2F%2Frepository.soilwise-he.eu%2Fcat%2Fcollections%2Fmetadata%3Amain%2Fitems%2F00682004-c6b9-4c1d-8b40-3afff8bbec69)


## Architecture

### Technological Stack

**Backend**

|Technology|Description|
|----------|-----------|
|**[pycsw](https://pycsw.org){target=_blank} v3.0**| Pycsw, written in python, allows for the publishing and discovery of geospatial metadata via numerous APIs ([CSW 2/CSW 3](https://www.ogc.org/standard/cat/){target=_blank}, [OAI-PMH](https://www.openarchives.org/pmh/){target=_blank}, providing a standards-based metadata and catalogue component of spatial data infrastructures. pycsw is [Open Source](https://opensource.org/){target=_blank}, released under an [MIT license](https://docs.pycsw.org/en/latest/license.html){target=_blank}, and runs on all major platforms (Windows, Linux, Mac OS X).
|**[Apache Solr](https://solr.apache.org/){target=_blank}**| |
|**[OpenStreetMaps API](){target=_blank}**| |

**Frontend**

|Technology|Description|
|----------|-----------|
|**[React](https://react.dev/){target=_blank}**| |
|**[pycsw](https://pycsw.org){target=_blank} v3.0**| Pycsw also offers User interface, which was used as a default in previous SoilWise prototype.|


**Inrastructure**

| Component | Technology |
|-----------|-----------|
| **Container** | Docker (multi-stage build, Eclipse Temurin JDK 21) |
| **CI/CD** | GitLab CI with semantic release (conventional commits) |
| **Orchestration** | Kubernetes (liveness/readiness probes) |

### Main Component Diagram

### Main Sequence Diagram

## Integrations & Interfaces

## Key Architectural Decisions

## Risks & Limitations
