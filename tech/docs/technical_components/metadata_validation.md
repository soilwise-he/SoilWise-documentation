# Metadata validation

!!! component-header "Important Links"
    :fontawesome-brands-github: Project: [Metadata validation](https://github.com/orgs/soilwise-he/projects/5)

<!--
Metadata is validated at ingestion against a set of rules. This allows SWR to log the completeness of ingested metadata during the processing of the record through Soilwise. Catalogues which capture metadata authored by data custodians typically have a wide range in metadata completion and accuracy. During processing SWR aims to extend the metadata of a resource by analysing the content, combine the metadata with information from other sources. After metadata processing this validation process can be repeated, to understand the value which has been added by SWR. To identify the individual ingested records which together form the final metadata, SWR needs to uniquely identify each ingested record by its identifier and the source from which it was imported.
-->

## Metadata completeness validation

Completeness of records can be evaluated by:

- contains the required and/or advised metadata elements of SWR
- contains the required elements endorsed by the adopted metadata standard itself 

### Metodology

Various technologies use dedicated mechanisms to validate inputs on type matching and completeness

- XML (Dublin core, iso19115, Datacite) validation - XSD schema, potentially extended with Schematron rules
- json (OGC API - Records/STAC) - json schema
- RDF (schema.org, dcat) - SHACL

[ISO19157 Geographic Information – Data quality](https://www.iso.org/standard/78900.html) offers a model to express the quality of (meta)data. 

### Goal

Completeness accorging to SWR and completeness according to adopted model result in quality indicators of a resource description.

## Metadata conformance evaluation

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
