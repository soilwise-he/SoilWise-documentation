# Metadata Validation

## Introduction

> Metadata should help users assess the usability of a data set for their own purposes and help users to understand their quality.
> Assessing the quality of metadata may guide the stakeholders in future governance of the system.  

### Overview and Scope
In terms of metadata, SoilWise Catalogue aims for an approach that balances harvesting between quantity and quality. See for more information in the [Harvester Component](ingestion.md). Catalogues which capture metadata authored by various data communities typically have a wide range of metadata completeness and accuracy. Therefore, the SoilWise Catalogue employs metadata validation mechanisms to provide additional information about metadata completeness, conformance and integrity. Information resulting from the validation process is stored together with each metadata record in a relational database and updated whenever a new metadata version is registered. Within the first iteration, they are not displayed in the [SoilWise Catalogue](catalogue.md).

On this topic, 3 components are available, which monitor aspects of metadata

- [Metadata INSPIRE compliance](#metadata-inspire-compliance) checks the conformity to the INSPIRE regulation
- [Metadata completeness](#metadata-completeness) calculates a score based on selected populated metadata properties
- [Link Liveliness Assessment](../metadata_augmentation/#link-liveliness-assessment) part of the Metadata Augmentation components, validates the availability of resources described by the record 

### Intended Audience

The SoilWise Metadata Validation targets the following user groups:

- **JRC data analysts** monitoring the metadata quality of published soil-related datasets.

## Metadata INSPIRE compliance

!!! component-header "Info"
    **Current version:** 1.0.0

    **Technology:** [Esdin Test Framework (ETF)](https://etf-validator.net/), Python

    **Release:** TBD

    **Project repository:** [Metadata validator](https://inspire.ec.europa.eu/validator/home/index.html)

    **Access point:** [Data and Knowledge Administration Console](admin_console.md)

### Overview and Scope
Compliance with a given standard is an indicator of (meta)data quality. This indicator is measured using datasets that claim to conform to the INSPIRE regulation. 

This component uses the [INSPIRE Reference Validator](https://inspire.ec.europa.eu/validator/home/index.html), which is based on INSPIRE ATS and available as a validation service. 

Regarding the INSPIRE validation, all metadata records with the source property value equal to INSPIRE are validated against the INSPIRE validation. Metadata is stored in the PostgreSQL database. This validation is performed on non-augmented, non-harmonised metadata records. The observed indicator is stored on the augmentation table. In January 2026, a total of 969 records were validated, of which 256 were fully valid against all test suites.

### Key Features

- automatic run of standardised validation tests for all INSPIRE resources
- generation of detailed structured validation reports

### Architecture

In this case, the INSPIRE Metadata validator, in dockerized form, is deployed to the server using the `docker-compose.yml` file. All desired INSPIRE Executable Test Suites shall be included in the container and extracted to the ~/etf folder.

The Esdin Test Framework (ETF) is used combined with metadata validation rules from the INSPIRE community. With INSPIRE ETF Validator set up and running, and the database updated with a script that adds two new tables for validation outputs and two columns in the `items` table to indicate when each record was validated, the variables were set up in the validation script. It contains credentials to connect to the database and a selection of test suites for datasets and metadata records for services. The script validates only records that have been updated since the last validation (this makes it faster for recurrent validation). The first run validates all records. 

### Database Design
The validation output includes the validation timestamp and its result (true or false). Then, for each validated metadata record, there is a new record inserted into the table `validation_runs` with run id, metadata record identifier, status of validation, timestamp, report in JSON, and report in HTML. Results of each individual test suite are stored in the table `validation_suite_results`. For every metadata record, there is a validation result of each test suite that was run.

#### Technologies Stack

The methodology of INSPIRE ATS/ETS is used in the case of INSPIRE validation.

**INSPIRE Abstract Test Suites (ATS)** provides  the conceptual, non-executable test requirements to verify that spatial data sets and network services conform to the INSPIRE technical guidelines. They define test cases for data interoperability and services, often implemented alongside Executable Test Suites (ETS) in the Inspire validator, with a focus on data structure and metadata requirements.

**Executable Test Suites (ETS)** are sets of tests designed according to ATS to perform the metadata validation. These tests are typically automated and can be run repeatedly to ensure consistent validation results. Executable test suites consist of scripts, programs, or software tools that perform various validation checks on metadata. The Python scripts define which tests are run for datasets and series metadata. The default test runs are listed in the table below.

|Test Name|Dataset Metadata|Services Metadata|
|----------|----------|----------|
|Common Requirements for ISO/TC 19139:2007 based INSPIRE metadata records.|&check;|&check;|
|Conformance Class 1: INSPIRE data sets and data set series baseline metadata.|&check;||
|Conformance Class 2: INSPIRE data sets and data set series interoperability metadata.|&check;||
|Conformance Class 2b: INSPIRE data sets and data set series metadata for Monitoring.|&check;||
|Conformance Class 3: INSPIRE Spatial Data Service baseline metadata.||&check;|
|Conformance Class 4: INSPIRE Network Services metadata.||&check;|
|Conformance Class 4b: INSPIRE Network Services metadata for Monitoring.||&check;|
|Conformance Class 8: INSPIRE data sets and data set series linked service metadata.|&check;||


**Executable Test Framework (ETF)** is the software platform that runs ETS tests.

|Technology|Description|
|----------|-----------|
|**Python**|Used for validation orchestration.|
|**Esdin Test Framework**|Opensource validation framework, commonly used in INSPIRE.|
|**[PostgreSQL](https://www.postgresql.org/)**|Primary database for storing and managing validation results.|


## Metadata completeness

!!! component-header "Info"
    **Current version:** 0.2.0

    **Technology**: Python

    **Project repository:** [Metadata validator](https://github.com/soilwise-he/metadata-validator)

### Overview and Scope
The software calculates a level of completeness of a record, indicated in % of 100 for endorsed properties, considering that some properties are conditional based on selected values in other properties.

Completeness is evaluated against a set of metadata elements for each harmonised metadata record in the SWC platform. Records for which harmonisation fails are not evaluated (nor imported).

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

### Technological stacks

**Abstract Test Suites (ATS)** define a set of abstract test cases or scenarios that describe the expected behaviour of metadata without specifying the implementation details. These test suites focus on the logical aspects of metadata validation and provide a high-level view of metadata validation requirements, enabling stakeholders to understand validation objectives and constraints without getting bogged down in technical details. They serve as valuable communication and documentation tools, facilitating collaboration among metadata producers, consumers, and validators. ATS are often documented using natural language descriptions, diagrams, or formal specifications. They outline the expected inputs, outputs, and behaviours of the metadata under various conditions.

The SWC ATS is under development at <https://github.com/soilwise-he/metadata-validator/blob/main/docs/abstract_test_suite.md>

**Executable Test Suites (ETS)** are sets of tests designed according to ATS to perform the metadata validation. These tests are typically automated and can be run repeatedly to ensure consistent validation results. Executable test suites consist of scripts, programs, or software tools that perform various validation checks on metadata. These checks can include:

1. **Data Integrity:** Checking for inconsistencies or errors within the metadata. This includes identifying missing values, conflicting information, or data that does not align with predefined constraints.
2. **Standard Compliance:** Assessing whether the metadata complies with relevant industry standards, such as Dublin Core, MARC, or specific domain standards like those for scientific data or library cataloguing.
3. **Interoperability:** Evaluating the metadata's ability to interoperate with other systems or datasets. This involves ensuring that metadata elements are mapped correctly to facilitate data exchange and integration across different platforms.
4. **Versioning and Evolution:** Considering the evolution of metadata over time and ensuring that the validation process accommodates versioning requirements. This may involve tracking changes, backward compatibility, and migration strategies.
5. **Quality Assurance:** Assessing the overall quality of the metadata, including its accuracy, consistency, completeness, and relevance to the underlying data or information resources.
6. **Documentation:** Documenting the validation process itself, including any errors encountered, corrective actions taken, and recommendations for improving metadata quality in the future.

ETS is currently implemented through the Hale Connect instance and as a locally running prototype of the GeoNetwork instance.

### Database Design
Results of metadata validation are stored on a PostgreSQL database, the table is called validation in the schema validation.

Validation runs weekly as part of the CI/CD pipeline for records that have not been validated for 2 weeks. This builds up a history to understand validation results over time (consider that both changes in records and the ETS itself may cause differences in scores).


## Integrations & Interfaces

Metadata validation results are displayed in the [Data and Knowledge Administration Console](admin_console.md).
