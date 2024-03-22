+++
title = "Network Watcher"
description = "Best practices and resiliency recommendations for Network Watcher and associated resources and settings."
date = "9/19/23"
author = "rodrigosantosms"
msAuthor = "rodrigosantosmsS"
draft = false
+++

The presented resiliency recommendations in this guidance include Network Watcher and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                      |  Category      |  Impact   |  State      | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------------: | :------:  | :------:    | :-----------------: |
| [NW-1 - Deploy Network Watcher in all regions where you have networking services](#nw-1---deploy-network-watcher-in-all-regions-where-you-have-networking-services) | Monitoring     |  Low      | Preview     |         Yes         |
| [NW-2 - Fix Flow Log configurations in Failed state or Disabled Status](#nw-2---fix-flow-log-configurations-in-failed-state-or-disabled-status)                     | Monitoring     |  Low      | Preview     |         Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### NW-1 - Deploy Network Watcher in all regions where you have networking services

**Category: Monitoring**

**Impact: Low**

**Guidance**

Azure Network Watcher provides a suite of tools to monitor, diagnose, view metrics, and enable or disable logs for Azure IaaS (Infrastructure-as-a-Service) resources. Network Watcher enables you to monitor and repair the network health of IaaS products like virtual machines (VMs), virtual networks (VNets), application gateways, load balancers, etc. Network Watcher isn't designed or intended for PaaS monitoring or Web analytics.

**Resources**

- [What is Azure Network Watcher?](https://learn.microsoft.com/azure/network-watcher/network-watcher-overview)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nw-1/nw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NW-2 - Fix Flow Log configurations in Failed state or Disabled Status

**Category: Monitoring**

**Impact: Low**

**Guidance**

Network security group flow logging is a feature of Azure Network Watcher that allows you to log information about IP traffic flowing through a network security group. If the flow log is in Failed state, the monitoring data from the associated resource is not being collected.

**Resources**

- [Manage NSG flow logs using the Azure portal](https://learn.microsoft.com/azure/network-watcher/nsg-flow-logging)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nw-2/nw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
