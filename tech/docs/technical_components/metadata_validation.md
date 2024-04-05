# Metadata validation

!!! component-header "Important Links"
    :fontawesome-brands-github: Project: [Metadata validation](https://github.com/orgs/soilwise-he/projects/5)


- metadata conformance evaluation
  - conformance is a indicator of quality?
- linkage evaluation
  - linkage to other metadata records
  - linkage to data/services. [Geohealthcheck](https://geohealthcheck.org){target=_blank} is an interesting tool to monitor availability of spatial services/resources.
  - linkage failure is a common problem on the web, first aspect is to tag a link as broken, so users can filter broken links, later it can be considered to remove/disable the link (other links on the same record may still be operational, the content behind the link may be recoverable via <https://web.archive.org> (so don't remove it).
- metadata quality evaluation
  - identify a level of completeness for a metadata file (match against a set of expectations from a SoilWise perspective)
  - governance is of interest, what do you do if a record scores low? notify the owner, try to auto-improve, tag with low score, exclude from the catalogue 
- data quality evaluation
- suggest improvements on metadata to users

[Geocat](https://geocat.iucnredlist.org/){target=_blank} has developed a linkage checker for iso19139:2007 metadata for INSPIRE geoportal, available at [icat](https://github.com/GeoCat/icat){target=_blank}, which includes link checks in OWS capabilities.

### Data quality assurance (MU + ISRIC)

- Automated validations on datasets to check if statements in metadata on resolution, projection, spatial/temporal bounds, accuracy, classification, uncertainty are correct.
- If a metadata record has no statements on these aspects, findings fom the validation will be used instead.
- understand the history of a data file is of interest, with every download save the hash of the file, to know if it was changed since last download and if this change was properly documented.

- Impact of validation? Tag the record with the actual value, notify the owner of our findings, On the UI show only the updated values, decrease the record quality score (impacting search ranking).

- Prevent to download data for every validation by checking against modification date.
- Run a full check at monthly intervals in case files are changed without updating the modification date.
- If data is provided as a service (or cloud optimised) a subset of the data may be extracted for the validation.

**Requirements to storage component:**

- For any data link in a metadata record, keep a registry of its validation result (keep a copy of (or reference to) the metadata record at that moment)
- A registry to keep record overrides introduced by validations
- A registry to track conversation with the data owner on validation results

**Impact on search engine:**

- decrease ranking in case metadata has many inconsistencies related to data quality

- [GeoHealthCheck](https://geohealthcheck.org) could be an interesting platform to monitor quality of data. 
