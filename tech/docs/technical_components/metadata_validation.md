# Metadata Validation

> Metadata should help users assess the usability of a data set for their own purposes and help users to understand their quality.
> Assessing the quality of metadata may guide the stakeholders in future governance of the system.  

In terms of metadata, SoilWise Repository aims for the approach to balance harvesting between quantity and quality. See for more information in the [Harvester Component](ingestion.md). Catalogues which capture metadata authored by various data communities typically have a wide range of metadata completion and accuracy. Therefore, the SoilWise Repository employs metadata validation mechanisms to provide additional information about metadata completeness, conformance and integrity. Information resulting from the validation process are stored together with each metadata record in a relation database and updated after registering a new metadata version. Within the first iteration, they are not displayed in the [SoilWise Catalogue](catalogue.md).

On this topic 2 components are available which monitor aspects of metadata


- [Metadata completeness](#metadata-completeness) calculates a score based on selected populated metadata properties
- [Metadata INSPIRE compliance](#metadata-compliance)
- [Link liveliness assessment](../metadata_augmentation/#link-liveliness-assessment) part of Metadata Augmentation components, validates the availability of resources described by the record 


## Metadata completeness

!!! component-header "Info"
    **Current version:** 0.2.0

    **Technology**: Python

    **Project:** [Metadata validator](https://github.com/soilwise-he/metadata-validator)

    **Access point:** Postgres database

The software calculates a level of completeness of a record, indicated in % of 100 for endorsed properties, considering that some properties are conditional based on selected values in other properties.

Completeness is evaluated against a set of metadata elements for each harmonized metadata record in the SWR platform. Records for which harmonisation fails are not evaluated (nor imported).

| Label | Description | Score |
| ---   | ---         | ---   |
| Identification | Unique identification of the dataset (A UUID, URN, or URI, such as DOI) | 10 |
| Title | Short meaningful title | 20 |
| Abstract | Short description or abstract (1/2 page), can include (multiple) scientific/technical references | 20 |
| Author/Organisation | An entity responsible for the resource (e.g. person or organisation) | 20 |
| Date | Last update date | 10 |
| Type | The nature of the content of the resource | 10 |
| Rights | Information about rights and licences | 10 |
| Extent (geographic) | Geographical coverage (e.g. EU, EU & Balkan, France, Wallonia, Berlin) | 5 |
| Extent (temporal) | Temporal coverage | 5 |

### Metadata ETS/ATS checking

The methodology of ETS/ATS has been suggested to develop validation tests.

**Abstract Executable Test Suites (ATS)** define a set of abstract test cases or scenarios that describe the expected behaviour of metadata without specifying the implementation details. These test suites focus on the logical aspects of metadata validation and provide a high-level view of metadata validation requirements, enabling stakeholders to understand validation objectives and constraints without getting bogged down in technical details. They serve as a valuable communication and documentation tool, facilitating collaboration between metadata producers, consumers, and validators. ATS are often documented using natural language descriptions, diagrams, or formal specifications. They outline the expected inputs, outputs, and behaviours of the metadata under various conditions.

The SWR ATS is under development at <https://github.com/soilwise-he/metadata-validator/blob/main/docs/abstract_test_suite.md>

**Executable Test Suites (ETS)** are sets of tests designed according to ATS to perform the metadata validation. These tests are typically automated and can be run repeatedly to ensure consistent validation results. Executable test suites consist of scripts, programs, or software tools that perform various validation checks on metadata. These checks can include:

1. **Data Integrity:** Checking for inconsistencies or errors within the metadata. This includes identifying missing values, conflicting information, or data that does not align with predefined constraints.
2. **Standard Compliance:** Assessing whether the metadata complies with relevant industry standards, such as Dublin Core, MARC, or specific domain standards like those for scientific data or library cataloguing.
3. **Interoperability:** Evaluating the metadata's ability to interoperate with other systems or datasets. This involves ensuring that metadata elements are mapped correctly to facilitate data exchange and integration across different platforms.
4. **Versioning and Evolution:** Considering the evolution of metadata over time and ensuring that the validation process accommodates versioning requirements. This may involve tracking changes, backward compatibility, and migration strategies.
5. **Quality Assurance:** Assessing the overall quality of the metadata, including its accuracy, consistency, completeness, and relevance to the underlying data or information resources.
6. **Documentation:** Documenting the validation process itself, including any errors encountered, corrective actions taken, and recommendations for improving metadata quality in the future.

ETS is currently implemented through Hale Connect instance and as a locally running prototype of GeoNetwork instance.

## Metadata INSPIRE compliance

!!! component-header "Info"
    **Current version:** 0.2.0

    **Technology**: [Esdin Test Framework (ETF)](https://etf-validator.net/), Python

    **Project:** [Metadata validator](https://inspire.ec.europa.eu/validator/home/index.html)

    **Access point:** Postgres database

Compliance to a given standard is an indicator for (meta)data quality. This indicator is measured on datasets claiming to confirm to the INSPIRE regulation. This validation is performed on non augmented, non harmonised metadata records. The observed indicator is stored on the augmentation table. The Esdin Test Framework is used combined with metadata validation rules from the INSPIRE community. 

Regarding the INSPIRE validation, all metadata records with the source property value equal to INSPIRE are validated against INSPIRE validation. In total 506 metadata records were harvested from the INSPIRE Geoportal. 

For this case, the [INSPIRE Reference Validator](https://inspire.ec.europa.eu/validator/home/index.html){target=_blank} was used. Validator is based on INSPIRE ATS and is available as a validation service. For the initial validation, INSPIRE metadata were harvested to the local instance of GeoNetwork, which allows on the fly validation of metadata using external validation services (including INSPIRE Reference Validator). Metadata were dowloaded from the PostgreSQL database and uploaded to the local instance of GeoNetwork, where the XML validation and INSPIRE validation were executed. Two validation runs were executed: one to check consistency of metadata using XSD and Schematron (using templates for ISO 19115 standard for spatial data sets and ISO 19119 standard for services), the second for validation of metadata records using INSPIRE ETS.

The results of the validation based on **XSD and Schematron consistency** are:

| Records type| Records count (24. 2. 2025) | Records count (31. 8. 2025)|
| ---         | ---           | ---           
| Records to process | 509 | 1016 |
| Records processed | 509 | 1016 |
| Records unchanged | 0 | 0 |
| Records not found | 0 | 0 |
| Records with errors(s) | 487 | 969 |
| Records with process not defined in their standard |  |  |
| Not editable records | 0 | 0 |

Most errors here are due to the Schematron validation.

**INSPIRE validation** results are:

| Records type| Records count (24. 2. 2025) | Records count (31. 8. 2025)|
| ---         | ---           | ---          
| Valid records | 402 | 832 |
| Invalid records | 98 | 175 |
| No rule applies | 5 | 0 |
| Unknown | 4 | 9 |

Confusion in the number of records in february 2025 is caused by the need of creating templates for metadata in GeoNetwork, 5 records from the catalogue are actually metadata templates: (1) one template for the feature catalogue, (2) one template for vector data, (3) one template for geographical data, (4) one template for map and (5) one template for service. Moreover, in two cases, the harvested metadata records have duplicate UUID, therefore they were unified into two records (instead of four).

### Technology

   * **Python**
        Used for the linkchecker integration, API development, and database interactions
   * **[PostgreSQL](https://www.postgresql.org/){target=_blank}**
        Primary database for storing and managing link information
   * **CI/CD**
        Automated pipeline for continuous integration and deployment, with scheduled weekly runs for link liveliness assessment
   * **Esdin Test Framework**
        Opensource validation framework, commonly used in INSPIRE.
     
Results of metadata validation are stored on PostgreSQL database, table is called validation in a schema validation.

| identifier | Score | Date |
| --- | --- | --- |
| abc-123-cba | 60 | 2025-01-20T12:20:10Z

Validation runs every week as a CI-CD pipeline on records which have not been validated for 2 weeks. This builds up a history to understand validation results over time (consider that both changes in records, as well as the ETS itself may cause differences in score).