# Meta-data Catalogue

The meta-data catalogue is a centre piece of the architecture, collecting and
giving access to individual meta-data records. In the geo-spatial domain
effective meta-data catalogues are developed around the standards issued by the
OGC, the [Catalogue Service for the Web](https://www.ogc.org/standard/cat/)
(CSW) and the [OGC API Records](https://ogcapi.ogc.org/records/).

Besides this essential compliance with international standards, meta-data
catalogues usually provide other important management functionalities: (i)
meta-data record edition, (ii) access control, (iii) records search, (iv)
resource preview, (v) records harvesting, etc. More sophisticated meta-data
catalogues approach the functionalities of a Content Management System (CMS).
The remainder of this section reviews two popular open source geo-spatial
meta-data catalogues: GeoNetwork and pycsw.

## GeoNetwork

This web-based software is centred on meta-data management, providing rich
edition forms. The editor supports the ISO19115/119/110 standards used for
spatial resources and also Dublin Core. The user can upload data, graphics,
documents, pdf files and any other content type to augment meta-data records.
Among others, GeoNetwork supports:
- multilingual meta-data record edition,
- validation system,
- automated suggestions for quality improvement,
- publication of geo-spatial layers to software compliant with OGC services (eg. GeoServer).

GeoNetwork implements the following protocols:
- OGC CSW
- OAI-PMH
- OpenSearch
- Z39.50


The meta-data harvesting feature is quite broad, able to interact with the following resources:
- OGC-CSW 2.0.2 ISO Profile
- OAI-PMH
- Z39.50 protocols
- Thredds
- Webdav
- Web Accessible Folders
- ESRI GeoPortal
- Other GeoNetwork node

Besides the core meta-data management functions, GeoNetwork also provides
useful monitoring and reporting tools. It is able to easily synthesise the
content of the catalogue with statistics and graphics. A system status is also
available to the system administrator.

### Use cases

The GeoNetwork project started out in 2001 as a [Spatial Data Catalogue
System for the Food and Agriculture
organisation](https://www.fao.org/land-water/databases-and-software/geonetwork/en/)
of the United Nations (FAO), the United Nations World Food Programme (WFP) and
the United Nations Environmental Programme (UNEP). Other relevant projects and
institutions using GeoNetwork include:
- [European Marine Observation and Data Network](https://emodnet.ec.europa.eu/geonetwork/srv/eng/catalog.search#/home) (EMODnet)
- [Federal Geographic Data
  Committee](https://www.fgdc.gov/organization/working-groups-subcommittees/mwg/iso-metadata-editors-registry/geonetwork-opensource)
of the United States (FGDC)
- [Scotland’s catalogue of spatial
  data](https://www.spatialdata.gov.scot/geonetwork/srv/eng/catalog.search#/home)
- [National Centers for Coastal Ocean Science](https://coastalscience.noaa.gov/products/geonetwork/) of the United States (NCCOS)

## pycsw

[pycsw](https://pycsw.org) is a catalogue component offering a html frontend and query a interface using various standardised catalogue API's to serve multiple communities. 

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

#### Relationship 
- Storage
- Metadata harvesting
- Metadata processing
- Link checking
- Metadata content authoring
- Metadata consistency
- Git participatory content moderation
- Metadata validation
- Data quality validation
- Metadata transformations

#### Use cases

pycsw is a core component of [GeoNode](https://geonode.org) and is the core of the [CKAN spatial extension](), used for example by FAO.

pycsw is used in various projects:

- [EJPSoil](https://catalogue.ejpsoil.eu)
- [Land Soil Crop hubs, Kenya, Ethiopia and Rwanda](https://kenya.lsc-hubs.org/cat/)

In preparation:

- Soils for Africa




