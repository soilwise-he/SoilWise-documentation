#  Harvester

!!! component-header "Info"
    **Current version:** 0.2.0

    **Project:** [Harvesters](https://github.com/soilwise-he/harvesters)

The Harvester component is dedicated to automatically harvest sources to populate SWR with metadata on [datasets](#datasets) and [knowledge sources](#knowledge-sources).

## Metadata harvesting concept

Metadata harvesting is the process of ingesting metadata, i.e. evidence on data and knowledge, from remote sources and storing it locally in the catalogue for fast searching. It is a scheduled process, so local copy and remote metadata are kept aligned. Various components exist which are able to harvest metadata from various (standardised) API's. SoilWise aims to use existing components where available.

The harvesting mechanism relies on the concept of a _universally unique identifier (UUID)_ or _unique resource identifier (URI)_ that is being assigned commonly by metadata creator or publisher. Another important concept behind the harvesting is the _last change date_. Every time a metadata record is changed, the last change date is updated. Just storing this parameter and comparing it with a new one allows any system to find out if the metadata record has been modified since last update. An exception is if metadata is removed remotely. SoilWise Repository can only derive that fact by harvesting the full remote content. Discussion is needed to understand if SWR should keep a copy of the remote source anyway, for archiving purposes. All metadata with an update date newer then _last-identified successfull harvester run_ are extracted from remote location. 

A harvesting task typically extracts records with update-date later then the _last-identified successfull harvester run_. In case the remote system supports such a filter, else the full set is harvested.

Local improvements to metadata records should be stored separately from the harvested content for the following reasons:

1. The harvesting is periodic so any local change to harvested metadata will be lost during the next run.
2. The change date may be used to keep track of changes so if the metadata gets changed, the harvesting mechanism may be compromised.

If inconsistencies with imported metadata are identified, we can add a statement to the graph of such inconsistencies. We can also notify the author of the inconsistency so they can fix the inconsistency on their side.

A governance aspect still under discussion is if harvested content is removed as soon as a harvester configuration is removed, or when records are removed from the remote endpoint. The risk of removing content is that relations within the graph are breached. An alternative is to indicate the record has been archived by the provider.

On top of a unique identification, SWR also captures a unique calculated string (a hash) for the harvested content. This allows to identify changes even if the update date has not changed.

Typical tasks of a harvester:

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

- Data & Knowledge Resources (datasets, services, software, documents, articles, videos)
- Organisations, Projects, LTE, Living labs initiatives
- News items from relevant websites

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

### Datasets

Metadata records of datasets are, for the first iteration, primarily imported from the **ESDAC**, **INSPIRE GeoPortal**, **BonaRes**, **Cordis**/**OpenAire**, **ISRIC**, **FAO**, and **EEA**. In later iterations SoilWise aims to include other projects and portals, such as **national** or **thematic portals**. These repositories contain large number of datasets. Selection of key datasets concerning the SoilWise scope is a subject of know-how to be developed within SoilWise.

### Knowledge sources

Compared to datasets, knowledge sources are typically very heterogeneous (reports, articles, websites, video's) and collected in a variety of repositories. Soilwise endorses projects to use persistent repositories, with sufficient options for metadata capture. For the acadmic community for example, inclusion in OpenAire is a prerequisite to be included in SWR. This allows SWR to use the OpenAire functionalities to collect evidence about the resources. 

The SoilWise project team is still exploring which knowledge resources to include. As an example, an important cluster of knowledge sources may be seen academic articles and report deliverables from Mission Soil Horizon Europe projects. These resources are accessible from **Cordis** and **OpenAire**, filteres by the grantnumber of the projects. Extracting content from Cordis and OpenAire can be achieved using a harvesting task (using the Cordis schema, extended with post processing). For the first iteration, SoilWise aims to achieve this goal. In future iterations new knowledge sources may become relevant, we will investigate at that moment what is the best approach to harvest them.

### Projects and organisations

Project details are extracted from Cordis. Discussion is ongoing how to improve this process, for example to understand 
if projects should be included which do not have European funding.

Indivicuals and organisations are typically mentioned as contact, author or owner in metadata records, as well as participant or funder in projects. 

A challenge for SWR is to understand the alignment between those individuals and organisations, to enable users to understand the relations between projects, organisations and resources.

### News items

A need has been expressed to be informed about ongoing Soil Mission projects. For that reason a harvesting mechanism has been set up which extracts and aggregates from the various Soil Mission Project websites the news items published in their websites. A common protocol, RSS/Atom feeds, implemented by most of the project websites is used to extract that information. At the moment we are investigating if we can also extract anounced upcoming events, for example via the iCalendar protocol, but we already noticed that this protocol has vert little adoption.

### Adoption of standards

With respect to harvesting, it is important to note that a wide range of levels of adoption of standards is implemented by repositories. 
Both for metadata models, identification, as well as access protocols. This will, in some cases, make it necessary to develop customized harvesting and metadata extraction processes. It also means that informed decisions need to be made on which resources to include, based on priority, required efforts and available capacity.

## Functionality

The Harvester component currently comprises of the following functions:

- [Harvest records from metadata and knowledge resources](#harvest-records-from-metadata-and-knowledge-resources)
- [Metadata harmonization](#metadata-harmonization)
- [Metadata RDF turtle serialization](#metadata-rdf-turtle-serialization)
- [RDF to Triple Store](#rdf-to-triple-store)
- [Duplication identification](#duplication-indentification)

### Harvest records from metadata and knowledge resources

Note, the second SoilWise Repository prototype contained **19,324** harvested metadata records (to date 14.2.2025).

#### CORDIS

European Research projects typically advertise their research outputs via [Cordis](https://cordis.europa.eu/){target=_blank}. This makes Cordis a likely candidate to discover research outputs, such as reports, articles and datasets. Cordis does not capture many metadata properties. In those cases where a resource is identified by a [DOI](https://www.doi.org/the-identifier/what-is-a-doi/){target=_blank}, additional metadata can be found in OpenAire via the DOI. The scope of projects, from which to include project deliverables is still under discussion. 

Which projects to include is derived from 2 sources:

- [ESDAC](https://esdac.jrc.ec.europa.eu/projects/Eufunded/Eufunded.html){target=_blank} maintains a list of historic EU funded research projects
- [Mission soil platform](https://mission-soil-platform.ec.europa.eu/project-hub/funded-projects-under-mission-soil){target=_blank} maintains a list of current Mission soil projects

A script fetches the content from these 2 sources and prepares relevant content for the CORDIS and OpenAire harvesting. The content in these pages is unstructured html. The content is scraped using a python library. This is not optimal, because the scraper expects a dedicated html structure, which is fragile.

Results of the scrape activity are stored in table `harvest.projects`. For each project a Record control number ([RCN](https://www.wikidata.org/wiki/Property:P5755){target=_blank}) is retrieved from the Cordis knowledge graph. This RCN could be used to filter OpenAire, however OpenAire can also be filtered using project grant number. At this moment in time the Cordis Knowledge graph does not contain the Mission Soil projects yet. 

Currently we do not harvest resources from Cordis which do not have a DOI. This includes mainly progress reports of the projects. 

#### OpenAire

For those resources, discovered via Cordis/ESDAC, and identified by a DOI, a harvester fetches additional metadata from OpenAire. OpenAire is a catalogue initiative which harvests metadata from popular scientific repositories, such as Zenodo, Dataverse, etc.

Not all DOI's registered in Cordis are available in OpenAire. OpenAire only lists resources with an open access license. Other DOI's can be fetched from the DOI registry directly or via Crossref.org. This work is still in preparation.

Records in OpenAire are stored in the Open Aire Research Graph ([OAF](https://www.openaire.eu/schema/1.0/doc/oaf-1.0.html){target=_blank}) format, which is transformed to a metadata set based on Dublin Core.

#### OGC-CSW

Many (spatial) catalogues advertise their metadata via the [catalogue Service for the Web](https://www.ogc.org/standard/cat/){target=_blank} standard, such as INSPIRE GeoPortal, Bonares, ISRIC. The [OWSLib](https://github.com/geopython/owslib){target=_blank} library is used to query records from CSW endpoints. A filter can be configured to retrieve subsets of the catalogue.

Incidentally, records advertised as CSW also include a DOI reference (Bonares/ISRIC). Additional metadata for these DOI's is extracted from OpenAire/Crossref.


#### INSPIRE

Although [INSPIRE Geoportal](https://inspire-geoportal.ec.europa.eu/){target=_blank} does offer a CSW endpoint, due to a technical reasons, we have not been able to harvest from it. Instead we have developed a dedicated harvester via the Elastic Search API endpoint of the Geoportal. If at some point the technical issue has been resolved, use of the CSW harvest endpoint is favourable.

#### ESDAC

The [ESDAC catalogue](https://esdac.jrc.ec.europa.eu/){target=_blank} is an instance of Drupal CMS. We have developed a dedicated harvester to scrape html elements to extract Dublin Core metadata from ESDAC html elements. Metadata is extracted for datasets, maps (EUDASM) and documents. Incidentally a DOI is mentioned as part of the HTML, this DOI is then used as identifier for the resource, else the resource url is used as identifier. If the DOI is not known to the system yet, OpenAire will be queried to capture additional metadata on the resource.

#### Prepsoil portal

[Prepsoil](https://prepsoil.eu/knowledge-hub){target=_blank} is build on a headless CMS. The CMS at times provides an API to retrieve datasets, knowledge items, living labs, lighthouses and communities of practice. The API provides minimal metadata, incidentally a DOI is included. DOI is used to capture additional metadata from OpenAire.

#### News feeds

From the project websites mentioned at <https://mission-soil-platform.ec.europa.eu/project-hub/funded-projects-under-mission-soil> a harvester algorythm fetches the contents of the RSS feed, if the website provides one. The harvested entries are stored on a database.

### Metadata Harmonization

Once stored in the harvest sources database, a second process is triggered which harmonizes the sources to the desired metadata profile. These processes are split by design, to prevent that any failure in metadata processing would require to fetch remote content again.

Table below indicates the various source models supported

| source | platform |
| --- | --- |
| Dublin Core | Cordis |
| Extended Dublin core | ESDAC |
| Datacite | OpenAire, Zenodo, DOI |
| ISO19115:2005 | Bonares, INSPIRE |

Metadata is harmonised to a [DCAT](https://www.w3.org/TR/vocab-dcat-3/){target=_blank} RDF representation.

For metadata harmonization some supporting modules are used, [OWSlib](https://owslib.readthedocs.io/en/latest/){target=_blank} is a module to parse various source metadata models, including iso19139:2007. A transformation script from [semic-eu/iso19139-to-dcat-ap.xslt](https://github.com/semic-eu/iso19139-to-dcat-ap/){target=_blank} in combination with lxml and rdflib is used to convert iso19139:2007 metadata to RDF, serialised as turtle.

Harmonised metadata is either transformed to iso19139:2007 or Dublin Core and then ingested by the pycsw software, used to power the [SoilWise Catalogue](catalogue.md), using an automated process running at intervals. At this moment the pycsw catalogue software requires a dedicated database structure. This step converts the harmonised metadata database to that model. In next iterations we aim to remove this step and enable the catalogue to query the harmnised model directly.

#### Metadata Augmentation

The metadata augmentation processes are described [elsewhere](metadata_augmentation.md), what is relevant here is that the output of these processes is integrated in the harmonised metadata database.

### Metadata RDF turtle serialization

The harmonised metadata model is based on the DCAT ontology. In this step the content of the database is written to RDF.

Harmonized metadata is transformed to RDF in preparation of being loaded into the triple store (see also [Knowledge Graph](./knowledge_graph.md)).

### RDF to Triple store

This is a component which on request can dump the content of the harmonised database as an RDF quad store. This service is requested at intervals by the triple store component. In a next iteration we aim to push the content to the triple store at intervals.

### Duplication indentification

A resource can be described in multiple Catalogues, identified by a common identifier. Each of the harvested instances may contain duplicate, alternative or conflicting statements about the resource. SoilWise Repository aims to persist a copy of the harvested content (also to identify if the remote source has changed). For this iteration we store the first copy, and capture on what other platforms the record has been discovered. OpenAire already has a mechanism to indicate in which platforms a record has been discovered, this information is ingested as part of the harvest. An aim of this exercise is also to understand in which repositories a certain resource is advertised.

Visualization of source repositories is in the first development iteration available as a dedicated section in the [SoilWise Catalogue](catalogue.md).

## Technology

### Git actions/pipelines to run harvest tasks

Git actions (github) or pipelines (gitlab) are automated processes which run at intervals or events. Git platforms typically offer this functionality including extended logging, queueing, and manual job monitoring and interaction (start/stop).

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

#### OGC-CSW

Many (spatial) catalogues advertise their metadata via the [catalogue Service for the Web](https://www.ogc.org/standard/cat/){target=_blank} standard, such as INSPIRE GeoPortal, Bonares, ISRIC.

#### CORDIS - OpenAire

Cordis does not capture many metadata properties. We harvest the title of a project publication and, if available, the DOI. In those cases where a resource is identified by a [DOI](https://www.doi.org/the-identifier/what-is-a-doi/){target=_blank}, additional metadata can be found in OpenAire via the DOI. For those resources a harvester fetches additional metadata from OpenAire. 

A second mechanism is available to link from Cordis to OpenAire, the RCN number. The OpenAire catalogue can be queried using an RCN filter to retrieve only resources relevant to a project. This work is still in preparation.

Not all DOI's registered in Cordis are available in OpenAire. OpenAire only lists resources with an open access license. Other DOI's can be fetched from the DOI registry directly or via Crossref.org. This work is still in preparation.
Detailed technical information can be found in the [technical description](https://github.com/soilwise-he/harvesters/tree/main/cordis#readme){target=_blank}.

#### OpenAire and other sources

The software used to query OpenAire by DOI or by RCN is not limited to be used by DOIs or RCNs that come from Cordis. Any list of DOIs or list of RCNs can be handled by the software.

## Integration opportunities

The Automatic metadata harvesting component will show its full potential when being in the SWR tightly connected to (1) [SWR Catalogue](catalogue.md), (2) [Metadata authoring](metadata_authoring.md) and (3) [ETS/ATS](metadata_validation.md#metadata-etsats-checking), i.e. test suites.
