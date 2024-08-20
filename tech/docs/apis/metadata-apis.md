# Discovery APIs

In order to enable resource discovery from SoilWise to a variety of communities. SWR aims to evaluate a wide range of standardised or de-facto discovery APIs

- Sparql (DCAT/Dublin Core/OpenAire)
- OAI-PMH + Dublin core (open archives initiative)
- Sitemap.xml + schema.org (Search engines)
- Catalog service for the Web, Spatio temporal Asset Catalog and OGC API records (OGC)

## Sparql (DCAT/SKOS)

Advanced queries can be composed using [SPARQL](./sparql.md), using the DCAT, Dublin Core and SKOS ontologies

## OAI-PMH + Dublin core

With this endpoint, we aim to enable academia and the open data community to interact with the SWR. Records from SWR can be harvested from CKAN and Dataverse software using this interface.

## Sitemap.xml + schema.org

The search engine community typically uses the Sitemap and schema.org annotations to crawl the SWR content

## Catalog service for the Web, STAC and OGC API records

The spatial community typically use CSW and OGC API Records to interact with catalogues. An example scenario is a catalogue search from within QGIS, using the Metasearch panel.
