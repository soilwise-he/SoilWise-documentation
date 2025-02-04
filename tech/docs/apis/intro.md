# Introduction

This section focusses on interfaces for access, sharing, population and integration, particularly with EUSO. It describes the technical interfaces (APIs) that will be offered and how they could be exploited for integration. It also describes the user interfaces that are developed as part of SWR. While these are primarily developed to serve the various stakeholder groups of the SoilWise project, these UIs, or derived versions, could in principle also become part of future systems like EUSO.

The architecture of the SoilWise repository (SWR) is highly modular (component based). This allows to compose the infrastructure using a mix of readily available (open source) components, and customized and newly developed elements in a flexible manner. Such a loosely couple, component based architecture allows teams to independently develop, adapt and merge in parts of the architecture without disrupting the working of the system. 

For such a system to be flexible and adaptable and to allow agile development, the use of and compliance with standardised interfaces between components, e.g. through APIs, is required. First of all, this makes the system as a whole more flexible and easily adaptable to required changes during the (agile) development process. Second, such interfaces will allow all users (both data & knowledge providers and users) to easily access SWR and/or connect their systems, both for access and usage and for population. Third, it will facilitate the integration of the SWR, or specific parts of SWR with other systems, and particularly with the European Soil Observatory (EUSO). The use of standardised APIs will keep options for such integration open, while both SWR and EUSO, and the required functions they will offer, are evolving.

This section describes the following elements of SWR:

1. [Application Programming Interfaces (APIs)](apis.md)
2. [User Interface (UI) components](uis.md)
