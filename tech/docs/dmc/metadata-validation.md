# Metadata validation (ETS/ATS)

- metadata conformance evaluation
  - conformance is a indicator of quality?
- linkage evaluation
  - linkage to other metadata records
  - linkage to data/services. [geohealthcheck](https://geohealthcheck.org) is an interesting tool to monitor availability of spatial services/resources.
  - linkage failure is a common problem on the web, first aspect is to tag a link as broken, so users can filter broken links, later it can be considered to remove/disable the link (other links on the same record may still be operational, the content behind the link may be recoverable via https://web.archive.org (so don't remove it).
- metadata quality evaluation
  - identify a level of completeness for a metadata file (match against a set of expectations from a SoilWise perspective)
  - governance is of interest, what do you do if a record scores low? notify the owner, try to auto-improve, tag with low score, exclude from the catalogue 
- data quality evaluation
- suggest improvements on metadata to users

Geocat has developed a linkage checker for iso19139:2007 metadata for INSPIRE geoportal, available at [icat](https://github.com/GeoCat/icat), which includes link checks in ows capabilities

- connections to data source, catalogue, processing
- technologies used:
- responsible person:
- participating:
