# Knowledge graph

The knowledge graph is meant to add a formal semantics layer to the meta-data collected at the SWR. It mirrors the XML-based meta-data harnessed in the Catalogue Server, but using Semantic Web standards such as DCAT, Dublin Core, VCard or PROV. This meta-data is augmented with links to domain web ontologies, in particular GloSIS. This semantically augmented meta-data is the main pilar of knowledge extraction activities and components.

Besides meta-data the knowledge graph is also expected to host the results of
knowledge extration activities. This assumes that knowledge to be semantically
laden, i.e. linking to relevant domain ontologies. The identification of
appropriate ontologies, and ontology mappinds thus becomes an essential aspect
of this project, bridging together various activities and assets.  

It is important to recognise the knowledge graph as an immaterial asset that
cannot exist by itself. In order to be usable the knowledge graph must be
stored in a triple store, thus highlighting the role of that component in the
architecture. In its turn the triple store provides another important
architectural component, the SPARQL end-point. That will be the main access
gateway to the knowledge graph, particularly by other techonological components
and software.

The Large Language Model foreseen in this project will be trained on the knowledge graph, thus forming the basis for the Chatbot component of the user interface. The knowledge graph will further feed the facilites for machine-based access to the SWR: a knowledge extration API and a SPARQL end-point.

- metadata storage
- metadata linking
- semantic consistency

- connections with: APIs, presentation, processing, harvester, metadata scheme, storage & structure
- technologies used: DCAT, Dublin Core, VCard, PROV, GloSIS, ...
- responsible person:
- participating: Luís de Sousa
