# Metadata Validation

> Metadata should help users assess the usability of a data set for their own purposes and help users to understand their quality.
> Assessing the quality of metadata may guide the stakeholders in future governance of the system.  

In terms of metadata, SoilWise Repository aims for the approach to balance harvesting between quantity and quality. See for more information in the [Harvester Component](ingestion.md). Catalogues which capture metadata authored by various data communities typically have a wide range of metadata completion and accuracy. Therefore, the SoilWise Repository employs metadata validation mechanisms to provide additional information about metadata completeness, conformance and integrity. Information resulting from the validation process are stored together with each metadata record in a relation database and updated after registering a new metadata version. Within the first iteration, they are not displayed in the [SoilWise Catalogue](catalogue.md).


## Minimal metadata elements

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


## Functionality

### Metadata validation

!!! component-header "Info"
    **Current version:** 0.2.0

    **Project:** [Metadata validator](https://github.com/soilwise-he/metadata-validator)

    **Access point:** not available yet

#### Metadata structure validation

Before validation, metadata is harmonized to a common model. If harmonization fails for some reason, the record is not ingested and validated.
The error is logged, so an administrator is able to follow up.

#### Metadata completeness indication

The indication calculates a level of completeness of a record, indicated in % of 100 for endorsed properties, considering that some properties are conditional based on selected values in other properties.

#### Metadata ETS/ATS checking

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

ETS is implemented as a [python module](https://github.com/soilwise-he/metadata-validator/blob/main/src) which is triggered from a CI-CD pipeline. 

#### Technology & Integration

Results of metadata validation will be available via an API, which is under development. The API will require authorisation to access it.

#### Future work

- Extend the ATS to JRC and user needs.
- Extend ETS based on ATS
