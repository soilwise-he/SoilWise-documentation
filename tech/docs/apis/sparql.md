# SPARQL API

!!! component-header "Info"

    **Current version:**
    
    **Access:** <https://sparql.soilwise-he.containers.wur.nl/sparql/>

This is the primary access point to the [knowledge graph](../technical_components/storage.md#knowledge-graph-triple-store), both for humans, as well as for machines. Many applications and end users will instead interact with specialised assets that use the SPARQL end-point, such as the Chatbot or the API. However, the SPARQL end-point is the main source for the development of further knowledge applications and provides bespoke search to humans.

Consider that this component relates to the [knowledge extraction](./knowledge-extraction.md) component, which describes alternative mechanisms to access selected parts of the knowledge graph.

See also [SWR Storage - Triple Store](../technical_components/storage.md#knowledge-graph-triple-store) for further details. 

## Rules and reasoning

Since we're importing resources from various data and knowledge repositories, we expect many duplicities, blank nodes and conflicting statements. Implementation of rules should be permissive, not preventing inclusion, only flag potential inconsistencies.

## Technology

A number of proven open source triple store implementations exist. In the first iteration **Virtuoso** is used.
