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
| Recommendation                                    |  Impact   |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :------: | :-----------------: |
| [LAW-1 - Enable Log Analytics data export to GRS or GZRS](#law-1---enable-log-analytics-data-export-to-grs-or-gzrs) | Medium  | Preview  |         No         |
| [LAW-2 - Link Log Analytics Workspace to an Availability Zone enabled dedicated cluster](#law-2---link-log-analytics-workspace-to-an-availability-zone-enabled-dedicated-cluster) | Medium  | Preview |         Yes          |
| [LAW-3 - Configure data collection to send critical data to multiple workspaces in different regions](#law-3---configure-data-collection-to-send-critical-data-to-multiple-workspaces-in-different-regions) | Medium  | Preview  |         No         |
| [LAW-4 - Create a health status alert rule for your Log Analytics workspace](#law-4---create-a-health-status-alert-rule-for-your-log-analytics-workspace) | Low  | Preview  |         No         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### LAW-1 - Enable Log Analytics data export to GRS or GZRS

**Importance: Medium**

**Recommendation/Guidance**

Data export in a Log Analytics workspace lets you continuously export data to an Azure Storage account.  Protect your Log Analytics workspace data from the unlikely event of a regional failure by continuously exporting to a geo-redundant storage (GRS) or geo-zone-redundant storage (GZRS) account.

**Resources**

- [Log Analytics workspace data export in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/logs/logs-data-export)
- [Azure Monitor configuration recommendations](https://learn.microsoft.com/azure/azure-monitor/best-practices-logs#configuration-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/law-1/law-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LAW-2 - Link Log Analytics Workspace to an Availability Zone enabled dedicated cluster

**Importance: Medium**

**Recommendation/Guidance**

Link your Log Analytics workspace to an availability zone enabled dedicated cluster to increase the resilience of Azure Monitor features that rely on your Log Analytics workspace and to protect your Log Analytics data against the unlikely event of a datacenter failure.

**Resources**

- [Enhance data and service resilience in Azure Monitor Logs with availability zones](https://learn.microsoft.com/azure/azure-monitor/logs/availability-zones)
- [Create and manage a dedicated cluster in Azure Monitor Logs](https://learn.microsoft.com/azure/azure-monitor/logs/logs-dedicated-clusters)
- [Azure Monitor configuration recommendations](https://learn.microsoft.com/azure/azure-monitor/best-practices-logs#configuration-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/law-2/law-2.kql" >}} {{< /code >}}

{{< /collapse >}}

##### Azure CLI

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="bash" file="code/law-2/law-2.azcli" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### LAW-3 - Configure data collection to send critical data to multiple workspaces in different regions

**Importance: Medium**

**Recommendation/Guidance**

If you require a workspace to be available in the unlikely scenario of a regional failure then configure data collection to send critical data to multiple workspaces in different regions.

**Resources**

- [Azure Monitor configuration recommendations](https://learn.microsoft.com/azure/azure-monitor/best-practices-logs#configuration-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/law-3/law-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### LAW-4 - Create a health status alert rule for your Log Analytics workspace

#### Importance: Low

**Recommendation/Guidance**

A health status alert will proactively notify you if a workspace becomes unavailable because of a datacenter or regional failure.

**Resources**

- [Monitor Log Analytics workspace health](https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-workspace-health)
- [Azure Monitor configuration recommendations](https://learn.microsoft.com/azure/azure-monitor/best-practices-logs#configuration-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/law-4/law-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
