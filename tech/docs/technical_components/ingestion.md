#  Ingestion

The Ingestion component is dedicated to automatically harvest sources to populate [SWR Catalogue](publication.md#catalogue-server). It comprises of the following components:

1. [Automated metadata harvesting](#automated-metadata-harvesting)
2. [Automated ingestion of metadata on knowledge sources](#automated-ingestion-of-metadata-on-knowledge-sources)

``` mermaid
flowchart LR
    DBD[(fa:fa-database Data & knowledge providers)] --> I
    AID --> MC(Metadata cache)
    AIK --> KL(Knowledge sources log)
    I --> CGM(Certification & governance management)
subgraph I [Ingestion]
    AID("`**Automated metadata harvesting**`") ~~~ AIK("`**Automated ingestion of metadata on knowledge sources**`")

end
```

## Automated metadata harvesting

Metadata harvesting is the process of ingesting metadata, i.e. evidence on data and knowledge, from remote sources and storing it locally in the catalogue for fast searching. It is a scheduled process, so local copy and remote metadata are kept aligned.  Metadata harvesting is a default feature of all the most common geospatial catalogue servers.
Two open-source cataloguing options were evaluated: **GeoNetwork** and **pycsw.** pycsw was selected primarily because of the two following reasons:

1.	we foresee that the [SWR Catalogue](publication.md#catalogue-server) will contain at least dozens of thousands or more probably even hundreds of thousands of metadata records. Based on our previous experience, GeoNetwork (Elastic Search) is a stable backend when working with thousands of metadata records. A known issue is harvesting large number of records, for this reason INSPIRE Geoportal started an initiative to implement [csw-harvesting](https://github.com/GeoCat/csw-harvester) using a dedicated microservice.
2. significant achievements in catalogue management were achieved within the [EJP Soil project](https://ejpsoil.eu/){target=_blank}. SoilWise will adopt these developments to re-use this good practice and use the resources efficiently.

In case of the SoilWise Repository, the primary aim is to retrieve metadata on data and knowledge resources. The harvesting mechanism relies on the concept of a _universally unique identifier (UUID)_ that is being assigned commonly by metadata creator or publisher. Another important concept behind the harvesting is the _last change date_. Every time you change a metadata record, the last change date is updated. Just storing this parameter and comparing it with a new one allows any system to find out if the metadata record has been modified since last update.

These two concepts allow catalogues to fetch remote metadata, check if it has been updated and remove it locally if it has been removed remotely. UUIDs also allowed cross catalogue harvesting in case B harvests from C and A harvests from B, as described in detail below.

### Harvesting life cycle

When a harvesting job is created, there is no harvested metadata. During the first run, all remote matching metadata are retrieved and stored locally. For some harvesters, after the first run, only metadata that has changed will be retrieved.

Harvested metadata are (by default) not editable for the following reasons:

1. The harvesting is periodic so any local change to harvested metadata will be lost during the next run.
2. The change date may be used to keep track of changes so if the metadata gets changed, the harvesting mechanism may be compromised.

The harvesting process goes on until one of the following situations arises:

1.	An administrator stops (deactivates) the harvester.
2.	An exception arises. In this case the harvester is automatically stopped.

When a harvester is removed, all metadata records associated with that harvester are removed.

### Multiple harvesting and hierarchies

Catalogues that use UUIDs to identify metadata records (e.g. pycsw) can be harvested several times without having to take care about metadata overlap.

As an example, consider the pycsw harvesting type which allows one pycsw node to harvest metadata records from another pycsw node and the following scenario:

1.	Node (A) has created metadata (a)
2.	Node (B) harvests (a) from (A)
3.	Node (C) harvests (a) from (B)
4.	Node (D) harvests from both (A), (B) and (C)

In this scenario, Node (D) will get the same metadata (a) from all 3 nodes (A), (B), (C). The metadata will flow to (D) following 3 different paths but thanks to its UUID only one copy will be stored. When (a) is changed in (A), a new version will flow to (D) but, thanks to the change date, the copy in (D) will be updated with the most recent version.

This scenario will fit to Mission Soil Horizon Europe projects that have catalogues on the pilot level and a central catalogue at the same time.

### Foreseen functionality

- finding metadata
- capturing metadata
- connecting source platform
- ingest remote records
- understand success of a harvest
- options to trigger monitor running harvestors

A range of **interfaces** need to be supported to extract resources from:

- Cordis (SPARQL)
- Zenodo, Dataverse, OpenAire (OAI-PMH / Datacite)
- INSPIRE (CSW)
- ESDAC (HTML scraping??)
- Web pages (Schema.org)
- ...

For some endpoints a metadata transformation may be required, before the document can be stored in SWR.

### Technology

[**geodatacrawler**](https://pypi.org/project/geodatacrawler/){target=_blank}, written in python, extracts metadata from various sources:

- Local file repository (metadata and various data formats)
- CSV of metadata records (each column represents a metadata property)
- remote identifiers (DOI, CSW)
- remote endpoints (CSW)

**pycsw**, written in python, allows for the publishing and discovery of geospatial metadata via numerous APIs ([CSW 2/CSW 3](https://www.ogc.org/standard/cat/){target=_blank}, [OpenSearch](https://opensearch.org/){target=_blank}, [OAI-PMH](https://www.openarchives.org/pmh/){target=_blank}, [SRU](https://developers.exlibrisgroup.com/rosetta/integrations/standards/sru/){target=_blank}), providing a standards-based metadata and catalogue component of spatial data infrastructures. pycsw is [Open Source](https://opensource.org/){target=_blank}, released under an [MIT license](https://docs.pycsw.org/en/latest/license.html){target=_blank}, and runs on all major platforms (Windows, Linux, Mac OS X).

**GeoNetwork** or **GeoNetwork INSPIRE GeoPortal harvest microservice**

Important aspect of harvesters is the capability to finetune filters, resources such as INSPIRE, Cordis, Zenodo need proper filters in order to preselect relevant sources.

**Git CI-CD** to run harvests, provides options to review CI-CD logs to check errors

### Integration opportunities

The Automatic metadata harvesting component will show its full potential when being in the SWR tightly connected to (1) [SWR Catalogue](publication.md#catalogue-server), (2) [data download](dashboard.md#data-download--export-mu) & [upload pipelines](dashboard.md#manual-data--metadata-upload-mu) and (3) [ETS/ATS](data_processing.md#metadata-validation-etsats), i.e. test suites.

## Automated extraction and ingestion of metadata on knowledge sources (WENR)

For knowlege resouces it is less usual to provide metadata according to standardized metadata schemas, and to expose metadata through harvesting protocols. Therefore, a dedicated strategy and procedures are needed to be able to harmonize and index knowledge as part of the SWR.

In cases where no metadata service is available:
- Access and download data via the (most feasible) available endpoint
- Process data
  - mapping the content to a SWR schema for knowledge metadata (Dublin Core)
  - Derive missing metadata fields if possible
  - Label metadata
- Store metadata

In cases where no a metadata service and/or harvesting protocol is available:
- Follow harvesting process for datasets
- Process data
  - Derive missing metadata fields if possible
  - Label metadata
- Store metadata

For use with AI/ML (e.g. LLMs), additionally it might be interesting to ingest and store the knowledge content itself (training ML models), or relevant fragments (explainnable AI). This is subject of the 2nd and 3rd interation and the development of LLM/Chatbot functionality on the SWR. 

List of knowledge repositories
- CORDIS: SparQL / REST endpoints / no metadata
- Zenodo: REST / OAI/PMH /
- OpenAIRE: REST / OAI/PMH /
- list to be extended...
