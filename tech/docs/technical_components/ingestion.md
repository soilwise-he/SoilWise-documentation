#  Harvester

!!! component-header "Info"
    **Current version:** v0.2

    **Project:** [Harvesters](https://github.com/soilwise-he/harvesters)

The Harvester component is dedicated to automatically harvest sources to populate SWR with metadata on [datasets](#datasets) and [knowledge sources](#knowledge-sources).

## Automated metadata harvesting concept

Metadata harvesting is the process of ingesting metadata, i.e. evidence on data and knowledge, from remote sources and storing it locally in the catalogue for fast searching. It is a scheduled process, so local copy and remote metadata are kept aligned. Various components exist which are able to harvest metadata from various (standardised) API's. SoilWise aims to use existing components where available.

The harvesting mechanism relies on the concept of a _universally unique identifier (UUID)_ or _unique resource identifier (URI)_ that is being assigned commonly by metadata creator or publisher. Another important concept behind the harvesting is the _last change date_. Every time a metadata record is changed, the last change date is updated. Just storing this parameter and comparing it with a new one allows any system to find out if the metadata record has been modified since last update. An exception is if metadata is removed remotely. SoilWise Repository can only derive that fact by harvesting the full remote content. Disucssion is needed to understand if SWR should keep a copy of the remote source anyway, for archiving purposes. All metadata with an update date newer then _last-identified successfull harvester run_ are extracted from remote location. 

## Foreseen functionality

A harvesting task typically extracts records with update-date later then the _last-identified successfull harvester run_.

Harvested content is (by default) not editable for the following reasons:

1. The harvesting is periodic so any local change to harvested metadata will be lost during the next run.
2. The change date may be used to keep track of changes so if the metadata gets changed, the harvesting mechanism may be compromised.

If inconsistencies with imported metadata are identified, we can add a statement to the graph of such inconsistencies. We can also notify the author of the inconsistency so they can fix the inconsistency on their side.

To be discussed is if harvested content is removed as soon as a harvester configuration is removed, or when records are removed from the remote endpoint. The risk of removing content is that relations within the graph are breached. Instead, we can indicate a record has been archived by the provider.

Typical functionalities of a harvester:

- **Define a harvester job**
    - Schedule (on request, weekly, daily, hourly)
    - Endpoint / Endpoint type (example.com/csw -> OGC:CSW)
    - Apply a filter (only records with keyword='soil-mission')
- **Understand success of a harvest job** 
    - overview of harvested content (120 records)
    - which runs failed, why? (today failed -> log, yesterday successfull -> log)
    - Monitor running harvestors (20% done -> cancel)
- **Define behaviours on harvested content**
    - skip records with low quality (if test xxx fails)
    - mint identifier if missing ( https://example.com/data/{uuid} )
    - a model transformation before ingestion ( example-transform.xsl / do-something.py )

## Resource Types

Metadata for following resource types are foreseen to be harvested:

- Data & Knowledge Resources 
- Projects/LTE/Living labs
- Funding schemes (Mission-soil)
- Organisations
- Repositories/Catalogues

These entities relate to each other as:

``` mermaid
flowchart LR
    people -->|memberOf| o[organisations] 
    o -->|partnerIn| p[projects]
    p -->|produce| d[data & knowledge resources]
    o -->|publish| d
    d -->|describedIn| c[catalogues]
    p -->|part-of| fs[Fundingscheme]
```

## Origin of harvested resources

### Datasets

Datasets are to be primarily imported from the **ESDAC**, **INSPIRE GeoPortal**, **BonaRes** and **Cordis**/**OpenAire**. In later iterations SoilWise aims to include other projects and portals, such as **national** or **thematic portals**. These repositories contain large number of datasets. Selection of key datasets concerning the SoilWise scope is a subject of know-how to be developed within SoilWise.

### Knowledge sources

With respect to harvesting, it is important to note that knowledge assets are heterogeneous, and that (compared to data), metadata standards and particularly access / harvesting protocols are not generally adopted. Available metadata might be implemented using a proprietary schema, and basic assumptions for harvesting, e.g. providing a "date of last change" might not be offered. This will, in some cases, make it necessary to develop customized harvesting and metadata extraction processes. It also means that informed decisions need to be made on which resources to include, based on priority, required efforts and available capacity.

The SoilWise project team is still exploring which knowledge resources to include. An important cluster of knowledge sources are academic articles and report deliverables from Mission Soil Horizon Europe projects. These resources are accessible from **ESDAC**, **Cordis** and **OpenAire**. Extracting content from Cordis, OpenAire can be achieved using a harvesting task (using the Cordis schema, extended with post processing). For the first iteration, SoilWise aims to achieve this goal. In future iterations new knowledge sources may become relevant, we will investigate at that moment what is the best approach to harvest them.

### Catalogue APIs and models

Catalogues offer standardised APIs as well as platform specific APIs to extract resources. Typically, the platform specific APIs offer extra capabilities which may be relevant to SoilWise. However in general we should adopt the standardised interfaces, because it allows us to use of the shelf components with high TRL.

Standardised APIs are available for harvesting records:

- Catalogue Service for the Web (OGC:CSW)
- Protocol metadata harvesting (OAI-PMH)
- SPARQL
- Sitemap.xml 


## Metadata Harmonization

Platforms have adopted various metadata models to store information. Imported metadata should be harmonized to a common model to facilitate searches over these resources.
In Soilwise metadata is harmonized after the harvesting step is finished. 

Table below indicates the various source models supported

| source | platform |
| --- | --- |
| Dublin Core | Cordis |
| Extended Dublin core | ESDAC |
| Datacite | OpenAire, Zenodo, DOI |
| ISO19115:2005 | Bonares, INSPIRE |

Metadata is harmonised to a [DCAT](https://www.w3.org/TR/vocab-dcat-3/) RDF representation.

For metadata harmonization some supporting modules are used, [owslib](https://owslib.readthedocs.io/en/latest/) is a module to parse various source metadata models, including iso19115:2005. [pygeometa](https://github.com/geopython/pygeometa) is a module which can export owslib parsed metadata to various outputs, including DCAT.


## Architecture

Each harvester runs in a dedicated container. The result of the harvester is ingested into a (temporary) storage.
Follow up processes (harmonization, augmentation, validation) pick up the results from the temporary storage. 

``` mermaid
flowchart LR
    c[CI-CD] -->|task| q[/Queue\]
    r[Runner] --> q
    r -->|deploys| hc[Harvest container]
    hc -->|harvests| db[(temporary storage)]
    hc -->|data cleaning| db[(temporary storage)]
```
Harvester tasks are triggered from [**Git CI-CD**](https://github.com/features/actions){target=_blank}, Git provides options to cancel and trigger tasks and review CI-CD logs to check errors

### Duplicates / Conflicts

A resource can be described in multiple Catalogues, identified by a common identifier. Each of the harvested instances may contain duplicate, alternative or conflicting statements about the resource. SoilWise Repository aims to persist a copy of the harvested content (also to identify if the remote source has changed). The Harvester component itself will not evaluate duplicities/conflicts between records, this will be resolved by the [Interlinker component](interlinker.md). 

An aim of this exercise is also to understand in which repositories a certain resource is advertised.

## Integration opportunities

The Automatic metadata harvesting component will show its full potential when being in the SWR tightly connected to (1) [SWR Catalogue](catalogue.md), (2) [Data download](dashboard.md#data-download-export) & [Metadata authoring](metadata_authoring.md) and (3) [ETS/ATS](metadata_validation.md#metadata-etsats-checking), i.e. test suites.




