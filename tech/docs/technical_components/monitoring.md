# Monitoring System Usage 

!!! component-header "Info"
    **Current version:** 1.0

    **Project:** [Usage statistics](https://github.com/soilwise-he/usage-statistics)

A component which reports on usage of resources. Generally 2 approaches for usage monitoring are available:

- Embed a javascript snippet which triggers a count to a stats software at page load
- analyse access logs of the infrastructure

Note that option one only counts website visits, direct calls to (data) API's are not included.

## Technology

The Soilwise website is using Google Analytics, which uses the first approach.

The SWR catalogue does currently not includes a counter script. The usage can be monitored via the usage logs, which are indexed in an instance of [splunk](https://www.splunk.com/), which provides dashboards on the underlying data.

## Future work

Feedback the popularity of resources from usage logs into the catalogue search ranking algorithm.