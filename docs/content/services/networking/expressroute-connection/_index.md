+++
title = "ExpressRoute Connection"
description = "Best practices and resiliency recommendations for ExpressRoute Connection and associated resources and settings."
date = "1/28/24"
author = "ehaslett"
msAuthor = "ethaslet"
draft = false
+++

The presented resiliency recommendations in this guidance include ExpressRoute Connection and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Category | Impact | State | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------: | :------: | :-----------------: |
| [ERCON-1 - For Connections using ExpressRoute Direct circuits and UltraPerformance or ErGw3AZ ExpressRoute Gateways, enable FastPath to improve data path performance between your on-premises network and your virtual network](#ercon-1---for-connections-using-expressroute-direct-circuits-and-ultraperformance-or-ergw3az-expressroute-gateways-enable-fastpath-to-improve-data-path-performance-between-your-on-premises-network-and-your-virtual-network) | System Efficiency | Medium | Verified | No |
| [ERCON-2 - Configure an Azure Resource Lock on connections to prevent accidental deletion](#ercon-2---configure-an-azure-resource-lock-on-connections-to-prevent-accidental-deletion) | Availability | High | Verified | No |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ERCON-1 - For Connections using ExpressRoute Direct circuits and UltraPerformance or ErGw3AZ ExpressRoute Gateways, enable FastPath to improve data path performance between your on-premises network and your virtual network

**Category: System Efficiency**

**Impact: Medium**

**Recommendation/Guidance**

ExpressRoute virtual network gateway is designed to exchange network routes and route network traffic. FastPath is designed to improve the data path performance between your on-premises network and your virtual network. When enabled, FastPath sends network traffic directly to virtual machines in the virtual network, bypassing the gateway. Bypassing the gateway enhances resiliency by reducing its utilization of the gateway.

**Resources**

- [About ExpressRoute FastPath](https://learn.microsoft.com/en-us/azure/expressroute/about-fastpath)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ercon-1/ercon-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ERCON-2 - Configure an Azure Resource Lock on connections to prevent accidental deletion

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Configure an Azure Resource lock for Gateway Connection resources to prevent accidental deletion. Accidental deletion of a Gateway Connection resource may result in unexpected loss of connectivity between your on-premises network and Azure workloads. As an administrator, you can lock an Azure subscription, resource group, or resource to protect them from accidental user deletions and modifications. The lock overrides any user permission.

**Resources**

- [Protect your Azure resources with a lock - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ercon-2/ercon-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
