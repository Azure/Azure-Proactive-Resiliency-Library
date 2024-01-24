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
| [AVD-2 Monitor Service Health and Resource Health of AVD](#avd-2---monitor-service-health-and-resource-health-of-avd)  | Medium |  Resiliency/Monitoring | Preview |       No        |
| [AVD-3 Deploy Session Hosts in an Availability Zone](#avd-3---deploy-session-hosts-in-an-availability-zone)  | High |  Application Delivery | Preview |       No        |
| [AVD-4 Deploy Domain Controllers in Azure Virtual Network Across Availability Zones](#avd-4---deploy-domain-controllers-in-azure-virtual-network-across-availability-zones)  | Medium |  Identity | Preview |       No        |
| [AVD-5 Implement RDP Shortpath for Public or Managed Networks](#avd-5---implement-rdp-shortpath-for-public-or-managed-networks)  | Medium |  Networking | Preview |       No        |
| [AVD-6 Implement a Multi-Region BCDR Plan](#avd-6---implement-a-multi-region-bcdr-plan)  | Medium |  Backup | Preview |       No        |
| [AVD-7 Store Golden Image Redundantly for Disaster Recovery](#avd-7---store-golden-image-redundantly-for-disaster-recovery)  | Low |  Backup | Preview |       No        |
| [AVD-8 Capacity Planning for AVD Resources](#avd-8---capacity-planning-for-avd-resources)  | Low |  Compute | Preview |       No        |
| [AVD-9 Ensure that FSLogix Storage Account is Redundant](#avd-9---ensure-that-fslogix-storage-account-is-redundant)  | High |  Reliability/Storage | Preview |       No        |

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

### AVD-2 - Monitor Service Health and Resource Health of AVD

**Category: Resiliency/Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Use Service Health to stay informed about the health of the Azure services and regions that you use to insure their availability.
Set up Service Health alerts so that you stay aware of service issues, planned maintenance, or other changes that might affect your Azure Virtual Desktop resources.
Use Resource Health to monitor your VMs and storage solutions.


**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/monitoring#resource-health)


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



### AVD-7 - Store Golden Image Redundantly for Disaster Recovery

**Category: Backup**

**Impact: Low**

**Recommendation/Guidance**

If a full BCDR strategy is not in place, consider using zone-redundant storage to store golden images across availability zones. Having the image available will allow for faster recovery in case of zonal or regional outage.

**Resources**

- [Golden Image](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/business-continuity#golden-images)
- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/application-delivery#fault-tolerance)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-7/avd-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-8 - Capacity Planning for AVD Resources

**Category: Backup**

**Impact: Low**

**Recommendation/Guidance**

Monitor and plan for subscription limits. Closely monitor your Azure Virtual Desktop deployments, and keep track of resource usage within your subscription. By proactively monitoring capacity, you can identify potential challenges early on, and you can take suitable actions to avoid reaching limits.
Consider scaling across multiple subscriptions if further scaling is required, or work with Azure support to adjust limits based on your business requirements.
To handle a large number of users, consider scaling horizontally by creating multiple host pools.


**Resources**

- [Capacity Planning](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/business-continuity#capacity-planning)
- [Learn More](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/wvd/windows-virtual-desktop#azure-virtual-desktop-limitations)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-8/avd-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-9 - Ensure that FSLogix Storage Account is Redundant

**Category: Reliability / Storage**

**Impact: High**

**Recommendation/Guidance**

It is important to ensure the redundancy of our user profiles when using FSLogix. When using FSLogix with AVD, it is deployed on a file share in a storage account. Data in an Azure Storage account is always replicated three times in the primary region. Below are the options for how your data is replicated in the primary or paired region:
LRS for least expensive replication (not recommended for apps with high availability and durability).
- LRS provides eleven 9 durability and replicates 3 time in a single physical location.
- ZRS is recommended for apps requiring high availability across zones. ZRS provides twelve 9s durability. Replicated across 3 availability zones
- GRS replicate additional 3 copies to secondary region and provides sixteen 9s availability.
- GZRS provides both high availability and redundancy across geo replication. It provides sixteen 9s durability over a given year.

Generally, it is recommended to store your data as secure and redundant as possible.


**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/storage#user-profiles)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-9/avd-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
