# Data & Knowledge publication

## Map Server

[MapServer](https://mapserver.org) is an Open Source platform for publishing spatial data to the web using standardised API's defined by Open Geospatial Consortium, such as WMS, WFS, WCS, OGC API-Features. Originally developed in the mid-1990’s at the University of Minnesota, MapServer is released under an MIT-style license, and runs on all major platforms (Windows, Linux, Mac OS X). MapServer is not a full-featured GIS system, nor does it aspire to be. 

Alternatives to mapserver are:
- Geoserver
- Qgis server
- pygeoapi (pygeoapi uses mapserver internally to provide map rendering)

A [docker image for mapserver](https://github.com/camptocamp/docker-mapserver) is maintained by Camp2Camp. Important aspect here is that the image uses a minimal build of GDAL, which defines the source formats consumable by mapserver. If formats such as Geoparquet or Geozarr are relevant, building a tailored image is relevant.

The configuration of mapserver is managed via a config file. The config files references metadata, data and styling rules. Various tools exist to create mapserver config files:
- [geocat bridge](https://www.geocat.net/docs/bridge/qgis/latest/) is a qgis plugin to create mapfiles from qgis projects
- [Mappyfile](https://github.com/geographika/mappyfile) is a python library to generate mapfiles by code
- [mapserver studio](https://mapserverstudio.net/) a saas solution to edit mapfiles
- [mapscript](https://www.mapserver.org/mapscript/) is a python library to interact with the mapserver binary 
- [pygeodatacrawler](https://pypi.org/project/geodatacrawler/) is a tool by ISRIC generating mapfiles from various resources
- [vs code mapfile plugin](https://marketplace.visualstudio.com/items?itemName=chicoff.mapfile)

Read more about mapserver at:
- [EJPSoil wiki](https://ejpsoil.github.io/soildata-assimilation-guidance/cookbook/mapserver.html)


## Catalogue Server

- query metadata
  - M: filter by (configurable set of) properties (AND/OR/NOT, FullTextSearch, by geography)
  - M: Sorting and pagination
  - S: aggregate results (faceted search, dashboarding)
  - W: customise ranking of the results
- OGC:CSW, OGCAPI:Records, OAI-PMH
- Search engine discoverability / Schema.org
- Link to data download / data preview

### Relationship 
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

### Technology

To date 2 relevant technologies for catalogue server:

- [pycsw](https://pycsw.org) is a python implementation of OGCAPI Records (and CSW, oai-omh,...) with a tailored html output used in the [ejpsoil project](https://catalogue.ejpsoil.eu). The implementation at EJPSoil has a github backend using the [mcf format](https://geopython.github.io/pygeometa/reference/mcf/) (a subset of iso19115 in YAML encoding) to faciliate participatory content creation. Harvesting is managed via CI-CD pipelines, using the [geodatacrawler](https://pypi.org/project/geodatacrawler/) tool. Content queries and faceted search are managed by a PostGreSQL database. Ranking is not available. No options exist to restrain read access to certain records (except limit by path on the webserver).
- [GeoNetwork](https://geonetwork-opensource.org) is a catalogue implementation in java. Backend is a PostGreSQL database, queries are managed by an Elastic Search index. Supports ranking and faceting. GeoNetwork contains harvesters which run at intervals, metadata transformations and metadata authoring workflows. JRC INSPIRE has build a number of extensions to GeoNetwork to facilitate the INSPIRE GeoPortal, such as bulk CSW harvesting, metadata validation and link checking. The authoring component can be linked to an LDAP or SAML authorisation to provide read/write access to dedicated members.

The diagram below describes the workflow of metadata editing using a git backend.

``` mermaid
flowchart LR
    G[fa:fa-code-compare Git] -->|mcf| CI{{pygeometa}} 
    CI -->|iso19139| DB[(fa:fa-database Database)]
    DB --> C(Catalogue)
    C --> G
    C --> CSW(fa:fa-gear CSW)
    C --> OAR(fa:fa-gear OGCAPI Records)
    C --> OAI(fa:fa-gear OAI-PMH)
```    

### Considerations

- Both technologies are oriented to the geospatial governmental domain and have limited options to interact with Academic repositories (Zenodo, Dataverse, OpenAire, Datacite), Open data catalogues (CKAN, european data portal). Semantic web portals (DCAT/schema.org), Earth observation catalogues (STAC and EO OpenSearch) and Biodiversity portals (GBIF EML). 
- GeoNetwork is a nice one stop solution, but presents some challenges on participatory content creation and maintainability.
- PYCSW is a frontend component in a metadata workflow which can be composed of dedicated components (harvesting, validation, tranformation, etc). It fits with the project architecture, and can be easily replaced by alternatives, such as pygeoapi, geonetwork. 

### People

- Responsible person: 
- participating: Tomas Reznik; Luís de Sousa; Paul van Genuchten


## Knowledge graph

The knowledge graph is meant to add a formal semantics layer to the meta-data collected at the SWR. It mirrors the XML-based meta-data harnessed in the Catalogue Server, but using Semantic Web standards such as DCAT, Dublin Core, VCard or PROV. This meta-data is augmented with links to domain web ontologies, in particular GloSIS. This semantically augmented meta-data is the main pilar of knowledge extraction activities and components.

Besides meta-data the knowledge graph is also expected to host the results of knowledge extration activities. This assumes that knowledge to be semantically laden, i.e. linking to relevant domain ontologies. The identification of appropriate ontologies, and ontology mappinds thus becomes an essential aspect of this project, bridging together various activities and assets.

It is important to recognise the knowledge graph as an immaterial asset that cannot exist by itself. In order to be usable the knowledge graph must be stored in a triple store, thus highlighting the role of that component in the architecture. In its turn the triple store provides another important architectural component, the SPARQL end-point. That will be the main access gateway to the knowledge graph, particularly by other techonological components and software.

The Large Language Model foreseen in this project will be trained on the knowledge graph, thus forming the basis for the Chatbot component of the user interface. The knowledge graph will further feed the facilites for machine-based access to the SWR: a knowledge extration API and a SPARQL end-point.

- metadata storage
- metadata linking
- semantic consistency

- connections with: APIs, presentation, processing, harvester, metadata scheme, storage & structure
- technologies used: DCAT, Dublin Core, VCard, PROV, GloSIS, ...
- responsible person:
- participating: Luís de Sousa