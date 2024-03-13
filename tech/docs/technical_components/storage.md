# Repository Cloud Storage

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

- centrepoint/target model for data interoperability
  - user defines a target model (based on needs) as part of a transformation pattern (Hale Studio, rml.io)
  - SoilWise can provide a set of prepared target models to select from (INSPIRE xsd, INSPIRE gpkg, WRB owl, GLOSIS owl, eSOTER mdb, LUCAS csv, ...)

- capable of being mapped (ideally to all) external data models

- connections with: (meta)data input, validation, processing
- technologies used: UML, Archimate, OWL, Relational model
- responsible person: Tomas Reznik
- participating:

## Soil health vocabulary

## Metadata scheme

- developing metadata templates using standards

- connections with: data input and structure
- technologies used: DCAT; VCard; Dublin Core; PROV; plus GloSIS for Soil Semantics
- responsible person: Luís de Sousa
- participating: Tomas Reznik

## Database

Various storage options exist, dedicated usage scenario's usually have an optimal storage option. Also consider maintenance as part of the choice.

- Relational databases provide performant filtering and aggregation options which facilitate performance of data api's. Relational databases have a fixed datamodel. 
- Search engines, such as SOLR/Elastic search. Search engines provide even higher performance and introduce faceted search (aggregations) and ranking customisation
- File (& bucket) repositories, which are slow and non queryable, but very flexible in data model, scalable and persistent
- Graph and triple stores, which are very fitted to store relations between random entities and can reason over data in multiple domain models
- Versioning systems (such as git) which are very slow and not queryable, but ultimately persistent/traceable. Less optimal for binary files.

### Metadata

- Metadata is best stored on a git versioning system to trace its history and facilitate community contributions
- Metadata is best stored in a graph database or triple store to validate interlinkage and facilitate harmonisation
- Metadata is best queried from a database or search engine, search engines by default offer ranking and faceting capabilities, which are hard to reproduce on databases, but search engines come at a high cost on maintenance and use of memory
- All collected metadata will be archived once per year


### Knowledge


### Processed data

- Data which changes often (due to continuous ingested data feeds) are best stored in a database
- Snapshots of data feeds or data processing results are best stored as files on a repository or bucket, the file location (in combination with a identification proxy, like DOI) provides a unique identification to the dataset.
- API access to larger datasets best use a scalable database or files in a cloud native (scalable) format. Data is exported to such formats before exposure via api's (from git, triple stores, files, etc). in some cases a search engine is the most relevant api backend

### High-value data

- Full dataset download or Single band (access by bbox, not by property) data is best stored as files on a scalable file infrastructure using cloud native formats, where the file location provides the identification.
- Data which is frequently filtered or aggregated on attribute value is best stored on a relational database or search engine.

### Technology

- PostGreSQL is a common open source database platform with spatial support. A database dump of a postgres database, as backup or to publish FAIR versions at intervals, is not very user friendly. A conversion to SQLite/GeoPackage (using GDAL/Hale) facilitates this case.
- Most popular search engine is Elastic Search (also used in JRC INSPIRE), but has some challenges in its license. Alternative is SOLR.
- File repositories range from amazon/google to a local NFS with Webdav access.
- Graph database Neo4J, Triple store; Jena Fuseki (java) or Virtuoso (C) both have spatial support. At ISRIC we have good experience with Virtuoso
- GIT is most used versioning system these days, option to go for SAAS (Github, Bitbucket) or on premise (Gitlab). I like github, because other groups are there such as OGC, INSPIRE, it means users already have an account and we can cross link issues between projects.
 

## Temporary store for uploaded data
