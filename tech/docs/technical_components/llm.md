# Large Language Model (RobK, Nick) --> Iteration II

LLM can be used to perform tasks in [metadata optimisation](#metadata-optimization) (identify similarities, resolve conflicts, populate gaps, classify or summarize resources). 

LLM can also power a chatbot interface in which a user asks questions to the bot on what type of resources they are looking for and the bot suggests options to improve the question.

## Precondition

- [Prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) or Retrieval-augmented generation (RAG) is the process of structuring text that can be interpreted and understood by a generative AI model. This process should run post harvest, but pre inclusion into the knowledge graph (to prevent the full knowledge graph is analysed at every insert)
- Vectors derived from RAG can best be stored on a vector database. No preferred vector database can be selected currently, they are under active development, we'll experiment with a number of them.

## Metadata optimization

A component which uses LLM to improve metadata 

- identify similarities
    - very high similarity; indication that the record (despite the differet identifier) is likely the same resource
    - high similarity; suggest it as a `similar` resource (linkage)
- resolve conflicts
    - if 2 records contains conflicting statements about a resource, try to derive from context which one is correct
- populate gaps
    - if important properties are not populated (contact, title), try to derive it from context
- classify resources (add thematic keywords)
    - Based on context, understand which thematic keyword is relevant (soil threats, soil functions, soil health indicators)
- summarize resources
    - If a record lacks an abstract or too short abstract, ask LLM to derive an abstract from the content or context
- derive spatial or temporal extent from content
    - if no patiotemporal extent is given, derive it from context

For each AI derived property, indicate that it has been derived by AI

- Translate the Title, Abstract elements into English, French and German


## Empower a chatbot for user support in defining (and answering) a relevant catalogue question 

A chatbot is a novel user interface to engage users in identifying what they are looking for and even provide a suggestion for an answer. 
