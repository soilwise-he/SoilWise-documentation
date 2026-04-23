# SoilWise Finder (Metadata Catalogue)

!!! component-header "Info"
    **Current version:** 2.0.0 

    **Technology:** [Apache Solr](https://solr.apache.org/), [React](https://react.dev/, Java SE)

    **Release:** TBD

    **Project repository:** [Catalogue UI](https://github.com/soilwise-he/SoilWiseFinder)

    **Access point:** <https://www.soilwise.wetransform.eu/search>

## Introduction

### Overview and Scope

The SoilWise Finder is a central piece of the SoilWise Catalogue architecture, providing search & discovery functions for end users and giving access to individual metadata records and knowledge content. For our first project iteration we selected the pycsw software, which supports most of these standards and also provided a user interface. In subsequent iterations, to improve both the user experience and the search performance, a UI based on [React](https://react.dev/), backed by the [Apache Solr](https://solr.apache.org/) search engine has been developed. 

### Intended Audience

The SoilWise Finder targets the following user groups:

- **Soil scientists and researchers** working with European soil health data and seeking catalogued knowledge, publications, and datasets.
- **Living Labs' data scientists** working with European soil health data and seeking catalogued knowledge, publications, and datasets.
- **Mission Soil Project Data Managers** searching for datasets published by other Mission Soil Projects, or veryfiing if their published data are recognized by SoilWise (EUSO).
- **Policy Makers** working with European soil health data and seeking catalogued knowledge, publications, and datasets.

### Key Features

#### User interface

The SoilWise Finder adopts a **React frontend**, focusing on:

1. **Paginated search results** - Search results are displayed per page in ranked order, in the form of a table comprising a summary of resource type, title, abstract, date and preview.
2. **Fulltext search** - including an autocomplete option.
3. **Resource type filter** - enabling to filter out certain types of resources, e.g. journal articles, datasets, reports, software.
4. **Thematic filters** - enabling to filter out resources containing certain keywords, language, source, resources published by specific projects, Mission Soil program, etc.
5. **Temporal filters** - enabling to filter out resources based on their creation date and temporal coverage.
6. **Spatial filters** - enabling to filter out resources based on their spatial extent using countries or regions, drawn bounding box, drawn free-form, vicinity of user's location, or by searching for geographical names.
7. **Record detail view** - After clicking a result's table item, a resource's detail page is displayed at a unique URL address to facilitate sharing. Resource's details currently comprise: resource's type tag, full title, full abstract, keywords' tags, preview of record's geographical extent, record's preview image, if available, information about relevant HE funding project, list of source repositories, last update date, all other resource's items...
8. **Resource preview** - 2 types of preview are currently supported: (1) Display resource geographical extent, which is available in the resource's detail, as well as in the search results list. (2) Display of a graphic preview (thumbnail) in case it is advertised in the metadata.
9. **Display results of metadata augmentation** - Results of metadata augmentation are stored on a dedicated database table. The results are merged into the harvested content during publication to the catalogue. At the moment it is not possible to differentiate between original and augmented content. For next iterations we aim to make this distinction more clear.
10. **Display links of related information** - Download of data "as is" is currently supported through the links section from the harvested repository. Note, "interoperable data download" has been only a proof-of-concept in the first iteration phase, i.e. is not integrated into the SoilWise Catalogue.
11. **Download search results** - Option to download current search results to .csv.

#### Search Engine - Index and search strategies

The SoilWise Finder implements back-end indexing strategies and search functions based on **Apache Solr**, focusing on:

1. **Denormalising metadata** - Solr is set up as a document indexing infrastructure, working on rather "flat" textual formats (documents) instead of normalised database models. The first step is therefore a conversion to a denormalised structure, currently implemented as a (single) database view (mv_records) in the Postgres metadata schema.
2. **Solr ingestion** - From the denormalised view, content of individual metadata records and textual content from documents are processed into Solr.documents that are ingested into the Solr infrastructure. Solr uses Natural Language Processing technologies (tranformers), to process and index Solr.documents. This is a combination of sequential sub processes (e.g. tokenizers) and configurations that determine how the documents are indexed and how they can be searched, ranked, faceted etc. The SoilWise search-API component implements a processing API that controls these transformations.
4. **Solr search** - The Search-API component, developed on top of the native Solr API, allows query access to the Solr index, so the UI (and potentially other clients) can search the metadata through the index.

**Apache SOLR and Apache Lucene for Lexical Search**

Solr as a search engine, ingesting data from the catalogue RDBMS, can dramatically increase the perfomance of end user queries. It suports (approximate, similarity based) lexical / full text search. Solr also supports the indexation of unstructured content, thus allows smart searches on unstructured text and extending the indexation from (meta)data to knowledge, e.g. unstructured content for documents, websites etc. It also offers better usability, e.g. through aggregation functions for faceted search and ranking of search results. 

**Apache Lucene for Semantic Search**

Besides for lexical search it is also possible to use Apache Lucene for semantic search. The first tries to match on the literals of words or their variants, the latter focusses on the intent or meaning of the data. To that end the data (usually text) is translated by a model into a multi-dimensional vector representation (called an embedding), which is then used with a proximity search algorithm. Tyically deep learning models are used to create the embeddings and they are trained so that the embeddings of semantically similar pieces of data are close to another. Semantic search capabilities can be used for many applications, amongst other LLM-driven systems like chatbots or RAG systems to provide them with content (pieces of text data) relevant to a question.

Although dedicated vector stores are available, SoilWise foresees the use of the Solr extension for storage of text embeddings. There are several advantages in using Solr to implement the SWR vector database. First of all it is an open source product. Second, as it is an extension to the Solr search engine platform, it allows adding vector embeddings, without introducing dependencies on additional components. Third, although part of the Solr platform, it allows maintaining a modular setup, where for a final deployment at EC-JRC it keeps the option open to include or exclude the foreseen SWR NLQ components. 

## Architecture

### Technological Stack

**Backend**

|Technology|Description|
|----------|-----------|
|**[Apache Lucene](https://lucene.apache.org/) v9.11.1**| Apache Lucene is a open source high-performance Java-based search engine library.|
|**[Apache Solr](https://solr.apache.org/) v9.7.0**| Open source full text, vector and geo-spatial search framework on top of the Apache Lucene Index.|
|**[Java SE](https://www.oracle.com/java/technologies/java-se-glance.html) v17**| Programming language / set of libraries for enterprise software development used to implement the metadata to Solr conversion and interfacing layer between Solr and the UI |

**Frontend**

|Technology|Description|
|----------|-----------|
|**[React](https://react.dev/)**| Javascript framework that implements the search interface and access to Solr API|
|**[MUI](https://mui.com/)**| MUI offers a comprehensive suite of free UI tools for Javascript applications|
|**[OpenLayers](https://openlayers.org/)**| OpenLayers is a JavaScript library for displaying map data in web browsers as slippy maps.|
|**[Nivo](https://github.com/plouc/nivo/)**| Nivo provides supercharged React components to easily build dataviz apps, it's built on top of d3.|


**Infrastructure**

| Component | Technology |
|-----------|-----------|
| **Container** | Docker (multi-stage build, Eclipse Temurin JDK 21) |
| **CI/CD** | GitLab CI with semantic release (conventional commits) |
| **Orchestration** | Kubernetes (liveness/readiness probes) |

### Main Component Diagram

``` mermaid
flowchart LR
    A[(denormalised metadata mv_records: Postgres)]

    B[pdf-parsing: GROBID]
    C[Solr ingestion: search-API]
    D[(Apache Solr / Lucene)]
    E[solr search: search-API]
    F[Catalogue UI: Search-UI]

    A -- SQL --> B
    A -- SQL --> C
    B -- XML --> C
    C -- JSON --> D
    D --> E
    E -- JSON --> F
```
  
<!--img width="908" height="510" alt="image" src="https://github.com/user-attachments/assets/3451ce98-3069-43c1-8b65-258c1a216b9c" /-->

## Key Architectural Decisions

| Decision | Rationale |
|----------|-----------|
| **Replace pycsw front-end with React** | pycsw user interface has limited functionality, which is also hard to adapt and extend. React is a broadly used JS library offering the required flexibility and adaptability |
| **Solr as search engine** | Solr was chosen as open source search engine because of support for storing vector embeddings (AI/ML support) |
| **Java Search-API** | A Java query layer is setup as an interface between the Solr native API and the React UI to delegate much of the complexity of query logic from the UI  |


## Risks & Limitations

| Risk / Limitation | Description | Mitigation |
|-------------------|-------------|------------|
| **Transferability** | The differences in technology stack between the SoilWise implementing consortium and the final owner (JRC) might lead to transferability and integration issues | Use of broadly adopted open source products. Alignment with JRC technical team |
| **Metadata quality** | The performance of the search functionality is highly dependent on the completeness and quality of the harvested metadata which is out of scope for SoilWise. | The Soil Mission will define guidelines for metadata creation. Metadata augmentation will allow to partly mitigate. |
| **Transparency and explainability** | The dependency on metadata completeness and quality in combination with the large amount of interdependent options for (fuzzy) search strategies and the different combinations of UI search features will make it hard to understand the logic behind search results. | Documentation of metadata augmentation, search strategies etc. |
| **Usability** | The diversity of user groups and their requirements and expectations make it difficult to find balance between functionality/complexity/user-friendliness. | Iterative appraoch and validation/testing with user groups to align. |


## Integrations & Interfaces

[Pycsw](https://pycsw.org/) is still used to provide standardised APIs for catalogue harvesting and filtering.

| Service | Auth | Endpoint | Purpose |
|---------|------|----------|---------|
|**Catalogue Service for the Web (CSW)**||<https://repository.soilwise-he.eu/cat/csw>|Catalogue service for the web (CSW) is a standardised pattern to interact with (spatial) catalogues, maintained by OGC.|
|**OGC API - Records**||<https://repository.soilwise-he.eu/cat/openapi>|OGC is currently in the process of adopting a revised edition of its catalogue standards. The new standard is called OGC API - Records. OGC API - Records is closely related to Spatio Temporal Asset Catalogue (STAC), a community standard in the Earth Observation community.|
|**Protocol for metadata harvesting (OAI-PMH)**||<https://repository.soilwise-he.eu/cat/oaipmh>|The open archives initiative has defined a common protocol for metadata harvesting (oai-pmh), which is adopted by many catalogue solutions, such as Zenodo, OpenAire, CKAN. The oai-pmh endpoint of Soilwise can be harvested by these repositories.|
|**Spatio Temporal Asset Catalog (STAC)**|| <https://repository.soilwise-he.eu/cat/stac/openapi>||
|**OpenSearch**|| <https://repository.soilwise-he.eu/cat/opensearch> ||
