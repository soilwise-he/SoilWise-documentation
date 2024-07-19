# Metadata validation

!!! component-header "Info"
    **Current version:**

    **Project:** [Metadata validator](https://github.com/soilwise-he/metadata-validator)


In terms of metadata, SoilWise Repository aims for the approach to harvest and register as much as possible (see more information in the [Harvester Component](ingestion.md)). Catalogues which capture metadata authored by data custodians typically have a wide range of metadata completion and accuracy. Therefore, the SoilWise Repository employs metadata validation mechanisms to provide additional information about metadata completeness, conformance and integrity. Information resulting from the validation process are stored together with each metadata record in a relation database and updated after registering a new metadata version. After metadata processing and extension (see the [Interlinker component](interlinker.md) and [Metadata augmentation](metadata_augmentation.md)), this validation process can be repeated to understand the value which has been added by SWR.

``` mermaid
flowchart LR
    HC(Harvest component)
    HC --> db[(Relation DB)]
    HC --> TS[(Triple Store)]
    MV[Run Metadata validation] --> |read| db
    db --> |write| MV
    MV --> |display validation results| MC(Metadata Catalogue)
    MV --> |display validation results| HA(Hale Connect Admin Console)
    MP[Metadata profile configuration] --> HA
    HA --> MV
```

## Metadata profile

Metadata profile specifies the required metadata elements that must be included to describe spatial data sets and services, ensuring they are discoverable, accessible, and usable. Metadata validation is inherently linked to the specific metadata profile it is intended to follow. This linkage ensures that metadata records are consistent, meet the necessary standards, and are fit for their intended purpose, thereby supporting effective data management, discovery, and use. In the soil domain, several metadata profiles are commonly used to ensure the effective documentation, discovery, and utilization of soil data, for example INSPIRE Metadata Profile, ISO 19115, ISO 19119, Dublin Core, ANZLIC Metadata Profile, FAO Global Soil Partnership Metadata Profile, EJP/EUSO Metadata Profile. SoilWise Repository is currently able to perform validation according to the following metadata profiles:

### Minimal metadata elements

A minimal set of metadata elements was defined to validate which records can be displayed in the [Metadata Catalogue](catalogue.md) so that basic search functions are enabled.

TBD

| Label                       | Cardinality | Codelist | DataCite | Description                                                                                               |
|-----------------------------|-------------|----------|----------|-----------------------------------------------------------------------------------------------------------|
| Title                       | 1-1         |          | yes      | Short meaningful title                                                                                    |


### EJP/EUSO Metadata profile 

This metadata profile was developed through EJP Soil project efforts and modified and approved by the EUSO Working Group.

| Label                       | Cardinality | Codelist | DataCite | Description                                                                                               |
|-----------------------------|-------------|----------|----------|-----------------------------------------------------------------------------------------------------------|
| Identification              | 1-1         |          | yes      | Unique identification of the dataset (A UUID, URN, or URI, such as DOI)                                   |
| EUSO Data WG subgroup       | 0-n         | yes      |          | The EUSO subgroups which contributed to this record                                                       |
| Context                     | 0-n         | yes      |          | Context: (e.g. EU-Project SOILCARE, EJP-Soil, Literature, ESDAC, etc.)                                    |
| Title                       | 1-1         |          | yes      | Short meaningful title                                                                                    |
| Abstract                    | 1-1         |          | yes      | Short description or abstract (1/2 page), can include (multiple) scientific/technical references          |
| Format                      | 0-1         | yes      | yes      | File Format in which the data is maintained or published                                                  |
| Extent (geographic)         | 0-1         |          | yes      | Geographical coverage (e.g. EU, EU & Balkan, …)                                                           |
| Reference period - Start    | 0-1         |          |          | Reference period for the data - Start                                                                     |
| Reference period - End      | 0-1         |          |          | Reference period - End; empty if ongoing                                                                  |
| Access constraints          | 1-1         | yes      |          | Indicates if the data is publicly accessible or the reason to apply access constaints                     |
| Usage constraints           | 1-1         | yes      | yes      | Indicates if there are legal usage constraints (license)                                                  |
| Keywords                    | 0-1         |          | yes      | Keywords; separated by ';'                                                                                |
| Contact                     | 1-n         |          | yes      | One Contact per line; name; organisation; email; role, where role is one of distributor, owner, pointOfContact, processor, publisher, metadata-contact |
| Source                      | 0-n         |          |          | Source is a reference to another dataset which is used as a source for this dataset. Reference a single dataset per line; Title; Date; or provide a DOI; |
| BackLinks                   | 0-n         |          |          | Other datasets that the current dataset is used as input source.                                          |
| Lineage                     | 1-1         |          |          | Statement on the origin and processing of the data                                                        |
| Processing steps            | 0-n         |          |          | Methods applied in data acquisition and processing: preferably reference a method from a standard (national, LUCAS, FAO, etc.). One processing step per line; Method; Date; Processor; Method reference; Comment |
| Language                    | 1-n         | yes      | yes      | Language, of the data and metadata, if metadata is multilingual multiple languages can be provided        |
| Reference system            | 0-1         |          |          | Spatial Projection: drop down list of options, including ‘unknown’  (you can also leave out the field if it is unknown) |
| Citation                    | 0-n         |          |          | Citations are references to articles which reference this dataset; one citation on each line; Title; Authors; Date; or provide a DOI |
| Spatial resolution          | 0-n         |          |          | Resolution (grid) or scale (vector)                                                                       |
| Geometry                    | 0-1         | yes      |          | Geometry for vector data                                                                                  |
| Categorical Data            | 0-n         | yes      |          | Lookup tables for categorical data in raster data or in columns of vector data                            |
| File / service Location     | 0-n         |          |          | Url or path to the data file or service                                                                   |
| Maintenenance frequency     | 0-1         | yes      |          | Indication of the frequency of data updates                                                               |
| Modification date           | 0-1         |          | yes      | Date of last modification                                                                                 |
| Status                      | 0-1         | yes      |          | Status of the dataset                                                                                     |
| Soil properties             | 0-n         | yes      |          | Soil properties described in this dataset                                                                 |
| Soil function               | 0-n         | yes      |          | Soil funtions described in this dataset                                                                   |
| Soil threats                | 0-n         | yes      |          | Soil threats described in this dataset                                                                    |
| Soil Indicators             | 0-n         | yes      |          | Soil indicators  described in this dataset                                                                |
| Quality statement           | 0-1         |          |          | A statement of quality or any other supplemental information                                              |
| Units of measure            | 0-1         | yes      |          | List of UoM from International System of Units                                                            |
| Error descriptor            | 0-n         |          |          | One or more measurements to describe the error and uncertainties in the dataset                           |
| Percent Complete            | 0-1         |          |          | The % of completeness                                                                                     |
| Delivery                    | 0-n         | yes      |          | The  way the dataset is available (ie digital: download, viewer OR physical way: Shipping or in situ access) |
| Theme/Category              | 0-n         | yes      |          | One or more thematic categories of the dataset                                                            |
| Possible End-users          | 0-n         | yes      |          | Possible end-users: citizens, scientific community, private sector, EU, member states, academia           |


### Future work

In the following iterations, INSPIRE metadata profiles, ISO, and compliance with GloSIS will be inspected

## Functionality

The metadata validation component currently comprises the following functions:

- [Metadata structure validation](#metadata-structure-validation)
- [Metadata completeness check](#metadata-completeness-validation)
- [Metadata ETS checking](#metadata-etsats-checking)
- [Display validation results](#display-validation-results)

### Metadata structure validation

The initial steps of metadata validation comprise:

1. **Markup (Syntax) Check:** Verifying that the metadata adheres to the specified syntax rules. This includes checking for allowed tags, correct data types, character encoding, and adherence to naming conventions.
2. **Schema (DTD) Validation:** Ensuring that the metadata conforms to the defined schema or metadata model. This involves verifying that all required elements are present, and relationships between different metadata components are correctly established.

### Metadata completeness validation

Completeness of records is evaluated by:

- contains the required Minimal metadata elements (completeness according to SWR)
- contains the required elements endorsed by the adopted metadata standard itself 

Completeness according to SWR and completeness according to the adopted model results in quality indicators of a resource description.

### Metadata ETS/ATS checking

**Abstract Executable Test Suites (ATS)** define a set of abstract test cases or scenarios that describe the expected behaviour of metadata without specifying the implementation details. These test suites focus on the logical aspects of metadata validation and provide a high-level view of metadata validation requirements, enabling stakeholders to understand validation objectives and constraints without getting bogged down in technical details. They serve as a valuable communication and documentation tool, facilitating collaboration between metadata producers, consumers, and validators. ATS are often documented using natural language descriptions, diagrams, or formal specifications. They outline the expected inputs, outputs, and behaviours of the metadata under various conditions.

**Executable Test Suites (ETS)** are sets of tests designed according to ATS to perform the metadata validation. These tests are typically automated and can be run repeatedly to ensure consistent validation results. Executable test suites consist of scripts, programs, or software tools that perform various validation checks on metadata. These checks can include:

1. **Data Integrity:** Checking for inconsistencies or errors within the metadata. This includes identifying missing values, conflicting information, or data that does not align with predefined constraints.
2. **Standard Compliance:** Assessing whether the metadata complies with relevant industry standards, such as Dublin Core, MARC, or specific domain standards like those for scientific data or library cataloguing.
3. **Interoperability:** Evaluating the metadata's ability to interoperate with other systems or datasets. This involves ensuring that metadata elements are mapped correctly to facilitate data exchange and integration across different platforms.
4. **Versioning and Evolution:** Considering the evolution of metadata over time and ensuring that the validation process accommodates versioning requirements. This may involve tracking changes, backward compatibility, and migration strategies.
5. **Quality Assurance:** Assessing the overall quality of the metadata, including its accuracy, consistency, completeness, and relevance to the underlying data or information resources.
6. **Documentation:** Documenting the validation process itself, including any errors encountered, corrective actions taken, and recommendations for improving metadata quality in the future.

### Display validation results

TBD

## Technology

[Hale Connect](https://wetransform.to/haleconnect/){target=_blank}

- **User Guide:**: <https://help.wetransform.to/docs/getting-started/2018-04-28-quick-start>

<!--
Various technologies use dedicated mechanisms to validate inputs on type matching and completeness

- XML (Dublin core, iso19115, Datacite) validation - XSD schema, potentially extended with Schematron rules
- json (OGC API - Records/STAC) - json schema
- RDF (schema.org, dcat) - SHACL
-->

## Future work

- on-demand metadata validation, which would generate reports for user-uploaded metadata
- applicability of [ISO19157 Geographic Information – Data quality](https://www.iso.org/standard/78900.html) (i.e. the standard intended for data validations) for metadata-based validation reports.
- ETS for GloSIS are not existing and need to be configured
- [Shacl](https://www.w3.org/TR/shacl/){target=_blank} is is in general intended for semantic web related validations; however, it's exact scope will be determined during the SoilWise developments. 

<!--
## Data quality assurance

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
-->
