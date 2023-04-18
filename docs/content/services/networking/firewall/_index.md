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

The below table shows the list of resiliency recommendations for Firewall and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                    |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [FW-1 - Deploy Azure Firewall across multiple availability zones](#fw-1---deploy-azure-firewall-across-multiple-availability-zones)                                                         | Preview  |         Yes          |
| [FW-2 - Test Azure Firewall performance](#fw-2---test-azure-wirewall-performance)                                                                                  | Preview  |         No           |
| [FW-3 - Monitor Azure Firewall metrics](#fw-3---monitor-azure-firewall-metrics)                                                                                   | Preview  |         Yes          |
| [FW-4 - Deploy an instance of Azure Firewall per region](#fw-4---deploy-an-instance-of-azure-firewall-per-region)                                                                  | Preview  |         No           |
| [FW-5 - Configure DDoS Protection on the Azure Firewall VNet](#fw-5---configure-ddos-protection-on-the-azure-firewall-vnet)                                                             | Preview  |         Yes          |
| [FW-6 - Leverage Azure Policy inheritance model](#fw-6---leverage-azure-policy-inheritance-model)                                                                          | Preview  |         No           |
| [FW-7 - Understand impact of management operations on long running TCP sessions](#fw-7---understand-impact-of-management-operations-on-long-running-tcp-sessions)                                          | Preview  |         No           |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### FW-1 - Deploy Azure Firewall across multiple availability zones

#### Importance: Critical

#### Recommendation/Guidance

Azure Firewall provides different SLAs when it's deployed in a single availability zone and when it's deployed in two or more availability zones. For information about all Azure SLAs, see [SLA summary for Azure services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services?lang=1).

##### Resources

- [Azure Well Architected Framework - Azure Firewall](https://learn.microsoft.com/azure/architecture/framework/services/networking/azure-firewall)
- [Deploy Azure Firewall across multiple availability zones](https://learn.microsoft.com/en-us/azure/firewall/deploy-availability-zone-powershell)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/fw-1/fw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FW-2 - Test Azure Firewall performance

#### Importance: High

#### Recommendation/Guidance

Reliable firewall performance is essential to operate and protect your virtual networks in Azure. More advanced features (like those found in Azure Firewall Premium) require more processing capacity. This will affect firewall performance and impact the overall network performance. Before you deploy Azure Firewall, the performance needs to be tested and evaluated to ensure it meets your expectations. Not only should Azure Firewall handle the current traffic on a network, but it should also be ready for potential traffic growth. It's recommended to evaluate on a test network and not in a production environment. The testing should attempt to replicate the production environment as close as possible. This includes the network topology, and emulating the actual characteristics of the expected traffic through the firewall.

##### Resources

- [Azure Firewall performance](https://learn.microsoft.com/azure/firewall/firewall-performance)
- [Azure Firewall performance data](https://learn.microsoft.com/en-us/azure/firewall/firewall-performance#performance-data)

<br><br>

### FW-3 - Monitor Azure Firewall metrics

#### Importance: High

#### Recommendation/Guidance

Monitor metrics related to availability and performance issues. More specifically:
- *FirewallHealth*: Indicates the overall health of the firewall.
- *Throughput*: Throughput processed by the firewall. An alert should be triggered if throughput gets close to the documented limits.
- *SNATPortUtilization*: Percentage of outbound SNAT ports currently in use. An alert should be triggered if this metric gets close to 100% (at which point Source-NATted connections, such as outbound internet connections will start to fail).


##### Resources

- [Azure Firewall metrics supported in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/metrics-supported#microsoftnetworkazurefirewalls)
- [Azure Firewall performance](https://learn.microsoft.com/azure/firewall/firewall-performance)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/fw-3/fw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FW-4 - Deploy an instance of Azure Firewall per region

#### Importance: High

#### Recommendation/Guidance

In multi-region environments, deploy an instance of Azure Firewall per region. For workloads designed to be resistant to failures and fault tolerant, remember to consider that instances of Azure Firewall and Azure Virtual Network are regional resources.

##### Resources

- [Azure Well Architected Framework - Azure Firewall](https://learn.microsoft.com/azure/architecture/framework/services/networking/azure-firewall)

<br><br>

### FW-5 - Configure DDoS Protection on the Azure Firewall VNet

#### Importance: High

#### Recommendation/Guidance

Associate a DDoS protection plan with the virtual network hosting Azure Firewall. A DDoS protection plan provides enhanced mitigation features to defend your firewall from DDoS attacks. Azure Firewall Manager is an integrated tool to create your firewall infrastructure and DDoS protection plans. For more information, see [Configure an Azure DDoS Protection Plan using Azure Firewall Manager](https://learn.microsoft.com/en-us/azure/firewall-manager/configure-ddos).

##### Resources

- [Azure DDoS Protection overview](https://learn.microsoft.com/azure/ddos-protection/ddos-protection-overview)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/fw-5/fw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FW-6 - Leverage Azure Policy inheritance model

#### Importance: Medium

#### Recommendation/Guidance

Azure Firewall policy allows you to define a rule hierarchy and enforce compliance. It provides a hierarchical structure to overlay a central base policy on top of a child application team policy. The base policy has a higher priority and runs before the child policy. Use an Azure custom role definition to prevent inadvertent base policy removal and provide selective access to rule collection groups within a subscription or resource group.

##### Resources

- [Azure Firewall Policy hierarchy](https://learn.microsoft.com/azure/firewall-manager/rule-hierarchy)

<br><br>

### FW-7 - Understand impact of management operations on long running TCP sessions

#### Importance: Medium

#### Recommendation/Guidance

Azure Firewall is designed to be available and redundant. Every effort is made to avoid service disruptions. However, there are few scenarios where Azure Firewall can potentially drop long running TCP sessions. The following scenarios can potentially drop long running TCP sessions:
- Scale in
- Firewall maintenance
- Idle timeout
- Auto-recovery

##### Resources

- [Long running TCP sessions](https://learn.microsoft.com/azure/firewall/long-running-sessions)

<br><br>
