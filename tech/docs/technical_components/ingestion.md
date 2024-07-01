#  Harvester

!!! component-header "Important Links"
    :fontawesome-brands-github: Project: [Harvesters](https://github.com/soilwise-he/harvesters)

The Harvester component is dedicated to automatically harvest sources to populate SWR with metadata on [datasets](#datasets) and [knowledge sources](#knowledge-sources).

## Automated metadata harvesting concept

Metadata harvesting is the process of ingesting metadata, i.e. evidence on data and knowledge, from remote sources and storing it locally in the catalogue for fast searching. It is a scheduled process, so local copy and remote metadata are kept aligned. Various components exist which are able to harvest metadata from various (standardised) API's. SoilWise aims to use existing components where available.

The harvesting mechanism relies on the concept of a _universally unique identifier (UUID)_ or _unique resource identifier (URI)_ that is being assigned commonly by metadata creator or publisher. Another important concept behind the harvesting is the _last change date_. Every time a metadata record is changed, the last change date is updated. Just storing this parameter and comparing it with a new one allows any system to find out if the metadata record has been modified since last update. An exception is if metadata is removed remotely. SoilWise Repository can only derive that fact by harvesting the full remote content. Disucssion is needed to understand if SWR should keep a copy of the remote source anyway, for archiving purposes. All metadata with an update date newer then _last-identified successfull harvester run_ are extracted from remote location. 

## Resource Types

Metadata for following resource types are foreseen to be harvested:

- Data & Knowledge Resources (Articles/Datasets/Videos/Software/Services)
- Projects/LTE/Living labs
- Funding schemes (Mission-soil)
- Organisations
- Repositories/Catalogues

These entities relate to each other as:

``` mermaid
flowchart LR
    people -->|memberOf| o[organisations] 
    o -->|partnerIn| p[projects]
    p -->|produce| d[data & knowledge resources]
    o -->|publish| d
    d -->|describedIn| c[catalogues]
    p -->|part-of| fs[Fundingscheme]
```

## Origin of harvested resources

### Datasets

Datasets are to be primarily imported from the **ZENODO**, **INSPIRE GeoPortal**, **BonaRes** as well as **Cordis**. In later iterations SoilWise aims to also include other projects and portals, such as **national** or **thematic portals**. These repositories contain a huge number of datasets. Selection of key datasets concerning the SoilWise scope is a subject of know-how to be developed within SoilWise.

### Knowledge sources

With respect to harvesting, it is important to note that knowledge assets are heterogeneous, and that (compared to data), metadata standards and particularly access / harvesting protocols are not generally adopted. Available metadata might be implemented using a proprietary schema, and basic assumptions for harvesting, e.g. providing a "date of last change" might not be offered. This will, in some cases, make it necessary to develop customized harvesting and metadata extraction processes. It also means that informed decisions need to be made on which resources to include, based on priority, required efforts and available capacity.

The SoilWise project team is still exploring which knowledge resources to include. An important cluster of knowledge sources are academic articles and report deliverables from Mission Soil Horizon Europe projects. These resources are accessible from **Cordis**, **Zenodo** and **OpenAire**. Extracting content from Cordis, OpenAire, and Zenodo can be achieved using a harvesting task (using the Cordis schema, extended with post processing). For the first iteration, SoilWise aims to achieve this goal. In future iterations new knowledge sources may become relevant, we will investigate at that moment what is the best approach to harvest them.

### Catalogue APIs and models

Catalogues typically offer standardised APIs as well as tailored APIs to extract resources. Typically, the tailored APIs offer extra capabilities which may be relevant to SoilWise. However in general we should adopt the standardised interfaces, because it allows us to use of the shelf components with high TRL.

Standardised APIs are available for harvesting records from:

- Catalogue Service for the Web (OGC:CSW)
- Protocol metadata harvesting (OAI-PMH)
- SPARQL
- Sitemap.xml 

### Semantic Web specifications for metadata

This section briefly reviews the specifications issued by the World Wide Web
Consortium (W3C) for the encoding of metadata. The most relevant of these is
DCAT, however, as is paramount in the Semantic Web, this ontology is meant to be
used together with other specifications. 

The web ontologies review here not only complement each other but in many cases
even overlap. Such is the nature of the Semantic Web, a single instance can be
simultaneously be declared as a `foaf:Person`, a `vcard:Individual` and a
`prov:Agent`, in doing so creating semantic links to multiple ontologies,
greatly boosting its meaning and effectiveness.   

#### Dublin Core

The Dublin Core Metadata Element Set (DCMES), better known simply as [Dublin
Core](https://www.rfc-editor.org/rfc/rfc5013.html){target=_blank}, was the first metadata
infrastructure produced within the Semantic Web. It owns its name to a city in
Ohio, wherein its foundations were laid in 1995.  Dublin Core was formalised as
[ISO-15836](https://www.iso.org/standard/71339.html){target=_blank} in 2003 and is maintained
by the Dublin Core Metadata Initiative (DCMI), a branch of the Association for
Information Science and Technology (ASIS&T). A revision was published in 2017
(ISO-15836-1:2017).


The first complete release of Dublin Core dates back to 2000, comprising
fifteen metadata terms meant to describe physical and digital resources,
independently of context. In its first iterations, these terms were loosely
defined, without specification on their application to resources. In 2012 a RDF
model was released, thereafter known as DCMI Metadata Terms. Still it kept its
flexibility, not imposing constraints on the resources with which the terms can
be used.


The DCMI Metadata Terms are organised within four modules, digested below:

- **[Elements](http://purl.org/dc/elements/1.1/){target=_blank}**: the original set of
  elements published in 2000, specified as RDF properties. Among other
  concepts, includes `dc:contributor`, `dc:creator`, `dc:date`,
  `dc:identifier`, `dc:language`, `dc:publisher`, `dc:rights` and `dc:title`. 

- **[Terms](http://purl.org/dc/terms/){target=_blank}**: it includes the original fifteen
  elements but adds classes and restrictions on their use. This module also
  specifies relations between its elements, meant for a more formal application
  of the standard. Of note are the classes `dcterms:BibliographicResource`,
  `dcterms:LicenseDocument`, `dcterms:Location` and `dcterms:PeriodOfTime`.
  Among the predicates, it defines `dcterms:license` and `dcterms:provenance`
  can be highlighted.

- **[DCMI Type](http://purl.org/dc/dcmitype/){target=_blank}**: defines a further set of
  resource classes that may be described with Dublin Core metadata terms. This
  set includes classes such as `Collection`, `Dataset`, `Image`,
  `PhysicalObject`, `Service`, `Software`, `Sound` and `Text`. 

- **[Abstract Model](http://purl.org/dc/dcam/){target=_blank}**: meant to document metadata
  themselves and generally not expected to be applied by end users.


#### FOAF

[Friend of a Friend](http://xmlns.com/foaf/0.1/){target=_blank} (FOAF) was the first web
ontology expressing personal relationships in OWL. It specifies axioms
describing persons, how they relate to each other and to resources on the
internet. From a personal profile described with FOAF, it is possible to
automatically derive information such as the set of people known to two
different individuals. As an early metadata specification, FOAF has been
popular to relate and describe people associated with web
resources. The [ActivityPub](https://www.w3.org/TR/activitypub/){target=_blank} specification,
the basis of the Fediverse, was influenced by FOAF.

Among the concepts specified by FOAF feature `Person`, `Agent`, `Organization`,
`Group`, `Document`, `PersonalProfileDocument`, `Image`, `OnlineAccount` and
`Project`. These are related by a comprehensive collection of data and object
properties whose meaning is mostly straightforward to understand.   

#### VCard

In 2014, the W3C developed an ontology mapping elements of the [vCard business
card standard](https://www.rfc-editor.org/rfc/rfc6350){target=_blank} to OWL, abstracting
persons, organisations and contacts. The [vCard web
ontology](https://www.w3.org/TR/vcard-rdf/){target=_blank} specifies a set of classes and
properties, but without limiting ranges and domains on the latter. vCard is
meant to be used together with other metadata ontologies, particularly Friend
of a Friend (FOAF).

The main classes in vCard representing contactable entities are `Individual`,
`Organisation` and `Group`. Within contact means classes are found `Address`,
`EMail`, `Location` and `Phone` (the later specialised in various sub-classes).
A collection of object properties relates these two kinds of classes together,
with a further set of data-type properties providing the concrete
definition of each contact instance. 

#### DCAT

The [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat-2/){target=_blank} (DCAT) is
the *de facto* Semantic Web standard for metadata, maintained by the W3C. Its main
purpose is to catalogue and identify data resources, re-using various concepts
from other ontologies. In particular, terms from Dublin Core and classes from
FOAF and VCard are part of the specification. DCAT is not restricted to
representing metadata of knowledge graphs, it even encompasses the concept of
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

- `Catalog`: a collection of metadata on related resources, e.g. available at
  the same location, or published by the same entity. A catalogue should
  represent a single location on the Web.

- `CatalogRecord`: a document or internet resource providing metadata for a
  single dataset (or other type of resource). It corresponds to the
  registration of a dataset with a catalogue. 

- `Relationship`: specifies the association between two resources. It is a
  sub-class of the `EntityInfluence` class in the PROV ontology.

#### PROV

[PROV](http://www.w3.org/TR/2013/REC-prov-o-20130430/){target=_blank} defines a core domain
model for provenance, to build representations of the entities, people, and
processes involved in producing a piece of data or thing in the world. This
specification is meant to express provenance records, containing descriptions of
the entities and activities involved in producing, delivering or otherwise
influencing a given object. Provenance can be used for many purposes, such as
understanding how data was collected so it can be meaningfully used, determining
ownership and rights over an object, making judgements about information to
determine whether to trust it, verifying that the process and steps used to
obtain a result that complies with given requirements, and reproduce how something
was generated. 

PROV defines classes at a high level of abstraction. In most cases, these classes
must be specialised to a specific level in order to be useful. The most relevant
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

### Other domain models for metadata

#### Schema.org

[schema.org](https://en.wikipedia.org/wiki/Schema.org){target=_blank} is an ontology developed by the main search engines to enrich websites with structured content about the topics described on that page (microdata). schema.org annotations (microdata) are typically added using an embedded json-ld document but can also be added as RDF-a.

The relevant entities in the schem.org ontology are [DataCatalog](https://schema.org/DataCatalog){target=_blank} and [Dataset](https://schema.org/Dataset){target=_blank} 

Schema.org is used in repositories such as [dataone.org](https://dataone.org){target=_blank} and [Google Dataset Search](https://datasetsearch.research.google.com/){target=_blank}.

#### Datacite

[Datacite](https://schema.datacite.org){target=_blank} is a list of core metadata properties chosen for accurate and consistent identification of a resource for citation and retrieval purposes, along with recommended use instructions. Datacite is common in academic tools such as Datacite, Dataverse, Zenodo, and OSF.

#### ISO19115

TC211 developed the initial version of ISO19115 in [2003](https://www.iso.org/standard/26020.html){target=_blank}, and a followup in [2014](https://www.iso.org/standard/53798.html){target=_blank}. A working group is currently preparing a new version. It is a metadata model to describe spatial resources, such as datasets, services and features. Part of and related to this work are the models for data quality ISO19157, services ISO19119 and data models ISO19110.

An XML serialisation of the models is available in [ISO19139:2007](https://www.iso.org/standard/32557.html){target=_blank}. Although withdrawn, iso19139:2007 is still the de-facto metadata standard in the geospatial domain in Europe, being used by the INSPIRE Directive as a harmonisation mean for all geospatial environmental evidence.

#### Ecological Metadata Language (EML)

[EML](https://eml.ecoinformatics.org/){target=_blank} defines a comprehensive vocabulary and a readable XML markup syntax for documenting research data. It is in widespread use in the earth and environmental sciences, and increasingly in other research disciplines as well. EML is a community-maintained specification and evolves to meet the data documentation needs of researchers who want to openly document, preserve, and share data and outputs. EML includes modules for identifying and citing data packages, for describing the spatial, temporal, taxonomic, and thematic extent of data, for describing research methods and protocols, for describing the structure and content of data within sometimes complex packages of data, and for precisely annotating data with semantic vocabularies. EML includes metadata fields to fully detail data papers that are published in journals specializing in scientific data sharing and preservation.


### Thesauri

Keywords referenced from metadata preferably originate from common thesauri. The section below provides a listing of relevant thesauri in the soil domain.

#### INSPIRE registry

The [INSPIRE registry](https://inspire.ec.europa.eu/registry){target=_blank} provides a central access point to a number of centrally managed INSPIRE registers. The content of these registers are based on the INSPIRE Directive, Implementing Rules and Technical Guidelines.

#### GEneral Multilingual Environmental Thesaurus (GEMET)

[GEMET](https://www.eionet.europa.eu/gemet/en/about/){target=_blank} is a source of common and relevant terminology used under the ever-growing environmental agenda.

#### Agrovoc

[AGROVOC Multilingual Thesaurus](https://agrovoc.fao.org/browse/agrovoc/en/){target=_blank}, including definitions from the [World Reference Base on Soil description](https://agrovoc.fao.org/browse/agrovoc/en/page/?clang=da&uri=c_89f35c33){target=_blank}.

#### GLOSIS web ontology

[GLOSIS codelists](http://w3id.org/glosis/model/codelists){target=_blank} is a community initiative originating from the GSP GLOSIS initiative, including soil properties, soil description codelists, and soil analysis procedures.

#### GBIF

[GBIF](https://gbif.org){target=_blank} maintains thesauri for ecological phenomena such as [species](https://www.gbif.org/species){target=_blank}.

## Persistence identification

The [Uniform Resource Identifier](https://www.rfc-editor.org/rfc/rfc2396){target=_blank} (URI)
is one of the earliest and most consequent specifications of the Semantic Web.
Originally meant to identify web resources, it became a central piece of the Web
of data concept with the [Resource Description
Framework](https://www.w3.org/TR/WD-rdf-schema/){target=_blank} (RDF). In time researchers
understood not only its relevance in providing unique and universal identifiers to
data, but also the importance of their longevity, past the lifetime of
projects, organisations or institutions. Thus emerged the concept of Persistent
Unique Identifier (PI or PID, i.e. a URI valid "forever") and its recognition
[as the foundation](https://doi.org/10.1162/dint_a_00025){target=_blank} of the Semantic Web
and the [FAIR
initiative](https://fairsfair.eu/d22-fair-semantics-first-recommendations-request-comments/p-rec-1-use-globally-unique-persistent-and){target=_blank}.

Within the SoilWise project, the persistent identification of metadata records
(and eventually the resources that metadata describe) is therefore a
fundamental aspect. The process or technology responsible for issuing and
assigning PIDs in SoilWise has heretofore been known as **Persistent Identifier
Mint**. In principle, it will rely on a third party for the allocation and
resolution of PIDs, which will then be redirected to the SoilWise Repository. These PIDs
can be used internally to identify metadata records, knowledge graphs in
quad-stores, and even as alternative identifiers of external resources. The
paragraphs below enumerate various options in this regard.


### ePIC

[Persistent Identifiers for eResearch](https://www.pidconsortium.net/){target=_blank} (ePIC)
was founded in 2009 by a consortium of European partners in order to provide PID
services for the European Research Community, based on the [Handle
system](https://www.handle.net/){target=_blank}. Consortium members signed a Memorandum of
Understanding aiming to provide the necessary resources for the long term
reliability of its PID services (allocation, resolution, long-term validity).
ePIC has since expanded into an international consortium, open to partners from
the research community worldwide.


### ARK Alliance

The [ARK Alliance](https://arks.org/){target=_blank} is an global, open community supporting the
ARK infrastructure on behalf of research and scholarship. This institution
provides Archival Resource Keys (ARKs), that serve as persistent identifiers, or
stable, trusted references for digital information objects, physical or
abstract. ARKs are meant to provide researchers (and other users) with long term
access to global scientific and cultural records. Since 2001, some 8.2
milliard ARKs have been created by over 1000 organisations — libraries, data
centres, archives, museums, publishers, government agencies and vendors. The ARK
Alliance strives for seamless access to its PID services, on an open,
non-paywalled and decentralised paradigm.
 
### DataCite

[DataCite](https://datacite.org/){target=_blank} was founded in 2009 on the principle of being
an open stakeholder-governed community that is open to participation from
organisations worldwide. This initiative was formed with the aim of safeguarding
common standards worldwide to support research, thereby facilitating compliance
with the rules of good scientific practice. DataCite maintains open
infrastructure services to ensure that research outputs and resources comply
with the FAIR principles. DataCite’s services are foundational components of the
scholarly ecosystem. Among these services are the creation and management of
PIDs. 

### The FREYA project

The [FREYA](https://www.project-freya.eu/){target=_blank} project funded by the European
Commission under the Horizon 2020 programme, active between 2017 and 2020.  It
aimed to build the infrastructure for persistent identifiers as a core component
of open science, in the EU and globally. FREYA worked to improve discovery,
navigation, retrieval, and access to research resources. New provenance services
enabled researchers to better evaluate data and make the scientific record more
complete, reliable, and traceable. The [FREYA Knowledge
Hub](https://www.project-freya.eu/en/resources/knowledge-hub){target=_blank} was designed to
help users understand what persistent identifiers are, why they exist, and how
to use them for research. It includes comprehensive guides and webinars to help
start working with PIDs.


## Architecture

Below are described 3 options for a harvesting infrastructure. The main difference is the scalability of the solution, which is mainly dependent on the frequency and volume of the harvesting. 

### Traditional approach

Traditionally, a harvesting script is triggered by a cron job.

``` mermaid
flowchart LR
    HC(Harvest configuration) --> AID
    AID(Harvest component)
    RW[RDFwriter] --> MC[(Triple Store)]
    AID --> RS[(Remote sources)]
    AID --> RW
    RS --> AID
```

### Containerised approach

In this approach, each harvester runs in a dedicated container. The result of the harvester is ingested into a (temporary) storage, where follow up processes pick up the results. Typically, these processes use existing containerised workflows such as GIT CI-CD, Google Cloud run, etc.

``` mermaid
flowchart LR
    c[CI-CD] -->|task| q[/Queue\]
    r[Runner] --> q
    r -->|deploys| hc[Harvest container]
    hc -->|harvests| db[(temporary storage)]
    hc -->|data cleaning| db[(temporary storage)]
```

### Microservices approach

The microservices approach uses a dedicated message queue where dedicated runners pick up harvesting tasks, validation tasks and cleaning tasks as soon as they are scheduled. Runners write their results back to the message queue, resulting in subsequent tasks to be picked up by runners.

``` mermaid
flowchart LR
    HC(Harvest configuration) -->|trigger| MQ[/MessageQueue\]
    MQ -->|task| AID
    AID --> MQ
    MQ -->|task| DC
    DC --> MQ
    MQ -->|write| RW[RDFwriter]
    AID(Harvest component)
    RW --> MC[(Triple Store)]
    AID --> RS[(Remote sources)]
```

In the beginning of the SoilWise development process, SoilWise will focus on the second approach.

## Foreseen functionality

A harvesting task typically extracts records with update-date later then the _last-identified successfull harvester run_.

Harvested content is (by default) not editable for the following reasons:

1. The harvesting is periodic so any local change to harvested metadata will be lost during the next run.
2. The change date may be used to keep track of changes so if the metadata gets changed, the harvesting mechanism may be compromised.

If inconsistencies with imported metadata are identified, we can add a statement to the graph of such inconsistencies. We can also notify the author of the inconsistency so they can fix the inconsistency on their side.

To be discussed is if harvested content is removed as soon as a harvester configuration is removed, or when records are removed from the remote endpoint. The risk of removing content is that relations within the graph are breached. Instead, we can indicate a record has been archived by the provider.

Typical functionalities of a harvester:

- **Define a harvester job**
    - Schedule (on request, weekly, daily, hourly)
    - Endpoint / Endpoint type (example.com/csw -> OGC:CSW)
    - Apply a filter (only records with keyword='soil-mission')
- **Understand success of a harvest job** 
    - overview of harvested content (120 records)
    - which runs failed, why? (today failed -> log, yesterday successfull -> log)
    - Monitor running harvestors (20% done -> cancel)
- **Define behaviours on harvested content**
    - skip records with low quality (if test xxx fails)
    - mint identifier if missing ( https://example.com/data/{uuid} )
    - a model transformation before ingestion ( example-transform.xsl / do-something.py )

### Duplicates / Conflicts

A resource can be described in multiple Catalogues, identified by a common identifier. Each of the harvested instances may contain duplicate, alternative or conflicting statements about the resource. SoilWise Repository aims to persist a copy of the harvested content (also to identify if the remote source has changed). The Harvester component itself will not evaluate duplicities/conflicts between records, this will be resolved by the [Interlinker component](interlinker.md). 

An aim of this exercise is also to understand in which repositories a certain resource is advertised.

## Technology options

[**geodatacrawler**](https://pypi.org/project/geodatacrawler/){target=_blank}, written in python, extracts metadata from various sources:

- Local file repository (metadata and various data formats)
- CSV of metadata records (each column represents a metadata property)
- remote identifiers (DOI, CSW)
- remote endpoints (CSW)

[**Google cloud run**](https://cloud.google.com/run){target=_blank} is a cloud environment to run scheduled tasks in containers on the Google platform, the results of tasks are captured in logs

[**Git CI-CD**](https://github.com/features/actions){target=_blank} to run harvests, provides options to review CI-CD logs to check errors

[**RabbitMQ**](https://www.rabbitmq.com/){target=_blank} a common message queue software

## Integration opportunities

The Automatic metadata harvesting component will show its full potential when being in the SWR tightly connected to (1) [SWR Catalogue](catalogue.md), (2) [Data download](dashboard.md#data-download-export) & [Upload pipelines](dashboard.md#manual-data-metadata-authoring) and (3) [ETS/ATS](metadata_validation.md#metadata-etsats-checking), i.e. test suites.




