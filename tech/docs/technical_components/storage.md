# Repository Cloud Storage (WE)

- asset and feature identification
- backup
- versioning
- store
- query

- structured folders
- user permissions (who can commit, who reviews code)

- connections with: catalog, ETL, SPARQL, QA, Identifier Mint
- technologies used: KV stores, Relational databases, Graph/Document databases, Vector databases (Knowledge component)
- responsible person:
- participating:

## Data model

‘To which data model shall I align?’ is the central question of data harmonisation efforts and data interoperability in general. SoilWise is aware of the fragmentation of soil data and the lack of harmonisation. As such, the SWR will, in the first development phase, focus on two major pan-European/global data modelling efforts within the soil domain:

-  **GloSIS** (Global Soil Information System) is the name for the system and the soil data model, also named the GloSIS domain model. The GloSIS domain model published as a UML class diagram is not publicly available, being in the FAO repositories under the CC <by-nc-sa/3.0/igo> license. Nevertheless, the [GloSIS web ontology](https://www.semantic-web-journal.net/system/files/swj3589.pdf){target=_blank} is publicly available implementation with the Web Ontology Language (OWL). The GloSIS web ontology employs a host of Semantic Web standards (SOSA, SKOS, GeoSPARQL, QUDT); GloSIS lays out not only a soil data ontology but also an extensive set of ready-to-use code lists for soil description and physio-chemical analysis. Various examples are provided on the provision and use of GloSIS-compliant linked data, showcasing the contribution of this ontology to the discovery, exploration, integration and access of soil data.
- **INSPIRE** (INfrastructure for SPatial InfoRmation in Europe) aiming to create a spatial environmental data infrastructure for the European union. A detailed [data specification for the soil theme](https://github.com/INSPIRE-MIF/technical-guidelines/tree/main/data/so){target=_blank} was published by the European Commission in 2013, supported by a detailed domain model documented as a [UML class diagram](https://inspire-mif.github.io/uml-models/approved/ea+xmi/EAXMI.zip){target=_blank}.

### Foreseen functionality

- centrepoint/target model for data interoperability
- user defines a target model (based on needs) as part of a transformation pattern (a part of the [Interoperability ETL](data_processing.md#interoperability-etl) component)

### Technology

- any software capable of UML/Archi/OWL notations. For instance: [Enterprise Architect](https://sparxsystems.com/products/ea/){target=_blank}, [Archi](https://www.archimatetool.com/){target=_blank}, [ShapeChange](https://www.interactive-instruments.de/en/shapechange/){target=_blank}, [protégé](https://protege.stanford.edu/){target=_blank}.

### Integration options

The Data model component is the centrepoint/target model towards data interoperability. However, this component has a low impact when being used alone. As such, tight integration to the [Interoperability ETL](data_processing.md#interoperability-etl) component, [Data & Knowledge publication](publication.md#data--knowledge-publication) and [Manual data & metadata upload](dashboard.md#) components is necessary for the SWR.

### Open issues

Many data models are used for data harmonisation and interoperability within the soil domain. The following data models may also be potentially relevant for the SWR:

- **SOTER**: the Global and National Soils and Terrain Digital Databases (SOTER) was chronologically the first global soil spatial data harmonisation/interoperability initiative of the International Society of Soil Science (ISSS), in cooperation with the United Nations Environment Programme, the International Soil Reference and Information Centre (ISRIC) and the FAO. Albeit lacking an abstract formalisation (SOTER pre-dates both UML and OWL), the ancient SOTER databases remained a reference for developing subsequent soil information models.
- **ISO 28258**, “Soil quality — Digital exchange of soil-related data” as one of the key achievements of the GS Soil project. This standard produced a general framework for exchanging soil data, recognising a need to combine soil with other kinds of data. ISO 28258 is documented with a UML domain model, applying the O&M framework to the soil domain. An XML exchange schema is derived from this domain model, adopting the Geography Markup Language (GML) to encode geospatial information. The standard was conceived as an empty container, lacking any kind of controlled content. It is meant to be further specialised for actual use (possibly at a regional or national scale).
- **ANZSoilML**, the Australian and New Zealand Soil Mark-up Language (ANZSoilML), results from a joint effort by CSIRO in Australia and New Zealand’s Manaaki Whenua to support the exchange of soil and landscape data. Its domain model was possibly the first application of O&M to soil domain, targeting the soil properties and related landscape features specified by
the institutional soil survey handbooks used in Australia and New Zealand. ANZSoilML is formalised as a UML domain model from which an XML schema is obtained, relying on the ComplexFeature abstraction that underlies the SOAP/XML web services specified by the OGC. A set of controlled vocabularies was developed for ANZSoilML, providing values for categorical soil properties and laboratory analysis methods. More recently, these vocabularies were transformed into RDF resources to be managed with modern Semantic Web technologies.

Moreover, GloSIS and INSPIRE data models fully support only vector data. GloSIS has not developed a data model for gridded data yet, and several issues were reported to the INSPIRE data model for gridded data.


- SoilWise can provide a set of prepared target models to select from (INSPIRE xsd, INSPIRE gpkg, WRB owl, GLOSIS owl, eSOTER mdb, LUCAS csv, ...)
- capable of being mapped (ideally to all) external data models

## Soil health vocabulary (Paul + Anna + Giovanni)

## Metadata scheme (Luis)

- developing metadata templates using standards

- connections with: data input and structure
- technologies used: DCAT; VCard; Dublin Core; PROV; plus GloSIS for Soil Semantics
- responsible person: Luís de Sousa
- participating: Tomas Reznik

## Storage

Various storage options exist, dedicated usage scenario's usually have an optimal storage option. Maintenance should be also considered as part of the choice.

- **Relational databases** provide performant filtering and aggregation options which facilitate performance of data API's. Relational databases have a fixed datamodel. 
- **Search engines**, such as SOLR/Elastic search. Search engines provide even higher performance and introduce faceted search (aggregations) and ranking customisation
- **File (& bucket) repositories**, which are slow and non queryable, but very flexible in data model, scalable and persistent
- **Graph and triple stores**, which are very fitted to store relations between random entities and can reason over data in multiple domain models
- **Versioning systems** (such as git) which are very slow and not queryable, but ultimately persistent/traceable. Less optimal for binary files.

### Metadata

- Metadata is best stored on a git versioning system to trace its history and facilitate community contributions.
- Metadata is best stored in a graph database or triple store to validate interlinkage and facilitate harmonisation.
- Metadata is best queried from a database or search engine, search engines by default offer ranking and faceting capabilities, which are hard to reproduce on databases, but search engines come at a high cost on maintenance and use of memory.
- All collected metadata will be archived once per year.
- Besides raw metadata, results of metadata validation process will be stored along with override values.


### Knowledge

-	Storage (or non-storage) of knowledge is highly dependent on the type of knowledge, how it is to be used and on the available resources for storage. 
-	As a minimum SWR stores metadata describing knowledge assets (unstructured content) – see section metadata
-	Knowledge that expresses links between data and knowledge assets is best stored in a graph DB or an RDF DB, depending also on the application requirements
-	Knowledge that expresses semantics is best stored as RDF in an RDF DB, to be able to reason over semantic relationships
-	When knowledge needs to be reasoned over using LLMs, it is preferably processed and stored in a vector DB, potentially linked to relevant text fragments (for explainable AI). 
-	Querying knowledge is best done from an indexed DB or search engine (see section metadata) or from a vector DB (through chatbot / LLM applications) 

### Processed data

- Data which changes often (due to continuous ingested data feeds) are best stored in a database.
- Snapshots of data feeds or data processing results are best stored as files on a repository or bucket, the file location (in combination with a identification proxy, like DOI) provides a unique identification to the dataset.
- API access to larger datasets best use a scalable database or files in a cloud native (scalable) format. Data is exported to such formats before exposure via API's (from git, triple stores, files, etc). in some cases a search engine is the most relevant api backend.

### High-value data

- Full dataset download or Single band data (access by bbox, not by property) is best stored as files on a scalable file infrastructure using cloud native formats, where the file location provides the identification.
- Data which is frequently filtered or aggregated on attribute value is best stored on a relational database or search engine.

### Temporary store for uploaded data

### Technology

- **PostGreSQL** is a common open source database platform with spatial support. A database dump of a postgres database, as backup or to publish FAIR versions at intervals, is not very user friendly. A conversion to **SQLite/GeoPackage** (using GDAL/Hale) facilitates this case.
- Most popular search engine is **Elastic Search** (also used in JRC INSPIRE), but has some challenges in its license. Alternative is **SOLR**.
- File repositories range from Amazon/Google to a local NFS with Webdav access.
- Graph database **Neo4J**, **Triple store**, **Jena Fuseki** (Java) or **Virtuoso** (C) both have spatial support.
- **GIT** is most used versioning system these days, option to go for SAAS (Github, Bitbucket) or on premise (Gitlab). Github seems the most suitable option,as other groups such as OGC, INSPIRE are already there, which means users already have an account and we can cross link issues between projects.
