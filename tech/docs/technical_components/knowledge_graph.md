# Knowledge Graph

!!! component-header "Info"
    **Current version:** 

    **Project:** [Soil Health Knowledge graph](https://github.com/soilwise-he/soil-health-knowledge-graph)

    **Access point:** [SWR SPARQL endpoint](https://sparql.soilwise-he.containers.wur.nl/sparql)


## Functionality

### RDF to triple store

A service is available which exposes the contents of the metadata database to the triple store. Loading rdf data from the service to the triple store is currently a manual operation at intervals.

### Knowledge Graph querying (SPARQL endpoint) 

!!! component-header "Info"
    **Current version:**

    **Projects:** [Knowledge Graph querying](https://github.com/soilwise-he)

The SPARQL endpoint, deployed on top of the SWR triple store, allows end users to query the SWR knoledge graph using the SPARQL query language.  


## Technology & Integration

Components used:

- Virtuoso (version 07.20.3239)
- @hugo to add tech info for RDF transformation

The first iteration of the SWR Knowledge Graph is a graph representation of the (harmonized) metadata that is currently harvested, validated and augmented as part of the SWR catalogue database. It's RDF representation, stored in a triple store, and the SPARQL endpoint deployed on top of the triple store, allow users alternate access to the metadata, exploiting semantics and relations between different assets. 

In future iterations the metadata graph will be linked/merged with a dedicated soil health knowledge graph also linking to external resources. Consequently, it will evolve into a knowledge network that allows much more powerful and impactful queries, e.g. supporting decision support and natural language quering.
