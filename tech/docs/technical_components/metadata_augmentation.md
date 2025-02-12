# Metadata Augmentation


This set of components augments metadata statements using various techniques. 
Augmentations are stored on a dedicated augmentation table, indicating the process which produced it.
The statements are combined with the ingested content to offer users an optimal catalogue experience.

At the moment, the functionality of the Metadata Augmentation component comprises these components:

- [Keyword-matcher](#keyword-matcher)
- [Translation module](#translation-module)
- [Link liveliness assessment](#link-liveliness-assessment)

Upcoming components

- [Spatial locator](#spatial-locator)
- [Spatial scope analyser](#spatial-scope-analyser)
- [Duplication identification](#duplication-identification)
- [Keyword extraction](#keyword-extraction)
- [Automatic metadata generation](#automatic-metadata-generation)
- [Metadata interlinker](#metadata-interlinker)

Metadata augmentation results are stored in a augmentation table (unless mentioned otherwise).

| metadata-uri | metadata-element | source | value | proces | date |
| --- | --- | --- | --- | --- | --- |
| <https://geo.fi/data/ee44-aa22-33> | spatial-scope | 16.7,62.2,18,81.5 |  <https://inspire.ec.europa.eu/metadata-codelist/SpatialScope/national> | spatial-scope-analyser | 2024-07-04 |
| <https://geo.fi/data/abc1-ba27-67> | soil-thread | This dataset is used to evaluate Soil Compaction in Nuohous Sundström | <http://aims.fao.org/aos/agrovoc/c_7163> | keyword-analyser | 2024-06-28 |


### Keyword matcher

!!! component-header "Info"
    **Current version:** 0.2.0

    **Projects:** [Keyword matcher](https://github.com/soilwise-he/metadata-augmentation/tree/main/keyword-matcher)

Keywords are an important mechanism to filter and cluster records. Similar keywords need to be clustered to be able to match them. This module evaluates keywords of existing records to make them equal in case of high similarity. 

Analyses existing keywords on a metadata record. Two cases can be identified:

- If a keyword, having a skos identifier, has a closeMatch or sameAs relation to a prefered keyword, the prefered keyword is used. 
- If an existing keyword, without skos identifier, matches a prefered keyword by (translated) string or synonym, then append the matched keyword (including skos identifier). 

To facilitate this use case the SWR contains a knowledge graph of prefered keywords in the soil domain derived from agrovoc, gemet and iso11074. This knowledge graph is maintained at <https://github.com/soilwise-he/soil-health-knowledge-graph>. These vocabularies are multilingual, facilitating the translation case.

For metadata records which have not been analysed yet (in that iteration), the module extracts the keywords, for each keyword an analyses is made if it maches any of the prefered keywords, if so, the prefered keyword is added to the augmentation results for that record. For string matching a fuzzy match algorythm is used, requiring a 90% match (configurable). Translations are matched using the metadata language as indicated in the record.

The process runs as a CI-CD pipeline at dayly intervals.

#### Technology
   * **Python**
        Used for the keyword matching and database interactions
   * **[PostgreSQL](https://www.postgresql.org/){target=_blank}**
        Primary database for storing and managing information
   * **Docker** 
        Used for containerizing the application, ensuring consistent deployment across environments
   * **CI/CD**
        Automated pipeline for continuous integration and deployment, with scheduled dayly runs


### Translation module

!!! component-header "Info"
    **Current version:** 0.2.0

    **Projects:** [Translation](https://github.com/soilwise-he/metadata-augmentation/tree/main/translation)

Some records arrive in a local language, SWR translates the main properties for the record: title and abstract into English, to offer a single language user experience. The translations are used in filtering and display of records.

The translation module builds on the EU translation service (API documentation at <https://language-tools.ec.europa.eu/>). Translations are stored in a database for reuse by the SWR.

The EU translation returns asynchronous responses to translation requests, this means that translations may not yet be available after initial load of new data. A callback operation populates the database, from that moment a translation is available to SWR. The translation service uses 2-letter language codes, it means a translation from a 3-letter iso code (as used in for example iso19139:2007) to 2-letter code is required. The EU translation service has a limited set of translations from a certain to alternative language available, else returns an error.

Initial translation is triggered by a running harvester. The translations will then be available once the record is ingested to the triplestore and catalogue database in a followup step of the harvester. 

#### Technology
   * **Python**
        Used for the translation module, API development, and database interactions
   * **[PostgreSQL](https://www.postgresql.org/){target=_blank}**
        Primary database for storing and managing information
   * **[FastAPI](https://fastapi.tiangolo.com/){target=_blank}**
        Employed to create and expose REST API endpoints. 
        Utilizes FastAPI's efficiency and auto-generated [Swagger](https://swagger.io/docs/specification/2-0/what-is-swagger/){target=_blank} documentation
   * **Docker** 
        Used for containerizing the application, ensuring consistent deployment across environments
   * **CI/CD**
        Automated pipeline for continuous integration and deployment, with scheduled dayly runs


## Keyword extraction

!!! component-header "Info"
    **Current version:** 0.2.0

    **Project:** [NER augmentation](https://github.com/soilwise-he/metadata-augmentation/tree/main/NER%20augmentation)

The value of relevant keywords is often underestimated by data producers. This module evaluates the metadata title/abstract to identify relevant keywords using NLP/NER technology.

## Metadata interlinker

To be able to provide interlinked data and knowledge assets (e.g. a dataset, the project in which it was generated and the operating procedure used) links between metadata must be identified and registered ideally as part of the [SWR Triple Store](./storage.md#virtuoso-triple-store-storage-of-swr-knowledge-graph).

We distinguish between explicit and implicit links:

- **Explicit links** can be directly derived from the data and/or metadata. E.g. projects in CORDIS are explicitly linked to documents and datasets. 
- **Implicit links** can not be directly derived from the (meta)data. They may be derived by spatial or temporal extent, keyword usage, or shared author/publisher. 

SWR-1 implements the interlinking of data and knowledge assets based on explicit links that are found in the harvested metadata. The harvesting processes implemented in SWR-1 have been extended with this function to detect such linkages and store them in the repository and add them to the SWR knowledge graph. This allows e.g. exposing this additional information to the UI for displaying and linkage the  and other functions. 

## Foreseen functionality

In the next iterations, Metadata augmentation component is foreseen to include the following additional functions:

### Spatial Locator

The module is foreseen to analyse existing keywords to find a relevant geography for the record. It will then use a gazeteer to find spatial coordinates for the geography, which will be inserted into the metadata record. Vice versa, if the record has a geography it will use reverse gazeteer to find a matching location keyword.

### Spatial scope analyser

A module that is foreseen to analyse the spatial scope of a resource.

The bounding box will be matched to country or continental bounding boxes using a gazeteer.

To understand if the dataset has a global, continental, national or regional scope

- Retrieves all datasets (as iso19139 xml) from database (records table joined with augmentations) which:
    - have a bounding box 
    - no spatial scope
    - in iso19139 format
- For each record it compares the boundingbox to country bounding boxes: 
    - if bigger then continents > global
    - If matches a continent > continental
    - if matches a country > national
    - if smaller > regional
- result is written to as an augmentation in a dedicated table

### EUSO-high-value dataset tagging

The EUSO high-value datasets are those with substantial potential to assess soil health status, as detailed on the [EUSO dashboard](https://esdac.jrc.ec.europa.eu/esdacviewer/euso-dashboard/){target=_blank}. This framework includes the concept of [soil degradation indicator](https://esdac.jrc.ec.europa.eu/content/soil-degradation-indicators-eu){target=_blank} metadata-based identification and tagging. Each dataset (possibly only those with the supra-national spatial scope - under discussion) will be annotated with a potential soil degradation indicator for which it might be utilised. Users can then filter these datasets according to their specific needs. 

The EUSO soil degradation indicators employ specific [methodologies and thresholds](https://esdac.jrc.ec.europa.eu/euso/euso-dashboard-sources){target=_blank} to determine soil health status, see also the Table below. These methodologies will also be considered, as they may have an impact on the defined thresholds. This issue will be examined in greater detail in the future.

<table>
  <tr>
    <th>Soil Degradation</th>
    <th>Soil Indicator</th>
    <th>Type of methodic for threshold</th>
  </tr>
  <tr>
    <td rowspan="5" style="text-align: center; vertical-align: middle; font-weight: bold;">Soil erosion</td>
    <td>Water erosion</td>
    <td>RUSLE2015</td>
  </tr>
  <tr>
    <td>Wind erosion</td>
    <td>GIS-RWEQ</td>
  </tr>
  <tr>
    <td>Tillage erosion</td>
    <td>SEDEM</td>
  </tr>
  <tr>
    <td>Harvest erosion</td>
    <td>Textural index</td>
  </tr>
  <tr>
    <td>Post-fire recovery</td>
    <td>USLE (Type of RUSLE)</td>
  </tr>
  <tr>
    <td rowspan="5" style="text-align: center; vertical-align: middle; font-weight: bold;">Soil pollution</td>
    <td>Arsenic excess</td>
    <td>GAMLSS-RF</td>
  </tr>
  <tr>
    <td>Copper excess</td>
    <td>GLM and GPR</td>
  </tr>
  <tr>
    <td>Mercury excess</td>
    <td>LUCAS topsoil database</td>
  </tr>
  <tr>
    <td>Zinc Excess</td>
    <td>LUCAS topsoil database</td>
  </tr>
  <tr>
    <td>Cadmium Excess</td>
    <td>GEMAS</td>
  </tr>
  <tr>
    <td rowspan="3" style="text-align: center; vertical-align: middle; font-weight: bold;">Soil nutrients</td>
    <td>Nitrogen surplus</td>
    <td>NNB</td>
  </tr>
  <tr>
    <td>Phosphorus deficiency</td>
    <td>LUCAS topsoil database</td>
  </tr>
  <tr>
    <td>Phosphorus excess</td>
    <td>LUCAS topsoil database</td>
  </tr>
  <tr>
    <td style="text-align: center; vertical-align: middle; font-weight: bold;">Loss of soil organic carbon</td>
    <td>Distance to maximum SOC level</td>
    <td>qGAM</td>
  </tr>
  <tr>
    <td style="text-align: center; vertical-align: middle; font-weight: bold;">Loss of soil biodiversity</td>
    <td>Potential threat to biological functions</td>
    <td>Expert Polling, Questionnaire, Data Collection, Normalization and Analysis</td>
  </tr>
  <tr>
    <td style="text-align: center; vertical-align: middle; font-weight: bold;">Soil compaction</td>
    <td>Packing density</td>
    <td>Calculation of Packing Density (PD)</td>
  </tr>
  <tr>
    <td style="text-align: center; vertical-align: middle; font-weight: bold;">Salinization</td>
    <td>Secondary salinization</td>
    <td>-</td>
  </tr>
  <tr>
    <td style="text-align: center; vertical-align: middle; font-weight: bold;">Loss of organic soils</td>
    <td>Peatland degradation</td>
    <td>-</td>
  </tr>
  <tr>
    <td style="text-align: center; vertical-align: middle; font-weight: bold;">Soil consumption</td>
    <td>Soil sealing</td>
    <td>Raster remote sense data</td>
  </tr>
</table>

Technically, we forsee the metadata tagging process as illustrated below. At first, metadata record's title, abstract and keywords will be checked for the occurence of specific **values from the Soil Indicator and Soil Degradation Codelists**, such as `Water erosion` or `Soil erosion` (see the Table above). If found, the `Soil Degradation Indicator Tag` (corresponding value from the Soil Degradation Codelist) will be displayed to indicate suitability of given dataset for soil indicator related analyses. Additionally, a search for corresponding **methodology** will be conducted to see if the dataset is compliant with the EUSO Soil Health indicators presented in the [EUSO Dashboard](https://esdac.jrc.ec.europa.eu/esdacviewer/euso-dashboard/){target=_blank}. If found, the tag `EUSO High-value dataset` will be added. In later phase we assume search for references to Scientific Methodology papers in metadata record's links. Next, the possibility of involving a more complex search using soil thesauri will also be explored.


``` mermaid
flowchart TD
    subgraph ic[Indicators Search]
        ti([Title Check]) ~~~ ai([Abstract Check])
        ai ~~~ ki([Keywords Check])
    end
    subgraph Codelists
        sd ~~~ si
    end
    subgraph M[Methodologies Search]
        tiM([Title Check]) ~~~ aiM([Abstract Check])
        kl([Links check]) ~~~ kM([Keywords Check])
    end
    m[(Metadata Record)] --> ic
    m --> M
    ic-- + ---M
    sd[(Soil Degradation Codelist)] --> ic
    si[(Soil Indicator Codelist)] --> ic
    em[(EUSO Soil Methodologies list)] --> M
    M --> et{{EUSO High-Value Dataset Tag}}
    et --> m
    ic --> es{{Soil Degradation Indicator Tag}}
    es --> m
    th[(Thesauri)]-- synonyms ---Codelists
```


