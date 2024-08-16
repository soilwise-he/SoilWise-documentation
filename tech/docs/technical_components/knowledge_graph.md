# Knowledge Graph

!!! component-header "Info"
    **Current version:** 

    **Project:** [Soil Health Knowledge graph](https://github.com/soilwise-he/soil-health-knowledge-graph)

    **Access point:** [SWR SPARQL endpoint](https://sparql.soilwise-he.containers.wur.nl/sparql)


## Functionality

### Augmented metadata to RDF transformation 

!!! component-header "Info"
    **Current version:**

    **Projects:** [Augmented metadata to RDF transformation](https://github.com/soilwise-he)

This function converts SWR metadata records to RDF and then stores the results in the SWR triple store. This process runs on the SWR catalogue datastore with harmonized metadata after validation, transformation to a common metadata model and metadata augmentation.


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

In future iterations, through integration with a dedicated soil health knowledge graph and external resources will evolve into a knowledge network allow much more powerful and impactful queries, e.g. supporting decision support and natural language quering.
