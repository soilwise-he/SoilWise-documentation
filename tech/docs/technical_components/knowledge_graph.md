# Knowledge Graph

!!! component-header "Info"
    **Current version:** 1.0 

    **Project:** [Soil Health Knowledge graph](https://github.com/soilwise-he/soil-health-knowledge-graph)

    **Access point:** SWR SPARQL endpoint: <https://sparql.soilwise-he.containers.wur.nl/sparql>

SoilWise develops and implements a Knowledge Graph linking the knowledge captured in harvested and augmented metadata with various sources of internal and external knowledge sources, particularly taxonomies, vocabularies and ontologies that are also implemented as RDF graphs. Linking such graphs into a harmonized SWR Knowledge Graph allows reasoning over the relations in the stored graph, and thus allows connecting and smartly combining knowledge from those domains.

The first iteration of the SWR Knowledge Graph is a graph representation of the (harmonized) metadata that is currently harvested, validated and augmented as part of the SWR catalogue database. It's RDF representation, stored in a triple store, and the SPARQL endpoint deployed on top of the triple store, allow users alternate access to the metadata, exploiting semantics and relations between different assets. 

At the same time, experiments have been performed to prepare for the linkage of this RDF metadata graph and existing and AI/ML generated graphs. In future iterations, the metadata graph will be linked/merged with a dedicated soil health knowledge graph also linking to external resources, establishing a broader interconnected soil health knowledge graph. Consequently, it will evolve into a knowledge network that allows much more powerful and impactful queries and reasoning, e.g. supporting decision support and natural language quering.

## Functionality

### Knowledge Graph querying (SPARQL endpoint) 

The SPARQL endpoint, deployed on top of the SWR triple store, allows end users to query the SWR knoledge graph using the SPARQL query language. It is the primary access point to the [knowledge graph](../technical_components/storage.md#knowledge-graph-triple-store), both for humans, as well as for machines. Many applications and end users will instead interact with specialised assets that use the SPARQL end-point, such as the Chatbot or the API. However, the SPARQL end-point is the main source for the development of further knowledge applications and provides bespoke search to humans.

Since we're importing resources from various data and knowledge repositories, we expect many duplicities, blank nodes and conflicting statements. Implementation of rules should be permissive, not preventing inclusion, only flag potential inconsistencies.

## Ongoing Developments

### Knowledge Graph enrichment and linking 

!!! component-header "Info"
    **Access point:** <https://voc.soilwise-he.containers.wur.nl/concept/>

As a preparation to extend the currently deployed metadata knowledge graph (KG) with broader domain knowledge, experimental work has been performed to enrich the KG to link it with other knowledge graphs. 

The following aspects have been worked on and will  be furhter developed and integrated into future iterations of the SoilWise KG:

- Applying various methods using AI/ML to derive a (soil health) knowledge graph from unstructured content. This is piloted by using (parts of) the EEA report "Soil monitoring in Europe - Indicators and thresholds for soil quality assessments". It tests the effectiveness of various methods to generate knowledge in the form of KGs from documents, which could also benefit other AI/ML functions foreseen.
- Establishing links between the SoilWise KG and external taxonomies and ontologies (linked data). Concepts in the SoilWise KG that (closely) match with concepts in the AGROVOC thesaurus are linked. The implemented method is exemplary for the foreseen wider linking required to establish a soil health KG.
- Testing AI/ML based methods to derive additional knowledge (e.g. keywords, geography) for data and knowledge assets. Such methods could for instance be used to further augment metadata or fill exisiting metadata gaps. Besides testing such methods, this includes establishing a model that allows to distinguish between genuine and generated metadata.

## Technology & Integration

Components used:

- Virtuoso (version 07.20.3239)
- Python notebooks

Ontologies/Vocabularies/Schemas:

- [SKOS Core](https://www.w3.org/2009/08/skos-reference/skos.html){target=_blank}
- [Dublin Core](https://www.dublincore.org/specifications/dublin-core/){target=_blank}
- [AGROVOC](https://aims.fao.org/aos/agrovoc){target=_blank}
- [GloSIS](https://glosis-ld.github.io/glosis/){target=_blank}
- [Agrontology](https://aims.fao.org/aos/agrontology){target=_blank}
- [QUDT](https://qudt.org/){target=_blank}

