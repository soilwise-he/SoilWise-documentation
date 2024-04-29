# Metadata validation

!!! component-header "Important Links"
    :fontawesome-brands-github: Project: [Metadata validation](https://github.com/orgs/soilwise-he/projects/5)


In terms of metadata, SoilWise Repository aims for the approach to harvest and register as much as possible (see more information in the [Harvester Component](ingestion.md)). Catalogues which capture metadata authored by data custodians typically have a wide range of metadata completion and accuracy. Therefore, the SoilWise Repository aims to employ metadata validation mechanisms to provide additional information about metadata completeness, conformance and integrity. Information resulting from the validation process are aimed to be stored together with each metadata record in a relation database and updated after registering a new metadata version. After metadata processing and extension (see the [Interlinker component](interlinker.md)), this validation process can be repeated to understand the value which has been added by SWR.

The metadata validation component comprises the following functions:

- [Data structure validation](#data-structure-validation)
- [Metadata completeness check](#metadata-completeness-validation)
- [Metadata ETS checking](#metadata-ets-checking)
- [Shacl](#shacl)

In the next iterations, SoilWise will explore the utilization of on-demand metadata validation, which would generate reports for user-uploaded metadata.

## Metadata structure validation

The initial steps of metadata validation, foreseen so far, comprise:

1. **Markup (Syntax) Check:** Verifying that the metadata adheres to the specified syntax rules. This includes checking for allowed tags, correct data types, character encoding, and adherence to naming conventions.
2. **Schema (DTD) Validation:** Ensuring that the metadata conforms to the defined schema or metadata model. This involves verifying that all required elements are present, and relationships between different metadata components are correctly established.

## Metadata completeness validation

Completeness of records can be evaluated by:

- contains the required and/or advised metadata elements of SWR
- contains the required elements endorsed by the adopted metadata standard itself 

Completeness according to SWR and completeness according to the adopted model results in quality indicators of a resource description.

### Methodology

Various technologies use dedicated mechanisms to validate inputs on type matching and completeness

- XML (Dublin core, iso19115, Datacite) validation - XSD schema, potentially extended with Schematron rules
- json (OGC API - Records/STAC) - json schema
- RDF (schema.org, dcat) - SHACL

We will explore applicability of [ISO19157 Geographic Information – Data quality](https://www.iso.org/standard/78900.html) (i.e. the standard intended for data validations) for metadata-based validation reports.

## Metadata ETS/ATS checking

**Abstract Executable Test Suites (ATS)** define a set of abstract test cases or scenarios that describe the expected behaviour of metadata without specifying the implementation details. These test suites focus on the logical aspects of metadata validation and provide a high-level view of metadata validation requirements, enabling stakeholders to understand validation objectives and constraints without getting bogged down in technical details. They serve as a valuable communication and documentation tool, facilitating collaboration between metadata producers, consumers, and validators. ATS are often documented using natural language descriptions, diagrams, or formal specifications. They outline the expected inputs, outputs, and behaviours of the metadata under various conditions.

**Example:** [INSPIRE ATS for Soil](https://inspire-mif.github.io/technical-guidelines/data/so/dataspecification_so.pdf){target=_blank} (see Annex A) 

**Executable Test Suites (ETS)** are sets of tests designed according to ATS to perform the metadata validation. These tests are typically automated and can be run repeatedly to ensure consistent validation results. Executable test suites consist of scripts, programs, or software tools that perform various validation checks on metadata. These checks can include:

1. **Data Integrity:** Checking for inconsistencies or errors within the metadata. This includes identifying missing values, conflicting information, or data that does not align with predefined constraints.
2. **Standard Compliance:** Assessing whether the metadata complies with relevant industry standards, such as Dublin Core, MARC, or specific domain standards like those for scientific data or library cataloguing.
3. **Interoperability:** Evaluating the metadata's ability to interoperate with other systems or datasets. This involves ensuring that metadata elements are mapped correctly to facilitate data exchange and integration across different platforms.
4. **Versioning and Evolution:** Considering the evolution of metadata over time and ensuring that the validation process accommodates versioning requirements. This may involve tracking changes, backward compatibility, and migration strategies.
5. **Quality Assurance:** Assessing the overall quality of the metadata, including its accuracy, consistency, completeness, and relevance to the underlying data or information resources.
6. **Documentation:** Documenting the validation process itself, including any errors encountered, corrective actions taken, and recommendations for improving metadata quality in the future.


**Example:** [INSPIRE ETS validator](https://inspire.ec.europa.eu/validator/home/index.html){target=_blank}

### Open issues

- ETS for GloSIS are not existing and need to be configured

## Shacl

[Shacl](https://www.w3.org/TR/shacl/){target=_blank} is is in general intended for semantic web related validations; however, it's exact scope will be determined during the SoilWise developments. 

## Technology

- [Schematron](https://schematron.com/){target=_blank}
- [INSPIRE ETS validator](https://inspire.ec.europa.eu/validator/home/index.html){target=_blank}
- [Shacl](https://www.w3.org/TR/shacl/){target=_blank}
- [Hale Connect](https://wetransform.to/haleconnect/){target=_blank}

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
