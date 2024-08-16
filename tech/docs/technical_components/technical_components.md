# Introduction

The SoilWise Repository (SWR) architecture aims towards effecient facilitation of soil data management. It seamlessly gathers, processes, stores, and disseminates data from diverse sources. The system prioritizes high-quality data dissemination, knowledge extraction and interoperability while user management and monitoring tools ensure secure access and system health. Note that, SWR primarily serves to power Decision Support Systems (DSS) rather than being a DSS itself.

The presented architecture represents an outlook and a framework for ongoing SoilWise development. As such, the implementation will follow intrinsic (within the SoilWise project) and extrinsic (e.g. EUSO development Mission Soil Projects) opportunities and limitations. The presented architecture is the first release out of two planned. Modifications during the implementation will be incorporated into the final version of the SoilWise architecture due M42.

This section lists technical components for building the SoilWise Repository as forseen in the architecture design. As for now, the following components are foreseen:

1. [Harvester](ingestion.md)
2. [Repository Storage](storage.md)
3. [Catalogue](catalogue.md)
4. [Metadata Validation](metadata_validation.md)
5. [Transformation and Harmonistation](transformation.md)
6. [Metadata Authoring](metadata_authoring.md)
7. [Metadata Augmentation](metadata_augmentation.md)
8. [Knowledge Graph](knowledge_graph.md)
9. [Natural Language Querying](llm.md)
11. [User Management and Access Control](user_management.md)
12. [System Usage & Monitoring](monitoring.md)

<iframe style="width:100%; height:800px"src="https://prototype-1-0.soilwise-architecture.pages.dev/?view=id-e3ae52bba4fb42dfa0b3900e7d3"></iframe>

A full version of architecture diagram is available at: <https://soilwise-he.github.io/soilwise-architecture/>{:target="_blank"}.
