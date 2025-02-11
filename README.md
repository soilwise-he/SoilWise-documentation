# SoilWise-documentation

## Technical Documentation
A **living preview** version is published at: https://main.soilwise-documentation.pages.dev/

A fixed production version (for delivery) is published at: https://soilwise-documentation.pages.dev/

A fixed **1st prototype version** (for delivery) is published at: https://prototype-1-0.soilwise-documentation.pages.dev/

## Knowledge Base

The knowledge-base repository serves for merging documentation from all desired technical components and displaying it at one place.

A **living preview** version is published at:  https://soilwise-documentation-kb.pages.dev/

### Contributions

#### Documentation content updates

New contributions to the documentation content should be added directly to the corresponding Git repositories. Please, primarily follow a predefined structure of the documents, however custom adjustments are possible.

#### Documentation of a new component

1. Set up `/docs` folder in the corresponding component repository
2. Set up `design.md` file with the following structure:

```
# Design Document: NER Augmentation

## Introduction

### Component Overview and Scope

### Users

### References

## Requirements

### Functional Requirements

### Non-functional Requirements

## Architecture

### Technological Stack

### Overview of Key Features

### Component Diagrams

### Sequence Diagram

### Database Design

### Integrations & Interfaces

### Key Architectural Decisions

## Risks & Limitations
```

3. Set up all other needed files
4. Add linkage to the source repository in the `mkdocs.yml` file under `multirepo` plugin (the file is located in this repository)

# Mkdocs

## How to start collaborating

1. install Python
2. install packages

```
pip install mkdocs
pip install mkdocs-material
pip install mkdocs-mermaid2-plugin
pip install mkdocs-git-revision-date-localized-plugin
pip install mkdocs-awesome-pages-plugin
pip install mkdocs-render-swagger-plugin
pip3 install mkdocs-print-site-plugin
pip install mkdocs-glightbox
pip3 install mkdocs-ezglossary-plugin
pip install mkdocs-multirepo-plugin
```

3. clone git repository
4. run `mkdocs serve` from .\tech\ to run a local (127.0.0.1:8000) instance of documentation
5. push changes to main branch
6. changes will be promoted after automatic deploy