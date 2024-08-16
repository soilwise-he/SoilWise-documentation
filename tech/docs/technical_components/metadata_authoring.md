# Metadata Authoring

!!! component-header "Info"
    **Current version:** 

    **Project:** 

    **Access point:** 

In the next iterations SWR will provide two major ways of data & metadata authoring

1.	in an automatized manner, as described in the [Harvester component](ingestion.md);
2.	in a manual mode, as described within this **Manual data & metadata authoring component**.

Note that option (1) is the preferred one from the SWR point of view as it allows to massively tackle metadata and knowledge of remotely available resources, including Catalogue servers of Mission Soil projects, Zenodo, Cordis, INSPIRE Geoportal and others.

A **manual mode** comprises four levels of data and metadata upload (note that the following points 1 and 3 work for both data and metadata, while points 2 and 4 work solely for metadata):

1.	Manual upload of one data file and/or metadata record as a file: a user selects a file from the local drive or types in a publicly available URL and defines the (meta)data structure (for more details, see [Data model component](storage.md#data-model)) and optionally other relevant information like target user group, open/restrict publication of this new data/metadata record etc. The Manual data & metadata upload component imports the file, assigns a UUID if needed, and stores the data in Zenodo, while metadata are stored in the [Storage](storage.md#storage-of-metadata) component.
2.	Manual upload of one metadata record as a source code: the functionality of the Manual data & metadata upload component is almost identical to the previous option (file upload). The only difference is that a user is copying a source code rather than a file upload.
3.	Manual batch upload: this option allows a user to import a set of data files and/or metadata records in the form of e.g. XML or JSON files. The following parameters need to be defined:
 - directory, full path on the server’s file system of the directory to scan and try to import all the available files;
 - file type, e.g. XML, JSON (note that the full list of supported file types needs to be elaborated yet);
4.	Manual connection to a Web service and semi-automatic extraction of available metadata: a user types in a publicly available URL pointing to a service metadata document, e.g. GetCapabilities response of OGC Web service. The Manual data & metadata upload component extracts metadata that can be copied in line with the desired metadata structure, i.e. a metadata profile. The Manual data & metadata upload component assigns a UUID if needed, and stores the metadata in the [Storage](storage.md#storage-of-metadata) component. Most likely, the metadata extracted from a service metadata document (e.g. GetCapabilities) would not be sufficient to address all the mandatory metadata elements defined by the desired metadata structure, i.e. a metadata profile. In such a case, a manual fill in would be needed

The diagram below provides an overview of the workflow of metadata authoring

``` mermaid
flowchart LR
    G[fa:fa-code-compare Git] -->|mcf| CI{{pygeometa}} 
    CI -->|iso19139| DB[(fa:fa-database Database)]
    DB --> C(Catalogue)
    C --> G
```

The authoring workflow uses a GIT backend, additions to the catalogue are entered by members of the GIT repository directly or via pull request (review).
Records are stored in iso19139:2007 XML or MCF. MCF is a subset of iso19139:2007 in a YAML encoding, defined by the pygeometa community. This library is used to 
convert the MCF to any requested metadata format.

A [webbased form](https://osgeo.github.io/mdme){target=_blank} is available for users uncomfortable with editing an MCF file directly.

With every change on the git repository, an export of the metadata is made to a Postgres Database (or the triple store).

### Foreseen functionality

- GUI and backend for online form
- validation of inserted values
- storing inserted metadata record

### Technology & Integration

- **pycsw** and **GeoNetwork** includes capabilities to harvest remote sources, it does not include a dashboard to create and monitor harvesters
- A **Git** based participatory metadata workflow as introduced in EJP Soil and foreseen for SoilWise as a follow-up
    - Users should be endorsed to register their metadata via known repositories, such as Zenodo, CORDIS, INSPIRE, ... at most register the identifier (DOI, CSW) of the record at EUSO, metadata will be mirrored from those locations at intervals
    - Data can be maintained in a Git Repository, such as the [EJP Soil repository](https://github.com/ejpsoil/ejpsoildatahub/tree/main/datasets){target=_blank}, preferably using a readably serialisation, such as YML
    - In EJP Soil we experiment with the [metadata control file](https://geopython.github.io/pygeometa/reference/mcf/){target=_blank} format (MCF), a subset of iso19139
    - A web editor for MCF is available at [osgeo.github.io](https://osgeo.github.io/mdme){target=_blank}
    - Users can also submit metadata using a CSV (excel) format, which is converted to MCF in a CI-CD 
    - A web based frontend can be developed to guide the users in submitting records (generate a pull request in their name)
    - Validation of inserted values
    - A CI-CD script which runs as part of a pull request triggers a validation and rejects (or optimises) a record if it does not match our quality criteria

The Manual data & metadata upload component will show its full potential when being in the SWR tightly connected to (1) SWR Catalogue, (2) [metadata validation](metadata_validation.md), and (3) Requires [authentication](user_management.md#authentication) and [authorisation](user_management.md#authorisation).

### Open issues
The Manual data & metadata upload component shall be technologically aligned with the SWR Catalogue and [Harvester](ingestion.md). Both considered software solutions, i.e. **GeoNetwork** and **pycsw** support the core desired functionality all these three SWR components.

The above-described mechanisms showed the “as is” manual metadata upload. Nevertheless, it is foreseen that the SWR will also support “on-the-fly transformation towards interoperability”. Such functionality is currently under discussion. The desired functionality aims to assist data producers and publishers with a pipeline that allows them to map their source data & metadata structures into target interoperable data & metadata structures. An example of this is an example of an upload of interpreted soil data and their on-the-fly transformation into a structure defined by the INSPIRE Directive, application schema from data specification on Soil respectively. A data & metadata upload pipeline supporting “on-the-fly transformation towards interoperability” will be described in greater detail later in line with SoilWise developments.
