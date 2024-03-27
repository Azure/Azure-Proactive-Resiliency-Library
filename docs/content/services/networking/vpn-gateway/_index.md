+++
title = "VPN Gateway"
description = "Best practices and resiliency recommendations for VPN Gateway and associated resources."
date = "4/20/23"
author = "sitarant"
msAuthor = "sitarant"
draft = false
+++

The presented resiliency recommendations in this guidance include VPN Gateway and associated VPN Gateway settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for VPN Gateway and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                      |     Category      | Impact |  State  | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [VPNG-1 - Choose a Zone-redundant gateway](#vpng-1---choose-a-zone-redundant-gateway)                                                                               |   Availability    |  High  | Preview |         Yes         |
| [VPNG-2 - Plan for Active-Active mode](#vpng-2---plan-for-active-active-mode)                                                                                       |   Availability    |  High  | Preview |         Yes         |
| [VPNG-4 - Deploy active-active VPN concentrators on your premises for maximum resiliency](#vpng-4---deploy-active-active-vpn-concentrators-on-your-premises-for-maximum-resiliency) | Availability | High | Preview | No |                                                                | Availability |  Medium  | Preview |         No          |
| [VPNG-5 - Monitor connections and gateway health](#vpng-5---monitor-connections-and-gateway-health)                                                                 |    Monitoring     | Medium | Preview |         No          |
| [VPNG-6 - Enable service health](#vpng-6---enable-service-health)                                                                                                   |    Monitoring     | Medium | Preview |         No          |
| [VPNG-7 - Deploy zone-redundant VPN Gateways with zone-redundant Public IP(s)](#vpng-7---deploy-zone-redundant-vpn-gateways-with-zone-redundant-public-ips)         | Availability | Medium | Preview | Yes |                                                                                          |    Availability     | High | Preview |         Yes          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VPNG-1 - Choose a Zone-redundant gateway

**Category: Availability**

**Impact: High**

**Guidance**

Azure VPN gateway provides different SLAs when it's deployed in a single availability zone and when it's deployed in two availability zones. To automatically deploy your virtual network gateways across availability zones, you can use zone-redundant virtual network gateways. With zone-redundant gateways, you can benefit from zone-resiliency to access your mission-critical, scalable services on Azure.

**Resources**

- [Zone redundant Virtual network gateway in availability zone](https://learn.microsoft.com/azure/vpn-gateway/about-zone-redundant-vnet-gateways)
- [Gateway SKU](https://learn.microsoft.com/azure/vpn-gateway/about-zone-redundant-vnet-gateways#gwskus)
- [SLA summary for Azure services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1).

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-1/vpng-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-2 - Plan for Active-Active mode

**Category: Availability**

**Impact: High**

**Guidance**

The active-active mode is available for all SKUs except Basic.
Active-active gateways have two Gateway IP configurations and two public IP addresses.

**Resources**

- [Active-active VPN gateway](https://learn.microsoft.com/azure/vpn-gateway/active-active-portal#gateway)
- [Gateway SKU](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsku)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-2/vpng-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-4 - Deploy active-active VPN concentrators on your premises for maximum resiliency

**Category: Availability**

**Impact: High**

**Guidance**

By deploying active-active VPN concentrators on your premises, along with active-active Azure VPN Gateways, you can maximize resilience and availability by using a fully-meshed topology based on four IPSec tunnels.

**Resources**

- [Dual-redundancy: active-active VPN gateways for both Azure and on-premises networks](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-highlyavailable#dual-redundancy-active-active-vpn-gateways-for-both-azure-and-on-premises-networks)


**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-4/vpng-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-5 - Monitor connections and gateway health

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Set up monitoring and alerts for Virtual Network Gateway health based on various metrics available.

**Resources**

- [VPN gateway data reference](https://learn.microsoft.com/azure/vpn-gateway/monitor-vpn-gateway-reference)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-5/vpng-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-6 - Enable service health

**Category: Monitoring**

**Impact: Medium**

**Guidance**

VPN Gateway uses service health to notify about planned and unplanned maintenance. Configuring service health will notify you about changes made to your VPN connectivity.

**Resources**

- [Getting started with Azure Metrics Explorer](hhttps://learn.microsoft.com/azure/azure-monitor/essentials/metrics-getting-started)
- [Monitor VPN gateway](hhttps://learn.microsoft.com/azure/vpn-gateway/monitor-vpn-gateway-reference#metrics)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-6/vpng-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-7 - Deploy zone-redundant VPN Gateways with zone-redundant Public IP(s)

**Category: Availability**

**Impact: High**

**Guidance**

When using zone-redundant SKUs for VPN Gateways (VpnGw*AZ), make sure that you associate your gateway with zone-redundant Standard SKU public IP addresses. If a VPN gateway is associated with zonal Standard SKU public IP addresses, all the gateway instances are deployed in the same zone as the IP address(es). This recommendation applies to both active-passive gateways (which use a single public IP address) and active-active VPN gateways (which use two public IP addresses).

**Resources**

- [About zone-redundant virtual network gateway in Azure availability zones](https://learn.microsoft.com/azure/vpn-gateway/about-zone-redundant-vnet-gateways)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-7/vpng-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

