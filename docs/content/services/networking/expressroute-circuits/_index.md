+++
title = "ExpressRoute Circuits"
description = "Best practices and resiliency recommendations for ExpressRoute circuits and associated resources."
date = "01/31/2024"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute circuits and associated ExpressRoute circuit settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for ExpressRoute circuits and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                                                    |     Category      | Impact |  State  | ARG Query Available |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [ERC-1 - Connect your on-premises network to critical workloads in Azure through two or more ExpressRoute circuits in different peering locations](#erc-1---connect-your-on-premises-network-to-critical-workloads-in-azure-through-two-or-more-expressroute-circuits-in-different-peering-locations) |   Availability    |  High  | Verified |         No          |
| [ERC-2 - Ensure the two physical links of your ExpressRoute circuit are connected to two distinct edge devices in your network](#erc-2---ensure-the-two-physical-links-of-your-expressroute-circuit-are-connected-to-two-distinct-edge-devices-in-your-network)   |   Availability    |  High  | Verified |         No          |
| [ERC-3 - Ensure both connections of an ExpressRoute circuit are configured in active-active mode](#erc-3---ensure-both-connections-of-an-expressroute-circuit-are-configured-in-active-active-mode)                                                               |   Availability    |  High  | Verified |         Yes         |
| [ERC-4 - Ensure Bidirectional Forwarding Detection is enabled and configured on customer or provider edge routing devices](#erc-4---ensure-bidirectional-forwarding-detection-is-enabled-and-configured-on-customer-or-provider-edge-routing-devices)             |   Availability    |  High  | Verified |         No          |
| [ERC-5 - Configure monitoring and alerting for ExpressRoute circuits](#erc-5---configure-monitoring-and-alerting-for-expressroute-circuits)                                                                                                                       |    Monitoring     | Medium | Verified |         No          |
| [ERC-6 - Configure service health to receive ExpressRoute circuit maintenance notification](#erc-6---configure-service-health-to-receive-expressroute-circuit-maintenance-notification)                                                                           |    Monitoring     | Medium | Verified |         No          |
| [ERC-7 - Use a site-to-site VPN as an interim backup solution for a single ExpressRoute circuit](#erc-7---use-a-site-to-site-vpn-as-an-interim-backup-solution-for-a-single-expressroute-circuit)                                                                 | Disaster Recovery | Medium | Verified |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ERC-1 - Connect your on-premises network to critical workloads in Azure through two or more ExpressRoute circuits in different peering locations

**Category: Availability**

**Impact: High**

**Guidance**

Connect each ExpressRoute Gateway to a minimum of two circuits instantiated in different peering locations.
**Resources**

- [Designing for disaster recovery with ExpressRoute private peering](https://learn.microsoft.com/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-1/erc-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-2 - Ensure the two physical links of your ExpressRoute circuit are connected to two distinct edge devices in your network

**Category: Availability**

**Impact: High**

**Guidance**

Microsoft (in the ExpressRoute direct model) or the ExpressRoute provider (in the ExpressRoute provider-based model) always offer a physically redundant service. Make sure that the same level of physical redundancy (two physical devices, two physical links) is used across the entire path from the ExpressRoute peering location to your network.

**Resources**

- [Designing for high availability with ExpressRoute](https://learn.microsoft.com/en-us/azure/expressroute/designing-for-high-availability-with-expressroute)
- [Azure Well-Architected Framework review - Azure ExpressRoute - Design Checklist](https://learn.microsoft.com/azure/well-architected/services/networking/azure-expressroute#recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-2/erc-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-3 - Ensure both connections of an ExpressRoute circuit are configured in active-active mode

**Category: Availability**

**Impact: High**

**Guidance**

To improve high availability, it's recommended that you operate both the connections of an ExpressRoute circuit in active-active mode. If you configure the connections to operate in active-active mode, the Microsoft network will load balance the traffic across the connections on a per-flow basis.

**Resources**

- [Designing for high availability with ExpressRoute - Active-active connections](https://learn.microsoft.com/azure/expressroute/designing-for-high-availability-with-expressroute#active-active-connections)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-3/erc-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-4 - Ensure Bidirectional Forwarding Detection is enabled and configured on customer or provider edge routing devices

**Category: Availability**

**Impact: High**

**Guidance**

When you enable Bidirectional Forwarding Detection (BFD) over ExpressRoute, you can speed up the link failure detection between Microsoft Enterprise edge (MSEE) devices and the routers that your ExpressRoute circuit gets configured (CE/PE). You can configure ExpressRoute over your edge routing devices or your Partner Edge routing devices (if you went with managed Layer 3 connection service).

**Resources**

- [Configure BFD over ExpressRoute](https://learn.microsoft.com/azure/expressroute/expressroute-bfd)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-4/erc-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-5 - Configure monitoring and alerting for ExpressRoute circuits

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Configure monitoring using Network Insights for ExpressRoute circuit availability, circuit QoS, and throughput. Configure alerts for availability metrics and circuit QoS metrics according to [ExpressRoute Circuits | Azure Monitor Baseline Alerts](https://azure.github.io/azure-monitor-baseline-alerts/services/Network/expressRouteCircuits/), and throughput metrics when bits/sec exceed a threshold appropriate for the ExpressRoute circuit SKU and customer usage.

Configure alerts using Connection Monitor for ExpressRoute with a Log Analytics workspace, and Network Watcher. Configure alerts for when ChecksFailedPercent exceeds 5%, and when RoundTripTimeMs exceeds a pre-tested average appropriate to the environment.

For ExpressRoute Direct, configure Traffic Collection for ExpressRoute Direct to send flow logs to a Log Analytics workspace.

**Resources**

- [Azure ExpressRoute Insights using Network Insights | Microsoft Learn](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-network-insights)
- [Monitoring Azure ExpressRoute](https://learn.microsoft.com/azure/expressroute/monitor-expressroute)
- [Configure Traffic Collector for ExpressRoute Direct - Azure ExpressRoute | Microsoft Learn](https://learn.microsoft.com/en-us/azure/expressroute/how-to-configure-traffic-collector#deploy-expressroute-traffic-collector)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-5/erc-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-6 - Configure service health to receive ExpressRoute circuit maintenance notification

**Category: Monitoring**

**Impact: Medium**

**Guidance**

ExpressRoute uses service health to notify about planned and unplanned maintenance. Configuring service health will notify you about changes made to your ExpressRoute circuits.

**Resources**

- [How to view and configure alerts for Azure ExpressRoute circuit maintenance](https://learn.microsoft.com/azure/expressroute/maintenance-alerts)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-6/erc-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-7 - Use a site-to-site VPN as an interim backup solution for a single ExpressRoute circuit

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

If you have not yet added a second ExpressRoute circuit for an ExpressRoute Gateway, use a site-to-site VPN as an interim solution until the second ExpressRoute circuit is available.

**Resources**

- [Using S2S VPN as a backup for ExpressRoute private peering](https://learn.microsoft.com/azure/expressroute/use-s2s-vpn-as-backup-for-expressroute-privatepeering)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-7/erc-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
