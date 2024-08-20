# Catalogue

!!! component-header "Info"
    **Current version:** v3.0b.2024-july

    **Project:** [pycsw](https://github.com/soilwise-he/pycsw)

    **Access point:** <https://soilwise-he.containers.wur.nl/cat/>
    
The metadata catalogue is a central piece of the architecture, 
giving access to individual metadata records. In the catalogue domain,
various effective metadata catalogues are developed around the standards issued by the
OGC, the [Catalogue Service for the Web](https://www.ogc.org/standard/cat/){target=_blank}
(CSW) and the [OGC API Records](https://ogcapi.ogc.org/records/){target=_blank}, Open Archives Initiative (OAI-PMH), W3C (DCAT), FAIR science (Datacite) and Search Engine community (schema.org). For our first iteration we've selected the pycsw software, which supports most of these standards. 

Besides this essential compliance with international standards, some metadata
catalogues provide other functionalities, such as: 

- metadata record authoring 
- access control
- resource preview
- records harvesting

Soilwise has delegated these tasks to dedicated components in the architecture. The catalog main focus is record search and display.

The remainder of this document describes the technical aspects of the current implementation.

## Technology 

[pycsw](https://pycsw.org){target=_blank}  is a catalogue component offering an HTML frontend and query interface using various standardised catalogue APIs to serve multiple communities. Pycsw, written in python, allows for the publishing and discovery of geospatial metadata via numerous APIs ([CSW 2/CSW 3](https://www.ogc.org/standard/cat/){target=_blank}, [OpenSearch](https://opensearch.org/){target=_blank}, [OAI-PMH](https://www.openarchives.org/pmh/){target=_blank}, [SRU](https://developers.exlibrisgroup.com/rosetta/integrations/standards/sru/){target=_blank}), providing a standards-based metadata and catalogue component of spatial data infrastructures. pycsw is [Open Source](https://opensource.org/){target=_blank}, released under an [MIT license](https://docs.pycsw.org/en/latest/license.html){target=_blank}, and runs on all major platforms (Windows, Linux, Mac OS X).

pycsw is deployed as a docker container from the official docker hub repository. Its configuration is updated at deployment. Some layout templates are overwritten at deployment to facilitate a tailored HTML view.


## Integration

The SWR catalogue component will show its full potential when integrated to (1) [Harvester](ingestion.md), (2) [Storage of metadata](storage.md#storage-of-metadata),  (3) [Metadata Augmentation](metadata_augmentation.md) and [Metadata Validation](metadata_validation.md). 
