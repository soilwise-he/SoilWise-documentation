# Data and Knowledge Administration Console

!!! component-header "Info"
    **Current version:** 

    **Technology:** Apache Superset

    **Project:** [Summary Dashboard](https://github.com/soilwise-he/summary-dashboard)

    **Access point:** 

## Introduction

### Overview & Scope

The Data and Knowledge Administration Console is compiled of several dashboard pages implemented using Apache Superset technology. Apache Superset is an open-source data exploration and visualization platform that enables to create interactive, web-based dashboards with minimal coding. In SoilWise it is used to present statistics from the [Metadata Catalogue](catalogue.md), results of the [Metadata Validation](metadata_validation.md) and to provide more insights into the results published by Mission Soil projects. The console is available only for authorised users.

### Intended Audience

- **SWC Administrator** monitoring the contents of the SoilWise Catalogue
- **Mission Soil Projects Monitoring officer** monitoring the results published by Mission Soil projects
- **JRC data analysts** monitoring the metadata quality of published soil-related datasets.

### Key Features

1. **Rich visualisation possibilities** different kinds of charts, tables and so on.
2. **Intuitive SQL editor** for querying data sources and preparation of data for visualisation.
3. **WYSIWYG editor** for configuring the content and layout of dashboard pages.
4. **Role-based access control** for managing access rights.

## Architecture

### Technological Stack

|Technology|Description|
|----------|-----------|
| **Apache Superset**|Used for configuration and display of the dashboard pages compiling the Console.|
| **Keycloak**|Used for user management and access rigths.|
| **PostgreSQL**|Connection to a DB with Catalogue contents and validation results.|

### Main Components Diagram