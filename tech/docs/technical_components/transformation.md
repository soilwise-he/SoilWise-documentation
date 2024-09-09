# Transformation and Harmonisation

!!! component-header "Info"

    **Current version:**

    **Project:** [Hale Studio](https://github.com/halestudio/hale)

These components make sure that data is interoperable, i.e. provided to agreed-upon formats, structures and semantics. They are used to ingest data and transform it into common standard data, e.g. in the central SWR format for soil health.

The specific requirements these components have to fulfil are:

- The services shall be able to work with data that is described explicitly or implicitly with a schema. The services shall be able to load schemas expressed as XML Schemas, GML Application Schemas, RDF-S and JSON Schema.
- The services shall support GML, GeoPackage, GeoJSON, CSV, RDF and XSL formats for data sources.
- The services shall be able to connect with external download services such as WFS or OGC API, Features.
- The services shall be able to write out data in GML, GeoPackage, GeoJSON, CSV, RDF and XSL formats.
- There shall be an option to read and write data from relational databases.
- The services should be exposed as [OGC API Processes](https://ogcapi.ogc.org/processes/){target=_blank}
- Transformation processes shall include the following capabilities:
    - Rename types & attributes
    - Convert between units of measurement
    - Restructure data, e.g. through, joining, merging, splitting
    - Map codelists and other coded values
    - Harmonise observations as if they were measured using a common procedure using [PTF](https://en.wikipedia.org/wiki/Pedotransfer_function){target=_blank}.
    - Reproject data
    - Change data from one format to another
- There should be an interactive editor to create the specific transformation processes required for the SWR.
- It should be possible to share transformation processes.
- Transformation processes should be fully documented or self-documented.

## Technology & Integration

We plan to deploy the needed capabilities to the SWR using two technologies:

- [GDAL](https://gdal.org/index.html){target=_blank} is a very robust conversion library used in most FOSS and commercial GIS software. It provides a wealth of format conversions and can handle reprojection. In cases where no structural or semantic transformation is needed, a GDAL-based conversion service would make sense. 
- [hale studio](https://github.com/halestudio/hale/){target=_blank} is a proven ETL tool optimised for working with complex structured data, such as XML, relational databases, or a wide range of tabular formats. It supports all required procedures for semantic and structural transformation. It can also handle reprojection. While Hale Studio exists as a multi-platform interactive application, its capabilities can be provided through a web service with an OpenAPI.

In some cases, the two services may be chained in a single workflow.
