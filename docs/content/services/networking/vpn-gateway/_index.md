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
| Recommendation                                                                                                                                                  |  State   | ARG Query Available |
| :-------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: | :-----------------: |
| [VPNG-1 - Choose a Zone-redundant gateway](#vpng-1---choose-a-zone-redundant-gateway)                                                         | Preview  |         Yes          |
| [VPNG-2 - Plan for Active-Active mode](#vpng-2---plan-for-active-active-mode)                                                               | Preview  |         Yes          |
| [VPNG-3 - Plan for Site-to-Site VPN and Azure ExpressRoute coexisting connection](#vpng-3---plan-for-site-to-site-vpn-and-azure-expressroute-coexisting-connection)                                                         | Preview  |         No          |
| [VPNG-4 - Plan for geo-redundant VPN Connections](#vpng-4---plan-for-geo-redundant-vpn-connections)                                                       | Preview  |         No          |
| [VPNG-5 - Monitor connections and gateway health](#vpng-5---monitor-connections-and-gateway-health)                                               | Preview  |         No          |
| [VPNG-6 - Enable service health](#vpng-6---enable-service-health)                                                                           | Preview  |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VPNG-1 - Choose a Zone-redundant gateway

**Impact: High**

**Guidance**

Azure VPN gateway provides different SLAs when it's deployed in a single availability zone and when it's deployed in two or more availability zones. For information about all Azure SLAs, see [SLA summary for Azure services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1).
To automatically deploy your virtual network gateways across availability zones, you can use zone-redundant virtual network gateways. With zone-redundant gateways, you can benefit from zone-resiliency to access your mission-critical, scalable services on Azure.

**Resources**

- [Zone redundant Virtual network gateway in availability zone](https://learn.microsoft.com/azure/vpn-gateway/about-zone-redundant-vnet-gateways)
- [Gateway SKU](https://learn.microsoft.com/azure/vpn-gateway/about-zone-redundant-vnet-gateways#gwskus)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-1/vpng-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-2 - Plan for Active-Active mode

**Impact: High**

**Guidance**

The active-active mode is available for all SKUs except Basic or Standard.
Active-active gateways have two Gateway IP configurations and two public IP addresses.

**Resources**

- [Active-active VPN gateway](https://learn.microsoft.com/azure/vpn-gateway/active-active-portal#gateway)
- [Gateway SKU](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsku)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-2/vpng-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-3 - Plan for Site-to-Site VPN and Azure ExpressRoute coexisting connection

**Impact: High**

**Guidance**

During the initial planning phase, you want to decide whether you want to configure an ExpressRoute connection.
An Azure ExpressRoute circuit provide a private dedicated connection into Azure.You also need to identify the bandwidth and the SKU type requirement for your business needs. Configure a Site-to-Site VPN as a failover path for ExpressRoute

**Resources**

- [Configure a Site-to-Site VPN as a failover path for ExpressRoute](https://learn.microsoft.com/azure/expressroute/expressroute-howto-coexist-resource-manager#configuration-designs)
- [Limit and limitations](https://learn.microsoft.com/azure/expressroute/expressroute-howto-coexist-resource-manager#limits-and-limitations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-3/vpng-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-4 - Plan for geo-redundant VPN connections

**Impact: High**

**Guidance**

To plan for disaster recovery, set up Site-to-Site VPN in more than one location. You can create IP Sec connectivity in the same metro or different metro and choose to work with different service providers for diverse paths

**Resources**

- [Highly available cross-premises](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-highlyavailable)
- [About VPN gateway redundancy](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-highlyavailable#about-vpn-gateway-redundancy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-4/vpng-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-5 - Monitor connections and gateway health

**Impact: Medium**

**Guidance**

Set up monitoring and alerts for Virtual Network Gateway health based on various metrics available.

**Resources**

- [VPN gateway data reference](https://learn.microsoft.com/azure/vpn-gateway/monitor-vpn-gateway-reference)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-5/vpng-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VPNG-6 - Enable service health

**Impact: Medium**

**Guidance**

VPN Gateway uses service health to notify about planned and unplanned maintenance. Configuring service health will notify you about changes made to your VPN connectivity.

**Resources**

- [Getting started with Azure Metrics Explorer](hhttps://learn.microsoft.com/azure/azure-monitor/essentials/metrics-getting-started)
- [Monitor VPN gateway](hhttps://learn.microsoft.com/azure/vpn-gateway/monitor-vpn-gateway-reference#metrics)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vpng-6/vpng-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
