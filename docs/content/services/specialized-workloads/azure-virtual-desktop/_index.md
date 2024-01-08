+++
title = "Azure Virtual Desktop"
description = "Best practices and resiliency recommendations for Azure Virtual Desktop and associated resources and settings."
date = "12/7/23"
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

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AVD-1 - Use Private link when connecting to File Share or Key Vault

**Category: Access & Security/Networking and Connectivity**

**Impact: Medium**

**Recommendation/Guidance**

Configuration options  to validate access Azure PaaS Services (for example, Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a private endpoint in your virtual network.

For a resilient AVD environment that ensures secure access to the services through the Private Link platform which will handle the connectivity between the consumer and services over the Azure backbone network.


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
