# Application Programming Interfaces (APIs)

This page presents an overview of all APIs that are served by the SoilWise Catalogue for (1) internal processing, (2) reuse of SoilWise data and functionality and (3) to enable future integration with other systems, particularly with EUSO. Information on interfaces is also available in a dedicated subchapter per each Technical Component.

## Discovery APIs

These APIs allow discovery of (meta)data and knowledge. Most of them are mostly meant to be used as part of SWC backend mechanisms to access or harvest remote data and knowledge resources or to process these resources internally. However, some of them are also relevant for end user discovery of content from SWC. Those user facing discovery APIs are used in user interface components developed by SoilWise, but could also be employed for integration with the EU Soil Observatory and other existing systems that want to make use of SWR.

| Service | Documentation | Purpose |
|---------|----------|---------|
|**Catalogue Service for the Web (CSW)**|<https://repository.soilwise-he.eu/cat/csw>|Catalogue service for the web (CSW) is a standardised pattern to interact with (spatial) catalogues, maintained by OGC.|
|**OGC API - Records**|<https://repository.soilwise-he.eu/cat/openapi>|OGC is currently in the process of adopting a revised edition of its catalogue standards. The new standard is called OGC API - Records. OGC API - Records is closely related to Spatio Temporal Asset Catalogue (STAC), a community standard in the Earth Observation community.|
|**Protocol for metadata harvesting (OAI-PMH)**|<https://repository.soilwise-he.eu/cat/oaipmh>|The open archives initiative has defined a common protocol for metadata harvesting (oai-pmh), which is adopted by many catalogue solutions, such as Zenodo, OpenAire, CKAN. The oai-pmh endpoint of Soilwise can be harvested by these repositories.|
|**Spatio Temporal Asset Catalog (STAC)**| <https://repository.soilwise-he.eu/cat/stac/openapi>|TBD|
|**OpenSearch**|<https://repository.soilwise-he.eu/cat/opensearch> |TBD|
|**SPARQL**|<https://repository.soilwise-he.eu/sparql/>|The API allows query access to the SoilWise knowledge graph, thus offering querying on linked data, traversing relationships between entities that are relevant and cannot be represented in conventional relational databases.|
|**Solr Search API**|TBD|The Solr search API Allows query access to the Solr index, so the UI (and other clients) can search the metadata through the index.|

## Processing API's

SWC processing APIs are mostly interfaces to components that have been developed or adapted to support the processing of metadata (e.g. metadata augmentation, transforming to RDF) or to support quality assurance and visualisation.  

| Service | Documentation | Purpose |
|---------|----------|---------|
|**Translate API**|<https://api.soilwise-he.containers.wur.nl/tolk/docs>|This API translates content between languages, and is used for metadata translation. It makes use of the EU translation service <https://language-tools.ec.europa.eu/>|
|**Link Liveness Assessment API**|<https://api.soilwise-he.containers.wur.nl/linky/docs>|The linkchecker component is designed to evaluate the status, validity and accuracy of links within metadata records in the a OGC API - Records based System. It's responses provide input that is used to inform end users about the status of published links and to collect required data for quality control.|
|**RDF to triplestore API**|<https://repo.soilwise-he.containers.wur.nl/swagger-ui/index.html>|Allows the conversion of RDF, e.g. as provided by the CORDIS API's to the SWR triple store.|
|**DOI resolution API**|TBD|TBD|
|**Soil Mission news feed API**|TBD|TBD|