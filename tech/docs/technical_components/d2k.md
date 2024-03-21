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

## Extraction of KPIs from data

## Metadata interlinkage and metadata ranking

- Assess livelyhood of a link (see [Link persistence validator](./data_processing.md#link-persistence-validator))
- Vice versa linkage (if resource A links to B, a vice versa link can be added to B)
- Derive links (links may be derived by spatial or temporal extent, keyword usage, shared author/publisher)
- Identify project scope of a resource from CORDIS
- Identify type of a remote resources, if linked from a metadata (download, api, record, document)
- Research item: Rank relevance of a resource by evaluating usage logs

- Connections with: retrieve from metadata catalog, write to SPARQL, notify user?
- Technologies used: Triple Store, pygeometa
- Responsible person: Paul van Genuchten
- Participating: ISRIC, WR, WE, ILVO, WENR

## Generating soil health maps

This seems not in scope for SoilWise, although an effort to create such a map will certainly be a user story, Soilwise to provide input for such an effort (both on data and covariates, as well as how to do it)

## Sophisticated Large Language Model

This model will be trained on the knowledge graph. It aims to provide an easy to use and personified interaction mechanism with the knowledge harnessed at the SWR. It is the main pillar supporting the Chatbot component of the user interface.

## High-value data & knowledge identification

## AI, ML

_T1.4 will produce detailed technical specifications, including information on components to be (re)used, interfaces between them and explaining the data flows and processing schemes, considering AgriDataSpace project conceptual reference architecture, **AI/ML architecture patterns and the Ethics by Design in AI.**_