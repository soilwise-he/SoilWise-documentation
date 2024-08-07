# API for knowledge extraction

An API providing machine-based access to the SWR knowledge graph. This API is most likely to conform to an existing meta-data standard, such as the OGC API Records, OpenAPI or GraphQL. However, its responses are RDF documents, for instance encoded with JSON-LD syntax. Other components of the SWR performing knowledge extraction and/or augmentation may also use this API to interact with the knowledge graph.

A point of discussion is if the SPARQL engine offers enough performance to facilitate basic discovery actions (by the catalogue frontend), an alternative was suggested to introduce an Elastic Search or PostgreSQL component, which caches the content retrieved with a SPARQL query. These aspects will be validated in the upcoming iteration.

## Technology

Various technology options exist, we will validate these in the upcoming iteration

- [pycsw](https://pycsw.org){target=_blank} and [pygeoapi](https://pygeoapi.org){target=_blank} could be extended to support SPARQL as a backend, which would enable OGC API Records on the SPARQL backend
- The [GRLC](https://grlc.io/){target=_blank} tool enables an Open Rest API on any SPARQL endpoint
- [Various tools](https://github.com/dbcls/grasp){target=_blank} exist offering Graphql interface to wrap a SPARQL endpoint, to facilitate the growing [GraphQL community](https://graphql.com/){target=_blank}
