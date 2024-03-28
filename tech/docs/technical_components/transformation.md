# Transformation Component - Hale Studio (WE)


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


### Codelist mapping (WE, ISRIC, WR)

- Hale Studio has a codelist mapping tool
- The skos ontology allows to map terms between code lists using SameAs relations (as part of Triple store)