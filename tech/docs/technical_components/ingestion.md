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

### Technology

[**geodatacrawler**](https://pypi.org/project/geodatacrawler/){target=_blank}, written in python, extracts metadata from various sources. 

- Local file repository (metadata and various data formats)
- CSV of metadata records (each column represents a metadata property)
- remote identifiers (DOI, CSW)
- remote endpoints (CSW)

**pycsw**, written in python, allows for the publishing and discovery of geospatial metadata via numerous APIs ([CSW 2/CSW 3](https://www.ogc.org/standard/cat/){target=_blank}, [OpenSearch](https://opensearch.org/){target=_blank}, [OAI-PMH](https://www.openarchives.org/pmh/){target=_blank}, [SRU](https://developers.exlibrisgroup.com/rosetta/integrations/standards/sru/){target=_blank}), providing a standards-based metadata and catalogue component of spatial data infrastructures. pycsw is [Open Source](https://opensource.org/){target=_blank}, released under an [MIT license](https://docs.pycsw.org/en/latest/license.html){target=_blank}, and runs on all major platforms (Windows, Linux, Mac OS X).

### Integration opportunities

The Automatic metadata harvesting component will show its full potential when being in the SWR tightly connected to (1) [SWR Catalogue](publication.md#catalogue-server), (2) [data download](dashboard.md#data-download--export-mu) & [upload pipelines](dashboard.md#manual-data--metadata-upload-mu) and (3) [ETS/ATS](data_processing.md#metadata-validation-etsats), i.e. test suites.

## Automated ingestion of metadata on knowledge sources (WENR)

- harvest from catalogue (Zenodo, OpenAire, Cordis, ...)
- metadata ingestion, it can also be of interest to ingest the knowledge source itself for training LLM's and full text search

- connections with: data source and validation
- responsible person: Rob Lokers
- participating: Anna Fensel, Paul van Genuchten, Tomas Reznik
