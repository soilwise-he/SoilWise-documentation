# Introduction


APIs in SoilWise can be classified in the following categories:

- [Discovery APIs](./metadata-apis.md)
- [Download & preview APIs](./data-download.md)
- [APIs for knowledge extraction](./knowledge-extraction.md)
- [Processing APIs](./processing-apis.md)


Currently the following APIs are employed in the SoilWise repository:

- Discovery APIs
    - [SPARQL](https://www.w3.org/TR/sparql11-query/){target=_blank}
    - [OGC API - Records](#)
    - [Spatio Temporal Asset Catalog (STAC)](#)
    - [Catalog service for the Web (CSW)](#)
    - [Protocol for Metadata Harvesting (OAI-PMH)](#)
    - [OpenSearch](#)
- Processing API's
    - [Translate API](#)
    - [Link Liveness Assessment API](#)
    - [RDF to triplestore API](#)

## Future work

SoilWise will in the future use more APIs to interact between components as well as enable remote users to interact with SoilWise components. Standardised APIs will be used if possible, such as:

- [Open API](https://www.openapis.org/){target=_blank}
- [GraphQL](https://graphql.com){target=_blank}
- OGC webservices (preferably [OGC API generation](https://ogcapi.ogc.org/){target=_blank} based on Open API)
