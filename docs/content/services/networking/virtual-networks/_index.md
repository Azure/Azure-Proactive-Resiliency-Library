+++
title = "Virtual Networks"
description = "Best practices and resiliency recommendations for Virtual Networks and associated resources."
date = "4/4/23"
author = "CHANGE ME TO YOUR GITHUB USERNAME"
msAuthor = "maheshbenke"
draft = false
+++

The presented resiliency recommendations in this guidance include Virtual Networks and associated Virtual Networks settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Virtual Networks and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                                          |     Category      | Impact |  State  | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [VNET-1 - All Subnets should have a Network Security Group associated](#vnet-1---all-subnets-should-have-a-network-security-group-associated)                                                                                                           | Access & Security |  High  | Preview |         Yes         |
| [VNET-2 - Use Azure DDoS Standard Protection Plans to protect all public endpoints hosted within customer Virtual Networks](#vnet-2---use-azure-ddos-standard-protection-plans-to-protect-all-public-endpoints-hosted-within-customer-virtual-networks) | Access & Security |  High  | Preview |         Yes         |
| [VNET-3 - Use Private Link, when available, for shared Azure PaaS services](#vnet-3---when-available-use-private-endpoints-instead-of-service-endpoints-for-paas-services)                                                                              | Access & Security | Medium | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VNET-1 - All Subnets should have a Network Security Group associated

**Category: Access & Security**

**Impact: High**

**Guidance**

Network security groups: Network security groups and application security groups can contain multiple inbound and outbound security rules that enable you to filter traffic to and from resources by source and destination IP address, port, and protocol. NSG's provide a security layer on Subnet level. Note that the following subnets are excluded(ignored) because applying NSG on these subnets is not supported: GatewaySubnet, AzureFirewallSubnet, AzureFirewallManagementSubnet, RouteServerSubnet.

**Resources**

- [Azure Virtual Network - Concepts and best practices | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/concepts-and-best-practices)
- [GatewaySUbnet](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsub)
- [Can I associate a network security group (NSG) to the RouteServerSubnet?](https://learn.microsoft.com/en-us/azure/route-server/route-server-faq#can-i-associate-a-network-security-group-nsg-to-the-routeserversubnet)
- [Are Network Security Groups (NSGs) supported on the AzureFirewallSubnet?](https://learn.microsoft.com/en-us/azure/firewall/firewall-faq#are-network-security-groups--nsgs--supported-on-the-azurefirewallsubnet)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vnet-1/vnet-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VNET-2 - Use Azure DDoS Standard Protection Plans to protect all public endpoints hosted within customer Virtual Networks

**Category: Access & Security**

**Impact: High**

**Guidance**

Azure DDoS Protection, combined with application design best practices, provides enhanced DDoS mitigation features to defend against DDoS attacks. It's automatically tuned to help protect your specific Azure resources in a virtual network.

**Resources**

- [Reliability and Azure Virtual Network - Microsoft Azure Well-Architected Framework | Microsoft Learn](https://learn.microsoft.com/azure/architecture/framework/services/networking/azure-virtual-network/reliability)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vnet-2/vnet-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VNET-3 - When available, use Private Endpoints instead of Service Endpoints for PaaS Services

**Category: Access & Security**

**Impact: Medium**

**Guidance**

Use virtual network service endpoints only when Private Link isn't available and there are no concerns with unauthorized movement of data. The VNet service endpoint feature (turning on VNet service endpoint on the network side and setting up appropriate VNet ACLs on the Azure service side) limits the Azure service access to the allowed VNet and subnet, thus providing a network level security and isolation of the Azure service traffic. All traffic using VNet service endpoints flows over Microsoft backbone, thus providing another layer of isolation from the public internet

**Resources**

- [Azure Virtual Network FAQ | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/virtual-networks-faq)
- [Reliability and Network connectivity - Microsoft Azure Well-Architected Framework | Microsoft LearnNetworking Reliability](https://learn.microsoft.com/azure/architecture/framework/services/networking/network-connectivity/reliability)
- [Azure Private Link availability](https://learn.microsoft.com/en-us/azure/private-link/availability)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vnet-3/vnet-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
