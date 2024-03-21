+++
title = "Private DNS Zones"
description = "Best practices and resiliency recommendations for Private DNS Zones and associated resources and settings."
date = "3/7/24"
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented resiliency recommendations in this guidance include Private DNS Zones and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Category | Impact | State | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [PVDNSZ-1 - Protect private DNS zones and records](#pvdnsz-1---protect-private-dns-zones-and-records) | Access & Security | Medium | Preview | No |
| [PVDNSZ-2 - Monitor Private DNS Zones health and set up alerts](#pvdnsz-2---monitor-private-dns-zones-health-and-set-up-alerts) | Monitoring | Low | Preview | No |
| [PVDNSZ-3 - Make sure Production and DR zones have equivalent entries for workloads and resources that will be failed over](#pvdnsz-3---make-sure-production-and-dr-zones-have-equivalent-entries-for-workloads-and-resources-that-will-be-failed-over) | Governance | Medium | Preview | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### PVDNSZ-1 - Protect private DNS zones and records

**Category: Access & Security**

**Impact: Medium**

**Guidance**

Private DNS zones and records are critical resources. Deleting a DNS zone or a single DNS record can result in a service outage. It's important that DNS zones and records are protected against unauthorized or accidental changes. The Private DNS Zone Contributor role is a built-in role for managing private DNS resources. This role applied to a user or group enables them to manage private DNS resources.

**Resources**

- [Protecting private DNS Zones and Records - Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-protect-private-zones-recordsets)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/pvdnsz-1/pvdnsz-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### PVDNSZ-2 - Monitor Private DNS Zones health and set up alerts

**Category: Monitoring**

**Impact: Low**

**Guidance**

The records contained in a private DNS zone aren't resolvable from the Internet. DNS resolution against a private DNS zone works only from virtual networks that are linked to it. You can link a private DNS zone to one or more virtual networks by creating virtual network links. You can also enable the autoregistration feature to automatically manage the life cycle of the DNS records for the virtual machines that get deployed in a virtual network.

**Resources**

- [Scenarios for Azure Private DNS zones](https://learn.microsoft.com/en-us/azure/dns/private-dns-scenarios)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/pvdnsz-2/pvdnsz-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### PVDNSZ-3 - Make sure Production and DR zones have equivalent entries for workloads and resources that will be failed over

**Category: Governance**

**Impact: Medium**

**Guidance**

Azure Private DNS provides a reliable, secure DNS service to manage and resolve domain names in a virtual network without the need to add a custom DNS solution. By using private DNS zones, you can use your own custom domain names rather than the Azure-provided names available today. The records contained in a private DNS zone aren't resolvable from the Internet. DNS resolution against a private DNS zone works only from virtual networks that are linked to it. You can link a private DNS zone to one or more virtual networks by creating virtual network links. You can also enable the autoregistration feature to automatically manage the life cycle of the DNS records for the virtual machines that get deployed in a virtual network.

**Resources**

- [Scenarios for Azure Private DNS zones](https://learn.microsoft.com/en-us/azure/dns/private-dns-scenarios)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/pvdnsz-3/pvdnsz-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
