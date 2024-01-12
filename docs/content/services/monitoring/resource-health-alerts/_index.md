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
| Recommendation                                    |  Category      |  Impact   |   State   | ARG Query Available |
| :------------------------------------------------ | :------------: | :--------:| :--------:| :------------------:|
| [MSR-1 - Configure Resource Health Alerts](#msr-1---configure-resource-health-alerts) | Monitoring | Low| Preview  |    No      |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### MSR-1 - Configure Resource Health Alerts

**Category: Monitoring**

**Impact: Low**

**Recommendation**

Resource health helps you diagnose and get support when an Azure issue impacts your resources. It informs you about the current and past health of your resources and helps you mitigate issues. Resource health provides technical support when you need help with Azure service issues Creating Resource Health alerts programmatically allow for users to create and customize alerts in bulk. Based on the health status, Resource Health provides you with recommendations with the goal of reducing the time you spent troubleshooting. For available resources, the recommendations focus on how to solve the most common problems customers encounter. If the resource is unavailable due to an Azure unplanned event, the focus will be on assisting you during and after the recovery process.

**Resources**

- [Resource Health](https://learn.microsoft.com/en-us/azure/service-health/resource-health-overview)
- [Configure Resource Health alerts in the Azure portal](https://learn.microsoft.com/en-us/azure/service-health/resource-health-alert-monitor-guide#create-a-resource-health-alert-rule-in-the-azure-portal )
- [Alerts Health](https://learn.microsoft.com/en-us/azure/service-health/alerts-activity-log-service-notifications-portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/msr-1/msr-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
