# Metadata Authoring

!!! component-header "Info"
    **Current version:** v1.1

    **Project:** https://github.com/soilwise-he/soilinfohub

    **Access point:** https://github.com/soilwise-he/soilinfohub

This document describes an approach to create metadata within the Soilwise infrastructure. Notice that this approach is not recommended, it should only be used if data can not be published in official repositories.

The EJP Soil project has prepared a metadata authoring workflow, optimised for research projects. It includes an approach to collect metadata via an Excel sheet and load the records from excel into the catalogue.

## Technology

The authoring workflow uses a GIT backend, additions to the catalogue are entered by members of the GIT repository directly or via pull request (review). Records are stored in iso19139:2007 XML or Metadata control file (MCF). [MCF](https://geopython.github.io/pygeometa/reference/mcf/) is a subset of iso19139:2007 in a YAML encoding, defined by the [pygeometa](https://github.com/geopython/pygeometa) community. The pygeometa library is used to convert the MCF to any requested metadata format.

A [webbased form](https://osgeo.github.io/mdme){target=_blank} is available for users uncomfortable with editing an MCF file directly. The [pyGeoDataCrawler](https://pypi.org/project/geodatacrawler/) tool is available to convert a set of records in an excel sheet to MCF.

## Integration

The Manual metadata authoring component will show its full potential when being in the SWR tightly connected to (1) GIT,  and the[Ingest component](./ingestion.md). It requires [authentication](user_management.md#authentication) and [authorisation](user_management.md#authorisation).
