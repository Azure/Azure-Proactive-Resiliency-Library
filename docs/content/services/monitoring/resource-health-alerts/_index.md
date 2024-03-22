+++
title = "Resource Health Alerts"
description = "Best practices and resiliency recommendations for Resources Health and associated resources and settings."
date = "11/6/23"
author = "anlucen"
msAuthor = "anlucena"
draft = false
+++

The presented resiliency recommendations in this guidance include Resources Health Alerts and associated resources and settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Resources Health Alerts and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                                                        |  Category  | Impact |  State  | ARG Query Available |
|:--------------------------------------------------------------------------------------|:----------:|:------:|:-------:|:-------------------:|
| [MSR-1 - Configure Resource Health Alerts](#msr-1---configure-resource-health-alerts) | Monitoring |  Low   | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### MSR-1 - Configure Resource Health Alerts

**Category: Monitoring**

**Impact: Low**

**Recommendation**

Configure Resource Health Alerts for all applicable resources. Azure Resource Health alerts keep you informed about the current and historical health status of your Azure resources. Azure Resource Health alerts can notify you when these resources have a change in their health status.

**Resources**

- [Resource Health](https://learn.microsoft.com/en-us/azure/service-health/resource-health-overview)
- [Configure Resource Health alerts in the Azure portal](https://learn.microsoft.com/en-us/azure/service-health/resource-health-alert-monitor-guide#create-a-resource-health-alert-rule-in-the-azure-portal)
- [Alerts Health](https://learn.microsoft.com/en-us/azure/service-health/alerts-activity-log-service-notifications-portal)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/msr-1/msr-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
