# Metadata validation at ingestion and after conflation

## Definition

A component (accessible as an API) which accepts a metadata record, identifies the format and model used, and validates the record, resulting in a quality indication of the record

## Background

Metadata is validated at ingestion against a set of rules. This allows SWR to log the completeness of ingested metadata during the processing of the record through Soilwise. Catalogues which capture metadata authored by data custodians typically have a wide range in metadata completion and accuracy. During processing SWR aims to extend the metadata of a resource by analysing the content, combine the metadata with information from other sources. After metadata processing this validation process can be repeated, to understand the value which has been added by SWR. To identify the individual ingested records which together form the final metadata, SWR needs to uniquely identify each ingested record by its identifier and the source from which it was imported.

The validation component comprises of the following functions:

1. [Metadata completeness validation](#metadata-completeness-validation)

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
