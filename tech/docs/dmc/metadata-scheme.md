# Metadata scheme

This article is split in

- [Semantic Web specifications for meta-data](#semantic-web-specifications-for-meta-data)
- [Domain models for meta-data](#domain-models-for-meta-data)
- [Thesauri](#thesauri)

## Semantic Web specifications for meta-data

This section briefly reviews the specifications issued by the World Wide Web
Consortium (W3C) for the encoding of meta-data. The most relevant of these is
DCAT, however, as is paramount in the Semantic Web, this ontology is meant to be
used together with other specifications. 

The web ontologies review here not only complement each other, but in many cases
even overlap. Such is the nature of the Semantic Web, a single instance can be
simultaneously be declared as a `foaf:Person`, a `vcard:Individual` and a
`prov:Agent`, in doing so creating semantic links to multiple ontologies,
greatly boosting its meaning and effectiveness.   

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


[Friend of a Friend](http://xmlns.com/foaf/0.1/) (FOAF) was the first web
ontology expressing personal relationships in OWL. It specifies axioms
describing persons, how they relate to each other and to resources on the
internet. From a personal profile described with FOAF it is possible to
automatically derive information such as the set of people known to two
different individuals. As an early meta-data specification, FOAF has been
popular to relate and describe people associated to web
resources. The [ActivityPub](https://www.w3.org/TR/activitypub/) specification,
basis of the Fediverse, was influenced by FOAF.

Among the concepts specified by FOAF feature `Person`, `Agent`, `Organization`,
`Group`, `Document`, `PersonalProfileDocument`, `Image`, `OnlineAccount` and
`Project`. These are related by a comprehensive collection of data and object
properties whose meaning is mostly straightforward to understand.   

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

[PROV](http://www.w3.org/TR/2013/REC-prov-o-20130430/) defines a core domain
model for provenance, to build representations of the entities, people and
processes involved in producing a piece of data or thing in the world. This
specification is meant to express provenance records, containing descriptions of
the entities and activities involved in producing, delivering or otherwise
influencing a given object. Provenance can be used for many purposes, such as
understanding how data was collected so it can be meaningfully used, determining
ownership and rights over an object, making judgements about information to
determine whether to trust it, verifying that the process and steps used to
obtain a result complies with given requirements, and reproducing how something
was generated. 

PROV defines classes at a high level of abstraction. In most cases these classes
must be specialised to a specific in order to be useful. The most relevant
classes are:

- `Entity`: physical, digital, conceptual, or other kind of thing. Examples of
  such entities are a web page, a chart, or a spellchecker. Provenance records
  can describe the provenance of entities.

- `Activity`: explains how entities come into existence and how their attributes
  change to become new entities. It is a dynamic aspect of the world, such as
  actions, processes, etc. Activities often create new entities. 

- `Agent`: takes a role in an activity such that the agent can be assigned some
  degree of responsibility for the activity taking place. An agent can be a
  person, a piece of software, an inanimate object, an organisation, or other
  entities that may be ascribed responsibility.

- `Role`: a description of the function or the part that an entity played in an
  activity. It specifies the relationship between an entity and an activity,
  i.e. how the activity used or generated the entity. Roles also specify how
  agents are involved in an activity, qualifying their participation in the
  activity or specifying for which aspect each agent was responsible.

### Schema.org

[schema.org](https://en.wikipedia.org/wiki/Schema.org) is an ontology developed by the main search engines to enrich websites with structured content about the topics described on that page (microdata). schema.org annotations (microdata) are typically added using an embedded json-ld document, but can als be added as RDF-a.

The relevant entities in the schem.org ontology are [DataCatalog](https://schema.org/DataCatalog) and [Dataset](https://schema.org/Dataset) 

Schema.org is used in repositories such as [dataone.org](https://dataone.org) and [Google Dataset Search](https://datasetsearch.research.google.com/).

## Domain models for meta-data

### Datacite

[Datacite](https://schema.datacite.org) is a list of core metadata properties chosen for an accurate and consistent identification of a resource for citation and retrieval purposes, along with recommended use instructions. Datacite is common in academic tools such as Datacite, Dataverse, Zenodo, OSF.

### ISO19115

TC211 developed the initial version of ISO19115 in [2003](https://www.iso.org/standard/26020.html), and a followup in [2014](https://www.iso.org/standard/53798.html). A working group is currently preparing a new version. It is a meta-data model to describe spatial resources, such as datasets, services and features. Part of and related to this work are the models for data quality ISO19157, services ISO19119 and data models ISO19110.

An XML serialisation of the models is available in [ISO19139:2007](https://www.iso.org/standard/32557.html). Although withdrawn, iso19139:2007 is still the de-facto meta-data standard in the geospatial domain in Europe.

### Ecological Metadata Language (EML)

[EML](https://eml.ecoinformatics.org/) defines a comprehensive vocabulary and a readable XML markup syntax for documenting research data. It is in widespread use in the earth and environmental sciences, and increasingly in other research disciplines as well. EML is a community-maintained specification, and evolves to meet the data documentation needs of researchers who want to openly document, preserve, and share data and outputs. EML includes modules for identifying and citing data packages, for describing the spatial, temporal, taxonomic, and thematic extent of data, for describing research methods and protocols, for describing the structure and content of data within sometimes complex packages of data, and for precisely annotating data with semantic vocabularies. EML includes metadata fields to fully detail data papers that are published in journals specializing in scientific data sharing and preservation.


## Thesauri

Keywords referenced from meta-data preferably originate from common thesauri. The section below provides a listing of revelant thesauri in the soil domain.

### INSPIRE registry

The [INSPIRE registry](https://inspire.ec.europa.eu/registry) provides a central access point to a number of centrally managed INSPIRE registers. The content of these registers are based on the INSPIRE Directive, Implementing Rules and Technical Guidelines.

### GEneral Multilingual Environmental Thesaurus (GEMET)

[GEMET](https://www.eionet.europa.eu/gemet/en/about/) is a source of common and relevant terminology used under the ever-growing environmental agenda.

### Agrovoc

[AGROVOC Multilingual Thesaurus](https://agrovoc.fao.org/browse/agrovoc/en/), including definitions from the [World Reference Base on Soil description](https://agrovoc.fao.org/browse/agrovoc/en/page/?clang=da&uri=c_89f35c33)

### GLOSIS web ontology

[GLOSIS codelists](http://w3id.org/glosis/model/codelists) is a community initiative originating from the GSP GLOSIS initiative, including soil properties, soil description codelists, soil analysis procedures

### GBIF

[GBIF](https://gbif.org) maintains thesauri for ecological phenomena such as [species](https://www.gbif.org/species)


## Metadata

- connections with: data input and structure
- responsible person: Luís de Sousa
- participating: Tomas Reznik, Paul van Genuchten
