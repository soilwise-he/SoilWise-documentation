# Interoperability (ETL)

- Describe the source dataset model in detail so ETL is facilitated (for example iso19110 or XSD or OWL)
- Prepare & share a transformation pattern so any potential user can trigger/adjust the transformation (also helps to understand the source model), allow feedback/contributions to the transformation pattern (Hale Studio, rml.io/yarrrml, csv-ld)
- Extract data from a dedicated format (many) to a selected format (GDAL) for example as [OGCAPI Processes](https://ogcapi.ogc.org/processes/), Nice to have: enable subsetting the dataset to a region of interest 
- Transform from source to target model using transformation pattern 
  - Standardise object & attribute names/types/units
  - Map attribute values to codelist values from selected taxonomies
  - Harmonise observations as if they were measured using a common procedure using [PTF](https://en.wikipedia.org/wiki/Pedotransfer_function) 
- Load transformed data to a shared database

- Restructure data to common repo structures + semantics
- Write out in common repo format
- Only for priority (meta)data, majority will be linked, stored elsewhere

- connections with: external data sources (API, files, DBs), storage, workflows (automation)
- technologies used: Hale, FME, gdal, rml.io/yarrrml, tarql, stetl
- responsible person: We Transform
- participating: Tomas Reznik, Paul van Genuchten, Luís de Sousa, Anna Fensel, Nick Berkvens

## INSPIRE interoperability aligner
