# Metadata authoring

The prefered approach to add (meta)data to SWR is via harvesting. However in case metadata needs to be added directly to the SWR the following workflow is suggested.

The diagram below provides an overview of the workflow of metadata authoring

``` mermaid
flowchart LR
    G[fa:fa-code-compare Git] -->|mcf| CI{{pygeometa}} 
    CI -->|iso19139| DB[(fa:fa-database Database)]
    DB --> C(Catalogue)
    C --> G
```

The authoring workflow uses a GIT backend, additions to the catalogue are entered by members of the GIT repository directly or via pull request (review).
Records are stored in iso19139:2007 xml or MCF. MCF is a subset of iso19139:2007 in a YAML encoding, defined by the pygeometa community. This library is used to 
convert the MCF to any requested metadata format.

A [webbased form](https://osgeo.github.io/mdme){target=_blank} is available for users uncomfortable in editing a MCF file directly.

With every change on the git repository an export of the metadata is made to a PostGres Database (or the triple store).

