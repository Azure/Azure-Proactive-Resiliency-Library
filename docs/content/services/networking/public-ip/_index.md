+++
title = "Public Ip"
description = "Best practices and resiliency recommendations for Public Ip and associated resources."
date = "4/12/23"
author = "lachaves"
msAuthor = "luchaves"
draft = false
+++

The presented resiliency recommendations in this guidance include Public Ip and associated Public Ip settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Public Ip and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                    |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [PIP-1 - Use Standard SKU](#pip-1---use-standard-sku) | Preview  |         No         |
| [PIP-2 - Use NAT gateway for outbound connectivity to avoid SNAT Exhaustion](#pip-2---use-nat-gateway-for-outbound-connectivity-to-avoid-snat-exhaustion) | Preview |         Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### PIP-1 - Use Standard SKU

**Impact: High**

**Guidance**

Public IP addresses with a standard SKU can be created as non-zonal, zonal, or zone-redundant in regions that support availability zones.
A zone-redundant IP is created in all zones for a region and can survive any single zone failure. A zonal IP is tied to a specific availability zone, and shares fate with the health of the zone. A "non-zonal" public IP addresses are placed into a zone for you by Azure and doesn't give a guarantee of redundancy.
In regions without availability zones, all public IP addresses are created as non-zonal. Public IP addresses created in a region that is later upgraded to have availability zones remain non-zonal. A public IP's availability zone can't be changed after the public IP's creation.
Note - All basic SKU public IP addresses are created as non-zonal. Any IP that is upgraded from a basic SKU to standard SKU remains non-zonal.

**Resources**

- [Public IP addresses - Availability Zones](https://learn.microsoft.com/azure/virtual-network/ip-services/public-ip-addresses#availability-zone)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/pip-1/pip-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### PIP-2 - Use NAT gateway for outbound connectivity to avoid SNAT Exhaustion

**Impact: Medium**

**Guidance**

Prevent risk of connectivity failures due to SNAT port exhaustion by using NAT gateway for outbound traffic from your virtual networks. NAT gateway scales dynamically and provides secure connections for traffic headed to the internet. We don't recommend exceeding 100 simultaneous outbound connections to a public IP address per worker. Avoid communicating with downstream services through public IP addresses when a private address (Private Endpoint) or Service Endpoint through vNet Integration could be used.

**Resources**

- [Use NAT GW for outbound connectivity](https://learn.microsoft.com/azure/advisor/advisor-reference-reliability-recommendations#use-nat-gateway-for-outbound-connectivity)
- [TCP and SNAT Ports](https://learn.microsoft.com/azure/architecture/framework/services/compute/azure-app-service/reliability#tcp-and-snat-ports)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/pip-2/pip-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
