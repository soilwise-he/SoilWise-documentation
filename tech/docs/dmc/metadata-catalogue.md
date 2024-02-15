# Catalogue Server

- query metadata
  - M: filter by (configurable set of) properties (AND/OR/NOT, FullTextSearch, by geography)
  - M: Sorting and pagination
  - S: aggregate results (faceted search, dashboarding)
  - W: customise ranking of the results
- OGC:CSW, OGCAPI:Records, OAI-PMH
- Search engine discoverability / Schema.org
- Link to data download / data preview

## Relationship 
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

## Technology

To date 2 relevant technologies for catalogue server:
- [pycsw](https://pycsw.org) is a python implementation of OGCAPI Records (and CSW, oai-omh,...) with a tailored html output used in the [ejpsoil project](https://catalogue.ejpsoil.eu). The implementation at EJPSoil has a github backend using the [mcf format](https://geopython.github.io/pygeometa/reference/mcf/) (a subset of iso19115 in YAML encoding) to faciliate participatory content creation. Harvesting is managed via CI-CD pipelines, using the [geodatacrawler](https://pypi.org/project/geodatacrawler/) tool. Content queries and faceted search are managed by a PostGreSQL database. Ranking is not available. No options exist to restrain read access to certain records (except limit by path on the webserver).
- [GeoNetwork](https://geonetwork-opensource.org) is a catalogue implementation in java. Backend is a PostGreSQL database, queries are managed by an Elastic Search index. Supports ranking and faceting. GeoNetwork contains harvesters which run at intervals, metadata transformations and metadata authoring workflows. JRC INSPIRE has build a number of extensions to GeoNetwork to facilitate the INSPIRE GeoPortal, such as bulk CSW harvesting, metadata validation and link checking. The authoring component can be linked to an LDAP or SAML authorisation to provide read/write access to dedicated members.

## Considerations

- Both technologies are oriented to the geospatial governmental domain and have limited options to interact with Academic repositories (Zenodo, Dataverse, OpenAire, Datacite), Open data catalogues (CKAN, european data portal). Semantic web portals (DCAT/schema.org), Earth observation catalogues (STAC and EO OpenSearch) and Biodiversity portals (GBIF EML). 
- GeoNetwork is a nice one stop solution, but presents some challenges on participatory content creation and maintainability.
- PYCSW is a frontend component in a metadata workflow which can be composed of dedicated components (harvesting, validation, tranformation, etc). It fits with the project architecture, and can be easily replaced by alternatives, such as pygeoapi, geonetwork. 

## People

- Responsible person: 
- participating: Tomas Reznik; Luís de Sousa; Paul van Genuchten
