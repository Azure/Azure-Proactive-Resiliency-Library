+++
title = "ExpressRoute Gateway"
description = "Best practices and resiliency recommendations for ExpressRoute Gateway and associated resources."
date = "01/31/24"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute Gateway and associated ExpressRoute Gateway settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                                        |   Category   | Impact |  State  | ARG Query Available |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------:|:------:|:-------:|:-------------------:|
| [ERGW-1 - Connect the ExpressRoute Gateway to two or more circuits from different peering locations for higher resiliency](#ergw-1---connect-the-expressroute-gateway-to-two-or-more-circuits-from-different-peering-locations-for-higher-resiliency) | Availability |  High  | Preview |         No          |
| [ERGW-2 - Use Zone-redundant gateway SKUs](#ergw-2---use-zone-redundant-gateway-skus)                                                                                                                                                                 | Availability |  High  | Preview |         Yes         |
| [ERGW-3 - Configure an Azure Resource lock for ExpressRoute Gateway to prevent accidental deletion](#ergw-3---configure-an-azure-resource-lock-for-expressroute-gateway-to-prevent-accidental-deletion)                                               | Availability |  High  | Preview |         No          |
| [ERGW-4 - Monitor gateway health](#ergw-4---monitor-gateway-health)                                                                                                                                                                                   |  Monitoring  |  High  | Preview |         No          |
| [ERGW-5 - Configure diagnostic logs and alerts for ExpressRoute virtual network gateway](#ergw-5---configure-diagnostic-logs-and-alerts-for-expressroute-virtual-network-gateway)                                                                     |  Monitoring  |  High  | Preview |         No          |
| [ERGW-6 - Avoid using ExpressRoute circuits for VNet to VNet communication](#ergw-6---avoid-using-expressroute-circuits-for-vnet-to-vnet-communication)                                                                                               |  Networking  | Medium | Preview |         No          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ERGW-1 - Connect the ExpressRoute Gateway to two or more circuits from different peering locations for higher resiliency

**Category: Availability**

**Impact: High**

**Guidance**

Connect each ExpressRoute Gateway to a minimum of two circuits, with each circuit connecting from a diverse peering location compared to the other.

**Resources**

- [Designing for disaster recovery with ExpressRoute private peering](https://learn.microsoft.com/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-1/ergw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-2 - Use Zone-redundant gateway SKUs

**Category: Availability**

**Impact: High**

**Guidance**

Azure ExpressRoute gateway provides different SLAs when it’s deployed in a single availability zone and when it’s deployed in two or more availability zones. For information about all Azure SLAs, see [Service Level Agreements (SLA) for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1&year=2023). To automatically deploy your virtual network gateways across availability zones, you can use zone-redundant virtual network gateways. With zone-redundant gateways, you can benefit from zone-resiliency to access your mission-critical, scalable services on Azure

**Resources**

- [About ExpressRoute virtual network gateways - Zone-redundant gateway SKUs](https://learn.microsoft.com/azure/expressroute/expressroute-about-virtual-network-gateways#zrgw)
- [About zone-redundant virtual network gateway in Azure availability zones](https://learn.microsoft.com/azure/vpn-gateway/about-zone-redundant-vnet-gateways)
- [Create a zone-redundant virtual network gateway in Azure Availability Zones](https://learn.microsoft.com/azure/vpn-gateway/create-zone-redundant-vnet-gateway)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-2/ergw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-3 - Configure an Azure Resource lock for ExpressRoute Gateway to prevent accidental deletion

**Category: Availability**

**Impact: High**

**Guidance**

Configure an Azure Resource lock for ExpressRoute Gateway to prevent accidental deletion. As an administrator, you can lock an Azure subscription, resource group, or resource to protect them from accidental user deletions and modifications. The lock overrides any user permission.

**Resources**

- [Protect your Azure resources with a lock - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-3/ergw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-4 - Monitor gateway health

**Category: Monitoring**

**Impact: High**

**Guidance**

Set up monitoring and alerts for Virtual Network Gateway health based on various metrics available.

**Resources**

- [Alerts for ExpressRoute gateway connections](https://learn.microsoft.com/azure/expressroute/monitor-expressroute#alerts-for-expressroute-gateway-connections)
- [Gateway Metrics](https://learn.microsoft.com/azure/expressroute/expressroute-network-insights#gateway-metrics)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-4/ergw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-5 - Configure diagnostic logs and alerts for ExpressRoute virtual network gateway

**Category: Monitoring**

**Impact: High**

**Guidance**

Enabling diagnostic logs allows you to capture and view diagnostic information so that you can troubleshoot any failures for ExpressRoute virtual network gateway. Creating alert rules based on a log query can alert you based on the criteria specific to the customer.

**Resources**

- [Troubleshooting Azure VPN Gateway using diagnostic logs | Microsoft Learn](https://learn.microsoft.com/azure/vpn-gateway/troubleshoot-vpn-with-azure-diagnostics)
- [Configure alerts on diagnostic resource log events - Azure VPN Gateway | Microsoft Learn](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-setup-alerts-virtual-network-gateway-log)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-5/ergw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-6 - Avoid using ExpressRoute circuits for VNet to VNet communication

**Category: Networking**

**Impact: Medium**

**Guidance**

By default, connectivity between virtual networks is enabled when you link multiple virtual networks, each with an ExpressRoute Gateway, to the same ExpressRoute circuit. However, Microsoft advises against using your ExpressRoute circuit for communication between virtual networks and instead use other techniques such as VNet peering, routing in a VNet hub via Azure Firewall, NVA and/or Azure Route Server, site-to-site VPN within Azure, the use of virtual WAN, or the use of SD-WAN.

For more information about why VNet-to-VNet connectivity isn’t recommended over ExpressRoute, see: [Connectivity between virtual networks over ExpressRoute | Microsoft Learn](https://learn.microsoft.com/azure/expressroute/virtual-network-connectivity-guidance)

**Resources**

- [About ExpressRoute virtual network gateways - VNet-to-VNet connectivity](https://learn.microsoft.com/azure/expressroute/expressroute-about-virtual-network-gateways#vnet-to-vnet-connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-6/ergw-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
