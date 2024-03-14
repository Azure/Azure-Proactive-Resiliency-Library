+++
title = "Traffic Manager"
description = "Best practices and resiliency recommendations for Azure Traffic Manager."
date = "9/21/23"
author = "chinthakaru"
msAuthor = "crupasinghe"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Traffic Manager and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                            |     Category      | Impact |  State  | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [TRAF-1 - Traffic Manager Monitor Status Should be Online](#traf-1---traffic-manager-monitor-status-should-be-online)                                     |   Availability    |  High  | Preview |         Yes          |
| [TRAF-2 - Traffic manager profiles should have more than one endpoint](#traf-2---traffic-manager-profiles-should-have-more-than-one-endpoint)             |   Availability    |  High  | Preview |         Yes          |
| [TRAF-3 - Configure at least one endpoint within a another region](#traf-3---configure-at-least-one-endpoint-within-a-another-region)                     | Disaster Recovery | Medium | Preview |         Yes         |
| [TRAF-4 - TTL value of user profiles should be in 60 Seconds](#traf-4---ttl-value-of-user-profiles-should-be-in-60-seconds)                               | System Efficiency | Medium | Preview |         Yes          |
| [TRAF-5 - Ensure endpoint configured to (All World) for geographic profiles](#traf-5---ensure-endpoint-configured-to-all-world-for-geographic-profiles) | Disaster Recovery | Medium | Preview |         No        |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### TRAF-1 - Traffic Manager Monitor Status Should be Online

**Category: Availability**

**Impact: High**

**Guidance**

  Monitor status should be online to provide the failover for application workload.  If the health of your Traffic Manager displays a Degraded status, then the status of one or more endpoints may be Degraded.

**Resources**

- [Azure Traffic Manager endpoint monitoring](https://learn.microsoft.com/azure/traffic-manager/traffic-manager-monitoring)
- [Enable or disable health checks](https://learn.microsoft.com/azure/traffic-manager/traffic-manager-monitoring#enable-or-disable-health-checks-preview)
- [Troubleshooting degraded state on Azure Traffic Manager](https://learn.microsoft.com/azure/traffic-manager/traffic-manager-troubleshooting-degraded)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}
{{< code lang="sql" file="code/traf-1/traf-1.kql" >}} {{< /code >}}
{{< /collapse >}}
<br><br>

### TRAF-2 - Traffic manager profiles should have more than one endpoint

**Category: Availability**

**Impact: High**

**Guidance**

When configuring the Azure traffic manager, you should provision minimum of two endpoints to fail-over the workload to a another instance.

**Resources**

- [Traffic Manager Endpoint Types](https://learn.microsoft.com/azure/traffic-manager/traffic-manager-endpoint-types)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/traf-2/traf-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### TRAF-3 - Configure at least one endpoint within a another region

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Profiles should have more than one endpoint to ensure availability if one of the endpoints fails. It is also recommended that endpoints be in different regions.

**Resources**

- [Reliability recommendations
](https://learn.microsoft.com/azure/advisor/advisor-reference-reliability-recommendations#add-at-least-one-more-endpoint-to-the-profile-preferably-in-another-azure-region)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/traf-3/traf-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### TRAF-4 - TTL value of user profiles should be in 60 Seconds

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Time to Live (TTL) affects how recent of a response a client will get when it makes a request to Azure Traffic Manager. Reducing the TTL value means that the client will be routed to a functioning endpoint faster in the case of a failover. Configure your TTL to 60 seconds to route traffic to a health endpoint as quickly as possible.

**Resources**

- [Configure DNS Time to Live to 60 seconds).](https://learn.microsoft.com/azure/advisor/advisor-reference-performance-recommendations#configure-dns-time-to-live-to-60-seconds)
- [Traffic Manager profile - ProfileTTL (Configure DNS Time to Live to 60 seconds).](https://aka.ms/Um3xr5)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/traf-4/traf-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### TRAF-5 - Ensure endpoint configured to (All World) for geographic profiles

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

For geographic routing, traffic is routed to endpoints based on defined regions. When a region fails, there is no pre-defined failover. Having an endpoint where the Regional Grouping is configured to "All (World)" for geographic profiles will avoid traffic black holing and guarantee service remains available.

**Resources**

- [Add an endpoint configured to "All (World)"](https://learn.microsoft.com/azure/advisor/advisor-reference-reliability-recommendations#add-an-endpoint-configured-to-all-world)
- [Traffic Manager profile - GeographicProfile (Add an endpoint configured to ""All (World)"").](https://aka.ms/Rf7vc5)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/traf-5/traf-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
