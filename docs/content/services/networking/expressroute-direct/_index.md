+++
title = "ExpressRoute Direct"
description = "Best practices and resiliency recommendations for ExpressRoute Direct and associated resources and settings."
date = "1/28/24"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute Direct and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Category | Impact | State | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------: | :------: | :-----------------: |
| [ERD-1 - The Admin State of both Links of an ExpressRoute Direct should be in Enabled state](#erd-1---the-admin-state-of-both-links-of-an-expressroute-direct-should-be-in-enabled-state) | Availability | High | Verified | No |
| [ERD-2 - Ensure you do not over-subscribe an ExpressRoute Direct](#erd-2---ensure-you-do-not-over-subscribe-an-expressroute-direct) | System Efficiency | High | Verified | No |
| [ERD-3 - Enable rate-limiting to help optimize network performance by controlling the traffic volume across all your ExpressRoute Direct based circuits - In Preview](#erd-3---enable-rate-limiting-to-help-optimize-network-performance-by-controlling-the-traffic-volume-across-all-your-expressroute-direct-based-circuits---in-preview) | System Efficiency | Medium | Verified| No |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ERD-1 - The Admin State of both Links of an ExpressRoute Direct should be in Enabled state

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

In Azure ExpressRoute Direct, the "Admin State" refers to the administrative status of the ExpressRoute layer 1 links. It essentially indicates whether a particular link is enabled or disabled, in other words the physical port is on or off; and is required to pass traffic across the ExpressRoute Direct connection. Admin State is a crucial setting because it determines the operational status of your ExpressRoute Direct, affecting connectivity between your on-premises network and Azure services.

**Resources**

- [How to configure ExpressRoute Direct: Change Admin State of links](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-howto-erdirect#state)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erd-1/erd-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERD-2 - Ensure you do not over-subscribe an ExpressRoute Direct

**Category: System Efficiency**

**Impact: High**

**Recommendation/Guidance**

You can provision logical ExpressRoute circuits on top of your selected ExpressRoute Direct resource of 10-Gbps or 100-Gbps up to the subscribed Bandwidth of 20-Gbps or 200-Gbps. From a resiliency perspective this is not recommended. If one of the ExpressRoute Direct ports goes down, and your ExpressRoute circuits are already consuming 100% of the 10-Gbps or 100-Gbps, the second ExpressRoute Direct port wouldn’t have bandwidth enough to support any additional load. One reason a port may be down would be during a maintenance event. The remaining port would support all traffic during the maintenance event, up to the 10-Gbps or 100-Gbps capacity. Unless you use rate limiting for ExpressRoute Direct circuits (Preview) to limit the bandwidth of non-production connections, you should not over-subscribe your ExpressRoute Direct ports being used for production workloads.

**Resources**

- [About ExpressRoute Direct: Circuit Sizes](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-erdirect-about?source=recommendations#circuit-sizes)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erd-2/erd-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERD-3 - Enable rate-limiting to help optimize network performance by controlling the traffic volume across all your ExpressRoute Direct based Circuits - In Preview

**Category: System Efficiency**

**Impact: Medium**

**Recommendation/Guidance**

Rate limiting is a feature that enables you to control the traffic volume between your on-premises network and Azure over an ExpressRoute Direct circuit. It applies to the traffic over either private or Microsoft peering of the ExpressRoute circuit. This feature helps distribute the port bandwidth evenly among the circuits, ensures network stability, and prevents network congestion. This document outlines the steps to enable rate limiting for your ExpressRoute Direct circuits.

**Resources**

- [Rate limiting for ExpressRoute Direct circuits (Preview)](https://learn.microsoft.com/en-us/azure/expressroute/rate-limit)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erd-3/erd-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
