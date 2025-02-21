# Application Programming Interfaces (APIs)

## Discovery APIs

These APIs allow discovery of (meta)data and knowledge. Most of them are mostly meant to be used as part of SWR back-end mechanisms to access or harvest remote data and knowledge resources or to process these resources internally. However, some of them are also relevant for end user discovery of content from SWR. Those user facing discovery APIs are used in user interface components developed by SoilWise, but could also be employed for integration with the EU Soil Observatory and other existing systems that want to make use of SWR.

**SPARQL:** <https://sparql.soilwise-he.containers.wur.nl/sparql/>

The API allows query access to the SoilWise knowledge graph, thus offering querying on linked data, traversing relationships between entities that are relevant and cannot be represented in conventional relational databases.

**OGC API- Records:** <https://repository.soilwise-he.eu/cat/openapi>

**Spatio Temporal Asset Catalog (STAC):** <https://repository.soilwise-he.eu/cat/stac/openapi>

**Catalog service for the Web (CSW):** <https://repository.soilwise-he.eu/cat/openapi>

**Protocol for Metadata Harvesting (OAI-PMH):** <https://repository.soilwise-he.eu/cat/oaipmh>

**OpenSearch:** <https://repository.soilwise-he.eu/cat/opensearch>


## Processing API's

SWR processing APIs are mostly interfaces to components that have been developed or adapted to support the processing of metadata (e.g. metadata augmentation, transforming to RDF) or to support quality assurance and visualisation.  

**Translate API:** <https://api.soilwise-he.containers.wur.nl/tolk/docs>

This API translates content between languages, and is used for metadata translation. It makes use of the EU translation service <https://language-tools.ec.europa.eu/>

**Link Liveness Assessment API:** <https://api.soilwise-he.containers.wur.nl/linky/docs>

The linkchecker component is designed to evaluate the status, validity and accuracy of links within metadata records in the a OGC API - Records based System. It's responses provide input that is used to inform end users about the status of published links and to collect required data for quality control.

**RDF to triplestore API:** <https://repo.soilwise-he.containers.wur.nl/swagger-ui/index.html>

Allows the conversion of RDF, e.g. as provided by the CORDIS API's to the SWR triple store.

## Future work

SoilWise will in the future use more APIs to interact between components as well as enable remote users to interact with SoilWise components. Additional interfaces that are to be included in SWR components under development are:

**Solr CLient APIs:** <https://solr.apache.org/guide/8_5/client-apis.html>

These APIs offers several standards to provide connections to the Solr search engine that is currently being integrated, allowing among others more advanced querying, faceted search and results ranking.  

Other standardised APIs will be used if possible, such as:

- [Open API](https://www.openapis.org/){target=_blank}
- [GraphQL](https://graphql.com){target=_blank}
- additional OGC webservices (preferably [OGC API generation](https://ogcapi.ogc.org/){target=_blank} based on Open API)

