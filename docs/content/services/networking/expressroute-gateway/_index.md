+++
title = "ExpressRoute Gateway"
description = "Best practices and resiliency recommendations for ExpressRoute Gateway and associated resources."
date = "01/16/24"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute Gateway and associated ExpressRoute Gateway settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Impact | State | ARG Query Available |
| :----------------------------------------------------------------------------------------------------------------------------------------------------- | :------: | :------: | :-----------------: |
| [ERGW-1 - Use Zone-redundant gateway SKUs](#ergw-1---use-zone-redundant-gateway-skus) | High | Preview | Yes |
| [ERGW-2 - Monitor gateway health](#ergw-2---monitor-gateway-health) | High | Preview | No |
| [ERGW-3 - Use Vnet peering for Vnet to Vnet connectivity instead of ExpressRoute circuits](#ergw-3---use-vnet-peering-for-vnet-to-vnet-connectivity-instead-of-expressroute-circuits) | Medium | Preview | No |
| [ERGW-4 - Configure diagnostic logs and alerts for ExpressRoute virtual network gateway](#ergw-4---configure-diagnostic-logs-and-alerts-for-expressroute-virtual-network-gateway) | High | Preview | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ERGW-1 - Use Zone-redundant gateway SKUs

**Category: Availability**

**Impact: High**

**Guidance**

Azure ExpressRoute gateway provides different SLAs when it’s deployed in a single availability zone and when it’s deployed in two or more availability zones. For information about all Azure SLAs, see SLA summary for Azure services. To automatically deploy your virtual network gateways across availability zones, you can use zone-redundant virtual network gateways. With zone-redundant gateways, you can benefit from zone-resiliency to access your mission-critical, scalable services on Azure

**Resources**

- [About ExpressRoute virtual network gateways - Zone-redundant gateway SKUs](https://learn.microsoft.com/azure/expressroute/expressroute-about-virtual-network-gateways#zrgw)
- [About zone-redundant virtual network gateway in Azure availability zones](https://learn.microsoft.com/azure/vpn-gateway/about-zone-redundant-vnet-gateways)
- [Create a zone-redundant virtual network gateway in Azure Availability Zones](https://learn.microsoft.com/azure/vpn-gateway/create-zone-redundant-vnet-gateway)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-1/ergw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-2 - Monitor gateway health

**Category: Monitoring**

**Impact: High**

**Guidance**

Set up monitoring and alerts for Virtual Network Gateway health based on various metrics available.

**Resources**

- [Alerts for ExpressRoute gateway connections](https://learn.microsoft.com/azure/expressroute/monitor-expressroute#alerts-for-expressroute-gateway-connections)
- [Gateway Metrics](https://learn.microsoft.com/azure/expressroute/expressroute-network-insights#gateway-metrics)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-2/ergw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-3 - Use Vnet peering for Vnet to Vnet connectivity instead of ExpressRoute circuits

**Category: Networking**

**Impact: Medium**

**Guidance**

By default, connectivity between virtual networks are enabled when you link multiple virtual networks to the same ExpressRoute circuit. However, Microsoft advises against using your ExpressRoute circuit for communication between virtual networks and instead uses VNet peering. For more information about why VNet-to-VNet connectivity isn't recommended over ExpressRoute, see connectivity between virtual networks over ExpressRoute.

**Resources**

- [About ExpressRoute virtual network gateways - VNet-to-VNet connectivity](https://learn.microsoft.com/azure/expressroute/expressroute-about-virtual-network-gateways#vnet-to-vnet-connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-3/ergw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERGW-4 - Configure diagnostic logs and alerts for ExpressRoute virtual network gateway

**Category: Networking**

**Impact: High**

**Guidance**

Enabling diagnostic logs allows you to capture and view diagnostic information so that you can troubleshoot any failures for ExpressRoute virtual network gateway. Creating alert rules based on a log query can alert you based on the criteria specific to the customer.

**Resources**

- [Troubleshooting Azure VPN Gateway using diagnostic logs | Microsoft Learn](https://learn.microsoft.com/en-us/azure/vpn-gateway/troubleshoot-vpn-with-azure-diagnostics)
- [Configure alerts on diagnostic resource log events - Azure VPN Gateway | Microsoft Learn](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-setup-alerts-virtual-network-gateway-log)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ergw-4/ergw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
