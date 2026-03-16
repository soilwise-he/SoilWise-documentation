# Metadata Validation

## Introduction

> Metadata should help users assess the usability of a data set for their own purposes and help users to understand their quality.
> Assessing the quality of metadata may guide the stakeholders in future governance of the system.  

### Overview and Scope
In terms of metadata, SoilWise Repository aims for the approach to balance harvesting between quantity and quality. See for more information in the [Harvester Component](ingestion.md). Catalogues which capture metadata authored by various data communities typically have a wide range of metadata completion and accuracy. Therefore, the SoilWise Repository employs metadata validation mechanisms to provide additional information about metadata completeness, conformance and integrity. Information resulting from the validation process are stored together with each metadata record in a relation database and updated after registering a new metadata version. Within the first iteration, they are not displayed in the [SoilWise Catalogue](catalogue.md).

On this topic 2 components are available which monitor aspects of metadata

- [Metadata completeness](#metadata-completeness) calculates a score based on selected populated metadata properties
- [Metadata INSPIRE compliance](#metadata-inspire-compliance)
- [Link Liveliness Assessment](../metadata_augmentation/#link-liveliness-assessment) part of Metadata Augmentation components, validates the availability of resources described by the record 

### Intended Audience

The SoilWise Metadata Validation targets the following user groups:

- **JRC data analysts** monitoring the metadata quality of published soil-related datasets.

## Metadata INSPIRE compliance

!!! component-header "Info"
    **Current version:** 0.2.0

    **Technology**: [Esdin Test Framework (ETF)](https://etf-validator.net/), Python

    **Project:** [Metadata validator](https://inspire.ec.europa.eu/validator/home/index.html)

    **Access point:** Postgres database

Compliance to a given standard is an indicator for (meta)data quality. This indicator is measured on datasets claiming to confirm to the INSPIRE regulation. This validation is performed on non augmented, non harmonised metadata records. The observed indicator is stored on the augmentation table. 

Regarding the INSPIRE validation, all metadata records with the source property value equal to INSPIRE are validated against INSPIRE validation. Metadata are stored in the PostgreSQL database.

For this case, the [INSPIRE Reference Validator](https://inspire.ec.europa.eu/validator/home/index.html) is used. Validator is based on INSPIRE ATS and is available as a validation service. INSPIRE Metadata validator in the dockerized form is deployed at the server using the `docker-compose.yml` file. All desired INSPIRE  Executable Test Suited shall be part of the container and are extracted to the ~/etf folder.

The Esdin Test Framework (ETF) is used combined with metadata validation rules from the INSPIRE community. With INSPIRE ETF Validator set up and running and the database updated with script that adds two new tables for validation outputs and two columns into `items` table to determine if and when was each record validated, the variables were set up in the validation script. It contains credentials to connect to the database and selection of test suites for datasets and services metadata records. The script validates only those records, that have been updated since last validation (this makes it faster for recurrent validation). The first run validates all records. 

The validation output contains timestamp of the validation and its result (true or false). Then, for each validated metadata recors, there is a new record inserted into the table `validation_runs` with run id, metadata record identifier, status of validation, timestamp, report in json and report in html. Results of each individual test suite are stored in the table `validation_suite_results`. For every metadata record, there is validation result of each test suite that was ran.

In January 2026, altogether 969 records were validated, as 256 of them were completele valid against all test suites.

### Architecture
#### Technologies Stack

The methodology of ETS/ATS is used to develop validation tests.

**Abstract Executable Test Suites (ATS)** define a set of abstract test cases or scenarios that describe the expected behaviour of metadata without specifying the implementation details. These test suites focus on the logical aspects of metadata validation and provide a high-level view of metadata validation requirements, enabling stakeholders to understand validation objectives and constraints without getting bogged down in technical details. They serve as a valuable communication and documentation tool, facilitating collaboration between metadata producers, consumers, and validators. ATS are often documented using natural language descriptions, diagrams, or formal specifications. They outline the expected inputs, outputs, and behaviours of the metadata under various conditions.

**Executable Test Suites (ETS)** are sets of tests designed according to ATS to perform the metadata validation. These tests are typically automated and can be run repeatedly to ensure consistent validation results. Executable test suites consist of scripts, programs, or software tools that perform various validation checks on metadata.

**Executable Test Framework (ETF)** is the software platform that runs ETS tests.

|Technology|Description|
|----------|-----------|
|**Python**|Used for validation orchestration.|
|**Esdin Test Framework**|Opensource validation framework, commonly used in INSPIRE.|
|**[PostgreSQL](https://www.postgresql.org/)**|Primary database for storing and managing validation results.|

### Database Design
Results of metadata validation are stored on PostgreSQL database, table is called validation in a schema validation.

Validation runs every week as a CI-CD pipeline on records which have not been validated for 2 weeks. This builds up a history to understand validation results over time (consider that both changes in records, as well as the ETS itself may cause differences in score).

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

### Architecture
#### Technologies Stack


## Integrations & Interfaces

Metadata validation results are displayed in the [Data & Knowledge Administration Console](admin_console.md).