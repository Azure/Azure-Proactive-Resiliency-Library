+++
title = "App Service"
description = "Best practices and resiliency recommendations for App Service and associated resources."
date = "6/27/23"
author = "kunalbabre"
msAuthor = "kunalbabre"
draft = true
+++

The presented resiliency recommendations in this guidance include App Service and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Impact  |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :------: | :-----------------: |
| [App-1 - Enable diagnostics logging](#app-1---enable-diagnostics-logging) | High | Preview  |         No         |
| [App-2 - Work in progress](#app-2---work-in-progress) | High | Preview |         Yes          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### App-1 - Enable diagnostics logging

**Impact: High**

**Recommendation/Guidance**

Enabling diagnostics logging for your Azure App Service is important for monitoring and diagnostics purposes. It includes application logging and web server logging.


**Resources**

- [Enable diagnostics logging for apps in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs)

<br><br>

### App-2 - Work in progress
**Impact: High**

**Recommendation/Guidance**

comming soon 

**Resources**

- [TBC](#app-2---work-in-progress)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/app-2/app-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
