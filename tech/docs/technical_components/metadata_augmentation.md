# Metadata Augmentation

!!! component-header "Info"

    **Current version:**
    
    **Project:** [Metadata augmentation](https://github.com/soilwise-he/metadata-augmentation)

## Functionality

In this component scripting / NLP / LLM are used on a metadata record to augment metadata statements about the resource. Augmentations are stored on a dedicated augmentation table, indicating the process which produced it.

| metadata-uri | metadata-element | source | value | proces | date |
| --- | --- | --- | --- | --- | --- |
| https://geo.fi/data/ee44-aa22-33 | spatial-scope | 16.7,62.2,18,81.5 |  https://inspire.ec.europa.eu/metadata-codelist/SpatialScope/national | spatial-scope-analyser | 2024-07-04 |
| https://geo.fi/data/abc1-ba27-67 | soil-thread | This dataset is used to evaluate Soil Compaction in Nuohous Sundström | http://aims.fao.org/aos/agrovoc/c_7163 | keyword-analyser | 2024-06-28 |

### Spatial scope analyser

A script that analyses the spatial scope of a resource

The bounding box is matched to country bounding boxes

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

| metadata-uri | metadata-element | source | value | proces | date |
| --- | --- | --- | --- | --- | ---|
| https://geo.fi/data/ee44-aa22-33 | spatial-scope | 16.7,62.2,18,81.5 |  https://inspire.ec.europa.eu/metadata-codelist/SpatialScope/national | spatial-scope-analyser | 2024-07-04 |
| https://geo.fi/data/abc1-ba27-67 | spatial-scope | 17.4,68.2,17.6,71,2 |  https://inspire.ec.europa.eu/metadata-codelist/SpatialScope/regional | spatial-scope-analyser | 2024-07-04 |

## Foreseen functionality

### Translation module

Many records arrive in a local language, we aim to capture at least english main properties for the record: title, abstract, keywords, lineage, usage constraints

- has a db backend, every translation is captured in a database
- the EU translation service is used, this service returns a asynchronous response to an API endpoint (callback)
- the callback populates the database, next time the translation is available
- make sure that frontend indicates if a string has been machine translated, with option to flag as inappropriate

API documentation: <https://language-tools.ec.europa.eu/>

### Keywords matcher

Analyses existing keywords on a metadata record, it matches an existing keyword to a list of predefined keywords, augmenting the keyword to include a thesaurus and uri reference (potentially a translation to English).

It requires a database (relational or RDF) with common thesauri.

### Metadata cleaning


### Spatial Locator

Analyses existing keywords to find a relevant geography for the record, it then uses the geonames api to find spatial coordinates for the geography, which are inserted into the metadata record.


### EUSO-high-value dataset tagging
