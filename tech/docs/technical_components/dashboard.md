# User Interface: Dashboard


- implement UCs
- deliver useful and usable apps for various stakeholders
- user friedly testing
- present data / knowledge in useable way
- show value, graphs, maps, tables, text

- connections with: processing, storage, structure & scheme, catalogue, APIs (all needs to be accessed and visualized), user
- technologies used:
- responsible person:
- participating:


## Metadata & data search & advanced filtering

## Chatbot

A personified and easy to use interface to the knowledge gathered by the SWR. Based on the LLM component.

## Map viewer

- technologies used: Leaflet

### Considerations

- Data in the soil domain is mainly gridded formats such as geotiff. Advances in the EO domain are quick these days. The use of STAC in combination with [COG](https://www.cogeo.org/) or even [GeoZarr](https://github.com/zarr-developers/geozarr-spec) are getting more common. Our findings with leaflet is that it is limited with the newer formats. OpenLayers could be an interesting alternative for the novel formats.
- At ISRIC, similar to FAO, we're investigating the use of [terriajs](https://terria.io/) as a viewer. Terria has some support for OGC standards, such as WMS and CSW. It offers an interesting full featured starting point for web mapping.
- Alternative view options should be considered other than maps, for example diagram visualisation of a dataset. [Apache superset](https://superset.apache.org/) is an interesting tool to create generic visualisations from average datasets.


- responsible person: Tomas Reznik
- participating:

## Manual data & metadata upload

- GUI and backend for online form
- validation of inserted values
- storing inserted metadata record

- connections with: catalogue, validation, scheme & structure
- technologies used: GeoNetwork, pycsw
- responsible person: Tomas Reznik
- participating:

## Data download & export

Considerations

- The FAIR principle endorses the use of persistent identification for the data download, which would result in a full download of the data/knowledge resource
- An api to data enables partial/filtered results from a dataset, data download api's are available trough [mapserver](./publication.md#map-server) via WFS, WCS and OGCAPI-Features
- Novel formats such as GeoParquet, COG, GeoZarr allow range (subset) requests to a single endpoint, and could combine FAIR identification and subset-requests
