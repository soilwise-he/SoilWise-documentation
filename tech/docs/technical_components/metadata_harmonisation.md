# Metadata harmonisation

The component harmonizes the content as imported by the [ingestion component](./ingestion.md).
A database is populated with the harmonised metadata content

Ingested records are retrieved from harvest.items table and processed. If the processing is successfull, 
the record is logged to records-processed table (so it won't be processed again). If processing fails, it is logged to records_failed table.

Harmonisation is based on the [pygeometa library](https://github.com/geopython/pygeometa), which is able to identify a number of metadata schema's. If a source returns data in a non
identified schema, the source data needs to be converted to a known schema before processing by metadata harminisation.

| Supported schemas | |
| --- | --- |
| iso19115-2003 | |  
| iso19115-1-2014 | |
| Dublin Core | |
| schema.org | |
| DCAT | |
| OpenAire (DataCite) | |
| OGCAPI-Records | |
| STAC | |

The harmonised metadata is modelled into a relational database. 
