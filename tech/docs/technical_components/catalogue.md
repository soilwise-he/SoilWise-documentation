# Catalogue

!!! component-header "Info"
    **Current version:** v3.0b.2024-july

    **Project:** [pycsw](https://github.com/soilwise-he/pycsw)

    **Access point:** <https://soilwise-he.containers.wur.nl/cat/>
    
The metadata catalogue is a central piece of the architecture, collecting and
giving access to individual metadata records. In the geo-spatial domain,
effective metadata catalogues are developed around the standards issued by the
OGC, the [Catalogue Service for the Web](https://www.ogc.org/standard/cat/){target=_blank}
(CSW) and the [OGC API Records](https://ogcapi.ogc.org/records/){target=_blank}.

Besides this essential compliance with international standards, metadata
catalogues usually provide other important management functionalities: (i)
metadata record editing, (ii) access control, (iii) records search, (iv)
resource preview, (v) records harvesting, etc. More sophisticated metadata
catalogues approach the functionalities of a Content Management System (CMS).
The remainder of this section reviews two popular open-source geo-spatial
metadata catalogues: [GeoNetwork](#geonetwork) and [pycsw](#pycsw).

## Functionality

The SoilWise prototype uses a tailored frontend, focusing on:

- Minimalistic User Interface, to prevent a technical feel
- Paginated search results, sorted alphabetically, by date, see more information in Chapter [Query Catalogue](#query-catalogue)
- Option to filter by facets, see more information in Chapter [Query Catalogue](#query-catalogue)
- Preview of the dataset (if a OGC:Service is available), else display of its spatial extent, see more information in Chapter [Display record's detail](#display-records-detail)
- Option to provide feedback to publisher/author, , see more information in Chapter [User Engagement](#user-engagement)
- Readable link in the browser bar, to facilitate link sharing

### Query Catalogue

The SoilWise Catalogue currently enables the following search options:

- [fulltext search](#fulltext-search)
- [faceted search](#faceted-search)

50 results are displayed per page in alphabetical order, in the form of overview table comprising preview of title, abstract, contributor, type and date. Search items set through user interface is also reflected in the URL to facilitate sharing.

#### Fulltext search

Fulltext search is currently enabled through certain attributes: title, keywords, abstract, contributor. Full list of queryables can be found at: <https://soilwise-he.containers.wur.nl/cat/collections/metadata:main/queryables>.

Fulltext search currently supports only nesting words with AND operator.

_TBD - describe OGC Record's API, CQL_

#### Faceted search

- search by record's type (dataset, service, software, text, knowledge source)
- search by source repository
- search by country

#### Future work

- extend fulltext search; allow complex queries using exact match, OR,...

### Display record's detail

After clicking result's table item, a record's detail is displayed at unique URL address to facilitate sharing. Record's detail currently comprises:

- record's type tag
- Full title
- Full abstract
- keywords' tags
- preview of record's geographical extent, see [Map preview](#map-preview)
- record's preview image, if available
- Links section with links to original repository, _TBD_...
- all other record's items
- section enabling [User Engagement](#user-engagement)
- Last update date

### Map preview

SoilWise Catalogue currently supports only simple map preview of record's geographical extent, which is available in the record's detail and also on the search results page (aggregated for current search results). Map preview uses [Leaflet](https://leafletjs.com/){target=_blank} and enables standard simple user interaction (zoom, changing backdrop layers).

### Data download (AS IS)

Download of data "as is" is currently supported through Links section from the harvested repository.

### Display link to knowledge

_TBD_

### CSW API

_TBD_

### OGC API Catalogue

_TBD_

### User Engagement

_TBD_

### Future work

- display metadata augmentation results
- display metadata validation results
- Show relations to other records
- Better distinguish link types; service/api, download, records, documentation, etc.
- Indication of remote link availability/conformance
- If a record originates from (multiple) catalogues, add a link to the origin
- Ranking (backend)

## Technology & Integration

[pycsw](https://pycsw.org){target=_blank}  is a catalogue component offering an HTML frontend and query interface using various standardised catalogue APIs to serve multiple communities. Pycsw, written in python, allows for the publishing and discovery of geospatial metadata via numerous APIs ([CSW 2/CSW 3](https://www.ogc.org/standard/cat/){target=_blank}, [OpenSearch](https://opensearch.org/){target=_blank}, [OAI-PMH](https://www.openarchives.org/pmh/){target=_blank}, [SRU](https://developers.exlibrisgroup.com/rosetta/integrations/standards/sru/){target=_blank}), providing a standards-based metadata and catalogue component of spatial data infrastructures. pycsw is [Open Source](https://opensource.org/){target=_blank}, released under an [MIT license](https://docs.pycsw.org/en/latest/license.html){target=_blank}, and runs on all major platforms (Windows, Linux, Mac OS X).

The SWR catalogue component will show its full potential when integrated to (1) [Harvester](ingestion.md), (2) [Storage of metadata](storage.md#storage-of-metadata),  (3) [Metadata Augmentation](metadata_augmentation.md) and [Metadata Validation](metadata_validation.md).