+++
title = "ExpressRoute Circuits"
description = "Best practices and resiliency recommendations for ExpressRoute circuits and associated resources."
date = "01/21/2024"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute circuits and associated ExpressRoute circuit settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for ExpressRoute circuits and associated resources.

{{< table style="table-striped" >}}
| Recommendation | Impact | State | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------ | :------: | :------: | :-----------------: |
| [ERC-1 - For each ExpressRoute Gateway implement two or more ExpressRoute circuits to two or more diverse peering locations](#erc-1---for-each-expressroute-gateway-implement-two-or-more-expressroute-circuits-to-two-or-more-diverse-peering-locations) | High | Preview | No |
| [ERC-2 - Ensure the two physical links of your ExpressRoute circuit are connected to two distinct edge devices in your network](#erc-2---ensure-the-two-physical-links-of-your-expressroute-circuit-are-connected-to-two-distinct-edge-devices-in-your-network) | High | Preview | No |
| [ERC-3 - Ensure both connections of an ExpressRoute circuit are configured in active-active mode](#erc-3---ensure-both-connections-of-an-expressroute-circuit-are-configured-in-active-active-mode) | High | Preview | Yes |
| [ERC-4 - Ensure Bidirectional Forwarding Detection is enabled and configured on customer or provider edge routing devices](#erc-4---ensure-bidirectional-forwarding-detection-is-enabled-and-configured-on-customer-or-provider-edge-routing-devices) | High | Preview | No |
| [ERC-5 - Configure monitoring and alerting for ExpressRoute circuits](#erc-5---configure-monitoring-and-alerting-for-expressroute-circuits) | Medium | Preview | No |
| [ERC-6 - Configure service health to receive ExpressRoute circuit maintenance notification](#erc-6---configure-service-health-to-receive-expressroute-circuit-maintenance-notification) | Medium | Preview | No |
| [ERC-7 - Use a site-to-site VPN as an interim backup solution for a single ExpressRoute circuit](#erc-7---use-a-site-to-site-vpn-as-an-interim-backup-solution-for-a-single-expressroute-circuit) | Medium | Preview | No |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ERC-1 - For each ExpressRoute Gateway implement two or more ExpressRoute circuits to two or more diverse peering locations

**Impact: High**

**Guidance**

Each ExpressRoute Gateway should have a minimum of two ExpressRoute circuits. Each circuit should connect to a peering location that is diverse from the other circuit's peering location.

**Resources**

- [Designing for disaster recovery with ExpressRoute private peering](https://learn.microsoft.com/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-1/erc-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-2 - Ensure the two physical links of your ExpressRoute circuit are connected to two distinct edge devices in your network

**Impact: High**

**Guidance**

Microsoft (in the direct model) or the ExpressRoute provider (in the provider-based model) always offer a physically redundant service. Make sure that the same level of physical redundancy (two physical devices, two physical links) is used across the entire path from the ExpressRoute peering location to your network.

**Resources**

- [Designing for high availability with ExpressRoute](https://learn.microsoft.com/en-us/azure/expressroute/designing-for-high-availability-with-expressroute)
- [Azure Well-Architected Framework review - Azure ExpressRoute - Design Checklist](https://learn.microsoft.com/azure/well-architected/services/networking/azure-expressroute#recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-2/erc-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-3 - Ensure both connections of an ExpressRoute circuit are configured in active-active mode

**Impact: High**

**Guidance**

To improve high availability, it's recommended to operate both the connections of an ExpressRoute circuit in active-active mode. If you let the connections operate in active-active mode, Microsoft network will load balance the traffic across the connections on per-flow basis.

**Resources**

- [Designing for high availability with ExpressRoute - Active-active connections](https://learn.microsoft.com/azure/expressroute/designing-for-high-availability-with-expressroute#active-active-connections)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-3/erc-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-4 - Ensure Bidirectional Forwarding Detection is enabled and configured on customer or provider edge routing devices

**Impact: High**

**Guidance**

When you enable Bidirectional Forwarding Detection (BFD) over ExpressRoute, you can speed up the link failure detection between Microsoft Enterprise edge (MSEE) devices and the routers that your ExpressRoute circuit gets configured (CE/PE). You can configure ExpressRoute over your edge routing devices or your Partner Edge routing devices (if you went with managed Layer 3 connection service).

**Resources**

- [Configure BFD over ExpressRoute](https://learn.microsoft.com/azure/expressroute/expressroute-bfd)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-4/erc-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-5 - Configure monitoring and alerting for ExpressRoute circuits

**Impact: Medium**

**Guidance**

Configure monitoring using Network Insights for ExpressRoute circuit availability, circuit QoS, and throughput. Configure alerts for availability metrics when they fall below 99%, circuit QoS metrics when dropped counts exceed 0 bits/sec, and throughput metrics when bits/sec exceed a threshold appropriate for the ExpressRoute circuit SKU and customer usage.

Configure alerts using Connection Monitor for ExpressRoute with a Log Analytics workspace, and Network Watcher. Configure alerts for when ChecksFailedPercent exceeds 5%, and when RoundTripTimeMs exceeds a pre-tested average appropriate to the environment.

For ExpressRoute Direct, configure Traffic Collection for ExpressRoute Direct to send flow logs to a Log Analytics workspace.

**Resources**

- [Azure ExpressRoute Insights using Network Insights | Microsoft Learn](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-network-insights)
- [Monitoring Azure ExpressRoute](https://learn.microsoft.com/azure/expressroute/monitor-expressroute)
- [Configure Traffic Collector for ExpressRoute Direct - Azure ExpressRoute | Microsoft Learn](https://learn.microsoft.com/en-us/azure/expressroute/how-to-configure-traffic-collector#deploy-expressroute-traffic-collector)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-5/erc-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-6 - Configure service health to receive ExpressRoute circuit maintenance notification

**Impact: Medium**

**Guidance**

ExpressRoute uses service health to notify about planned and unplanned maintenance. Configuring service health will notify you about changes made to your ExpressRoute circuits.

**Resources**

- [How to view and configure alerts for Azure ExpressRoute circuit maintenance](https://learn.microsoft.com/azure/expressroute/maintenance-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-6/erc-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-7 - Use a site-to-site VPN as an interim backup solution for a single ExpressRoute circuit

**Impact: Medium**

**Guidance**

If you have not yet added a second ExpressRoute circuit for an ExpressRoute Gateway, use a site-to-site VPN as an interim solution until the second ExpressRoute circuit is available.

**Resources**

- [Using S2S VPN as a backup for ExpressRoute private peering](https://learn.microsoft.com/azure/expressroute/use-s2s-vpn-as-backup-for-expressroute-privatepeering)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-7/erc-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
