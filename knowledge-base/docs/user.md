# SoilWise Catalogue — User Guide

## 1. Quick overview

SoilWise is a FAIR-focused data & knowledge repository that helps you discover datasets and knowledge resources about soil and soil health across Europe. 
This guide explains how to find relevant resources using the catalogue search page and how to read and access a resource from its detail page.


## 2. Quick start 

1. Open the [Search page](https://repository.soilwise-he.eu).
2. Type a keyword in the search box and press **Enter** (or click Search).
3. Narrow results with filters on the left.
4. Select a result title to open the **Detail page** where you can view metadata.
5. Follow a link to access the resource.

## 3. Search page — interface elements & how to use them

### 3.1 Search box (keywords)

* Purpose: free-text search across titles, descriptions, keywords and metadata.
* Tips:

  * Use short phrases like `soil organic carbon`, `soil health indicators`, `Europe`.
  * Quotes for exact phrases: `"soil organic carbon"`.
  * Boolean-style hints (if supported): `AND`, `OR`, `-` to exclude terms (if not supported, present examples only).

**Microcopy suggestion:**
`Search by keyword, title, author, or description. Try: "soil organic carbon", or use multiple keywords separated by spaces.`



### 3.2 Filters (left-hand panel)

Common filter types you may see:

* **Resource type** (dataset, document, model, policy brief)
* **Subject / Topic** (soil organic matter, erosion, biodiversity...)
* **Geographic scope** (country, region)
* **Temporal coverage / Date** (year collected or published)
* **License / Access** (open / restricted / embargoed)
* **Provider / Source** (institution or repository)

How to use:

* Click a filter category to expand it. Check the boxes matching your interest to narrow results.
* Filters combine as **AND** across categories and as **OR** within a category (standard behaviour). Example: checking `Dataset` **AND** `Policy brief` in Resource type (if multiple allowed) will return both types.

**Microcopy suggestion on top of filters panel:**
`Refine your results — select one or more options. Filters stack: selections in different groups narrow the list.`



### 3.3 Explode filters (show related/expanded items)

**What it does:** “Explode” expands a selected filter to include narrower or related terms. Use it when you want broader coverage that includes child concepts (e.g., exploding “soil health” to include individual indicators like porosity or organic matter).

**How to present/explain:**

* Next to hierarchical filters show a small toggle/icon: `▸ Expand` or `+ Explode`.
* When user toggles it, include a popup explanation: `Including narrower terms (e.g., 'soil health' → 'soil organic carbon', 'microbial biomass', ...)`.

**Example microcopy for the toggle:**
`Explode: include narrower/related terms`

**Behavior notes (recommended implementation):**

* Default: **off** (keeps search precise).
* When on: filter expands to include child concepts; results will increase. Show a small badge `exploded` near the active filter list and include an undo/clear option.



### 3.4 Sorting

Common sort options:

* **Relevance** (default when you search)
* **Newest first** (publication or data collection date)
* **Alphabetical** (title or provider)


**Microcopy suggestion:**
`Sort by: Relevance | Date | Title (A–Z)`

### 3.5 Pagination & results per page

* Provide clear pagination controls at top and bottom of results: `Prev` / page numbers / `Next`.
* Allow user to change results per page (e.g., 10 / 25 / 50 / 100). Show current range (`Showing 1–25 of 342 results`).
* Keep filters and sort selections while switching pages.
* For long result lists, consider offering an **Export** option (CSV / JSON) for result metadata.

**Microcopy for pagination:**
`Showing 1–25 of 342 results. Change per page: [10 ▾]`



### 3.6 Result items — what each list item should show

Each result listing (compact) should include:

* Title (clickable link to Detail page)
* Resource type badge (e.g., Dataset, Report)
* Short description (1–2 lines)
* Geographic coverage or tags (if present)
* Date (publication or dataset date)
* Provider / source name
* Access indicator (Open / Restricted) and an icon/link to the resource if fast-access is available
* Optional: star or save-to-favorites, and a small `i` for quick view modal

**Example compact item:**
Title
`Dataset · Soil organic carbon (France) · 2021 · INRAE`
Short sentence describing it… [Open] [Save] [Share]



## 4. Detail page — reading resource metadata & accessing the resource

### 4.1 Header area

* Full title
* Resource type and provider
* Badges: Access (Open/Restricted), License (CC BY, ODbL…), Format (CSV, GeoTIFF, PDF)

### 4.2 Key metadata (display prominently)

* **Abstract / Description** (full)
* **Authors / Contributors**
* **Date of publication or data collection**
* **Geographic coverage** (map thumbnail if coordinates exist)
* **Keywords / Subjects**
* **Spatial and temporal extent**
* **Licensing and access conditions** (open / request / restricted) — include exact license text or short summary and a `View full license` link
* **DOI / Persistent identifier** (if present)
* **Contact / provider link**
* **Related resources** (links to datasets, publications, or tools that reference the resource)

### 4.3 Access link / Download

* Prominently present a clear CTA button: `Access resource` or `Download data` (if file) or `Request access` (when restricted).
* If external: `Opens in new tab` microcopy.
* If requires login or access request: show the steps and contact details.

**Microcopy for CTA:**
`Access resource — external site (opens in new tab)`

### 4.4 Additional features (recommended)

* **Citable record**: provide citation text in common citation styles (APA, BibTeX) and a `Copy citation` button.
* **Provenance / lineage**: short timeline of the dataset’s creation/updates.
* **Version history** (if multiple versions exist).
* **Usage metrics**: downloads/views (if available).
* **Feedback / report issue** button to flag broken links or incorrect metadata.



## 5. Example workflows (copy-ready)

### A. Find open datasets about soil organic carbon in Spain

1. Search: `soil organic carbon`
2. Filter: `Geographic scope → Spain`
3. Filter: `Access → Open`
4. Sort: `Newest first`
5. Click a dataset title → press `Download data`

### B. Broaden a topic using explode

1. Search: `soil health`
2. Under `Topic` toggle `Explode` to include narrower indicators (organic matter, microbial biomass)
3. Results will increase; refine by date or provider.



## 6. Suggested microcopy & tooltips (copy-ready)

* Search box placeholder: `Search the catalogue (title, author, keyword...)`
* Filter panel header: `Refine results`
* Explode tooltip: `Include narrower/related terms (e.g., indicators under "soil health")`
* Sort control tooltip: `Choose how results are ordered`
* Access badge hover: `Open — data is directly available` / `Restricted — request access from provider`
* Detail page CTA: `Access resource (opens in new tab)`
* Error message example: `No results found. Try different keywords, fewer filters, or enable "Explode" to broaden the search.`



## 7. Accessibility & UX suggestions

* Ensure keyboard navigation for filters and results (tab order, ARIA attributes).
* Provide sufficient contrast for badges and CTA buttons.
* Offer a screen-reader-friendly list view (ARIA labels for resource type, date, access).
* Mobile: keep filters collapsible and sticky header for sorting/pagination.



## 8. Troubleshooting & FAQ (short)

**Q: I clicked “Access resource” and it fails.**
A: Check if the link opened in a new tab (pop-ups blocked?), verify your network. If the resource is restricted, follow the `Request access` instructions on the detail page. Use `Report issue` to notify us.

**Q: My search returns no results.**
A: Try fewer filters, use broader terms, or enable **Explode** for hierarchical topics. Remove date constraints.

**Q: How current is the data?**
A: Check the `Date` and `Version` fields on the resource detail page; contact the provider listed in the metadata for confirmation.


