# Natural Language Querying

> Making open ___knowledge___ findable and accessible for SoilWise users

!!! component-header "Info"
    **Current version:**

    **Project:** [Natural Language querying](https://github.com/soilwise-he/natural-language-querying)

## Functionality

Still in research phase, no implementations yet.

Core topics:

 - **LLM**[^1] based (semantic)KG generation from unstructured content (leveraging existing search technology)
 - chatbot - Natural Language Interface (using advanced **NLP**[^2] methodologies, such as LLMs)
 - LLM operationalisation (**RAG**[^3] ingestion pipeline(s), generation pipeline, embedding store, models)

## Foreseen functionality

Leverage existing search technology (e.g. the Apache Solr open source search engine) combined with new developments in NLP (such as transformer based language models) to make harvested knowledge (documents and formal knowledge graphs) accessible to SoilWise users. 

General steps towards an AI based self-learning search system, from less to more complex: 

 - basic keyword based search (**tf-idf**[^4], **bm25**[^5])
 - use of taxonomies and entity extraction
 - understanding query intent (semantic query parsing, semantic knowledge graphs, virtual assistants)
 - automated relevance tuning (signals boosting, collaborative filtering, learning to rank)
 - Self-learning search system

The final aim is towards extractive question answering (extract answers from sources in real-time), result summarization (summarize search results for easy review), and abstractive question answering (generate answers to questions from search results). Not all these aims might be achievable within the project though. Later steps depend more on the use of complex language models.

One step towards personalisation could be the use of (user) signals boosting and collaborative filtering. But this would require tracking and logging (user) actions.

A seperate development could be a chatbot based on selected key soil knowledge documents ingested into a vector database (as a fixed resource), or even a fine-tuned LLM that is more soil science specific than a plain foundation LLM.

Optionally the functionality can be extended from text processing to also include multi-modal data such as photos (e.g. of soil profiles). Effort needed for this has to be carefully considered.

Along the way natural language processing (NLP) methods and approaches can also be applied for various metadata handling and augmentation.

## Foreseen technology

 - (Semantic) search engine, e.g. [Apache Solr](https://solr.apache.org) or [Elasticsearch](https://www.elastic.co/elasticsearch)
 - Graph database (if needed)
 - (Scalable) vector database (if needed)
 - Java and/or Python based NLP libraries, e.g. [OpenNLP](https://opennlp.apache.org), [spaCy](https://spacy.io)
 - Small to large foundation LLMs
 - LLM development framework (such as [langChain](https://www.langchain.com) or [LlamaIndex](https://www.llamaindex.ai))
 - Front end toolkit 
 - LLM deployment and/or hosted API access
 - Authentication and authorisation layer
 - Computation and storage infrastructure
 - Hardware acceleration, e.g. GPU (if needed)


[^1]: **Large Language Model**. Typically a deep learning model based on the transformer architecture that has been trained on vast amounts of text data, usually from known collections scraped from the Internet.
[^2]: **Natural Language Processing**. An interdisciplinary subfield of computer science and artificial intelligence, primarily concerned with providing computers with the ability to process data encoded in natural language. It is closely related to information retrieval, knowledge representation and computational linguistics.
[^3]: **Retrieval Augmented Generation**. A framework for retrieving facts from an external knowledge base to ground large language models on the most accurate, up-to-date information and enhancing the (pre)trained parameteric (semantic) knowledge with non-parameteric knowledge to avoid hallucinations and get better responses.
[^4]: **tf-idf**. Term Frequency - Inverse Document Frequency, a statistical method in NLP and information retrieval that measures how important a term is within a document relative to a collection of documents (called a corpus).
[^5]: **bm25**. Okapi Best Match 25, a well-known ranking function used by search engines to estimate the relevance of documents to a given search query. It is based on tf-idf, but considered an improvement and adding some tunable parameters.


<!-- previous text for reference:

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
    - if two records contain conflicting statements about a resource, try to derive from context which statement is correct
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
-->

<!-- alternative text from former dashboard description
### Chatbot

[Large Language models](llm.md) (LLM) enriched with SoilWise content can offer an alternative interface to assist the user in finding and accessing the relevant knowledge or data source. Users interact with the chatbot interactively to define the relevant question and have it answered. The LLM will provide an answer but also provide references to sources on which the answer was based, in which the user can extend the search. The LLM can also support the user in gaining access to the source, using which software, for example.

-->
