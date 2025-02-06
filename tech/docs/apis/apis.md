# Application Programming Interfaces (APIs)

Within the first development iteration, the following APIs are employed in the SoilWise repository:

- Discovery APIs
    - **SPARQL:** <https://sparql.soilwise-he.containers.wur.nl/sparql/>
The API allows query access to the SoilWise knowledge graph, thus offering querying on linked data, traversing relationships between entities that are relevant and cannot be represented in conventional relational databases
    - **OGC API- Records:** <https://soilwise-he.containers.wur.nl/cat/openapi>
    - **Spatio Temporal Asset Catalog (STAC):** <https://soilwise-he.containers.wur.nl/cat/stac/openapi>
    - **Catalog service for the Web (CSW):** <https://soilwise-he.containers.wur.nl/cat/openapi>
    - **Protocol for Metadata Harvesting (OAI-PMH):** <https://soilwise-he.containers.wur.nl/cat/oaipmh>
    - **OpenSearch:** <https://soilwise-he.containers.wur.nl/cat/opensearch>
- Processing API's
    - **Translate API:** <https://api.soilwise-he.containers.wur.nl/tolk/docs>
    - **Link Liveness Assessment API:** <https://api.soilwise-he.containers.wur.nl/linky/docs>
    - **RDF to triplestore API:** <https://repo.soilwise-he.containers.wur.nl/swagger-ui/index.html>


## Future work



SoilWise will in the future use more APIs to interact between components as well as enable remote users to interact with SoilWise components. Standardised APIs will be used if possible, such as:

- [Open API](https://www.openapis.org/){target=_blank}
- [GraphQL](https://graphql.com){target=_blank}
- OGC webservices (preferably [OGC API generation](https://ogcapi.ogc.org/){target=_blank} based on Open API)
- [SPARQL](https://www.w3.org/TR/sparql12-query/){target=_blank} for potential future knowledge graphs

