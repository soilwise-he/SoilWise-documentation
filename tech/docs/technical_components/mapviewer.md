# Map viewer

!!! component-header "Info"
    **Current version:** 1.7.1
    
    **Project:** https://github.com/Leaflet/Leaflet

### Functionality

A light-weight client map viewer component is employed as an integrated part of the Catalogue:

- to indicate the location of a dataset on a map (if the record has the geographic extent populated)
- to provide the preview of data, when a link to web view service is available

#### Technology

The mapviewer is based on the [leaflet](https://leaflet.org) javascript library on a backdrop of [OpenStreetMap](https://osm.org) tiles (provided by the OpenStreetMap community).

### Future work

It will be interesting to provide preview functionality to those datasets which do not have a view service configured, for those formats which support direct consumption in a javascript client (cloud Optimized GeoTiff, GeoJson, GeoParquet, ...)
