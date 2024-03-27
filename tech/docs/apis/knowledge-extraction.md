# SPARQL to Rest API

An API providing machine-based access to the SWR knowledge graph. This API is most likely to conform to an existing meta-data standard, such as the OGC API Records, OpenAPI or GraphQL. However, its responses are RDF documents, for instance encoded with JSON-LD syntax. Other components of the SWR performing knowledge extraction and/or augmentation may also use this API to interact with the knowledge graph.

A point of discussion is if the SPARQL engine offers enough performance to facilitate such an API, an alternative was suggested to introduce an Elastic Search or PostGreSQL component, which caches the content retrieved with a SPARQL query. These aspects will be validated in the upcoming iteration.


- API to search and harvest graph
- graph maintenance
- Search / harvest graph

- connections with: knowledge graph, automated / harvesting, tagging, manual editor, AI/ML processes
- technologies used: grlc, OGC Open API Records, ...
- responsible person:
- participating: Luís de Sousa