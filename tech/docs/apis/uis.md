# User Interfaces (UIs)

The usabilty of the SoilWise repository will eventually not only be determined by it's back-end functionality and the (meta)data and knowledge it exposes. User, whether they are data & knowledge providers, users or SWR administrators, will operate the system through various user interfaces.  

Within the first development iteration, the following User Interfaces have been deployed as part the SoilWise repository:

## Interfaces for end users

**SWR Catalogue** <https://repository.soilwise-he.eu/>

This UI, provided as part of the pycsw component, is currently the access point for end users of the SWR catalogue. It allows users to run search queries, spatial queries and faceted search.

**Hale Studio** : <https://wetransform.to/halestudio/> 

Hale studio (a standalone desktop application) supports the transformation and harmonisation of datasets over different standards, so users can easily harmonise their data, e.g. for complying with INSPIRE. 

## Interfaces for administration and system management

**Summary SWR Catalogue Dashboard** <https://dashboards.isric.org/superset/dashboard/43/>

This UI, based on the superset BI tools, provides a multi-dimensional visual overview of the contents of the SWR,

## Future work

SoilWise will in the future deploy adapted, and newly developed user interfaces to serve it's stakeholder groups, such as:

**Chatbot interface**

A chatbot UI will allow users to perform natural language queries, using Large Language Models. A chatbot implementation is currently under development and is interactively tested with SoilWise stakeholders. A first version is intended to be integrated during the second development cycle and deployed as part of prototype 3.

**New or adapted catalogue query interface**

The functions of the current end user interface of the catalogue will be extended, e.g. through the integration search engine queries and responses, including faceted search, ranking of results etc. As part of the first development cycle, experimental work on the integration of a (Solr) search engine is performed. This includes a pilot user interface that allows expemimentation with search strategies and testing with users. Integration of such search engine based queries into the catalogue user interface will be part of the efforts in the second development cucle.

**Monitoring dashboard** 

A dashboard that shows the evolution of the SWR data and knowledge contents, quality indicators etc



