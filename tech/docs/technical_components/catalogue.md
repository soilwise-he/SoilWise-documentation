# Catalogue

!!! component-header "Info"
    **Current version:** 0.2.0

    **Project:** [Catalogue UI](https://github.com/soilwise-he/catalogue-ui); [pycsw](https://github.com/geopython/pycsw)

    **Access point:** <https://repository.soilwise-he.eu/>
    
The metadata catalogue is a central piece of the architecture, 
giving access to individual metadata records. In the catalogue domain,
various effective metadata catalogues are developed around the standards issued by the
OGC, the [Catalogue Service for the Web](https://www.ogc.org/standard/cat/){target=_blank}
(CSW) and the [OGC API Records](https://ogcapi.ogc.org/records/){target=_blank}, Open Archives Initiative (OAI-PMH), W3C (DCAT), FAIR science (Datacite) and Search Engine community (schema.org). For our first iteration we've selected the pycsw software, which supports most of these standards. 

## Functionality

The SoilWise prototype adopts a frontend, focusing on:

- minimalistic User Interface, to prevent a technical feel,
- paginated search results, sorted alphabetically, by date, see more information in Chapter [Query Catalogue](#query-catalogue),
- option to filter by facets, see more information in Chapter [Faceted Search](#faceted-search),
- preview of the dataset (if a thumbnail or OGC:Service is available), else display of its spatial extent, see more information in Chapter [Display record's detail](#display-records-detail),
- option to provide feedback to publisher/author, see more information in Chapter [User Engagement](#user-engagement),
- readable link in the browser bar, to facilitate link sharing.

## Query Catalogue

The SoilWise Catalogue currently enables the following search options:

- [fulltext search](#fulltext-search)
- [faceted search](#faceted-search)

50 results are displayed per page in alphabetical order, in the form of overview table comprising preview of title, abstract, contributor, type and date. Search items set through user interface is also reflected in the URL to facilitate sharing.

### Fulltext search

Fulltext search is currently enabled through the q= attribute. Other queryable parameters are title, keywords, abstract, contributor. Full list of queryables can be found at: <https://repository.soilwise-he.eu/cat/collections/metadata:main/queryables>.

Fulltext search currently supports only nesting words with AND operator.

### Faceted search

- filter by **record's type** (journalpaper, dataset, document, service, series, best practices and tools, ...)
- filter by **contamination** (antibiotics)
- filter by **soil chemical properties** (nitrogen, carbon, soc, soil organic matter, soil carbon stock, soil nutrient status, ...)
- filter by **soil biological properties** (microbial biomass, respiration, plant residues, soil biological activity, crop yield response)
- filter by **soil services** (plant health, animal health)
- filter by **soil functions** (ecosystems, climate, plants, decomposition, food production, nutrients)
- filter by **soil processes** (organic matter accumulation)
- filter by **soil properties** (soil fertility, soil physical properties, instrinsic soil properties, soil chemical properties, soil biological properties)
- filter by **soil threats** (soil pollution, desertification, soil erosion, compaction, soil degradation, risk assessment, soil organic carbon loss)
- filter by **productivity** (soil productivity, land productivity, net biome productivity)
- filter by **soil physical properties** (soil stability, soil structure, bulk density, aggregate stability, Soil sealing, ...)
- filter by **soil classification** (lixisols, entisols, leptosols, alfisols, luvisols, ...)

The faceted search is the outcome of Keyword matcher in [Metadata Augmentation](./metadata_augmentation.md).

### Future work

- optimize the terms and groups of faceted search
- extend fulltext search; allow complex queries using exact match, OR,...
- use Full Text Search ranking to sort by relevance.

#### Search engine querying

A search engine, deployed on top of the current RDBMS, will increase the perfomance of end user queries. It will also offer better usability, e.g. by offering aggregation functions for faceted search and ranking of search results. They are also implementing the indexation of unstructured content, and are therefore a good starting point (or alternative?) to offer smart searches on unstructured text, using more conventional and broadly adopted software. It will support SoilWise extending the indexation from (meta)data to knowledge, e.g. unstructured content for documents, websites etc.

In the first development cycle, SoilWise has deployed an experimental setup that uses the Solr search platform. It consists of a backend deployment of the Solr platform, providing access to an (Apache Lucene) index of the currently harvested metadata. It is extended with a pilot user interface on top of Solr that allows experimentation with different search strategies. In the 2nd development cycle we intend to integrate the Solr search engine and deploy it as part of the next prototype.   


## Display record's detail

After clicking result's table item, a record's detail is displayed at unique URL address to facilitate sharing. Record's detail currently comprises:

- record's type tag,
- full title,
- full abstract,
- keywords' tags,
- preview of record's geographical extent, see [Map preview](#map-preview),
- record's preview image, if available,
- information about relevant HE funding project,
- list of source repositories,
- indication of link availability, see [Link liveliness assessment](./metadata_validation.md#link-liveliness-assessment).
- last update date,
- all other record's items,
- section enabling [User Engagement](#user-engagement).

### Future work

- display metadata validation results,
- show relations to other records,
- better distinguish link types; service/api, download, records, documentation, etc.

## Resource preview

SoilWise Catalogue currently supports 3 types of preview:

- Display resource geographical extent, which is available in the record's detail, as well in the search results list.
- Display of a graphic preview (thumbnail) in case it is advertised in metadata.
- Map preview of OGC:WMS services advertised in metadata enables standard simple user interaction (zoom, changing layers).

## Display results of metadata augmentation 

Results of metadata augmentation are stored on a dedicated database table. The results are merged into the harvested content during publication to the catalogue. At the moment it is not possible to differentiate between original and augmented content. For next iterations we aim to make this distinction more clear.

## Data download (AS IS)

Download of data "as is" is currently supported through the links section from the harvested repository. Note, "interoperable data download" has been only a proof-of-concept in the first iteration phase, i.e. is not integrated into the SoilWise Catalogue.

## Display link to knowledge

Download of knowledge source "as is" is currently supported through the links section from the harvested repository.

## Support catalogue API's of various communities

In order to interact with the many relevant data communities, Soilwise aims to support a range of catalogue standards.

### Catalogue Service for the Web

Catalogue service for the web (CSW) is a standardised pattern to interact with (spatial) catalogues, maintained by OGC. <https://repository.soilwise-he.eu/cat/csw>

### OGC API - Records

OGC is currently in the process of adopting a revised edition of its catalogue standards. The new standard is called OGC API - Records. OGC API - Records is closely related to Spatio Temporal Asset Catalogue (STAC), a community standard in the Earth Observation community. <https://repository.soilwise-he.eu/cat/openapi>

### Protocol for metadata harvesting (oai-pmh)

The open archives initiative has defined a common protocol for metadata harvesting (oai-pmh), which is adopted by many catalogue solutions, such as Zenodo, OpenAire, CKAN. The oai-pmh endpoint of Soilwise can be harvested by these repositories. <https://repository.soilwise-he.eu/cat/oaipmh>

### Schema.org annotations

Annotiations using [schema.org/Dataset](https://schema.org/Dataset) ontology enable search engines to harvest metadata in a structured way.
<https://validator.schema.org/#url=https%3A%2F%2Frepository.soilwise-he.eu%2Fcat%2Fcollections%2Fmetadata%3Amain%2Fitems%2F00682004-c6b9-4c1d-8b40-3afff8bbec69>

## User Engagement

Collecting users feedback provides an important channel on the usability of described resources. Users can even support each other by sharing the feedback as 'questions and answers'. For this purpose every display of a record is concluded with a feedback section where users can interact about the resource. Users need to authenticate to provide feedback. This aspect has been implemented as [giscuss widget](https://giscus.app/), which used [github discussion](https://docs.github.com/en/discussions) as a backend.

### Future work

Notify the resource owners of incoming feedback, so they can answer any questions or even improve their resource.

## Technology 

[pycsw](https://pycsw.org){target=_blank}  is a catalogue component offering an HTML frontend and query interface using various standardised catalogue APIs to serve multiple communities. Pycsw, written in python, allows for the publishing and discovery of geospatial metadata via numerous APIs ([CSW 2/CSW 3](https://www.ogc.org/standard/cat/){target=_blank}, [OAI-PMH](https://www.openarchives.org/pmh/){target=_blank}, providing a standards-based metadata and catalogue component of spatial data infrastructures. pycsw is [Open Source](https://opensource.org/){target=_blank}, released under an [MIT license](https://docs.pycsw.org/en/latest/license.html){target=_blank}, and runs on all major platforms (Windows, Linux, Mac OS X).

pycsw is deployed as a docker container from the [geopython/pycsw docker hub repository](https://hub.docker.com/r/geopython/pycsw){target=_blank}. A beta release of the upcoming v3.0 is used. Its configuration is updated at deployment. Some layout templates are overwritten at deployment to facilitate a tailored HTML view. The tailored html view is stored as part of the kuberneters deployment configuration.

## Integration

The SWR catalogue component will show its full potential when integrated to (1) [Harvester](ingestion.md), (2) [Storage of metadata](storage.md#storage-of-metadata),  (3) [Metadata Augmentation](metadata_augmentation.md) and [Metadata Validation](metadata_validation.md). 
