+++
title = "ExpressRoute Traffic Collector"
description = "Best practices and resiliency recommendations for ExpressRoute Traffic Collector and associated resources and settings."
date = "1/28/24"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute Traffic Collector and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Category | Impact | State | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------: | :------: | :-----------------: |
| [ERTC-1 - Ensure ExpressRoute Traffic Collector is enabled and configured for ExpressRoute Direct circuits](#ertc-1---ensure-expressroute-traffic-collector-is-enabled-and-configured-for-expressroute-direct-circuits) | Monitoring | Medium | Verified | No |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ERTC-1 - Ensure ExpressRoute Traffic Collector is enabled and configured for ExpressRoute Direct circuits

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

ExpressRoute Traffic Collector enables sampling of network flows sent over your ExpressRoute Direct circuits. Flow logs get sent to a Log Analytics workspace where you can create your own log queries for further analysis. You can also export the data to any visualization tool or SIEM (Security Information and Event Management) of your choice. Flow logs can be enabled for both private peering and Microsoft peering with ExpressRoute Traffic Collector.

You can associate a single ExpressRoute Direct circuit with multiple ExpressRoute Traffic Collectors deployed in different Azure region within a given geo-political region. It's recommended that you associate your ExpressRoute Direct circuit with multiple ExpressRoute Traffic Collectors as part of your disaster recovery and high availability plan.

**Resources**

- [Azure ExpressRoute Traffic Collector](https://learn.microsoft.com/en-us/azure/expressroute/traffic-collector)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ertc-1/ertc-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
