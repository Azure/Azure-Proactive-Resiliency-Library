+++
title = "VPN Gateway"
description = "Best practices and resiliency recommendations for Vpn Gateway and associated resources."
date = "4/20/23"
author = "sitarant"
msAuthor = "sitarant"
draft = false
+++

The presented resiliency recommendations in this guidance include VPN Gateway and associated VPN Gateway settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for VPN Gateway and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                    |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [GW-1 - Choose a Zone-redundant gateway](#gw-1---choose-a-zone-redundant-gateway)                                                         | Preview  |         Yes          |
| [GW-2 - Plan for Active-Active mode](#gw-2---plan-for-active-active-mode)                                                               | Preview  |         Yes          |
| [GW-3 - Plan for Site-to-Site VPN and Azure ExpressRoute coexisting connection](#gw-3---plan-for-site-to-site-vpn-and-azure-expressroute-coexisting-connection)                                                         | Preview  |         No          |
| [GW-4 - Plan for geo-redundant circuits](#gw-4---plan-for-geo-redundant-circuits)                                                       | Preview  |         Yes          |
| [GW-5 - Monitor circuits and gateway health](#gw-5---monitor-circuits-and-gateway-health)                                               | Preview  |         Yes          |
| [GW-6 - Enable service health](#gw-6---enable-service-health)                                                                           | Preview  |         Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### GW-1 - Choose a Zone-redundant gateway

#### Importance: Critical

#### Recommendation/Guidance

Azure VPN gateway provides different SLAs when it's deployed in a single availability zone and when it's deployed in two or more availability zones. For information about all Azure SLAs, see [SLA summary for Azure services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1).
To automatically deploy your virtual network gateways across availability zones, you can use zone-redundant virtual network gateways. With zone-redundant gateways, you can benefit from zone-resiliency to access your mission-critical, scalable services on Azure.

##### Resources

- [Zone redundant Virtual network gateway in availability zone](https://learn.microsoft.com/en-us/azure/vpn-gateway/about-zone-redundant-vnet-gateways)
- [Gateway SKU](https://learn.microsoft.com/en-us/azure/vpn-gateway/about-zone-redundant-vnet-gateways#gwskus)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gw-1/gw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### GW-2 - Plan for Active-Active mode

#### Importance: High

#### Recommendation/Guidance

The active-active mode is available for all SKUs except Basic or Standard.
Active-active gateways have two Gateway IP configurations and two public IP addresses.


##### Resources

- [Active-active VPN gateway](https://learn.microsoft.com/en-us/azure/vpn-gateway/active-active-portal#gateway)
- [Gateway SKU](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsku)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gw-2/gw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### GW-3 - Plan for Site-to-Site VPN and Azure ExpressRoute coexisting connection

#### Importance: High

#### Recommendation/Guidance

During the initial planning phase, you want to decide whether you want to configure an ExpressRoute connection.
An Azure ExpressRoute circuit provide a private dedicated connection into Azure.You also need to identify the bandwidth and the SKU type requirement for your business needs. Configure a Site-to-Site VPN as a failover path for ExpressRoute

##### Resources

- [Configure a Site-to-Site VPN as a failover path for ExpressRoute](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-howto-coexist-resource-manager#configuration-designs)
- [Limit and limitations](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-howto-coexist-resource-manager#limits-and-limitations)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gw-3/gw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### GW-4 - Plan for geo-redundant circuits

#### Importance: High

#### Recommendation/Guidance

To plan for disaster recovery, set up Site-to-Site VPN in more than one location. You can create IP Sec connectivity in the same metro or different metro and choose to work with different service providers for diverse paths

##### Resources

- [Highly available cross-premises](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable)
- [About VPN gateway redundancy](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable#about-vpn-gateway-redundancy)


#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gw-4/gw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### GW-5 - Monitor circuits and gateway health

#### Importance: High

#### Recommendation/Guidance

Set up monitoring and alerts for Virtual Network Gateway health based on various metrics available.

##### Resources

- [VPN gateway data reference](https://learn.microsoft.com/en-us/azure/vpn-gateway/monitor-vpn-gateway-reference)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gw-5/gw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### GW-6 - Enable service health

#### Importance: High

#### Recommendation/Guidance

VPN Gateway uses service health to notify about planned and unplanned maintenance. Configuring service health will notify you about changes made to your VPN connectivity.

##### Resources

- [Getting started with Azure Metrics Explorer](hhttps://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-getting-started)
- [Monitor VPN gateway](hhttps://learn.microsoft.com/en-us/azure/vpn-gateway/monitor-vpn-gateway-reference#metrics)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gw-6/gw-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
