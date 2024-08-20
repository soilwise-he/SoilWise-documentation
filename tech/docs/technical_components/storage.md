# Repository Storage


<!--
- asset and feature identification
- backup
- versioning
- store
- query

- structured folders
- user permissions (who can commit, who reviews code)

- connections with: catalog, ETL, SPARQL, QA, Identifier Mint
- technologies used: KV stores, Relational databases, Graph/Document databases, Vector databases (Knowledge component)

-->

The SoilWise Repository is expected to fulfil the following functions:

1. [Storage of artefacts](#storage-of-artefacts)
2. [Storage of metadata](#storage-of-metadata)
3. [Storage of data](#storage-of-data)
4. [Storage of knowledge](#storage-of-knowledge)
5. [Storage of configuration](#storage-of-configuration)
6. [Backup and versioning](#backup-and-versioning)


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

-  **GloSIS** (Global Soil Information System) is the name for the system and the soil data model, also named the GloSIS domain model. The GloSIS domain model published as a UML class diagram is not publicly available, being in the FAO repositories under the CC <by-nc-sa/3.0/igo> license. Nevertheless, the [GloSIS web ontology](https://www.semantic-web-journal.net/system/files/swj3589.pdf){target=_blank} is publicly available implementation with the Web Ontology Language (OWL). The GloSIS web ontology employs a host of Semantic Web standards (SOSA, SKOS, GeoSPARQL, QUDT); GloSIS lays out not only a soil data ontology but also an extensive set of ready-to-use code lists for soil description and physio-chemical analysis. Various examples are provided on the provision and use of GloSIS-compliant linked data, showcasing the contribution of this ontology to the discovery, exploration, integration and access of soil data.
- **INSPIRE** (INfrastructure for SPatial InfoRmation in Europe) aiming to create a spatial environmental data infrastructure for the European Union. A detailed [data specification for the soil theme](https://github.com/INSPIRE-MIF/technical-guidelines/tree/main/data/so){target=_blank} was published by the European Commission in 2013, supported by a detailed domain model documented as a [UML class diagram](https://inspire-mif.github.io/uml-models/approved/ea+xmi/EAXMI.zip){target=_blank}.


Other (potentially) relevant data models are:

- [World Reference base (WRB)](https://wrb.isric.org/){target=_blank} maintains the code lists, which are the source of GLOSIS codelists, but the WRB online presence is currently limited.
- [Landuse](https://inspire.ec.europa.eu/theme/lu){target=_blank}
- [Land management practices](https://qcat.wocat.net/en/wocat/){target=_blank}
- [monitoring facilities](https://inspire.ec.europa.eu/theme/ef){target=_blank}
- [Landcover](https://inspire.ec.europa.eu/theme/lc){target=_blank}

#### Open issues

Many data models are used for data harmonisation and interoperability within the soil domain. The following data models may also be potentially relevant for the SWR:

- **SOTER**: the Global and National Soils and Terrain Digital Databases (SOTER) was chronologically the first global soil spatial data harmonisation/interoperability initiative of the International Society of Soil Science (ISSS), in cooperation with the United Nations Environment Programme, the International Soil Reference and Information Centre (ISRIC) and the FAO. Albeit lacking an abstract formalisation (SOTER pre-dates both UML and OWL), the ancient SOTER databases remained a reference for developing subsequent soil information models.
- **ISO 28258**, “Soil quality — Digital exchange of soil-related data” as one of the key achievements of the GS Soil project. This standard produced a general framework for exchanging soil data, recognising a need to combine soil with other kinds of data. ISO 28258 is documented with a UML domain model, applying the O&M framework to the soil domain. An XML exchange schema is derived from this domain model, adopting the Geography Markup Language (GML) to encode geospatial information. The standard was conceived as an empty container, lacking any kind of controlled content. It is meant to be further specialised for actual use (possibly at a regional or national scale).
- **ANZSoilML**, the Australian and New Zealand Soil Mark-up Language (ANZSoilML), results from a joint effort by CSIRO in Australia and New Zealand’s Manaaki Whenua to support the exchange of soil and landscape data. Its domain model was possibly the first application of O&M to the soil domain, targeting the soil properties and related landscape features specified by
the institutional soil survey handbooks used in Australia and New Zealand. ANZSoilML is formalised as a UML domain model from which an XML schema is obtained, relying on the ComplexFeature abstraction that underlies the SOAP/XML web services specified by the OGC. A set of controlled vocabularies was developed for ANZSoilML, providing values for categorical soil properties and laboratory analysis methods. More recently, these vocabularies were transformed into RDF resources to be managed with modern Semantic Web technologies.

Moreover, GloSIS and INSPIRE data models fully support only vector data. GloSIS has not developed a data model for gridded data yet, and several issues were reported to the INSPIRE data model for gridded data.

GloSIS and INSPIRE soil are oriented to Observations and Measurements of OGC, with the arrival of the samples objects in the new version of O&M, now named [Observations Measurements & Samples](https://www.ogc.org/standard/om/){target=_blank}. Soilwise can probably contribute to the migration of the soil models to the new OMS version.

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

The [Large Language Model](llm.md) foreseen in this project will be trained on the knowledge graph, thus forming the basis for the Chatbot component of the user interface. The knowledge graph will further feed the facilities for machine-based access to the SWR: a knowledge extraction API and a SPARQL end-point.

#### Technology
- DCAT, Dublin Core, VCard, PROV, GloSIS, see chapter [Semantic Web specifications for metadata](ingestion.md#semantic-web-specifications-for-metadata) and [Data model](#data-model)


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

## Storage of configuration

Many configurations are maintained as part of the Soilwise infrastructure. The storage of types of configuration may differ, but is always documented, for reproducabillity.

1. Which version of a component is used in which environment (CMDB)
2. Connection details to API's, databases (Secrets)
3. Scheduling of scheduled tasks, such as harvesters, backups, synchronisation, validation
4. Authorisation, which users are authorised for which roles.

## Backup and versioning

For any data, there shall be at least two levels of backups. Volume snapshots shall be the preferred mode of backups. These volume snapshots should be stored in a different location and should enable fast recovery (i.e. in less than 4 hours during business hours) even if the location where the SWR is operated is entirely unavailable. These volume snapshots should be configured in such a way that at no point in time, more than 1 hour of new data/changed data would be lost. Volume backups should be retained for 30 days.

A second level of backups can be more granular, e.g., storing all data and metadata assets, as well as configuration and system data as encrypted files in an object store such as AWS S3. This type of backup allows for a more specific or partial recovery for cases where data integrity was damaged, where there was a partial data loss or another incident which does not necessitate restoring the system. This could also include explicit backups (dumps) of the database systems that are part of the SWR. It is tolerable for these backups to be updated once per day.

If there is data that requires full versioning or historisation, it is recommended to store it in a version control system.

Finally, there should be a restore exercise at least once per year, where a fresh system is set up from both types of backups.
