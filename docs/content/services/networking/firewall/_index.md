+++
title = "Firewall"
description = "Best practices and resiliency recommendations for Firewall and associated resources."
date = "4/14/23"
author = "fguerri"
msAuthor = "fguerri"
draft = false
+++

The presented resiliency recommendations in this guidance include Firewall and associated Firewall settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                    | Impact   |  State   | ARG Query Available |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: | :------: | :-----------------: |
| [AFW-1 - Deploy Azure Firewall across multiple availability zones](#afw-1---deploy-azure-firewall-across-multiple-availability-zones)                               |  High    | Preview  |         Yes         |
| [AFW-2 - Test Azure Firewall performance](#afw-2---test-azure-firewall-performance)                                                                                 |  High    | Preview  |         No          |
| [AFW-3 - Monitor Azure Firewall metrics](#afw-3---monitor-azure-firewall-metrics)                                                                                   |  High    | Preview  |         No         |
| [AFW-4 - Deploy an instance of Azure Firewall per region](#afw-4---deploy-an-instance-of-azure-firewall-per-region)                                                 |  High    | Preview  |         No          |
| [AFW-5 - Configure DDoS Protection on the Azure Firewall VNet](#afw-5---configure-ddos-protection-on-the-azure-firewall-vnet)                                       |  High    | Preview  |         No         |
| [AFW-6 - Leverage Azure Policy inheritance model](#afw-6---leverage-azure-policy-inheritance-model)                                                                 |  Medium  | Preview  |         No          |
| [AFW-7 - Understand impact of management operations on long running TCP sessions](#afw-7---understand-impact-of-management-operations-on-long-running-tcp-sessions) |  Medium  | Preview  |         No          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AFW-1 - Deploy Azure Firewall across multiple availability zones

**Impact: High**

**Guidance**

Azure Firewall provides different SLAs when it's deployed in a single availability zone and when it's deployed in two or more availability zones.

**Resources**

- [Azure Well Architected Framework - Azure Firewall](https://learn.microsoft.com/azure/architecture/framework/services/networking/azure-firewall)
- [Deploy Azure Firewall across multiple availability zones](https://learn.microsoft.com/azure/firewall/deploy-availability-zone-powershell)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-1/afw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-2 - Test Azure Firewall performance

**Impact: High**

**Guidance**

Reliable firewall performance is essential to operate and protect your virtual networks in Azure. More advanced features (like those found in Azure Firewall Premium) require more processing capacity. This will affect firewall performance and impact the overall network performance. Before you deploy Azure Firewall, the performance needs to be tested and evaluated to ensure it meets your expectations. Not only should Azure Firewall handle the current traffic on a network, but it should also be ready for potential traffic growth. It's recommended to evaluate on a test network and not in a production environment. The testing should attempt to replicate the production environment as close as possible. This includes the network topology, and emulating the actual characteristics of the expected traffic through the firewall.

**Resources**

- [Azure Firewall performance](https://learn.microsoft.com/azure/firewall/firewall-performance)
- [Azure Firewall performance data](https://learn.microsoft.com/azure/firewall/firewall-performance#performance-data)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-2/afw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-3 - Monitor Azure Firewall metrics

**Impact: High**

**Guidance**

Monitor metrics related to availability and performance issues. More specifically:

- *FirewallHealth*: Indicates the overall health of the firewall.
- *Throughput*: Throughput processed by the firewall. An alert should be triggered if throughput gets close to the documented limits.
- *SNATPortUtilization*: Percentage of outbound SNAT ports currently in use. An alert should be triggered if this metric gets close to 100% (at which point Source-NATted connections, such as outbound internet connections will start to fail). If you'll need more than 512,000 SNAT ports, deploying a NAT gateway with Azure Firewall can be considered. However, deploying NAT gateway with a zone redundant firewall is not recommended deployment option, as the NAT gateway does not support zonal deployment at this time. In order to use NAT gateway with Azure Firewall, a zonal Firewall deployment is required. In addition, Azure Virtual Network NAT integration is not currently supported in secured virtual hub network architectures.

**Resources**

- [Azure Firewall metrics supported in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/metrics-supported#microsoftnetworkazurefirewalls)
- [Azure Firewall performance](https://learn.microsoft.com/azure/firewall/firewall-performance)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-3/afw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-4 - Deploy an instance of Azure Firewall per region

**Impact: High**

**Guidance**

In multi-region environments, deploy an instance of Azure Firewall per region. For workloads designed to be resistant to failures and fault tolerant, remember to consider that instances of Azure Firewall and Azure Virtual Network are regional resources.

**Resources**

- [Azure Well Architected Framework - Azure Firewall](https://learn.microsoft.com/azure/architecture/framework/services/networking/azure-firewall)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-4/afw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-5 - Configure DDoS Protection on the Azure Firewall VNet

**Impact: High**

**Guidance**

Associate a DDoS protection plan with the virtual network hosting Azure Firewall. A DDoS protection plan provides enhanced mitigation features to defend your firewall from DDoS attacks. Azure Firewall Manager is an integrated tool to create your firewall infrastructure and DDoS protection plans.

**Resources**

- [Azure DDoS Protection overview](https://learn.microsoft.com/azure/ddos-protection/ddos-protection-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-5/afw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-6 - Leverage Azure Policy inheritance model

**Impact: Medium**

**Guidance**

Azure Firewall policy allows you to define a rule hierarchy and enforce compliance. It provides a hierarchical structure to overlay a central base policy on top of a child application team policy. The base policy has a higher priority and runs before the child policy. Use an Azure custom role definition to prevent inadvertent base policy removal and provide selective access to rule collection groups within a subscription or resource group.

**Resources**

- [Azure Firewall Policy hierarchy](https://learn.microsoft.com/azure/firewall-manager/rule-hierarchy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-6/afw-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-7 - Understand impact of management operations on long running TCP sessions

**Impact: Medium**

**Guidance**

Azure Firewall is designed to be available and redundant. Every effort is made to avoid service disruptions. However, there are few scenarios where Azure Firewall can potentially drop long running TCP sessions. The following scenarios can potentially drop long running TCP sessions:

- Scale in
- Firewall maintenance
- Idle timeout
- Auto-recovery

**Resources**

- [Long running TCP sessions](https://learn.microsoft.com/azure/firewall/long-running-sessions)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-7/afw-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
