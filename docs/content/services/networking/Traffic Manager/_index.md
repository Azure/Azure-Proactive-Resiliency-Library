+++
title = "Traffic Manager"
description = "Best practices and resiliency recommendations for Azure Traffic Manager."
date = "6/13/23"
author = "chinthakaru"
msAuthor = "crupasinghe"
draft = true
+++

The presented resiliency recommendations in this guidance include Azure Traffic Manager and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                              | Impact   | State    | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------ | :------: | :------: | :-----------------: |
| [TM-1 - Traffic Manager Monitor Status Should be Online](#tm-1---traffic-manager-monitor-status-should-be-online)     |  High    | Preview  | Yes |
| [TM-2 - Traffic manager profiles should have more than one endpoint](#tm-2---traffic-manager-profiles-should-have-more-than-one-endpoint)                                   |  High    | Preview  | Yes |
| [TM-3 - Configure at least one endpoint within a another region](#tm-3---configure-at-least-one-endpoint-within-a-another-region)                                                        |  Medium    | Preview  | Yes |
| [TM-4 - TTL value of user profiles should be in 60 Seconds](#tm-4---ttl-value-of-user-profiles-should-be-in-60-seconds)                                             |  Medium    | Preview  | Yes |
| [TM-5 - Ensure endpoint configured to All World for geographic profiles](#tm-5---ensure-endpoint-configured-to-all-world-for-geographic-profiles)                       |  Medium  | Preview  | Yes |


{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### TM-1 - Traffic Manager Monitor Status Should be Online

**Impact: High**

**Recommendation/Guidance**

  Monitor status should be online to provide the failover for application workload.  If the health of your Traffic Manager displays a Degraded status, then the status of one or more endpoints may be Degraded.

**Resources**

- [Azure Traffic Manager endpoint monitoring](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-monitoring)
- [Enable or disable health checks](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-monitoring#enable-or-disable-health-checks-preview)
- [Troubleshooting degraded state on Azure Traffic Manager](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-troubleshooting-degraded)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}
{{< code lang="sql" file="code/tm-1/tm-1.kql" >}} {{< /code >}}
{{< /collapse >}}
<br><br>

### TM-2 - Traffic manager profiles should have more than one endpoint

**Impact: High**

**Recommendation/Guidance**

When configuring the Azure traffic manager, you should provision minimum of two endpoints to fail-over the workload to a another instance.

**Resources**

- [Traffic Manager Endpoint Types](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-endpoint-types)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/tm-2/tm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### TM-3 - Configure at least one endpoint within a another region

**Impact: Medium**

**Recommendation/Guidance**

Profiles should have more than one endpoint to ensure availability if one of the endpoints fails. It is also recommended that endpoints be in different regions.

**Resources**

- [Reliability recommendations
](https://learn.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations#add-at-least-one-more-endpoint-to-the-profile-preferably-in-another-azure-region)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/tm-3/tm-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### TM-4 - TTL value of user profiles should be in 60 Seconds

**Impact: Medium**

**Recommendation/Guidance**

Time to Live (TTL) affects how recent of a response a client will get when it makes a request to Azure Traffic Manager. Reducing the TTL value means that the client will be routed to a functioning endpoint faster in the case of a failover. Configure your TTL to 60 seconds to route traffic to a health endpoint as quickly as possible.

**Resources**

- [Configure DNS Time to Live to 60 seconds).](https://learn.microsoft.com/en-us/azure/advisor/advisor-reference-performance-recommendations#configure-dns-time-to-live-to-60-seconds)
- [Traffic Manager profile - ProfileTTL (Configure DNS Time to Live to 60 seconds).](https://aka.ms/Um3xr5)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/tm-4/tm-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### TM-5 - Ensure endpoint configured to All World for geographic profiles

**Impact: Medium**

**Recommendation/Guidance**

For geographic routing, traffic is routed to endpoints based on defined regions. When a region fails, there is no pre-defined failover. Having an endpoint where the Regional Grouping is configured to "All (World)" for geographic profiles will avoid traffic black holing and guarantee service remains available.

**Resources**

- [Add an endpoint configured to "All (World)"](https://learn.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations#add-an-endpoint-configured-to-all-world)
- [Traffic Manager profile - GeographicProfile (Add an endpoint configured to ""All (World)"").](https://aka.ms/Rf7vc5)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/tm-5/tm-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

