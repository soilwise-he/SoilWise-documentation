# NLP and Large Language Models

LLM (and less complex Natural Language Processing (NLP) approaches) can be used to perform tasks in [metadata optimisation](#metadata-optimization) (e.g. identify similarities, resolve conflicts, populate gaps, classify or summarize resources). 

LLM can also power a chatbot interface in which a user asks questions to the bot on what type of resources they are looking for and the bot suggests options that can lead to improved search results (finding more relevant resources).

## Precondition

- [Prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) and [Retrieval-Augmented Generation (RAG)](https://en.wikipedia.org/wiki/Prompt_engineering#Retrieval-augmented_generation) are approaches for preparing text to be used as input (prompt) for a generative AI model. These techniques help to tune the usually very generic foundational LLMs to generate more specific responses with less change of halucinations. RAG, in particular, should run post harvest, but pre inclusion into the knowledge graph (to prevent the full knowledge graph is analysed at every insert).
- [Embeddings](https://en.wikipedia.org/wiki/Word_embedding) are numerical (vector) representations of words, phrases, or larger text fragments (or even images) and have become a key part for text analysis. Small-size embeddings can be calculated on-the-fly, but larger size (capturing more complex semantic or linguistic characteristics), as used in RAG, take time to compute and thus are best stored. Vector databases are specifically being developed for this purpose, allowing fast processing and comparing of embeddings. No preferred vector database can be selected currently, as they are under active development, we'll experiment with a number of them and select the best suited.

## Metadata optimization

A component which uses NLP/LLM to improve metadata 

- identify similarities
    - very high similarity; indication that the record (despite the different identifier) is likely the same resource
    - high similarity; suggest it as a `similar` resource (linkage)
- resolve conflicts
    - if 2 records contain conflicting statements about a resource, try to derive from context which statement is correct
- populate gaps
    - if important properties are not populated (contact, title), try to derive it from context (with e.g. [Named-Entity Recognition](https://en.wikipedia.org/wiki/Named-entity_recognition))
- classify resources (add thematic keywords/tags)
    - Based on context, understand which thematic keywords/tags are relevant (soil threats, soil functions, soil health indicators). Keywords/tags should be related to provided codelist or can be suggested as a potential new one to be added.
- summarize resources
    - If a record lacks an abstract or has a too short abstract, ask LLM to derive an abstract from the resource itself 
- derive spatial or temporal extent from content
    - if no spatio-temporal extent is given, derive it from the resource itself or from context if possible

For each AI derived property, indicate that it has been derived by AI. (Need to be discussed how this can be indicated, e.g. with attributes / relations in the knowledge graphs?)

- Translate the Title, Abstract elements into English, French and German


## Empower a chatbot for user support in defining (and answering) a relevant catalogue question 

A chatbot is a natural language user interface to engage users in identifying what they are looking for and even provide a suggestion for an answer. Advanced LLMs provide improved text processing capabilities that can serve more usable human-machine interfaces.
