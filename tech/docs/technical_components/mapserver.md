# Map Server

[MapServer](https://mapserver.org){target=_blank} is an Open Source platform for publishing spatial data to the web using standardised API's defined by Open Geospatial Consortium, such as WMS, WFS, WCS, OGC API-Features. Originally developed in the mid-1990’s at the University of Minnesota, MapServer is released under an MIT-style license, and runs on all major platforms (Windows, Linux, Mac OS X). MapServer is not a full-featured GIS system, nor does it aspire to be. 

## Technology

A [docker image for mapserver](https://github.com/camptocamp/docker-mapserver){target=_blank} is maintained by Camp2Camp. Important aspect here is that the image uses a minimal build of GDAL, which defines the source formats consumable by mapserver. If formats such as Geoparquet or Geozarr are relevant, building a tailored image is relevant.

The **configuration** of mapserver is managed via a config file. The config files references metadata, data and styling rules. Various tools exist to create mapserver config files:
- [geocat bridge](https://www.geocat.net/docs/bridge/qgis/latest/){target=_blank} is a QGis plugin to create mapfiles from qgis projects
- [Mappyfile](https://github.com/geographika/mappyfile){target=_blank} is a python library to generate mapfiles by code
- [mapserver studio](https://mapserverstudio.net/){target=_blank} a saas solution to edit mapfiles
- [mapscript](https://www.mapserver.org/mapscript/){target=_blank} is a python library to interact with the mapserver binary 
- [pygeodatacrawler](https://pypi.org/project/geodatacrawler/){target=_blank} is a tool by ISRIC generating mapfiles from various resources
- [vs code mapfile plugin](https://marketplace.visualstudio.com/items?itemName=chicoff.mapfile){target=_blank}

Read more about Mapserver at [EJPSoil wiki](https://ejpsoil.github.io/soildata-assimilation-guidance/cookbook/mapserver.html){target=_blank}.

Alternatives to Mapserver are:

- Geoserver
- Qgis server
- pygeoapi (pygeoapi uses Mapserver internally to provide map rendering)