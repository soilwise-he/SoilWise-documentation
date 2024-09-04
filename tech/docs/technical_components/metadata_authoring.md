# Metadata Authoring

!!! component-header "Info"
    **Current version:** 
      0.1
    **Project:** 
      https://github.com/soilwise-he/soilinfohub
    **Access point:** 
      https://github.com/soilwise-he/soilinfohub

## Functionality

Users are enabled to create and maintain metadata records within the SWR, in case these records can not be imported from a remote source. Note that importing records from remote is the preferred approach from the SWR point of view because the ownership and persistence of the record is facilitated by the remote platform. 

- Users login to the system and are enabled to upload a metadata record. 
- A form is available for users to create or manage an existing record. The form has select options for those fields which are linked to a codelist. 
- Users can also upload a spreadsheet of records which are converted to the MCF format.

## Technology

The authoring workflow uses a GIT backend, additions to the catalogue are entered by members of the GIT repository directly or via pull request (review).
Records are stored in [iso19139:2007](https://www.iso.org/standard/32557.html) XML or MCF. [MCF](https://geopython.github.io/pygeometa/reference/mcf/) is a subset of iso19139:2007 in a YAML encoding, defined by the pygeometa community. The [pygeometa library](https://geopython.github.io/pygeometa) is used to 
convert the MCF to any requested metadata format.

The pygeometa community provides a [webbased form](https://osgeo.github.io/mdme){target=_blank} for users uncomfortable with editing an MCF file directly. The tool can be hosted within SWR, to faciliate a dedicated color scheme. The form is auto generated from mcf json schema, the schema can be annotated to provide a dedicated EUSO user experience (for example preselect relevant codelists).

Users can also submit metadata using a CSV (excel) format, which is converted to MCF in a CI-CD workflow 

At intervals the SWR ingests metadata which has been uploaded via the authoring workflow.
