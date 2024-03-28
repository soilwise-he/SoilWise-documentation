# Interlinker (Rob)

Interlinker component comprises of the following functions:

1. [Automatic metadata interlinking](#automatic-metadata-interlinking)
2. [Duplicates identification](#duplicates-identification)
3. [Link liveliness assessment](#link-liveliness-assessment)

## Automatic metadata interlinking

To be able to provide interlinked data and knowledge assets (e.g. a dataset, the project in which it was generated and the operating procedure used) links between metadata must be identified and registered as part of the [SWR Triple Store](storage.md#triple-store)

- **Explicit links** can be directly derived from the data and/or metadata. E.g. projects in CORDIS are explicitly linked to documents and datasets. 
For those linkages, the harvesting process needs to be extended, calling this component to store the relation in the knowledge graph. It should accomodate "vice versa linkage" (if resource A links to B, a vice versa link can be added to B)
- **Implicit links** can not be directly derived from the (meta)data. They may be derived by spatial or temporal extent, keyword usage, shared author/publisher. In this case, AI/ML can support the discovery of potential links, including somekind of probability indicator

## Duplicates identification

In the context of Persistent Identifiers (PIDs), duplication refers to the occurrence of multiple identifiers 
pointing to the same digital object or resource. As SWR will be ingesting datafiles from multiple data sources 
this is an aspect that has to be taken into account. 

We have no knowledge of existing technologies we can integrate as a component in the platform. This functionality will be 
setup within the platform. 
The methodology applied to identify duplicates will be by comparing multiple (meta)data attributes like 
_File Name, File Size, File Type, Owner, Description, Date Created/Modified_. 
**Natural Language Processing techniques** like Bag-of-words or Word/Sentence Embedding algorithms can be used to convert textual attributes into vectors, 
capturing semantic similarity and relationships between words. Each datafile will be characterized by their attributes 
and represented in a continuous vector space together with the other datafiles. Similarity algorithms 
(e.g. cosine similarity, euclidean distance, etc.) are then applied 
to identify datafiles with a similarity above a certain threshold, which are then considered to be duplicates.
If necessary a business rule will be integrated taking the "completeness" of the datafile into account as to be able 
to determine which PID and datafile to keep and which to discard.

### Technology

This proces can be automated in the platform using automated (Python) scripts running within the data processing environment 
of the platform. A second approach is to use data processing functionalities and AI algorithms integrated in a database, 
e.g. the Neo4J Graph Database and Neo4J Graph Data Science [Similarity algorithms](https://neo4j.com/docs/graph-data-science/current/algorithms/similarity/){target=_blank} 
(Node Similarity, K-Nearest Neighbours, ...). This requires the data to exist in
the graph database as linked data, either importing from the SWR knowledge graphs or using such a graph database 
technology (e.g. Neo4J) as the SWR knowledge graph technology.

- two levels inspection (coarse = dataset level, fine = objects/attributes? level)
- read existing data in terms of size, identical identifiers (data, metadata level)
- identify duplicite values


## Link liveliness assessment

**Persistent content** is considered to be stored in a trustworthy, persistent repository. We expect those storages to store the asset compliant with the applicable legally and scientifically required terms and periods for storage of the content, and to use a DOI or other persistent URI for persistent identification. These can be safely referred to from the SoilWise catalogue. For long-term preservation and availability of data and knowledge assets, SWR relies on the repository holders and their responsibility to keep it available.

**Non-persistent** data and knowledge are the ones that are not guaranteed to persist by the repository or data and knowledge holder and/or does not guarantee a persistent URI for reference for at least 10 years. In practice many non-persistent knowledge sources and assets exist that could be relevant for SWR, e.g. on project websites, in online databases, at computers of researchers, etc. Due to their heterogeneity in structure and underlying implementing technologies etc., it is not possible nor desirable to store those in the SWR, with exception of high value data/knowledge assets.  

### Foreseen functionality

Assess if resources use proper identifiers to reference external items.
Metadata (and data and knowledge sources) tend to contain links which over time degrade and result in `File not found` experiences. By running availability checks on links mentioned in (meta)data, for each link an availability indicator (available, requires authentication, intermittent, unavailable) can be calculated. Alternatively a link check can be performed at the moment a user tries to open a resource.

### Technology

- [ePIC](https://pidconsortium.net){target=_blank}  ePIC API providing a software stack for a PID service
- [GeoHealthCheck](https://GeoHealthCheck.org){target=_blank}  or
- [INSPIRE Geoportal Link checker](https://github.com/GeoCat/icat){target=_blank}  or
- ...
