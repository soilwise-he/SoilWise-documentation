# User Interface: Dashboard (WE)

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

## Chatbot (Rob)

A personified and easy to use interface to the knowledge gathered by the SWR. Based on the LLM component.

## Map viewer (MU + ISRIC)

A light-weight client map viewer component will be employed:
- as a frontend of [Map Server](publication.md#map-server) component to visualize provided WMS, WFS, WCS layers
- as a integrated part of the [Catalogue Server](publication.md#catalogue-server) to visualize primarily the geographical extent of data described in the metadata record and a snapshot visualization of the data
- full preview of data is currently a subject of discussions

### Technology

- Data in the soil domain is mainly gridded formats such as geotiff. Advances in the EO domain are quick these days. The use of STAC in combination with [COG](https://www.cogeo.org/){target=_blank} or even [GeoZarr](https://github.com/zarr-developers/geozarr-spec){target=_blank} are getting more common. 
- **Leaflet** is that it is limited with the newer formats. **OpenLayers** could be an interesting alternative for the novel formats.
- At ISRIC, similar to FAO,the use of [**terriajs**](https://terria.io/){target=_blank} is being investigating as a viewer. Terria has some support for OGC standards, such as WMS and CSW. It offers an interesting full featured starting point for web mapping.
- Alternative view options should be considered other than maps, for example diagram visualisation of a dataset. [**Apache superset**](https://superset.apache.org/){target=_blank} is an interesting tool to create generic visualisations from average datasets.


## Manual data & metadata upload

The SWR provides two major ways of data & metadata upload:

1.	in an automatized manner, as described in the components [Automatic metadata harvesting](ingestion.md#automatic-metadata-harvesting) and [Automatic knowledge ingestion components](ingestion.md#automatic-knowledge-ingestion);
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
- GeoNetwork, pycsw

### Integration opportunities
The Manual data & metadata upload component will show its full potential when being in the SWR tightly connected to (1) [SWR Catalogue](publication.md#catalogue-server), (2) [metadata validation](data_processing.md#metadata-validation-etsats) and (3) [metadata scheme & structure](storage.md#metadata-scheme).

### Open issues
The Manual data & metadata upload component shall be technologically aligned with the [SWR Catalogue](publication.md#catalogue-server) and [Automatic metadata harvesting component](ingestion.md#automatic-metadata-harvesting). Both considered software solutions, i.e. **GeoNetwork** and **pycsw** support the core desired functionality all these three SWR components.

## Data download & export (MU)

- The FAIR principle endorses the use of persistent identification for the data download, which would result in a full download of the data/knowledge resource.
- An API to data enables partial/filtered results from a dataset, data download API's are available trough [**Mapserver**](publication.md#map-server) via WFS, WCS and OGCAPI-Features.
- Novel formats such as GeoParquet, COG, GeoZarr allow range (subset) requests to a single endpoint, and could combine FAIR identification and subset-requests.
