# API for knowledge extraction

Project: [API's](https://github.com/orgs/soilwise-he/projects/9)

An API providing machine-based access to the SWR knowledge graph. This API is most likely to conform to an existing meta-data standard, such as the OGC API Records, OpenAPI or GraphQL. However, its responses are RDF documents, for instance encoded with JSON-LD syntax. Other components of the SWR performing knowledge extraction and/or augmentation may also use this API to interact with the knowledge graph.

A point of discussion is if the SPARQL engine offers enough performance to facilitate basic discovery actions (by the catalogue frontend), an alternative was suggested to introduce an Elastic Search or PostGreSQL component, which caches the content retrieved with a SPARQL query. These aspects will be validated in the upcoming iteration.

## Technology

Various technology options exist, we will validate these in the upcoming iteration

- [pycsw](https://pycsw.org) and [pygeoapi](https://pygeoapi.org) could be extended to support SPARQL as a backend, which would enable OGC API Records on the SPARQL backend
- The [GRLC](https://grlc.io/) tool enables an Open Rest API on any SPARQL endpoint
- [Various tools](https://github.com/dbcls/grasp) exist offering Graphql interface to wrap a SPARQL endpoint, to facilitate the growing [GraphQL community](https://graphql.com/)


- API to search and harvest graph
- graph maintenance
- Search / harvest graph

- connections with: knowledge graph, automated / harvesting, tagging, manual editor, AI/ML processes
- technologies used: grlc, OGC Open API Records, ...
- responsible person:
- participating: Luís de Sousa