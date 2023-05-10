+++
title = "Log Analytics"
description = "Best practices and resiliency recommendations for Log Analytics and associated resources."
date = "5/9/23"
author = "judyer28"
msAuthor = "judyer"
draft = false
+++

The presented resiliency recommendations in this guidance include Log Analytics and associated Log Analytics settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Log Analytics and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                    |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [LAW-1 - Enable Log Analytics data export to GRS or GZRS](#law-1---enable-log-analytics-data-export-to-grs-or-gzrs) | Preview  |         No         |
| [LAW-2 - Link Log Analytics Workspace to an Availability Zone enabled dedicated cluster](#law-2---link-log-analytics-workspace-to-an-availability-zone-enabled-dedicated-cluster) | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### LAW-1 - Enable Log Analytics data export to GRS or GZRS

#### Importance: High

#### Recommendation/Guidance

Data export in a Log Analytics workspace lets you continuously export data to an Azure Storage account.  Protect your Log Analytics workspace data from the unlikely event of a regional failure by continuously exporting to a geo-redundant storage (GRS) or geo-zone-redundant storage (GZRS) account.

##### Resources

- [https://learn.microsoft.com/en-us/azure/azure-monitor/logs/logs-data-export](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/logs-data-export)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LAW-2 - Link Log Analytics Workspace to an Availability Zone enabled dedicated cluster

#### Importance: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
