# Map Server

!!! component-header "Info"
    **Current version:** 8.4.0

    **Project:** [MapServer](https://github.com/soilwise-he/MapServer)

At this moment mapserver is not added to the infrastructure. We're still evaluating the user need for a component like this. 

## Functionality

[MapServer](https://mapserver.org){target=_blank} is an Open Source platform for publishing spatial data to the web with standardised APIs defined by Open Geospatial Consortium, such as WMS, WFS, WCS, OGC API-Features. Originally developed in the mid-1990s at the University of Minnesota, MapServer is released under an MIT-style license and runs on all major platforms (Windows, Linux, Mac OS X). MapServer is not a full-featured GIS system, nor does it aspire to be. 

Read more about MapServer at [EJPSoil wiki](https://ejpsoil.github.io/soildata-assimilation-guidance/cookbook/mapserver.html){target=_blank}.

## Technology

A [docker image for mapserver](https://github.com/camptocamp/docker-mapserver){target=_blank} is maintained by Camp2Camp. The important aspect here is that the image uses a minimal build of GDAL, which defines the source formats consumable by the MapServer (in line with section [Transformation and Harmonistation Components](transformation.md)). If formats such as Geoparquet or Geozarr are relevant, building a tailored image is relevant.

The **configuration** of the MapServer is managed via a config file. The config files reference metadata, data and styling rules. Various tools exist to create MapServer config files:

- [geocat bridge](https://www.geocat.net/docs/bridge/qgis/latest/){target=_blank} is a QGIS plugin to create mapfiles from QGis projects
- [Mappyfile](https://github.com/geographika/mappyfile){target=_blank} is a python library to generate mapfiles by code
- [mapserver studio](https://mapserverstudio.net/){target=_blank} a saas solution to edit mapfiles
- [mapscript](https://www.mapserver.org/mapscript/){target=_blank} is a python library to interact with the MapServer binary 
- [pygeodatacrawler](https://pypi.org/project/geodatacrawler/){target=_blank} is a tool by ISRIC generating mapfiles from various resources
- [vs code mapfile plugin](https://marketplace.visualstudio.com/items?itemName=chicoff.mapfile){target=_blank}

Mapfiles produced in the project are maintained in a git repository and mounted into the mapserver container in a deployment phase.




