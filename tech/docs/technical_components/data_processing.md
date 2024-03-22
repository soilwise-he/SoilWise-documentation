# Data processing

``` mermaid
flowchart LR
    DPR("`**Data processing**`") --> D2K(Data2Knowledge processing)
    D2K --> DPR
    DPR --> S(Repository Storage)
    S --> DPR

subgraph DPR [Data processing]
    PI("`**Persistence identification
          - Persistent Identifier Mint**
          - Data duplicities discovery
          - Link persistence validator`") ~~~ 
    MV("`**Metadata validation**
          - Metadatacompleteness
          - Data quality assurance`")
    I("`**Interoperability**
          - INSPIRE interoperability
          - Codelist mapping`") ~~~ MV
end
```

The data processing component comprises of the following components:

1. [Persistent identification](#persistent-identification)
2. [Metadata indexing](#metadata-indexing)
3. [Metadata validation](#metadata-validation)
4. [Interoperability](#interoperability)

## Persistent identification

### Persistent Identifier Mint

Persistent Identifiers (PIDs) are unique and long-lasting codes refering to digital objects like  document, file, 
web page, or other objects. They act as permanent name tags for digital information, ensuring it can be reliably found 
and accessed over time, even if the original location or format changes. An example of a PID frequently used in 
academic publishing to identify journal articles, research reports and data sets is DOI (Digital Object Identifier).
Key characteristics of PIDs are:

- persistance (unchanged over time),
- resolvability (retrieving the identified object), 
- uniqueness (identifying a single, unique resource)
 and actionability (a way to directly access or interact with the resource)

They are used in the SoilWise Repository in respect to:

- consistent identification
- findability
- versioning / derivates linking

### Data duplicities discovery

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

#### Technology

This proces can be automated in the platform using automated (Python) scripts running within the data processing environment 
of the platform. A second approach is to use data processing functionalities and AI algorithms integrated in a database, 
e.g. the Neo4J Graph Database and Neo4J Graph Data Science [Similarity algorithms](https://neo4j.com/docs/graph-data-science/current/algorithms/similarity/){target=_blank} 
(Node Similarity, K-Nearest Neighbours, ...). This requires the data to exist in
the graph database as linked data, either importing from the SWR knowledge graphs or using such a graph database 
technology (e.g. Neo4J) as the SWR knowledge graph technology.


- two levels inspection (coarse = dataset level, fine = objects/attributes? level)
- read existing data in terms of size, identical identifiers (data, metadata level)
- identify duplicite values


### Link persistence validator

**Persistent content** is considered to be stored in a trustworthy, persistent repository. We expect those storages to store the asset compliant with the applicable legally and scientifically required terms and periods for storage of the content, and to use a DOI or other persistent URI for persistent identification. These can be safely referred to from the SoilWise catalogue. For long-term preservation and availability of data and knowledge assets, SWR relies on the repository holders and their responsibility to keep it available.

**Non-persistent** data and knowledge are the ones that are not guaranteed to persist by the repository or data and knowledge holder and/or does not guarantee a persistent URI for reference for at least 10 years. In practice many non-persistent knowledge sources and assets exist that could be relevant for SWR, e.g. on project websites, in online databases, at computers of researchers, etc. Due to their heterogeneity in structure and underlying implementing technologies etc., it is not possible nor desirable to store those in the SWR, with exception of high value data/knowledge assets.  

#### Foreseen functionality

Assess if resources use proper identifiers to reference external items.
Metadata (and data and knowledge sources) tend to contain links which over time degrade and result in `File not found` experiences. By running availability checks on links mentioned in (meta)data, for each link an availability indicator (available, requires authentication, intermittent, unavailable) can be calculated. Alternatively a link check can be performed at the moment a user tries to open a resource.

#### Technology

- [ePIC](https://pidconsortium.net){target=_blank}  ePIC API providing a software stack for a PID service
- [GeoHealthCheck](https://GeoHealthCheck.org){target=_blank}  or
- [INSPIRE Geoportal Link checker](https://github.com/GeoCat/icat){target=_blank}  or
- ...

## Metadata validation

- metadata conformance evaluation
  - conformance is a indicator of quality?
- linkage evaluation
  - linkage to other metadata records
  - linkage to data/services. [Geohealthcheck](https://geohealthcheck.org){target=_blank} is an interesting tool to monitor availability of spatial services/resources.
  - linkage failure is a common problem on the web, first aspect is to tag a link as broken, so users can filter broken links, later it can be considered to remove/disable the link (other links on the same record may still be operational, the content behind the link may be recoverable via <https://web.archive.org> (so don't remove it).
- metadata quality evaluation
  - identify a level of completeness for a metadata file (match against a set of expectations from a SoilWise perspective)
  - governance is of interest, what do you do if a record scores low? notify the owner, try to auto-improve, tag with low score, exclude from the catalogue 
- data quality evaluation
- suggest improvements on metadata to users

[Geocat](https://geocat.iucnredlist.org/){target=_blank} has developed a linkage checker for iso19139:2007 metadata for INSPIRE geoportal, available at [icat](https://github.com/GeoCat/icat){target=_blank}, which includes link checks in OWS capabilities.

### Metadata completeness 

The completeness of the metadata will be evaluated according to an ISO19157 Geographic Information – Data quality and the official ISO19115 and ISO19119 XML schema definitions, including compliance with specified international standards.
Rule-based validation languages such as Schematron are foreseen to be used for pattern-matching validation, i.e., allowing the definition of patterns to match specific structures or data within the XML document. These patterns can be used to check for the presence or absence of certain elements, attributes, or values.

### Data quality assurance (MU + ISRIC)

- Automated validations on datasets to check if statements in metadata on resolution, projection, spatial/temporal bounds, accuracy, classification, uncertainty are correct.
- If a metadata record has no statements on these aspects, findings fom the validation will be used instead.
- understand the history of a data file is of interest, with every download save the hash of the file, to know if it was changed since last download and if this change was properly documented.

- Impact of validation? Tag the record with the actual value, notify the owner of our findings, On the UI show only the updated values, decrease the record quality score (impacting search ranking).

- Prevent to download data for every validation by checking against modification date.
- Run a full check at monthly intervals in case files are changed without updating the modification date.
- If data is provided as a service (or cloud optimised) a subset of the data may be extracted for the validation.

**Requirements to storage component:**

- For any data link in a metadata record, keep a registry of its validation result (keep a copy of (or reference to) the metadata record at that moment)
- A registry to keep record overrides introduced by validations
- A registry to track conversation with the data owner on validation results

**Impact on search engine:**

- decrease ranking in case metadata has many inconsistencies related to data quality

- [GeoHealthCheck](https://geohealthcheck.org) could be an interesting platform to monitor quality of data. 

## Interoperability

- Describe the source dataset model in detail so ETL is facilitated (for example iso19110 or XSD or OWL).
- Prepare & share a transformation pattern so any potential user can trigger/adjust the transformation (also helps to understand the source model), allow feedback/contributions to the transformation pattern (Hale Studio, rml.io/yarrrml, csv-ld).
- Extract data from a dedicated format (many) to a selected format (GDAL) for example as [OGCAPI Processes](https://ogcapi.ogc.org/processes/){target=_blank}, Nice to have: enable subsetting the dataset to a region of interest.
- Transform from source to target model using transformation pattern. 
  - Standardise object & attribute names/types/units.
  - Map attribute values to codelist values from selected taxonomies.
  - Harmonise observations as if they were measured using a common procedure using [PTF](https://en.wikipedia.org/wiki/Pedotransfer_function){target=_blank}.
- Load transformed data to a shared database.

- Restructure data to common repo structures + semantics
- Write out in common repo format
- Only for priority (meta)data, majority will be linked, stored elsewhere

### Technology

- Hale, gdal, tarql, stetl


### INSPIRE interoperability aligner

### Codelist mapping (WE, ISRIC, WR)

- Hale Studio has a codelist mapping tool
- The skos ontology allows to map terms between code lists using SameAs relations (as part of Triple store)