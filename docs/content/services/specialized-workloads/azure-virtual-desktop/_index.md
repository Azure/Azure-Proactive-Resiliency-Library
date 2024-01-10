+++
title = "Azure Virtual Desktop"
description = "Best practices and resiliency recommendations for Azure Virtual Desktop and associated resources and settings."
date = "1/9/24"
author = "yshafner"
msAuthor = "yonahshafner"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Virtual Desktop and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  Recommendation                                   |      Impact         |  Design Area         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :------:          |
| [AVD-1 Use Private link when connecting to File Share or Key Vault](#avd-1---use-private-link-when-connecting-to-file-share-or-key-vault)    | Medium | Networking and Connectivity |  Preview  |        Yes         |
| [AVD-2 Deploy Host Pools in an Availability Zone](#avd-2---deploy-host-pools-in-an-availability-zone)  | Medium|  Application Delivery | Preview |       No        |
| [AVD-3 Deploy Session Hosts in an Availability Zone](#avd-3---deploy-session-hosts-in-an-availability-zone)  | High |  Application Delivery | Preview |       No        |
| [AVD-4 Deploy Domain Controllers in Azure Virtual Network Across Availability Zones](#avd-4---deploy-domain-controllers-in-azure-virtual-network-across-availability-zones)  | Medium |  Identity | Preview |       No        |
| [AVD-5 Implement RDP Shortpath for Public or Managed Networks](#avd-5---implement-rdp-shortpath-for-public-or-managed-networks)  | Medium |  Networking | Preview |       No        |
| [AVD-6 Implement a Multi-Region BCDR Plan](#avd-6---implement-a-multi-region-bcdr-plan)  | Medium |  Backup | Preview |       No        |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AVD-1 - Use Private link when connecting to File Share or Key Vault

**Category: Access & Security/Networking and Connectivity**

**Impact: Medium**

**Recommendation/Guidance**

Private Link is available for other Azure services that work in conjunction with Azure Virtual Desktop, such as Azure Files and Key Vault. From a resiliency standpoint, we recommending implementing private endpoints for these services to reduce exposure to potential internet-related issues such as latency, packet loss, and/or downtime. This can lead to more reliable communication between AVD and dependent services.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/networking#private-endpoints-private-link)
- [Private link](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/networking#private-endpoints-private-link)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-1/avd-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-2 - Deploy Host Pools in an Availability Zone

**Category: Application Resilience/Availability**

**Impact: High**
**Recommendation/Guidance**

Distributing session hosts across all zones increases the resiliency of your overall Azure Virtual Desktop service to your end customer. If you have distributed your session hosts across three zones and one zone becomes unavailable, only one third of your user estate is impacted.

Increase application resiliency and availability for virtual machines. Maintain synchronous replication, withstand datacenter failures, and ensure customer impact is minimal to none.

**Resources**

- [Learn More](https://techcommunity.microsoft.com/t5/azure-virtual-desktop-blog/announcing-general-availability-of-support-for-azure/ba-p/3636262#:~:text=By%20distributing%20your%20session%20hosts%20across%20all%20zones,one%20third%20of%20your%20user%20estate%20is%20impacted.)
- [Availability Zones](https://learn.microsoft.com/en-us/azure/well-architected/reliability/regions-availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-2/avd-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-3 - Deploy Session Hosts in an Availability Zone

**Category: Application Resilience/Availability**

**Impact: High**

**Recommendation/Guidance**

Deploy session hosts in an availability zone or an availability set helps protect the environment from outages.

Enhances reliability by minimizing latency and impacts reliability helping keep the data synchronized and protecting from outages. If one zone experiences an outage, then regional services, capacity, and high availability are supported by the remaining zones.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/application-delivery#session-host-settings)
- [Availability Zones](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/application-delivery#session-host-settings)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-3/avd-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-4 - Deploy Domain Controllers in Azure Virtual Network Across Availability Zones

**Category: Availability/Identity**

**Impact: Medium**

**Recommendation/Guidance**

When using an AD DS identity solution with AVD, it is recommended to deploy domain controllers on azure virtual machines across availability zones. This improves the reliability of the environment by being independent of an on premises connection as well as creates a shorter path for user’s authentication improving performance.

This recommendation is not relevant when you are utilizing Microsoft Entra as the identity provider.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/identity/adds-extend-domain#reliability)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-4/avd-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-5 - Implement RDP Shortpath for Public or Managed Networks

**Category: Networking**

**Impact: Medium**

**Recommendation/Guidance**

It is recommended to enable RDP Shortpath for AVD. RDP Shortpath is a feature of Azure Virtual Desktop that establishes a direct UDP-based transport between a supported Windows Remote Desktop client and session host. By default, Remote Desktop Protocol (RDP) tries to establish connection using UDP and uses a TCP-based reverse connect transport as a fallback connection mechanism. TCP-based reverse connect transport provides the best compatibility with various networking configurations and has a high success rate for establishing RDP connections. UDP-based transport offers better connection reliability and more consistent latency.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/rdp-shortpath?tabs=managed-networks)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-5/avd-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-6 - Implement a Multi-Region BCDR Plan

**Category: Backup**

**Impact: Medium**

**Recommendation/Guidance**

It is recommended to adopt a multi-region deployment (active-active) for AVD. Each region should contain at least identity, name resolution, AVD management resources, and session hosts in case of a primary region outage.

**Resources**

- [Multi-region BCDR](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/wvd/azure-virtual-desktop-multi-region-bcdr)
- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/business-continuity#active-active-scenarios)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-6/avd-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
