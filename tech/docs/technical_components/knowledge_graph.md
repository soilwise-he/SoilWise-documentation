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

## Foreseen functionality

### Knowledge Graph enrichment and linking 

!!! component-header "Info"
    **Current version:**

    **Projects:** [Knowledge Graph querying]([https://github.com/soilwise-he](https://github.com/soilwise-he/soil-health-knowledge-graph))

The basic (metadata) Knowledge Graph that is generated from the augmented metadata will be enriched with additional knowledge in various manners:

- linking with "external" ontologies and taxonomies (linked data) to extend the knowledge base and allow more meaningful semantic querying
- using AI/ML to derive a knowledge graph specifically for the soil health domain
- using AI/ML to derive additional context (e.g. keywords, geography) for data and knowledge assets

Currently this work still has an explorative character, with the repository containing several experiments that will be further developed over the project's lifetime.





## Technology & Integration

Components used:

- Virtuoso (version 07.20.3239)
- @hugo to add tech info for RDF transformation

The first iteration of the SWR Knowledge Graph is a graph representation of the (harmonized) metadata that is currently harvested, validated and augmented as part of the SWR catalogue database. It's RDF representation, stored in a triple store, and the SPARQL endpoint deployed on top of the triple store, allow users alternate access to the metadata, exploiting semantics and relations between different assets. 

In future iterations the metadata graph will be linked/merged with a dedicated soil health knowledge graph also linking to external resources. Consequently, it will evolve into a knowledge network that allows much more powerful and impactful queries, e.g. supporting decision support and natural language quering.
