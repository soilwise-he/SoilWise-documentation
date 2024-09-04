# Map viewer

!!! component-header "Info"

    **Current version:**
    
    **Project:** 

### Functionality

A light-weight client map viewer component will be employed:

- as a frontend of [Map Server](mapserver.md) component to visualize provided WMS, WFS, WCS layers, but also external services.
- as an integrated part of the Catalogue to visualize primarily the geographical extent of data described in the metadata record and a snapshot visualization of the data
- to provide the full preview of data, when a link to web service or data browse graphics (preview image) is available

A dedicated mapviewer, can support spatial oriented users in accessing relevant data in a spatial way. For example maps of spatial distribution of soil properties or health indicators over Europe. A typical example is [Soilgrids](https://soilgrids.org){target=_blank}.

An interesting aspect of a community like EUSO is the ability to prepare and share a map with stakeholders to trigger some discussion on phenomena at a location.

Examine the need for viewing novel formats such as Vector tiles, [COG](https://www.cogeo.org/){target=_blank}, [GeoZarr](https://github.com/zarr-developers/geozarr-spec){target=_blank}, [GeoParquet](https://geoparquet.org/){target=_blank} directly on a map background. The benefit of these formats is that no (OGC) API is required to facilitate data visualisation.

#### Technology

The mapviewer in the catalogue is the [leaflet](https://leaflet.org) javascript library on a backdrop of OpenStreetMap tiles (provided by the OpenStreetMap community).

If a more elaborate mapviewer is requested, a suggestion could be the terriajs library.
[TerriaJS](https://terria.io){target=_blank} is an environment to share maps (react+leaflet+cesium), but also create maps and share them with stakeholders.
