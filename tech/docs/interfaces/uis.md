# User Interfaces (UIs)

The usabilty of the SoilWise Catalogue will eventually not only be determined by it's back-end functionality and the (meta)data and knowledge it exposes. User, whether they are data & knowledge providers, users or SWC administrators, will operate the system through various user interfaces.  

Within the first and second development iteration, the following User Interfaces have been deployed as part the SoilWise Catalogue:

## Interfaces for end users

### SoilWise Finder (Metadata Catalogue)

**Access point:** <https://repository.soilwise-he.eu/>

This UI is currently the main access point for end users searching for resources harvested by SoilWise. It allows users to run term search queries, spatial queries and fulltext search. More information is available in [SoilWise Finder](../technical_components/catalogue.md).

### Soil Companion

**Access point:** <https://soil-companion.containers.wur.nl/app/index.html>

UI providing users the option to query Metadata Catalogue using natural language. After loging in, users can ask soil-related questions through Chatbot-like user interface. More information is available in [Soil Companion](../technical_components/soil_companion.md).

### Tabular Soil Data Annotation

**Access point:** <https://dataannotator-swr.streamlit.app/>

UI providing data publishers support in annotating their observation data, such as soil observations, measurements and samples. 
Researchers typically keep their observation data in tabular form (.csv, .xls, .mat, .shp), with an observed property in every column (pH, N, P, K, texture, bulk density). 
The metadata of the columns is typically expressed in a readme.txt (or dedicated excel tab) in an unstructured format. 
This tool supports data publishers to annotate their dataset using a standardised format, referencing terms from common vocabularies when available.
Publishers are invited to deposit the metadata file with their dataset, so it can be used when ingesting the data by consumers. 
The metadata file can also be distributed separately, for example if a data consumer aims to enrich an existing dataset with relevant metadata.
More information is available in [Tabular Metadata annotation](../technical_components/data_publication_support/#tabular-soil-data-annotation)

### SoilVoc

**Access points:** 

- Browser: <https://w3id.org/eusoilvoc >
- Vocabulary: <https://github.com/soilwise-he/soil-vocabs>

A User Interface providing a hierarchical overview of soil terms, soil properties and corresponding observation procedures with a link to related terms in other vocabularies. Users can use the search option to locate a term, or browse the hierarchy. 
The terms are maintained in a CSV format in [Github](https://github.com/soilwise-he/soil-vocabs/blob/main/SoilVoc_concepts.csv). From the CSV a html edition for human consumption and a semantic web edition (for machines) are generated.
The soil vocabulary is used as source for the catalogue filters in the catalogue sidebar and the keyword matcher.
More information is available in [Knowledge graph](../technical_components/knowledge_graph#soilvoc).

### Soil Health Knowledge graph

**Access points:** 

- Namespace: <https://soilwise-he.github.io/soil-health>
- Browser: <https://voc.soilwise-he.containers.wur.nl/>
- Agroportal: <https://agroportal.eu/ontologies/SHKG/>
- Knowledge graph (.ttl): <https://github.com/soilwise-he/soil-health-knowledge-graph>

The soil health knowledge graph aims to describe relevant terms around Soil Health and relations between the terms. The knowledge graph is maintained in [github](https://github.com/soilwise-he/soil-health-knowledge-graph).
Selected terms of the Soil Health Knowledge graph are used in the Soil Vocabulary. The Soil Health Knowledge graph can be used by devices aiming to increase the knowledge status around soil health (chatbots, aggregators, catalogues).

## Interfaces for administration and system management

### Data & Knowledge Administration Console

**Access point:** <https://superset.soilwise.wetransform.eu/superset/dashboard/p/P52OgRVBGo9/>

This UI, based on the superset BI tools, provides a multi-dimensional visual overview of the contents of the SWC together with a dedicated page focusing on Mission Soil outputs. Additionally, results from metadata validations are displayed. More information is available in [Data & Knowledge Administration Console](../technical_components/admin_console.md).

### System Monitoring

**Access point:** TBD


