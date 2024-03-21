# Metadata scheme

## Semantic Web specifications for meta-data

### Dublin Core

The Dublin Core Metadata Element Set (DCMES), better known simply as [Dublin
Core](https://www.rfc-editor.org/rfc/rfc5013.html), was the first meta-data
infrastructure produced within the Semantic Web. It owns its name to a city in
Ohio, wherein its foundations were laid in 1995.  Dublin Core was formalised as
[ISO-15836](https://www.iso.org/standard/71339.html) in 2003 and is maintained
by the Dublin Core Metadata Initiative (DCMI), a branch of the Association for
Information Science and Technology (ASIS&T). A revision was published in 2017
(ISO-15836-1:2017).


The first complete release of Dublin Core dates back to 2000, comprising
fifteen meta-data terms meant to describe physical and digital resources,
independently of context. In its first iterations, these terms were loosely
defined, without specification on their application to resources. In 2012 a RDF
model was released, thereafter known as DCMI Metadata Terms. Still it kept its
flexibility, not imposing constraints on the resources with which the terms can
be used.


The DCMI Metadata Terms are organised within four modules, digested below:

- **[Elements](http://purl.org/dc/elements/1.1/)**: the original set of
  elements published in 2000, specified as RDF properties. Among other
  concepts, includes `dc:contributor`, `dc:creator`, `dc:date`,
  `dc:identifier`, `dc:language`, `dc:publisher`, `dc:rights` and `dc:title`. 

- **[Terms](http://purl.org/dc/terms/)**: it includes the original fifteen
  elements, but adds classes and restrictions on their use. This module also
  specifies relations between its elements, meant for a more formal application
  of the standard. Of note are the classes `dcterms:BibliographicResource`,
  `dcterms:LicenseDocument`, `dcterms:Location` and `dcterms:PeriodOfTime`.
  Among the predicates it defines `dcterms:license` and `dcterms:provenance`
  can be highlighted.

- **[DCMI Type](http://purl.org/dc/dcmitype/)**: defines a further set of
  resource classes that may be described with Dublin Core meta-data terms. This
  set includes classes such as `Collection`, `Dataset`, `Image`,
  `PhysicalObject`, `Service`, `Software`, `Sound` and `Text`. 

- **[Abstract Model](http://purl.org/dc/dcam/)**: meant to document meta-data
  themsleves and general not expected to be applied by end users.


### FOAF



### VCard

In 2014 the W3C developed an ontology mapping elements of the [vCard business
card standard](https://www.rfc-editor.org/rfc/rfc6350) to OWL, abstracting
persons, organisations and contacts. The [vCard web
ontology](https://www.w3.org/TR/vcard-rdf/) specifies a set of classes and
properties, but without limiting ranges and domains on the latter. vCard is
meant to be used together with other meta-data ontologies, particularly Friend
of a Friend (FOAF).

The main classes in vCard representing contactable entities are `Individual`,
`Organisation` and `Group`. Within contact means classes are found `Address`,
`EMail`, `Location` and `Phone` (the later specialised in various sub-classes).
A collection of object properties relates this two kinds of classes together,
with a further set of data-type properties providing for the concrete
definition of each contact instance. 


### DCAT

The [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat-2/) (DCAT) is
the *de facto* Semantic Web standard for meta-data, maintained by the W3C. Its main
purpose is to catalogue and identify data resources, re-using various concepts
from other ontologies. In particular, terms from Dublin Core and classes from
FOAF and VCard are part of the specification. DCAT is not restricted to
represent meta-data of knowledge graphs, it even encompasses the concept of
multiple representations for the same data. Among the most relevant classes
specified by DCAT are:

- `Resource`: any concrete thing on the Web, in principle identifiable by a
  URI. `Dataset`, `DataService` and `Catalog` are sub-classes of `Resource`. 

- `Dataset`: a collection of data, published or curated by a single entity. In
  general represents a knowledge graph that may be encoded and/or presented in
  different ways, and even be available from different locations.

- `DataService`: an operation providing data access and/or data
  processing. Expected to correspond to a service location on the internet
  (i.e. an endpoint).

- `Distribution`: a particular representation of a `Dataset` instance. More
  than one distribution may exist for the same dataset (e.g. Turtle and XML for
  the same knowledge graph).

- `Catalog`: a collection of meta-data on related resources, e.g. available at
  the same location, or published by the same entity. A catalogue should
  represent a single location on the Web.

- `CatalogRecord`: a document or internet resource providing meta-data for a
  single dataset (or other type of resource). It corresponds to the
  registration of a dataset with a catalogue. 

- `Relationship`: specifies the association between two resources. It is a
  sub-class of the `EntityInfluence` class in the PROV ontology.


### PROV

## Soil Semantics


## Notes (outdated)

- developing metadata templates using standards

- connections with: data input and structure
- technologies used: DCAT; VCard; Dublin Core; PROV; plus GloSIS for Soil Semantics
- responsible person: Luís de Sousa
- participating: Tomas Reznik
