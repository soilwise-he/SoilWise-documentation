# Data preview & download APIs

The API-based (soil) data publication has been chosen as a key channel of the SWR to satisfy user needs in terms of data download & export. So far, the following APIs were selected to be verified in terms of their implementation and usability to SoilWise stakeholders.

## Foreseen functionality

- Dataset download, no matter its format or data model.
- Export of a subset of a dataset in various forms, including, e.g. feature collection, tiles or a zone in a gridded coverage.
- Export a collection of datasets or their parts, the most typically a mosaic combining several satellite images.

## Data preview APIs

Support the discovery and query operations of an API that provides access to electronic maps in a manner independent of the underlying data store:

- Non geographical resources
    - Resources such as PDF, SQlite, Excel, CSV would benefit from an API which will read the remote file and return a section of the file in a common format, for the user interface to display it (or a summary provided by a LLM).
- Geographical resources (benefitting from a map view)
    - The [OGC Web Map Service (WMS aka ISO 19123)](https://portal.ogc.org/files/?artifact_id=14416https://ogcapi.ogc.org/maps/){target=_blank} supports requests for map images (and other formats) generated from geographical data,
    - The [OGC API - Maps](https://ogcapi.ogc.org/maps/){target=_blank} supports a REST API that can serve spatially referenced electronic maps, whether static or dynamically rendered, independently of the underlying data store. Note that this standard has not been approved yet; further development may still occur.
    - The [OGC Web Map Tile Service (WMTS)](https://portal.ogc.org/files/?artifact_id=35326){target=_blank} supports serving map tiles of spatially referenced data using tile images with predefined content, extent, and resolution.
    - The [OGC API - Tiles](https://ogcapi.ogc.org/tiles/){target=_blank} supports in the form of a REST API that defines building blocks for creating Web APIs that support retrieving geospatial information as tiles. Different forms of geospatial information are supported, such as tiles of vector features (“vector tiles”), coverages, maps (or imagery) and other types of geospatial information.


## Data download APIs

In order to monitor the usage of datasets downloaded from federated sources, it could be relevant to introduce a reverse proxy for those remote sources. This api would count the download and then forward the user to that resource.

Also see the section on [Knowledge extraction](./knowledge-extraction.md)

In some cases it is relevant not to guide the user to the remote source but let Soilwise do some preprocessing (filtering, reformatting, reprojection) and provide a more tailored answer to the user question. Similar needs may exist for resources which are hosted from within the SWR.

Various tools exist which provide standardised APIs on various data sources. The following API's offer the functionality described above.

- For non geographical data
    - GraphQL
    - SPARQL
    - OpenAPI
- For geograpical data
    - For vector data
        - the [OGC Web Feature Service (WFS aka ISO 19142)](https://portal.ogc.org/files/?artifact_id=39967){target=_blank} supports requests for geographical feature data (with vector geometry and attributes)s,
        - the [OGC API – Features](https://ogcapi.ogc.org/features/){target=_blank} supports in the form of a REST API the capability to create, modify, and query spatial data on the Web and specifies requirements and recommendations for APIs that want to follow a standard way of sharing feature data.
        - [Sensorthings API]() is a good fit for harmonised soil data 
    - For raster data
        - the [OGC Web Coverage Service (WCS)](https://portal.ogc.org/files/09-110r4){target=_blank} supports requests for coverage data (rasters),
        - the [OGC API – Coverages](https://ogcapi.ogc.org/coverages/){target=_blank} supports the download of coverages represented by some binary or ASCII serialisation, specified by some data (encoding) format. Arguably, the most popular type of coverage is a gridded one. Satellite imagery is typically modelled as a gridded coverage, for example. Note that this standard has not been approved yet; further development may still occur.

## Open issues

Persistent identification of records within a dataset is not guaranteed on (remote) sources which are disseminated using various API's, such as OGC OWS services, GraphQL and OpenAPI. Novel formats such as GeoParquet and COG allow range (subset) requests to a single endpoint and could combine FAIR identification and subset requests. Exploration of their potential for the SWR data download and export remains an open question.


## Technology

### Non geographic

Reverse proxy can probably be set up at the ingress/firewall level

Research is needed to understand available technology to provide preview options on various types of resource types


### Geographic data

As described within the Data & Knowledge publication component, MapServer is intended for data publication in the SWR. [MapServer](../technical_components/mapserver.md) is an open-source platform for publishing spatial data to the web using standardised APIs defined by the Open Geospatial Consortium, such as WMS, WFS, WCS, and OGC API-Features. Initially developed in the mid-1990s at the University of Minnesota, MapServer is released under an MIT-style license and runs on all major platforms (Windows, Linux, Mac OS X). MapServer is not a full-featured GIS system, nor does it aspire to be. 

Mapserver is not an optimal solution for providing rich data in hierarchical structure. For that type of data Sensorthings API (frost server), WFS (deegree), graphql (postgraphile) and SPARQL (virtuoso) are more relevant.

## Integration opportunities

SWR fully stands behind the [FAIR principles](https://www.nature.com/articles/sdata201618){target=_blank}, including persistent identification for the data download, which would result in a full download of the data/knowledge resource.

