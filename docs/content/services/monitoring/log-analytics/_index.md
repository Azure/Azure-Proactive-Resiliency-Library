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
| Recommendation                                                                                                                                                                                              |     Category      | Impact |  State  | ARG Query Available |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [LOG-1 - Enable Log Analytics data export to GRS or GZRS](#log-1---enable-log-analytics-data-export-to-grs-or-gzrs)                                                                                         | Governance | Medium | Verified |         No          |
| [LOG-4 - Create a health status alert rule for your Log Analytics workspace](#log-4---create-a-health-status-alert-rule-for-your-log-analytics-workspace)                                                   |    Monitoring     |  Low   | Verified |         No          |
| [LOG-5 - Configure minimal logging and retention of logs](#log-5---configure-minimal-logging-and-retention-of-logs)                                                                                         |    Governance     |  Low   | Verified |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### LOG-1 - Enable Log Analytics data export to GRS or GZRS

**Category: Governance**

**Impact: Medium**

**Guidance**

Data export in a Log Analytics workspace lets you continuously export data to an Azure Storage account.  Protect your Log Analytics workspace data from the unlikely event of a regional failure by continuously exporting to a geo-redundant storage (GRS) or geo-zone-redundant storage (GZRS) account.  This is primarily a recommendation to meet compliance for data retention, but can also be used to integrate the data with other Azure services and tools.

**Resources**

- [Log Analytics workspace data export in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/logs/logs-data-export)
- [Azure Monitor configuration recommendations](https://learn.microsoft.com/azure/azure-monitor/best-practices-logs#configuration-recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/log-1/log-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LOG-4 - Create a health status alert rule for your Log Analytics workspace

**Category: Monitoring**

**Impact: Low**

**Guidance**

A health status alert will proactively notify you if a workspace becomes unavailable because of a datacenter or regional failure.

**Resources**

- [Monitor Log Analytics workspace health](https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-workspace-health)
- [Azure Monitor configuration recommendations](https://learn.microsoft.com/azure/azure-monitor/best-practices-logs#configuration-recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/log-4/log-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LOG-5 - Configure minimal logging and retention of logs

**Category: Governance**

**Impact: Low**

**Guidance**

 Azure Monitor Logs automatically retains log data for a specific period of time depending on the data type (for example, 30 days for platform logs and metrics). However, you may need to retain your data for longer periods for compliance or business reasons. You can configure the data retention settings based on your requirements.

 Use Azure Monitor archive settings for older, less used data in your workspace at a reduced cost. You can access data in the archived state by using search jobs and restore. You can keep data in archived state for up to 12 years.

**Resources**

- [Data retention and archive in Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-retention-archive?tabs=portal-1%2Cportal-2)
- [Run search jobs in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/search-jobs?tabs=portal-1%2Cportal-2)
- [Restore logs in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/restore?tabs=api-1)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/log-5/log-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
