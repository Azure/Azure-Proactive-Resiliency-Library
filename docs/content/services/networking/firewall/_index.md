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
| Recommendation                                                                                                                        |     Category      | Impact |  State  | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [AFW-1 - Deploy Azure Firewall across multiple availability zones](#afw-1---deploy-azure-firewall-across-multiple-availability-zones) |   Availability    |  High  | Preview |         No          |
| [AFW-2 - Monitor Azure Firewall metrics](#afw-2---monitor-azure-firewall-metrics)                                                     |    Monitoring     | Medium | Preview |         No          |
| [AFW-3 - Configure DDoS Protection on the Azure Firewall VNet](#afw-3---configure-ddos-protection-on-the-azure-firewall-vnet)         | Access & Security |  High  | Preview |         No          |
| [AFW-4 - Leverage Azure Policy inheritance model](#afw-4---leverage-azure-policy-inheritance-model)                                   |    Governance     | Medium | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AFW-1 - Deploy Azure Firewall across multiple availability zones

**Category: Availability**

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

### AFW-2 - Monitor Azure Firewall metrics

**Category: Monitoring**

**Impact: Medium**

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

{{< code lang="sql" file="code/afw-2/afw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-3 - Configure DDoS Protection on the Azure Firewall VNet

**Category: Access & Security**

**Impact: High**

**Guidance**

Associate a DDoS protection plan with the virtual network hosting Azure Firewall. A DDoS protection plan provides enhanced mitigation features to defend your firewall from DDoS attacks. Azure Firewall Manager is an integrated tool to create your firewall infrastructure and DDoS protection plans.

**Resources**

- [Azure DDoS Protection overview](https://learn.microsoft.com/azure/ddos-protection/ddos-protection-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-3/afw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFW-4 - Leverage Azure Policy inheritance model

**Category: Governance**

**Impact: Medium**

**Guidance**

Azure Firewall policy allows you to define a rule hierarchy and enforce compliance. It provides a hierarchical structure to overlay a central base policy on top of a child application team policy. The base policy has a higher priority and runs before the child policy. Use an Azure custom role definition to prevent inadvertent base policy removal and provide selective access to rule collection groups within a subscription or resource group.

**Resources**

- [Azure Firewall Policy hierarchy](https://learn.microsoft.com/azure/firewall-manager/rule-hierarchy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afw-4/afw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
