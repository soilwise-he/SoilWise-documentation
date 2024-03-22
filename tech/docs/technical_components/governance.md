# Certification & Governance management (EV ILVO)

??? question to allign on: is this governance related to:

* connecting with a data space, 
* setting up the SWR as a data space 
* or common usage of data and knowledge by users? In case of the latter are we not further distributing "open data" 
and what extra governance policies do we need?

<br>

<br>


Soilwise plans to implement a governance framework to tackle the challenge of ensuring equitable access to and 
utilization of data and knowledge. This framework aims to foster data sharing and enable the generation of value 
from these resources. A governance framework encompasses a set of principles, standards, policies (rules/regulations), 
and practices. Additionally, the framework addresses the enforcement of these measures and the resolution of 
any conflicts that may arise.

The governance framework will be designed by integrating relevant EU legislation concerning governance within data 
ecosystems, alongside insights from ongoing Digital Europe CSA projects focused on constructing the Common European 
Data Spaces. The formulation of this governance framework will rely mainly on the Data Spaces Support Centre 
([DSSC](https://dssc.eu/){target=_blank}) 
results which are:

1. [Starter Kit](https://dssc.eu/space/SK/29523973/Starter+Kit+for+Data+Space+Designers+%7C+Version+1.0+%7C+March+2023){target=_blank}, 
a document that helps organizations and individuals understand the requirements for creating a data space by providing. 
a multifaceted view of data spaces, highlighting business, legal and governance, operational, functional, 
and technical aspects to consider
2. [Glossary](https://dssc.eu/space/Glossary/55443460/DSSC+Glossary+%7C+Version+1.0+%7C+March+2023){target=_blank} 
3. [Blueprint](https://confluence.external-share.com/content/80889/dssc_blueprintv05_public_consultation?sortChildren=tree){target=_blank}, 
a consistent and comprehensive set of guidelines to support the development cycle of data spaces.
 
Additionally, the DSSC proposes the utilization of the Building Blocks Taxonomy, which serves as a classification scheme. 
This taxonomy aids in describing, analyzing, and organizing data space initiatives based on predefined characteristics, 
thus promoting a structured approach to governance implementation (_Figure 1_). We will equally consider the 
[openDEI design principles for data spaces]((https://design-principles-for-data-spaces.org){target=_blank}){target=_blank}, the requirements of [ISO 30401 for KM](https://iso-docs.com/blogs/iso-concepts/knowledge-management-system-iso-30401){target=_blank} and rely on the results of the preparatory 
action for the data space for Agriculture ([AgriDataSpace](https://agridataspace-csa.eu/){target=_blank}).

<br>

![img_governance.png](img_governance.png)


Following the introduction of the GDPR, the European Commission has put forward several legislative proposals, 
such as the Digital Services Act, the Digital Markets Act, the Data Act, and the Data Governance Act. 
Soilwise places particular emphasis on the [Data Governance Act](https://www.european-data-governance-act.com/){target=_blank} 
and the [Data Act](https://www.eu-data-act.com/){target=_blank}, as their primary goals 
align closely with the project's aims to enhance data sharing and facilitate product development. 
These legislations are designed to:

- Promote equity in the distribution of value derived from data across various stakeholders.
- Enhance access to data and its utilization.

The documents described in the higher paragraphs will be used to asses if the technical components used to develop and 
implement SWR meet the necessities for the governance of the data ecosystem. If this is not the case technical 
components adhering the governance requirements will be integrated in further iterations of the project.


- governance
- interoperability
- clearing house, broker, ...
- vocabulary provider (connects to knowledge graph)

- connections with: external repo, identity providers, connectors, UI/UX

## SoilWise Data Spaces (EV ILVO + WE)

_T1.4 will produce detailed technical specifications, including information on components to be (re)used, interfaces between them and explaining the data flows and processing schemes, **considering AgriDataSpace project** conceptual reference architecture, AI/ML architecture patterns and the Ethics by Design in AI._

CONNECTOR:

- config and control of data access
- config and control of data usage
- user authorisation for data access

- connections with: Storage, APIs
- technologies used: Eclipse Dataspace Components Connector
- responsible person: Thorsten Reitz
- participating:

