# User Interface: Dashboard

!!! component-header "Important Links"
    :fontawesome-brands-github: Project: [Dashboard](https://github.com/orgs/soilwise-he/projects/10)

The term dashboard is used with various meanings, in the scope of Soilwise the following uses are relevant:

- A [search interface on metadata](#search-interface-on-metadata), search results are typically displayed in a paginated set of web pages. But alternatives, such as a map or chatbot, could be interesting.
- A set of [diagrams showing an overview of the contents and usage of the catalogue](#overview-of-catalogue-content); for example a diagram of the percentage of records by topiccategory, number of visits by member state.

Other parts of the dashboard are:

- [Metadata authoring](metadata-authoring.md) and [harvest configuration](../technical_components/ingestion.md) components
- [Data download & export](#data-download-export) options

SoilWise Dashboard is intended to support the implementation of User stories, deliver useful and usable apps for various stakeholders, provide interface for user testing and present present data and knowledge in useable way.


## Search interface on metadata

Typical example of a catalogue search interface is the current [ESDAC catalogue](https://esdac.jrc.ec.europa.eu/resource-type/soil-functions-data).

### Ranking, relations, full text search, and filtering

Optimal search capabilities are provided by the catalogue backend, this component leverages these capabilities to provide users with an optimal user interface to effectively use those capabilities.

The EJPSoil prototype uses a tailored frontend, focussing on:

- Paginated search result, sort alphabetically, by date
- Minimalistic User Interface, to prevent a technical feel
- Option to filter by facets
- Option to provide feedback to publisher/author
- Readable link in the browser bar, to facilitate link sharing
- Preview of the dataset (if a OGC:Service is available), else display of its spatial extent

What can be improved:

- Show relations to other records
- Better distinguish link types; service/api, download, records, documentation, etc.
- Indication of remote link availability/conformance
- If a record originates from (multiple) catalogues, add a link to the origin
- Ranking (backend)

#### Technology

- Jinja2 templates (html, css) as a tailored skin on pycsw/pygeoapi, or dedicated frontend (vuejs, react)
- Leaflet/OpenLayers/MapLibre

### Chatbot

[Large Language models](llm.md) (LLM) enriched with Soilwise content can offer an alternative interface to assist the user in finding and accessing the relevant knowledge or data source. Users interact with the chatbot interactively to define the relevant question and have it answered. The LLM will provide an answer, but also provides references to sources on which the answer was based, in which the user can extend the search. The LLM can also support the user in how to access the source, using which software for example.

### Map viewer

A light-weight client map viewer component will be employed:

- as a frontend of [Map Server](mapserver.md) component to visualize provided WMS, WFS, WCS layers
- as a integrated part of the Catalogue to visualize primarily the geographical extent of data described in the metadata record and a snapshot visualization of the data
- full preview of data, when link to web service or data browse graphics (preview image) is available

A dedicated mapviewer, such as [TerriaJS](https://terria.io){target=_blank}, can support users in accessing relevant data which has been prepared for optimal consumption in a typical GIS Desktop environment. For example maps of spatial distribution of soil properties or health indicators over Europe. A typical example is [Soilgrids](https://soilgrids.org){target=_blank}.

An interesting aspect for a community like EUSO is the ability to prepare and share a map with stakholders to trigger some discussion on a phenomena at a location.

Examine the need of viewing novel formats such as Vector tiles, [COG](https://www.cogeo.org/){target=_blank}, [GeoZarr](https://github.com/zarr-developers/geozarr-spec){target=_blank}, [GeoParquet](https://geoparquet.org/){target=_blank} directly on a map background. Benefit of these formats is that no (OGC) service is required to facilitate data vizualisation.

#### Technology

[TerriaJS](https://terria.io){target=_blank} is an environment to share maps (react+leaflet+cesium), but also create maps and share them with stakeholders.


## Overview of catalogue content

### Traditional dashboards 

The [INSPIRE Geoportal](https://inspire-geoportal.ec.europa.eu/srv/eng/catalog.search#/overview?view=themeOverview&theme=tn) increased its usage with their new dashboard like interface, for each memberstate the number of published datasets per topic is upfront in the application. Dashboards on catalogue content provide mechanisms to generate overviews of that content to provide such insight.

### Technology

The [EJP Soil Catalogue Dashboard](https://dashboards.isric.org/superset/dashboard/29) is based on Apache Superset, with direct access to the PostGreSQL database containing the catalogue records. GeoNode recently implemented Superset, enabling users to define their diagrams on relevant data from the catalogue (as an alternative to a map viewer).

Dashboarding functionality is available in Geonetwork, using the Elastic Search Kibana dashboarding.

The source data for the dashboards is very likely enriched with AI generated indicators. LLM's seem also able to provide overviews of sets of content.

## Manual data & metadata authoring

The SWR provides two major ways of data & metadata authoring

1.	in an automatized manner, as described in the [Harvester component](ingestion.md);
2.	in a manual mode, as described within this **Manual data & metadata component**.

Note that option (1) is the preferred one from the SWR point of view as it allows to massively tackle metadata and knowledge of remotely available resources, including Catalogue servers of Mission Soil projects, Zenodo, Cordis, INSPIRE Geoportal and others.

A **manual mode** comprises four levels of data and metadata upload (note that the following points 1 and 3 work for both data and metadata, while points 2 and 4 work solely for metadata):

1.	Manual upload of one data file and/or metadata record as a file: a user selects a file from the local drive or types in a publicly available URL and defines the (meta)data structure (for more details, see [Data model component](storage.md#data-model)) and optionally other relevant information like target user group, open/restrict publication of this new data/metadata record etc. The Manual data & metadata upload component imports the file, assigns a UUID if needed, and stores the data in Zenodo, while metadata are stored in the [Storage](storage.md#metadata) component.
2.	Manual upload of one metadata record as a source code: the functionality of the Manual data & metadata upload component is almost identical to the previous option (file upload). The only difference is that a user is copying a source code rather than a file upload.
3.	Manual batch upload: this option allows a user to import a set of data files and/or metadata records in the form of e.g. XML or JSON files. The following parameters need to be defined:
 - directory, full path on the server’s file system of the directory to scan and try to import all the available files;
 - file type, e.g. XML, JSON (note that the full list of supported file types need to be elaborated yet);
4.	Manual connection to a Web service and semi-automatic extraction of available metadata: a user types in a publicly available URL pointing to a service metadata document, e.g. GetCapabilities response of OGC Web service. The Manual data & metadata upload component extracts metadata that can be copied in line with the desired metadata structure, i.e. a metadata profile. The Manual data & metadata upload component assigns a UUID if needed, and stores the metadata in the [Storage](storage.md#metadata) component. Most likely, the metadata extracted from a service metadata document (e.g. GetCapabilities) would not be sufficient to address all the mandatory metadata elements defined by the desired metadata structure, i.e. a metadata profile. In such a case, manual fill in would be needed

The above-described mechanisms showed the “as is” manual metadata upload. Nevertheless, it is foreseen that the SWR will also support “on-the-fly transformation towards interoperability”. Such functionality is currently under discussion. The desired functionality aims assist data producers and publishers with a pipeline that allows them to map their source data & metadata structures into a target interoperable data & metadata structures. An example of this is an example of an upload of interpreted soil data and their on-the-fly transformation into a structure defined by the INSPIRE Directive, application schema from data specification on Soil respectively. A data & metadata upload pipeline supporting “on-the-fly transformation towards interoperability” will be described in greater detail later in line with SoilWise developments.

### Foreseen functionality

- GUI and backend for online form
- validation of inserted values
- storing inserted metadata record

### Technology


- **pycsw** includes capabilities to harvest remote sources, it does not include a dashboard to create and monitor harvesters
- A **Git** based participatory metadata workflow as introduced in EJP Soil
    - Users should be endorsed to register their metadata via known repositories, such as Zenodo, CORDIS, INSPIRE, ... at most register the identifier (DOI, CSW) of the record at EUSO, metadata will be mirrored from those locations at intervals
    - Data can be maintained in a Git Repository, such as the [EJP Soil repository](https://github.com/ejpsoil/ejpsoildatahub/tree/main/datasets){target=_blank}, preferably using a readably serialisation, such as YML
    - In EJP Soil we experiment with the [metadata control file](https://geopython.github.io/pygeometa/reference/mcf/){target=_blank} format (MCF), a subset of iso19139
    - A web editor for MCF is available at [osgeo.github.io](https://osgeo.github.io/mdme){target=_blank}
    - Users can also submit metadata using a CSV (excel) format, which is converted to MCF in a CI-CD 
    - A web based frontend can be developed to guide the users in submitting records (generate a pull request in their name)
    - Validation of inserted values
    - A CI-CD script which runs as part of a pull request triggers a validation, and reject (or optimise) a record if it does not match our quality criteria


### Integration opportunities
The Manual data & metadata upload component will show its full potential when being in the SWR tightly connected to (1) SWR Catalogue, (2) [metadata validation](metadata_validation.md) and (3) [metadata scheme & structure](storage.md#metadata-scheme).

- Requires authentication and autorisation

### Open issues
The Manual data & metadata upload component shall be technologically aligned with the SWR Catalogue and [Harvester](ingestion.md). Both considered software solutions, i.e. **GeoNetwork** and **pycsw** support the core desired functionality all these three SWR components.

## Data download & export

A UI component could be made available as part of the SWR Catalogue application which facilitates access to subsets of data from a data download or API. A user selects the relevant featuretype/band, defines a spatial or attribute filter and selects an output format (or harmonised model). The component will process the data and notify the user when the result is available for download. The API-based data publication is described as part of [API'S](../apis/publication-apis.md).