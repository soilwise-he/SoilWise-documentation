# Map viewer

- technologies used: Leaflet

## Considerations

- Data in the soil domain is mainly gridded formats such as geotiff. Advances in the EO domain are quick these days. The use of STAC in combination with [COG](https://www.cogeo.org/) or even [GeoZarr](https://github.com/zarr-developers/geozarr-spec) are getting more common. Our findings with leaflet is that it is limited with the newer formats. OpenLayers could be an interesting alternative for the novel formats.
- At ISRIC, similar to FAO, we're investigating the use of [terriajs](https://terria.io/) as a viewer. Terria has some support for OGC standards, such as WMS and CSW. It offers an interesting full featured starting point for web mapping.
- Alternative view options should be considered other than maps, for example diagram visualisation of a dataset. [Apache superset](https://superset.apache.org/) is an interesting tool to create generic visualisations from average datasets.


- responsible person: Tomas Reznik
- participating:
