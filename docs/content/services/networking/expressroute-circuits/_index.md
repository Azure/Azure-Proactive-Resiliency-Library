+++
title = "ExpressRoute Circuits"
description = "Best practices and resiliency recommendations for ExpressRoute Circuits and associated resources."
date = "4/28/23"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute Circuits and associated ExpressRoute Circuits settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for ExpressRoute Circuits and associated resources.

{{< table style="table-striped" >}}
| Recommendation | State | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [ERC-1 - Ensure both connections of an ExpressRoute circuit are configured and active](#erc-1---ensure-both-connections-of-an-expressroute-circuit-are-configured-and-active) | Preview | Yes |
| [ERC-2 - Physical layer diversity](#erc-2---physical-layer-diversity) | Preview | No |
| [ERC-3 - Diversify primary and secondary connections to customer end routers](#erc-3---diversify-primary-and-secondary-connections-to-customer-end-routers) | Preview | No |
| [ERC-4 - Diversify primary and secondary connections to customer end ports](#erc-4---diversify-primary-and-secondary-connections-to-customer-end-ports) | Preview | No |
| [ERC-5 - Monitor ExpressRoute using Azure Monitor](#erc-5---monitor-expressroute-using-azure-monitor) | Preview | TBD |
| [ERC-6 - Configure service health to receive ExpressRoute circuit maintenance notification](#erc-6---configure-service-health-to-receive-expressroute-circuit-maintenance-notification) | Preview | TBD |
| [ERC-7 - Ensure Bidirectional Forwarding Detection is enabled and configured on customer equipment](#erc-7---ensure-bidirectional-forwarding-detection-is-enabled-and-configured) | Preview | No |
| [ERC-8 - Implement multiple ExpressRoute circuits](#erc-8---implement-multiple-expressroute-circuits) | Preview | TBD |
| [ERC-9 - Configure site-to-site VPN as a backup to ExpressRoute private peering](#erc-9---configure-site-to-site-vpn-as-a-backup-to-expressroute-private-peering) | Preview | TBD |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

## Recommendations Details

### ERC-1 - Ensure both connections of an ExpressRoute circuit are configured and active

#### Importance: Critical

#### Recommendation/Guidance

To improve high availability, it's recommended to operate both the connections of an ExpressRoute circuit in active-active mode. If you let the connections operate in active-active mode, Microsoft network will load balance the traffic across the connections on per-flow basis.

##### Resources

- [Designing for high availability with ExpressRoute - Active-active connections](https://learn.microsoft.com/en-us/azure/expressroute/designing-for-high-availability-with-expressroute#active-active-connections)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-1/erc-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-2 - Physical layer diversity

#### Importance: High

#### Recommendation/Guidance

For better resiliency, plan to have multiple paths between the on-premises edge and the peering locations (provider/Microsoft edge locations). This configuration can be achieved by going through different service provider or through a different location from the on-premises network.

##### Resources

- [Azure Well-Architected Framework review - Azure ExpressRoute - Design Checklist](https://learn.microsoft.com/en-us/azure/well-architected/services/networking/azure-expressroute#recommendations)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-2/erc-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-3 - Diversify primary and secondary connections to customer end routers

#### Importance: High

#### Recommendation/Guidance

Never terminate primary and secondary connections on the same customer end router. This creates a single point of failure.

##### Resources

- [Designing for high availability with ExpressRoute - First mile physical layer design considerations](https://learn.microsoft.com/en-us/azure/expressroute/designing-for-high-availability-with-expressroute#first-mile-physical-layer-design-considerations)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-3/erc-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-4 - Diversify primary and secondary connections to customer end ports

#### Importance: High

#### Recommendation/Guidance

Don’t configure both Primary and secondary connections via same port. This creates a single point of failure.

##### Resources

- [Designing for high availability with ExpressRoute - First mile physical layer design considerations](https://learn.microsoft.com/en-us/azure/expressroute/designing-for-high-availability-with-expressroute#first-mile-physical-layer-design-considerations)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-4/erc-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-5 - Monitor ExpressRoute using Azure Monitor

#### Importance: High

#### Recommendation/Guidance

ExpressRoute monitor provides end-to-end monitoring capabilities including: Loss, latency, and performance from on-premises to Azure and Azure to on-premises

##### Resources

- [Monitoring Azure ExpressRoute](https://learn.microsoft.com/en-us/azure/expressroute/monitor-expressroute)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-5/erc-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-6 - Configure service health to receive ExpressRoute circuit maintenance notification

#### Importance: High

#### Recommendation/Guidance

ExpressRoute uses service health to notify about planned and unplanned maintenance. Configuring service health will notify you about changes made to your ExpressRoute circuits.

##### Resources

- [How to view and configure alerts for Azure ExpressRoute circuit maintenance](https://learn.microsoft.com/en-us/azure/expressroute/maintenance-alerts)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-6/erc-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-7 - Ensure Bidirectional Forwarding Detection is enabled and configured

#### Importance: High

#### Recommendation/Guidance

When you enable Bidirectional Forwarding Detection (BFD) over ExpressRoute, you can speed up the link failure detection between Microsoft Enterprise edge (MSEE) devices and the routers that your ExpressRoute circuit gets configured (CE/PE). You can configure ExpressRoute over your edge routing devices or your Partner Edge routing devices (if you went with managed Layer 3 connection service).

##### Resources

- [https://learn.microsoft.com/en-us/azure/expressroute/expressroute-bfd](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-bfd)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-7/erc-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-8 - Implement multiple ExpressRoute circuits

#### Importance: Medium

#### Recommendation/Guidance

Implement multiple ExpressRoute circuits in your Virtual Network for cross premises resiliency

##### Resources

- [Designing for disaster recovery with ExpressRoute private peering](https://learn.microsoft.com/en-us/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-8/erc-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERC-9 - Configure site-to-site VPN as a backup to ExpressRoute private peering

#### Importance: Medium

#### Recommendation/Guidance

Consider using site-to-site VPN as a failover when an ExpressRoute circuit becomes unavailable.

##### Resources

- [Using S2S VPN as a backup for ExpressRoute private peering](https://learn.microsoft.com/en-us/azure/expressroute/use-s2s-vpn-as-backup-for-expressroute-privatepeering)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/erc-9/erc-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
