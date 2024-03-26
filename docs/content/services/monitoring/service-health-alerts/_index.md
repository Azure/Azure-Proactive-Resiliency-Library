+++
title = "Service Health Alerts"
description = "Best practices and resiliency recommendations for Service Health Alerts and associated resources and settings."
date = "2/23/24"
author = "ejhenry"
msAuthor = "erhenry"
draft = false
+++

The presented resiliency recommendations in this guidance include Service Health Alerts and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |                                Category                                 |     Impact      |      State       | ARG Query Available |
|:--------------------------------------------------|:-----------------------------------------------------------------------:|:---------------:|:----------------:|:-------------------:|
| [ALA-1 - Configure Service Health Alerts](#ala-1---configure-service-health-alerts) | Monitoring | High | Preview |         No         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ALA-1 - Configure Service Health Alerts

**Category: Monitoring**

**Impact: High**

**Guidance**

Service health provides a personalized view of the health of the Azure services and regions you're using. This is the best place to look for service impacting communications about outages, planned maintenance activities, and other health advisories because the authenticated Service Health experience knows which services and resources you currently use. The best way to use Service Health is to set up Service Health alerts to notify you via your preferred communication channels when service issues, planned maintenance, or other changes may affect the Azure services and regions you use.

**Resources**

- [What is Azure Service Health?](https://learn.microsoft.com/azure/service-health/overview)
- [Configure alerts for service health events](https://learn.microsoft.com/azure/service-health/alerts-activity-log-service-notifications-portal)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ala-1/ala-1.kql" >}} {{< /code >}}

{{< /collapse >}}
