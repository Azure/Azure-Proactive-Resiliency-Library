+++
title = "General Networking"
description = "Best practices and resiliency recommendations for General Networking and associated resources and settings."
date = "6/29/23"
author = "maheshbenke"
msAuthor = "maheshbenke"
draft = false
+++

The presented resiliency recommendations in this guidance include General Networking and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State   | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------: | :-----------------: |
| [GNW-1 - Use ExpressRoute as the primary connectivity channel for connecting an on-premises network to Azure](#gnw-1---use-expressroute-as-the-primary-connectivity-channel-for-connecting-an-on-premises-network-to-azure) | Networking | High | Preview  |         No         |
| [GNW-2 - Simulate a failure path to ensure that connectivity is available over alternative paths](#gnw-2---simulate-a-failure-path-to-ensure-that-connectivity-is-available-over-alternative-paths) | Networking | High | Preview |         No          |
| [GNW-3 - Use a global load balancer to distribute traffic and failover across regions](#gnw-3---use-a-global-load-balancer-to-distribute-traffic-and-failover-across-regions) | Networking | Medium | Preview  |         No         |
| [GNW-4 - Eliminate all single points of failure from the data path both on-premises and hosted on Azure](#gnw-4---eliminate-all-single-points-of-failure-from-the-data-path-both-on-premises-and-hosted-on-azure) | Networking | Medium | Preview  |         No         |
| [GNW-5 - Assess critical application dependencies with health probes](#gnw-5---assess-critical-application-dependencies-with-health-probes) | Networking | Medium | Preview  |         No         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### GNW-1 - Use ExpressRoute as the primary connectivity channel for connecting an on-premises network to Azure

**Category: Networking**

**Impact: High**

**Guidance**

Use ExpressRoute as the primary connectivity channel for connecting an on-premises network to Azure. You can use VPNs as a source of backup connectivity to enhance connectivity resiliency.
For cross-premises connectivity, by using Azure ExpressRoute or VPN, ensure that there are redundant connections from different locations.
At least two redundant connections should be established across two or more Azure regions and peering locations to ensure there are no single points of failure. An active/active load-shared configuration provides path diversity and promotes availability of network connection paths.

**Resources**

- [Connectivity to Azure - Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/connectivity-to-azure)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gnw-1/gnw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### GNW-2 - Simulate a failure path to ensure that connectivity is available over alternative paths

**Category: Networking**

**Impact: High**

**Guidance**

The failure of a connection path onto other connection paths should be tested to validate connectivity and operational effectiveness. Using site-to-site VPN connectivity as a backup path for ExpressRoute provides an extra layer of network resiliency for cross-premises connectivity.

**Resources**

- [Design requirements connectivity](https://learn.microsoft.com/en-us/azure/well-architected/resiliency/design-requirements#connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gnw-2/gnw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### GNW-3 - Use a global load balancer to distribute traffic and failover across regions

**Category: Networking**

**Impact: Medium**

**Guidance**

Azure Front Door, Azure Traffic Manager, or third-party content delivery network services can be used to direct inbound requests to external-facing application endpoints deployed across multiple regions. Traffic Manager is a DNS-based load balancer, so failover must wait for DNS propagation to occur. A sufficiently low time-to-live (TTL) value should be used for DNS records, though not all ISPs honor this setting. For application scenarios that require transparent failover, Azure Front Door should be used.

**Resources**

- [Design requirements connectivity](https://learn.microsoft.com/en-us/azure/well-architected/resiliency/design-requirements#connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gnw-3/gnw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### GNW-4 - Eliminate all single points of failure from the data path both on-premises and hosted on Azure

**Category: Networking**

**Impact: High**

**Guidance**

Single-instance Network Virtual Appliances (NVAs) introduce significant connectivity risk, whether deployed in Azure or within an on-premises datacenter.

**Resources**

- [Design requirements connectivity](https://learn.microsoft.com/en-us/azure/well-architected/resiliency/design-requirements#connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gnw-4/gnw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### GNW-5 - Assess critical application dependencies with health probes

**Category: Networking**

**Impact: Medium**

**Guidance**

Custom health probes should be used to assess overall application health including downstream components and dependent services, such as APIs and datastores. In this approach, traffic isn't sent to backend instances that can't successfully process requests due to dependency failures.

**Resources**

- [Design requirements connectivity](https://learn.microsoft.com/en-us/azure/well-architected/resiliency/design-requirements#connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/gnw-5/gnw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
