# Metadata Catalogue

The metadata catalogue is a central piece of the architecture, collecting and
giving access to individual metadata records. In the geo-spatial domain,
effective metadata catalogues are developed around the standards issued by the
OGC, the [Catalogue Service for the Web](https://www.ogc.org/standard/cat/){target=_blank}
(CSW) and the [OGC API Records](https://ogcapi.ogc.org/records/){target=_blank}.

Besides this essential compliance with international standards, metadata
catalogues usually provide other important management functionalities: (i)
metadata record edition, (ii) access control, (iii) records search, (iv)
resource preview, (v) records harvesting, etc. More sophisticated metadata
catalogues approach the functionalities of a Content Management System (CMS).
The remainder of this section reviews two popular open-source geo-spatial
metadata catalogues: [GeoNetwork](#geonetwork) and [pycsw](#pycsw).

## GeoNetwork

This web-based software is centred on metadata management, providing rich
edition forms. The editor supports the ISO19115/119/110 standards used for
spatial resources and also Dublin Core. The user can upload data, graphics,
documents, PDF files and any other content type to augment metadata records.
Among others, GeoNetwork supports:

- multilingual metadata record edition,
- validation system,
- automated suggestions for quality improvement,
- publication of geo-spatial layers to software compliant with OGC services (e.g. GeoServer).

GeoNetwork implements the following protocols:

- OGC CSW
- OAI-PMH
- OpenSearch
- Z39.50


The metadata harvesting feature is quite broad, able to interact with the following resources:

- OGC-CSW 2.0.2 ISO Profile
- OAI-PMH
- Z39.50 protocols
- Thredds
- Webdav
- Web Accessible Folders
- ESRI GeoPortal
- Other GeoNetwork node

Besides the core metadata management functions, GeoNetwork also provides
useful monitoring and reporting tools. It is able to easily synthesise the
content of the catalogue with statistics and graphics. A system status is also
available to the system administrator.

### Use cases

The GeoNetwork project started out in 2001 as a [Spatial Data Catalogue
System for the Food and Agriculture
organisation](https://www.fao.org/land-water/databases-and-software/geonetwork/en/){target=_blank}
of the United Nations (FAO), the United Nations World Food Programme (WFP) and
the United Nations Environmental Programme (UNEP). Other relevant projects and
institutions using GeoNetwork include:

- [European Marine Observation and Data Network](https://emodnet.ec.europa.eu/geonetwork/srv/eng/catalog.search#/home){target=_blank} (EMODnet)
- [Federal Geographic Data
  Committee](https://www.fgdc.gov/organization/working-groups-subcommittees/mwg/iso-metadata-editors-registry/geonetwork-opensource){target=_blank}
of the United States (FGDC)
- [Scotland’s catalogue of spatial
  data](https://www.spatialdata.gov.scot/geonetwork/srv/eng/catalog.search#/home){target=_blank}
- [National Centers for Coastal Ocean Science](https://coastalscience.noaa.gov/products/geonetwork/){target=_blank} of the United States (NCCOS)

## pycsw

[pycsw](https://pycsw.org){target=_blank} is a catalogue component offering an HTML frontend and query interface using various standardised catalogue APIs to serve multiple communities. 

- Technology: python
- License: MIT
- OSGeo project

### Functionality

- query metadata
  - M: filter by (configurable set of) properties (AND/OR/NOT, FullTextSearch, by geography)
  - M: Sorting and pagination
  - S: aggregate results (faceted search)
  - W: customise ranking of the results
- OGC:CSW, OGCAPI:Records, OAI-PMH
- Search engine discoverability / Schema.org
- Link to data download / data preview

#### Use cases

pycsw is a core component of [GeoNode](https://geonode.org){target=_blank} and is the core of the [CKAN spatial extension](https://extensions.ckan.org/extension/spatial/){target=_blank}, used for example by FAO. pycsw is used in various projects:

- [EJPSoil](https://catalogue.ejpsoil.eu){target=_blank}
- [Land Soil Crop hubs, Kenya, Ethiopia and Rwanda](https://kenya.lsc-hubs.org/cat/){target=_blank}

In preparation:

- Soils for Africa




