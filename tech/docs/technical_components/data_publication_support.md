# Data publication support

## Introduction
### Overview and Scope

At the moment, SoilWise supports data publishers with the following tools:

- [DOI Resolution Widget](#doi-resolution-widget)
- [Tabular Soil Data annotation](#tabular-soil-data-annotation)
- [INSPIRE Geopackage Transformation](#inspire-geopackage-transformation)
- [Soil Vocabulary Viewer](../knowledge_graph/#soil-voc-viewer), part of the Knowledge Graph component, visualizes and links different soil-domain vocabularies and terms.

## Intended Audience


## DOI Resolution Widget

!!! component-header "Info"

    **Current version:** 

    **Technology:** 

    **Project:** 

### Overview and Scope
### Key Features
### Architecture
#### Technological Stack
#### Main Sequence Diagram
### Integrations & Interfaces
### Key Architectural Decisions
### Risks & Limitations


## Tabular Soil Data annotation

!!! component-header "Info"

    **Current version:** 

    **Technology:** 

    **Project:** 

### Overview and Scope
### Key Features
### Architecture
#### Technological Stack
#### Main Sequence Diagram
### Integrations & Interfaces
### Key Architectural Decisions
### Risks & Limitations


## INSPIRE Geopackage Transformation

!!! component-header "Info"

    **Current version:** 

    **Technology:** 

    **Project:** 

### Overview and Scope
### Key Features
### User Manual
### Architecture
#### Technological Stack
#### Main Sequence Diagram
#### Database Design
### Integrations & Interfaces
### Key Architectural Decisions
### Risks & Limitations

## Other recommended tools acknowledged by SoilWise community

### Hale Studio

A proven ETL tool optimised for working with complex structured data, such as XML, relational databases, or a wide range of tabular formats. It supports all required procedures for semantic and structural transformation. It can also handle reprojection. While Hale Studio exists as a multi-platform interactive application, its capabilities can be provided through a web service with an OpenAPI.

### User Manual
A comprehensive tutorial video on [soil data harmonisation with hale studio can be found here](https://www.youtube.com/watch?v=U1lxzlUquE8&list=PLoyBfgUelhNOwA_GGkd4hSwDnwNhxGC87&index=3).

**Setting up a transformation process in hale»connect**

Complete the following steps to set up soil data transformation, validation and publication processes:

1. Log into hale»connect.
2. Create a new transformation project (or upload it).
3. Specify source and target schemas.
4. Create a theme (this is a process that describes what  should happen with the data).
5. Add a new transformation configuration. Note: Metadata generation can be configured in this step.
6. A validation process can be set up to check against conformance classes.

**Executing a transformation process**

1. Create a new dataset and select the theme of the current source data, and provide the source data file.
2. Execute the transformation process. ETF validation processes are also performed. If successful, a target dataset and the validation reports will be created.
3. View and download services will be created if required.

To create metadata (data set and service metadata), activate the corresponding button(s) when setting up the theme for the transformation process.

<!-- HERE'S FOR REFERENCE, THE PREVIOUS CONTENT
## Transformation and Harmonization

### Overview and Scope
These components make sure that data is interoperable, i.e. provided to agreed-upon formats, structures and semantics. They are used to ingest data and transform it into common standard data, e.g. in the central SWR format for soil.

The specific requirements these components have to fulfil are:

- The services shall be able to work with data that is described explicitly or implicitly with a schema. The services shall be able to load schemas expressed as XML Schemas, GML Application Schemas, RDF-S and JSON Schema.
- The services shall support GML, GeoPackage, GeoJSON, CSV, RDF and XSL formats for data sources.
- The services shall be able to connect with external download services such as WFS or OGC API, Features.
- The services shall be able to write out data in GML, GeoPackage, GeoJSON, CSV, RDF and XSL formats.
- There shall be an option to read and write data from relational databases.
- The services should be exposed as [OGC API Processes](https://ogcapi.ogc.org/processes/){target=_blank}

### Key Features
- Transformation processes shall include the following capabilities:
    - Rename types & attributes.
    - Convert between units of measurement.
    - Restructure data, e.g. through, joining, merging, splitting.
    - Map codelists and other coded values.
    - Harmonise observations as if they were measured using a common procedure using [Pedotransfer Functions](https://en.wikipedia.org/wiki/Pedotransfer_function){target=_blank}.
    - Reproject data.
    - Change data from one format to another.
- There should be an interactive editor to create the specific transformation processes required for the SWR.
- It should be possible to share transformation processes.
- Transformation processes should be fully documented or self-documented.

### Architecture
#### Technological Stack

|**[hale studio](https://github.com/halestudio/hale/){target=_blank}**|A proven ETL tool optimised for working with complex structured data, such as XML, relational databases, or a wide range of tabular formats. It supports all required procedures for semantic and structural transformation. It can also handle reprojection. While Hale Studio exists as a multi-platform interactive application, its capabilities can be provided through a web service with an OpenAPI.|
|**[GDAL](https://gdal.org/index.html){target=_blank}**|A very robust conversion library used in most FOSS and commercial GIS software, can be used for  a wealth of format conversions and can handle reprojection. In cases where no structural or semantic transformation is needed, a GDAL-based conversion service would make sense.|
-->