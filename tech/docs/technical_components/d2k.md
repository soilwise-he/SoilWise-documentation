# Data2Knowledge processing (Rob)

- understands what is in any soil repository & how to use it
- gives output to interlinker
- AI used for labelling information, interlinking metadata (linked with the box below),
documents
- analysis of CORDIS (what to link)
- connections with: catalogue (for looking up things), client / presentation (for
enduser interaction), APIs (for machine & developer interaction), schemes &
structures
- technologies used: GloSIS?
- responsible person: Rob Lokers
- participating: Luís de Sousa, Anna Fensel, We Transform, Nick Berkvens, Giovanni
L'Abate


## Enhancing metadata items

Powered by AI

- finding citations and usage of data, methodologies
- provide data labelling
- enable user input??

## Alignment with existing data

## Automatic metadata interlinking

To be able to provide interlinked data and knowledge assets (e.g. a dataset, the project in which it was generated and the operating procedure used) links between metadata must be identified and registered as part of the SWR knowledge graph

- Explicit links can be directly derived from the data and/or metadata. For those linkages, the harvesting process needs to be extended, calling this component to store the relation in the knowledge graph. It should accomodate "vice versa linkage" (if resource A links to B, a vice versa link can be added to B)
- Implicit links can not be directly derived from the (meta)data. They may be derived by spatial or temporal extent, keyword usage, shared author/publisher. In this case, AI/ML can support the discovery of potential links, including somekind of probability indicator

It should be connected to: 
- Automatic metadata harvesting (initiate)
- - Metadata store (read)
  - Knowledge graph (read/write)
  - Assess livelyhood of a link (see [Link persistence validator](./data_processing.md#link-persistence-validator))

## Metadata ranking

- Research item: Rank relevance of a resource by evaluating usage logs

## Sophisticated Large Language Model

This model will be trained on the knowledge graph. It aims to provide an easy to use and personified interaction mechanism with the knowledge harnessed at the SWR. It is the main pillar supporting the Chatbot component of the user interface.

## High-value data & knowledge identification

- Is this somehow related to metadata ranking?

## AI, ML

- Questionable if this should be a separate component, maybe integrated part of other components?

## Extraction of KPIs from data

- **To be decided on** - in the session on land manager UCs we concluded that KPIs will either come from (Soil Mission) projects as in input to SWR, or would be derived by an intermediary and/or end user based on data from SWR

## Generating soil health maps

- **To be decided on** - This seems not in scope for SoilWise, although an effort to create such a map will certainly be a user story, Soilwise to provide input for such an effort (both on data and covariates, as well as how to do it)


Remaining notes:
- Identify project scope of a resource from CORDIS
- Identify type of a remote resources, if linked from a metadata (download, api, record, document)


_T1.4 will produce detailed technical specifications, including information on components to be (re)used, interfaces between them and explaining the data flows and processing schemes, considering AgriDataSpace project conceptual reference architecture, **AI/ML architecture patterns and the Ethics by Design in AI.**_
