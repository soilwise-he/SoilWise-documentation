# User Interface: Dashboard

The term dashboard is used with various meanings, in the scope of Soilwise the following uses are relevant:

- A [search interface on metadata](#search-interface-on-metadata), search results are typically displayed in a paginated set of web pages. But alternatives, such as a map or chatbot, could be interesting.
- A set of [diagrams showing an overview of the contents and usage of the catalogue](#overview-of-catalogue-content); for example a diagram of the percentage of records by topiccategory, number of visits by an EU Member State.

Other parts of the dashboard are:

- [Metadata authoring](#manual-data-metadata-authoring) and [harvest configuration](../technical_components/ingestion.md) components
- [Data download & export](#data-download-export) options

SoilWise Dashboard is intended to support the implementation of User stories, deliver useful and usable apps for various stakeholders, provide interface for user testing and present data and knowledge in useable way.

### Chatbot

[Large Language models](llm.md) (LLM) enriched with SoilWise content can offer an alternative interface to assist the user in finding and accessing the relevant knowledge or data source. Users interact with the chatbot interactively to define the relevant question and have it answered. The LLM will provide an answer but also provide references to sources on which the answer was based, in which the user can extend the search. The LLM can also support the user in gaining access to the source, using which software, for example.

## Data download & export

A UI component could be made available as part of the SWR Catalogue application which facilitates access to subsets of data from a data download or API. A user selects the relevant feature type/band, defines a spatial or attribute filter and selects an output format (or harmonised model). The component will process the data and notify the user when the result is available for download. The API-based data publication is described as part of [APIs](../apis/apis-intro.md).
