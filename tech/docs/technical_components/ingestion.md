#  Harvester

!!! component-header "Important Links"
    :fontawesome-brands-github: Project: [Metadata ingestion](https://github.com/orgs/soilwise-he/projects/6)

The Harvester component is dedicated to automatically harvest sources to populate [SWR Triple Store](./storage.md) with metadata on [datasets](#datasets) and [knowledge sources](#knowledge-sources).

## Automated metadata harvesting concept

Metadata harvesting is the process of ingesting metadata, i.e. evidence on data and knowledge, from remote sources and storing it locally in the catalogue for fast searching. It is a scheduled process, so local copy and remote metadata are kept aligned. Various components exist which are able to harvest metadata from various (standardised) API's. SoilWise aims to use existing components were available.

The harvesting mechanism relies on the concept of a _universally unique identifier (UUID)_ or _unique resource identifier (URI)_ that is being assigned commonly by metadata creator or publisher. Another important concept behind the harvesting is the _last change date_. Every time you change a metadata record, the last change date is updated. Just storing this parameter and comparing it with a new one allows any system to find out if the metadata record has been modified since last update. An exception is if metadata is removed remotely. SoilWise Repository can only derive that fact by harvesting the full remote content. Disucssion is needed to understand if SWR should keep a copy of the remote source anyway, for archiving purposes. All metadata with an update date newer then _last-identified successfull harvester run_ are extracted from remote location. 

## Persistence identification

Persistent Identifiers (PIDs) are unique and long-lasting codes refering to digital objects like  document, file, 
web page, or other objects. They act as permanent name tags for digital information, ensuring it can be reliably found 
and accessed over time, even if the original location or format changes. An example of a PID frequently used in 
academic publishing to identify journal articles, research reports and data sets is DOI (Digital Object Identifier).
Key characteristics of PIDs are:

- persistance (unchanged over time),
- resolvability (retrieving the identified object), 
- uniqueness (identifying a single, unique resource)
 and actionability (a way to directly access or interact with the resource)

They are used in the SoilWise Repository in respect to:

- consistent identification
- findability
- versioning / derivates linking

## Resource Types

Metadata for following resource types are forseen to be harvested:

- Data & Knowledge Resources (Articles/Datasets/Videos/Software/Services)
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

Datasets are to be imported from the **INSPIRE GeoPortal**, **BonaRes** as well as **Cordis**. In later iterations SoilWise aims to also include other portals, such as **national** or **thematic portals**.

### Knowledge sources

The SoilWise group is still exploring which knowledge resources to include. With respect to harvesting, it is important to note that knowledge assets will be heterogeneous, and that (compared to data), metadata standards and particularly access / harvesting protocols are not generally adopted. This can make it necessary to develop customized harvesting and metadata extraction processes. It also means that informed decisions need to be made on which resources to include, based on priority, required efforts and available capacity.

An important cluster of knowledge sources are academic articles and report deliverables from Horizon Europe projects. These resources are accessible from **Cordis**, **Zenodo** and **OpenAire**. Extracting content from Cordis, OpenAire and Zenodo can be achieved using a harvesting task (using the Cordis schema, extended with post processing). For the first itereation SoilWise aims for this goal. In future iterations new knowledge sources may become relevant, we will investigate at that moment what is the best approach to harvest them.

### Catalogue API's and models

Catalogues typically offer standardised API's as well as tailored API's to extract resources. Typically the tailored API's offer extra capabilities which may be relevant to SoilWise. However in general we should adopt the standardised interfaces, because it allows us to use of the shelf components with high TRL.

Standardised API's are available for harvesting records from:

- Catalogue Service for the Web (OGC:CSW)
- Protocol metadata harvesting (OAI-PMH)
- SPARQL
- Sitemap.xml 

Dedicated communities made efforts to standardise metadata in their domain. This resulted in a large number of standardised metadata models. Most of them (but not all) are oriented on the Dublin Core model, which provides a common entry point to these models. In that scenario we should be able to at least extract the Dublin Core elements from various schema's. If we identify that additional properties need to be extracted, extraction extensions will be added to the metadata cleaning component per origin metadata schema.

For now we identified the following general metadata models from which the Dublin Core elements can be extracted:

- ISO 19139:2007 / ISO 19115:2012 (xml)
- Dublic Core (xml)
- DataCite (json/xml)
- DCAT (RDF)

Potentially of interest are:

- [EML/Darwin Core](https://www.gbif.org/standards)
- [Schema.org](https://schema.org/Dataset) (json-ld)
- [OpenGraph](https://ogp.me/)

Because of their relevance we aim to also support:

- Cordis data model
- ESDAC (HTML scraping??)

## Architecture

Below are described 3 options for a harvesting infrastructure. The main difference is the scalability of the solution, which is mainly dependent on the frequency and volume of the harvesting. 

### Traditional approach

Traditionally a harvesting script is triggered by a cron job.

``` mermaid
flowchart LR
    HC(Harvest configuration) --> AID
    AID(Harvest component)
    RW[RDFwriter] --> MC[(Triple Store)]
    AID --> RS[(Remote sources)]
    AID --> RW
    RS --> AID
```

### Containerised appraoch

In this approach each harvester runs in a dedicated container. The result of the harvester is ingested into a (temporary) storage, where follow up processes pick up the results. Typically these processes are using existing containerised workflows such as GIT CI-CD, Google cloud run, etc.

``` mermaid
flowchart LR
    c[CI-CD] -->|task| q[/Queue\]
    r[Runner] --> q
    r -->|deploys| hc[Harvest container]
    hc -->|harvests| db[(temporary storage)]
    hc -->|data cleaning| db[(temporary storage)]
```

### Microservices approach

The microservices approach uses a dedicated message queue where dedicated runners pick up harvesting tasks, validation tasks and cleaning tasks as soon as they are scheduled. Runners write their results back to the message queue, resulting in subsequent tasks to be picked up by runners.

``` mermaid
flowchart LR
    HC(Harvest configuration) -->|trigger| MQ[/MessageQueue\]
    MQ -->|task| AID
    AID --> MQ
    MQ -->|task| DC
    DC --> MQ
    MQ -->|write| RW[RDFwriter]
    AID(Harvest component)
    RW --> MC[(Triple Store)]
    AID --> RS[(Remote sources)]
```

For this iteration, SoilWise will focus on the second approach.

## Foreseen functionality

A harvesting task typically extracts records with update-date later then the _last-identified successfull harvester run_.

Harvested content is (by default) not editable for the following reasons:

1. The harvesting is periodic so any local change to harvested metadata will be lost during the next run.
2. The change date may be used to keep track of changes so if the metadata gets changed, the harvesting mechanism may be compromised.

If inconsitencies with imported metadata are identified, we can add a statement to the graph of such inconsistencies. We can also notify the author of the inconsistency, so they can fix the inconsistency on their side.

To be discussed is if harvested content is removed, as soon as a harvester configuration is removed, or records are removed from the remote endpoint. The risk of removing content is that relations within the graph are breached. Instead, we can indicate a record has been archived by the provider.

Typical functionalities of a harvester:

- **Define a harvester job**
    - Schedule (on request, weekly, daily, hourly)
    - Endpoint / Endpoint type (eample.com/csw -> OGC:CSW)
    - Apply a filter (only records with keyword='soil-mission')
- **Understand success of a harvest job** 
    - overview of harvested content (120 records)
    - which runs failed, why? (today failed -> log, yesterday successfull -> log)
    - Monitor running harvestors (20% done -> cancel)
- **Define behaviors on harvested content**
    - skip records with low quality (if test xxx fails)
    - mint identifier if missing ( https://example.com/data/{uuid} )
    - a model transformation before ingestion ( example-transform.xsl / do-something.py )

### Duplicates / Conflicts

A resource can be described in multiple Catalogues, identified by a common identifier. Each of the harvested instances may contain duplicate, alternative or conflicting statements about the resource. SoilWise Repository aims to persist a copy of the harvested content (also to identify if the remote source has changed). The Harvester component itself will not evaluate duplicities/conflicts between records, this will be resolved by the [Interlinker component](interlinker.md). 

An aim of this exersice is also to understand in which repoitories a certain resource is advertised.

## Technology options

[**geodatacrawler**](https://pypi.org/project/geodatacrawler/){target=_blank}, written in python, extracts metadata from various sources:

- Local file repository (metadata and various data formats)
- CSV of metadata records (each column represents a metadata property)
- remote identifiers (DOI, CSW)
- remote endpoints (CSW)

[**Google cloud run**](https://cloud.google.com/run){target=_blank} is a cloud environment to run scheduled tasks in containers on the google platform, the results of tasks are captured in logs

[**Git CI-CD**](https://github.com/features/actions){target=_blank} to run harvests, provides options to review CI-CD logs to check errors

[**RabbitMQ**](https://www.rabbitmq.com/){target=_blank} a common message queue software

## Integration opportunities

The Automatic metadata harvesting component will show its full potential when being in the SWR tightly connected to (1) SWR Catalogue, (2) [data download](dashboard.md#data-download-export) & [upload pipelines](dashboard.md#manual-data-metadata-authoring) and (3) [ETS/ATS](metadata_validation.md), i.e. test suites.




