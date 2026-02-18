# Repository Storage

## Introduction

### Overview and Scope
The SoilWise repository aims at merging and seamlessly providing different types of content. To host this content and to be able to efficiently drive internal processes and to offer performant end user functionality, different storage options are implemented.

1. [A relational database management system](#postgresql-rdbms-storage-of-raw-and-augmented-metadata) for the storage of the core metadata of both data and knowledge assets.
2. [A Triple Store](#virtuoso-triple-store-storage-of-swr-knowledge-graph) to store the metadata of data and knowledge assets as a graph, linked to soil health and related knowledge as a linked data graph.
3. [Git](#git-storage-of-code-and-configuration) for storage of user-enhanced metadata.

### Intended Audience

Storage is a backend component, therefore we only expect a maintenance role:

* **SWC Administrator** monitoring the health status, logs, signaling maintenance issues etc .
* **SWC Maintainer** performing corrective / adaptive maintenance tasks that require database access and updates.

## PostgreSQL RDBMS: storage of raw and augmented metadata

!!! component-header "Info"
    **Current version:** Postgres release 12.2; 

    **Technology:** Postgres

    **Access point:** SQL

A "conventional" RDBMS is used to store the (augmented) metadata of data and knowledge assets. There are several reasons for choosing an RDBMS as the main source for metadata storage and metadata querying:

- An RDBMS provides good options to efficiently structure and index its contents, thus allowing performant access for both internal processes and end user interface querying.
- An RDBMS easily allows implementing constraints and checks to keep data and relations consistent and valid.
- Various extensions, e.g. search engines, are available to make querying, aggregations even more performant and fitted for end users.

### Key Features

The Postgres database serves as a the destination and/or source for many of the backend processes of the SoilWise Catalogie. Its key features are:

1. **Raw metadata storage** — The harvester process uses it to store the raw results of the metadata harvesting of the different resources that are currently connected.
2. **Storage of Augmented metadata** — Various metadata augmentation jobs use it as input and write their input to this data store.
3. **Source for Search Index processing** — This database is also the source for denormalisation, processing and indexing metadata through the Solr framework.
4. **Source for UI querying** — While Solr is the main resource for end user querying through the catalogue UI, the catalogue also queries the Postgress database..


## Virtuoso Triple Store: storage of SWR knowledge graph

!!! component-header "Info"
    **Current version:** Virtuoso release 07.20.3239

    **Technology:** Virtuoso

    **Access point:** Triple Store (SWR SPARQL endpoint) <https://repository.soilwise-he.eu/sparql>

A Triple Store is implemented as part of the SWR infrastructure to allow a more flexible linkage between the knowledge captured as metadata and various sources of internal and external knowledge sources, particularly taxonomies, vocabularies and ontologies that are implemented as RDF graphs. Results of the harvesting and metadata augmentation that are stored in the RDBMS are converted to RDF and stored in the Triple Store. 

### Key Features

A Triple Store, implemented in Virtuoso, is integrated for parallel storage of metadata because it offers several capabilites:

1. **Semantic linkage** — It allows the linking of different knowledge models, e.g. to connect the SWR metadata model with existing and new knowledge structures on soil health and related domains.
2. **Cross-domain reasoning** — It allows reasoning over the relations in the stored graph, and thus allows connecting and smartly combining knowledge from those domains.
3. **Semantic querying** — The SPARQL interface offered on top of the Triple Store allows users and processes to use such reasoning and exploit previously unconnected sets of knowledge.


## Git: storage of code and configuration

!!! component-header "Info"
    **Technology:** Gitlab and GitHub

    **Access point:** https://github.com/soilwise-he

Git is a multi purpose environment for storing and managing software and documentation, versioning and configuration that also offers various functions the support the management and monitoring of the software development process. 

### Key Features

Git is an acknowledged platform to store, version, configure and docuemnt software, with additional features for software and software development management. The key features used in SoilWise are:

1. **Code storage, version and configuration management** — Git is used to deposit and manage versions of Soilwise code, documentation and configurations.
2. **Issue and release management** — SoilWIse uses the issue and release management to document, monitor and track the development of software conponents and their integration.
3. **Process automation** — Git defines and runs automated pipelines for deployment, augmentation, validation and harvesting external sources.

## Integrations & Interfaces

## Key Architectural Decisions

## Risks & Limitations


<!-- HERE'S FOR REFERENCE, THE PREVIOUS CONTENT

## Ongoing Developments

In the next iteration of the SWR development, the currently deployed storage options will be extended to support new features and functions. Such extensions can improve performance and usability. Moreover, we expect that the integration of AI/ML based functions will require additional types of storage and better integration to exploit their combined power. Exploratory work that was performed in the first development cycle, but is not yet integrated into the deployment of iteration 2 include:

### Apache SOLR and Apache Lucene for Lexical Search

A search engine, ingesting data from the RDBMS, will increase the perfomance of end user queries. It will also offer better usability, e.g. by offering aggregation functions for faceted search and ranking of search results. They are also implementing the indexation of unstructured content, and are therefore a good starting point (or alternative?) to offer smart searches on unstructured text, using more conventional and broadly adopted software. It will support SoilWise extending the indexation from (meta)data to knowledge, e.g. unstructured content for documents, websites etc. 

As part of the first develoment cycle of SWR, SoilWise has deployed an experimental setup that uses the Solr search platform. Apache Lucene is the search library under Solr facilitating the storage of SWR indexed content. 

### Apache Lucene for Semantic Search

Besides for lexical search it is also possible to use Apache Lucene for semantic search. The first tries to match on the literals of words or their variants, the later focusses on the intent or meaning of the data. To that end the data (usually text) is translated by a model into a multi-dimensional vector representation (called an embedding), which is then used with a proximity search algorithm. Tyically deep learning models are used to create the embeddings and they are trained so that the embeddings of semantically similar pieces of data are close to another. Semantic search capabilities can be used for many applications, amongst other LLM-driven systems like chatbots or RAG systems to provide them with content (pieces of text data) relevant to a question.

Although dedicated vector stores are available, SoilWise foresees the use of the Solr extension for storage of text embeddings. There are several advantages in using Solr to implement the SWR vector database. First of all it is an open source product. Second, as it is an extension to the Solr search engine platform, it allows adding vector embeddings, without introducing dependencies on additional components. Third, although part of the Solr platform, it allows maintaining a modular setup, where for a final deployment at EC-JRC it keeps the option open to include or exclude the foreseen SWR NLQ components. 

## Technology & Integration

Components used:

- Virtuoso (version 07.20.3239)
- PostgreSQL (release 12.22)
- Solr (release 9.8.0)





The SoilWise Repository is expected to fulfil the following functions:

1. [Storage of artefacts](#storage-of-artefacts)
2. [Storage of metadata](#storage-of-metadata)
3. [Storage of data](#storage-of-data)
4. [Storage of knowledge](#storage-of-knowledge)
5. [Backup and versioning](#backup-and-versioning)

## Technology

Various storage options exist, dedicated usage scenarios usually have an optimal storage option. Maintenance will also be considered as part of the choice.

- **Relational databases** provide performant filtering and aggregation options that facilitate the performance of data APIs. Relational databases have a fixed data model. 
- **Search engines**, such as SOLR/Elastic search. Search engines provide even higher performance and introduce faceted search (aggregations) and ranking customisation.
- **File (& bucket) repositories**, which are slow and non-queryable but very flexible in the data model, scalable and persistent.
- **Graph and triple stores**, which are very fitted to store relations between random entities and can reason over data in multiple domain models.
- **Versioning systems** (such as git), which are very slow and not queryable but ultimately persistent/traceable. Less optimal for binary files.


## Storage of artefacts

### Data model

‘To which data model shall I align?’ is the central question of data harmonisation efforts and data interoperability in general. SoilWise is aware of the fragmentation of soil data and the lack of harmonisation. As such, the SWR will, in the first project iteration cycle, focus on two major pan-European/global data modelling efforts within the soil domain. 

-  **GloSIS** (Global Soil Information System) is the name for the system and the soil data model, also named the GloSIS domain model. The GloSIS domain model published as a UML class diagram is not publicly available, being in the FAO repositories under the CC <by-nc-sa/3.0/igo> license. Nevertheless, the [GloSIS web ontology](https://www.semantic-web-journal.net/system/files/swj3589.pdf) is publicly available implementation with the Web Ontology Language (OWL). The GloSIS web ontology employs a host of Semantic Web standards (SOSA, SKOS, GeoSPARQL, QUDT); GloSIS lays out not only a soil data ontology but also an extensive set of ready-to-use code lists for soil description and physio-chemical analysis. Various examples are provided on the provision and use of GloSIS-compliant linked data, showcasing the contribution of this ontology to the discovery, exploration, integration and access of soil data.
- **INSPIRE** (INfrastructure for SPatial InfoRmation in Europe) aiming to create a spatial environmental data infrastructure for the European Union. A detailed [data specification for the soil theme](https://github.com/INSPIRE-MIF/technical-guidelines/tree/main/data/so) was published by the European Commission in 2013, supported by a detailed domain model documented as a [UML class diagram](https://inspire-mif.github.io/uml-models/approved/ea+xmi/EAXMI.zip).


Other (potentially) relevant data models are:

- [World Reference base (WRB)](https://wrb.isric.org/) maintains the code lists, which are the source of GLOSIS codelists, but the WRB online presence is currently limited.
- [Landuse](https://inspire.ec.europa.eu/theme/lu)
- [Land management practices](https://qcat.wocat.net/en/wocat/)
- [monitoring facilities](https://inspire.ec.europa.eu/theme/ef)
- [Landcover](https://inspire.ec.europa.eu/theme/lc)

#### Open issues

Many data models are used for data harmonisation and interoperability within the soil domain. The following data models may also be potentially relevant for the SWR:

- **SOTER**: the Global and National Soils and Terrain Digital Databases (SOTER) was chronologically the first global soil spatial data harmonisation/interoperability initiative of the International Society of Soil Science (ISSS), in cooperation with the United Nations Environment Programme, the International Soil Reference and Information Centre (ISRIC) and the FAO. Albeit lacking an abstract formalisation (SOTER pre-dates both UML and OWL), the ancient SOTER databases remained a reference for developing subsequent soil information models.
- **ISO 28258**, “Soil quality — Digital exchange of soil-related data” as one of the key achievements of the GS Soil project. This standard produced a general framework for exchanging soil data, recognising a need to combine soil with other kinds of data. ISO 28258 is documented with a UML domain model, applying the O&M framework to the soil domain. An XML exchange schema is derived from this domain model, adopting the Geography Markup Language (GML) to encode geospatial information. The standard was conceived as an empty container, lacking any kind of controlled content. It is meant to be further specialised for actual use (possibly at a regional or national scale).
- **ANZSoilML**, the Australian and New Zealand Soil Mark-up Language (ANZSoilML), results from a joint effort by CSIRO in Australia and New Zealand’s Manaaki Whenua to support the exchange of soil and landscape data. Its domain model was possibly the first application of O&M to the soil domain, targeting the soil properties and related landscape features specified by
the institutional soil survey handbooks used in Australia and New Zealand. ANZSoilML is formalised as a UML domain model from which an XML schema is obtained, relying on the ComplexFeature abstraction that underlies the SOAP/XML web services specified by the OGC. A set of controlled vocabularies was developed for ANZSoilML, providing values for categorical soil properties and laboratory analysis methods. More recently, these vocabularies were transformed into RDF resources to be managed with modern Semantic Web technologies.

Moreover, GloSIS and INSPIRE data models fully support only vector data. GloSIS has not developed a data model for gridded data yet, and several issues were reported to the INSPIRE data model for gridded data.

GloSIS and INSPIRE soil are oriented to Observations and Measurements of OGC, with the arrival of the samples objects in the new version of O&M, now named [Observations Measurements & Samples](https://www.ogc.org/standard/om/). Soilwise can probably contribute to the migration of the soil models to the new OMS version.

### Soil health vocabulary 

Understand if Soil health codelists as developed in the Envasso and Landmark projects, can be adopted by the online soil community, for example, as part of the Glosis ontology, INSPIRE registry or EUSO. Research is needed to evaluate if a legislative body is available to confirm the definitions of the terms.

## Storage of metadata

- Metadata is best stored on a git versioning system to trace its history and facilitate community contributions.
- Metadata is best stored in a graph database or triple store to validate interlinkage and facilitate harmonisation.
- Metadata is best queried from a database or search engine. Search engines, by default, offer ranking and faceting capabilities, which are hard to reproduce on databases, but search engines come at a high cost in terms of maintenance and memory use.
- All collected metadata will be archived once per year.
- Besides raw metadata, the results of the metadata validation process will be stored along with override values.

## Storage of knowledge

-	Storage (or non-storage) of knowledge is highly dependent on the type of knowledge, how it is to be used and the available resources for storage. 
-	As a minimum SWR stores metadata describing knowledge assets (unstructured content) – see section [storage of metadata](#storage-of-metadata).
-	Knowledge that expresses links between data and knowledge assets is best stored in a graph DB or an RDF DB, depending also on the application requirements.
-	Knowledge that expresses semantics is best stored as RDF in an RDF DB, to be able to reason over semantic relationships.
-	When knowledge needs to be reasoned over using LLMs, it is preferably processed and stored in a vector DB, potentially linked to relevant text fragments (for explainable AI). 
-	Querying knowledge is best done from an indexed DB or search engine (see section metadata) or from a vector DB (through chatbot / LLM applications).


### Knowledge graph - Triple Store

The knowledge graph is meant to add a formal semantics layer to the metadata collected at the SWR. It mirrors the XML-based metadata harnessed in the Catalogue Server but uses Semantic Web standards such as DCAT, Dublin Core, VCard or PROV. This metadata is augmented with links to domain web ontologies, in particular GloSIS. This semantically augmented metadata is the main pillar of knowledge extraction activities and components.

Besides metadata on knowledge assets, the knowledge graph is also expected to host the results of knowledge extraction activities. This assumes knowledge to be semantically loaded, i.e. linking to relevant domain ontologies. The identification of appropriate ontologies and ontology mappings thus becomes an essential aspect of this project, bridging together various activities and assets.

It is important to recognise the knowledge graph as an immaterial asset that cannot exist by itself. In order to be usable the knowledge graph must be stored in a triple store, thus highlighting the role of that component in the architecture. In its turn the triple store provides another important architectural component, the SPARQL end-point. That will be the main access gateway to the knowledge graph, particularly through other technological components and software.

The [Natural Language Querying](natural_language_querying.md) functionality foreseen in this project will, amongst others, use the formal knowledge graph, e.g. as part of a Chatbot component of the user interface. The knowledge graph will further feed the facilities for machine-based access to the SWR: a knowledge extraction API and a SPARQL end-point.

#### Technology
- DCAT, Dublin Core, VCard, PROV, GloSIS


## Storage of data

### Processed data

- Data that changes often (due to continuous ingested data feeds) are best stored in a database.
- Snapshots of data feeds or data processing results are best stored as files on a repository or bucket, and the file location (in combination with an identification proxy, like DOI) provides a unique identification of the dataset.
- API access to larger datasets best uses a scalable database or files in a cloud native (scalable) format. Data is exported to such formats before exposure via APIs (from git, triple stores, files, etc). in some cases, a search engine is the most relevant API backend.

### High-value data

- Full dataset download or Single band data (access by bbox, not by property) is best stored as files on a scalable file infrastructure using cloud native formats, where the file location provides the identification.
- Data that is frequently filtered or aggregated on attribute value is best stored on a relational database or search engine.

### Temporary store for uploaded data

Temporary data storage may be necessary as a caching mechanism to achieve acceptable performance (e.g. response time and throughput), e.g. for derived and harmonised data sets. For any data that is supposed to be stored temporarily, there shall be a flag that indicates its validity until it shall be cleaned up. The monitoring system shall check whether any such flags are present that should have been cleaned up already.

### Technology

- **PostgreSQL** is a common open-source database platform with spatial support. A database dump of a Postgres database, as a backup or to publish FAIR versions at intervals, is not very user-friendly. A conversion to **SQLite/GeoPackage** (using GDAL/Hale) facilitates this case.
- The most popular search engine is **Elastic Search** (also used by JRC in INSPIRE), but has some challenges in its license. Alternative is **SOLR**.
- File repositories range from Amazon/Google to a local NFS with Webdav access.
- Graph database **Neo4J**, **Triple store**, **Jena Fuseki** (Java) or **Virtuoso** (C) both have spatial support.
- **GIT** is the most used versioning system these days, with the option to go for SAAS (Github, Bitbucket) or on-premise (Gitlab). GitHub seems the most suitable option, as other groups such as OGC and INSPIRE are already there, which means users already have an account, and we can cross-link issues between projects.

## Backup and versioning

For any data, there shall be at least two levels of backups. Volume snapshots shall be the preferred mode of backups. These volume snapshots should be stored in a different location and should enable fast recovery (i.e. in less than 4 hours during business hours) even if the location where the SWR is operated is entirely unavailable. These volume snapshots should be configured in such a way that at no point in time, more than 1 hour of new data/changed data would be lost. Volume backups should be retained for 30 days.

A second level of backups can be more granular, e.g., storing all data and metadata assets, as well as configuration and system data as encrypted files in an object store such as AWS S3. This type of backup allows for a more specific or partial recovery for cases where data integrity was damaged, where there was a partial data loss or another incident which does not necessitate restoring the system. This could also include explicit backups (dumps) of the database systems that are part of the SWR. It is tolerable for these backups to be updated once per day.

If there is data that requires full versioning or historisation, it is recommended to store it in a version control system.

Finally, there should be a restore exercise at least once per year, where a fresh system is set up from both types of backups.

-->

