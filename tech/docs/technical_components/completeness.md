# Ingestion validation

Ingestion validation component comprises of the following functions:

1. [Metadata completeness validation](#metadata-completeness-validation)

## Metadata completeness validation

The completeness of the metadata will be evaluated according to an ISO19157 Geographic Information – Data quality and the official ISO19115 and ISO19119 XML schema definitions, including compliance with specified international standards.
Rule-based validation languages such as Schematron are foreseen to be used for pattern-matching validation, i.e., allowing the definition of patterns to match specific structures or data within the XML document. These patterns can be used to check for the presence or absence of certain elements, attributes, or values.