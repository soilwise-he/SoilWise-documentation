# Knowledge Graph

!!! component-header "Info"
    **Current version:** 0.2.0 

    **Project:** [Soil health knowledge graph](https://github.com/soilwise-he/soil-health-knowledge-graph)

    **Access point:** SWR SPARQL endpoint: <https://sparql.soilwise-he.containers.wur.nl/sparql>

SoilWise develops and implements a knowledge graph linking the knowledge captured in harvested and augmented metadata with various sources of internal and external knowledge sources, particularly taxonomies, vocabularies and ontologies that are also implemented as RDF graphs. Linking such graphs into a harmonized SWR knowledge graph allows reasoning over the relations in the stored graph, and thus allows connecting and smartly combining knowledge from those domains.

The first iteration of the SWR knowledge graph is a graph representation of the (harmonized) metadata that is currently harvested, validated and augmented as part of the SWR catalogue database. It's RDF representation, stored in a triple store, and the SPARQL endpoint deployed on top of the triple store, allow users alternate access to the metadata, exploiting semantics and relations between different assets.

At the same time, preliminary experiments have been conducted to integrate this RDF metadata graph with a dedicated soil health knowledge graph, which is constructed with the assistance of AI/ML, using [keyword matching](../technical_components/metadata_augmentation/#keyword-matcher). During this process, unmatched terms from harvested metadata records were identified and cataloged. These terms, acting as candidate keywords, are currently under review by domain experts to assess their potential value for inclusion in the soil health knowledge graph. This analysis serves as a critical mechanism to identify gaps and prioritize new concepts for future enrichment of the graph.

In future iterations, the metadata graph will be linked/merged with this soil health knowledge graph also linking to external resources, establishing a broader interconnected SWR knowledge graph. Consequently, it will evolve into a knowledge network that allows much more powerful and impactful queries and reasoning, e.g. supporting decision support and natural language quering.

## Functionality

### Knowledge graph querying (SPARQL endpoint) 

The SPARQL endpoint, deployed on top of the SWR triple store, allows end users to query the SWR knowledge graph using the SPARQL query language. It is the primary access point to the [knowledge graph](../technical_components/storage.md#knowledge-graph-triple-store), both for humans, as well as for machines. Many applications and end users will instead interact with specialised assets that use the SPARQL end-point, such as the Chatbot or the API. However, the SPARQL end-point is the main source for the development of further knowledge applications and provides bespoke search to humans.

Since we're importing resources from various data and knowledge repositories, we expect many duplicities and conflicting statements. Implementation of rules should be permissive, not preventing inclusion, only flag potential inconsistencies.

## Ongoing Developments

### Knowledge graph enrichment and linking 

!!! component-header "Info"
    **Access point:** <https://raw.githubusercontent.com/soilwise-he/soil-health-knowledge-graph/refs/heads/main/soil_health_KG.ttl>

As a preparation to extend the currently deployed metadata knowledge graph with broader domain knowledge, experimental work has been performed to enrich the knowledge graph to link it with other knowledge graphs.

The following aspects have been worked on and will be furhter developed and integrated into future iterations of the SoilWise knowledge graph:

- Applying various methods using AI/ML to derive a soil health knowledge graph from unstructured content. This is piloted by using (parts of) the EEA report _"[Soil monitoring in Europe – Indicators and thresholds for soil health assessments](https://www.eea.europa.eu/en/analysis/publications/soil-monitoring-in-europe)"_. It tests the effectiveness of various methods to generate knowledge in the form of knowledge graphs from documents, which could also benefit other AI/ML functions foreseen.
- Establishing links between the SoilWise knowledge graph and external taxonomies and ontologies (linked data). Concepts in the SoilWise knowledge graph that (closely) match with concepts in the AGROVOC thesaurus are linked. Other candidate vocabularies in scope are ISO 11074 and GloSIS ontology. The implemented method is exemplary for the foreseen wider linking required to establish a soil health knowledge graph.
- Testing AI/ML based methods to derive additional knowledge (e.g. keywords, geography) for data and knowledge assets. Such methods could for instance be used to further augment metadata or fill exisiting metadata gaps. Besides testing such methods, this includes establishing a model that allows to distinguish between genuine and generated metadata.

### Knowledge graph validation

The validation of the soil health knowledge graph will follow a structured two-phase methodology:

#### Question Formulation
A series of questions will be developed based on the content of the EEA report. The principle underpinning this step is that if the knowledge graph accurately encapsulates the report’s information, it should generate answers consistent with those derived directly from the source. These questions will undergo collaborative review to ensure their scientific validity and relevance within soil science.

#### SPARQL Query Execution and Result Verification
Validated questions will be converted into SPARQL queries and executed against the knowledge graph. The retrieved results will be aggregated and systematically cross-referenced with the answers documented in the EEA report. To ensure domain accuracy, a domain expert will perform a rigorous evaluation of the knowledge graph’s outputs, verifying their technical correctness and adherence to soil science principles.

This process ensures the knowledge graph's fidelity to the source material and its capability to support domain-specific queries reliably.

## Technology & Integration

Components used:

- Virtuoso (version 07.20.3239)
- Python notebooks

Ontologies/Schemas imported:

- [SKOS Core](https://www.w3.org/2009/08/skos-reference/skos.html){target=_blank}
- [Dublin Core](https://www.dublincore.org/specifications/dublin-core/){target=_blank}
- [Agrontology](https://aims.fao.org/aos/agrontology){target=_blank}
- [QUDT](https://qudt.org/){target=_blank}
- [PROV-O](https://www.w3.org/TR/prov-o/){target=_blank}
- [EuroVoc](https://op.europa.eu/en/web/eu-vocabularies){target=_blank}
- [Semanticscience Integrated Ontology](https://sio.semanticscience.org/){target=_blank}
- [Open Biological and Biomedical Ontology](https://obofoundry.org/){target=_blank}
- [Schema.org](https://schema.org/){target=_blank}
- [Wikidata](https://www.wikidata.org/){target=_blank}
- [Biolink](https://biolink.github.io/biolink-model/){target=_blank}
- [SWEET ontology](http://sweetontology.net/){target=_blank}
- [Allotrope Foundation Ontology](https://www.allotrope.org/ontologies){target=_blank}

Vocabularies/Thesauri linked:

- [AGROVOC](https://aims.fao.org/aos/agrovoc){target=_blank}
- [ISO11074](https://data.geoscience.earth/ncl/ISO11074"){target=_blank}
- [GloSIS ontology](https://glosis-ld.github.io/glosis/){target=_blank}
