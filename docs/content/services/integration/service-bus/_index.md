+++
title = "Service Bus"
description = "Best practices and resiliency recommendations for Service Bus and associated resources and settings."
date = "2/13/24"
author = "DaFitRobsta"
msAuthor = "rolightn"
draft = false
+++

The presented resiliency recommendations in this guidance include Service Bus and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |                                Category                                 |     Impact      |      State       | ARG Query Available |
|:--------------------------------------------------|:-----------------------------------------------------------------------:|:---------------:|:----------------:|:-------------------:|
| [SBNS-1 - Enable Availability Zones for Service Bus namespaces](#sbns-1---enable-availability-zones-for-service-bus-namespaces) | Availability | High | Preview |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SBNS-1 - Enable Availability Zones for Service Bus namespaces

**Category: Availability**

**Impact: High**

**Guidance**

Use Service Bus with zone redundancy for production workloads. The Service Bus Premium SKU supports availability zones, providing fault-isolated locations within the same Azure region. Service Bus manages three copies of the messaging store (1 primary and 2 secondary). Service Bus keeps all three copies in sync for data and management operations. If the primary copy fails, one of the secondary copies is promoted to primary with no perceived downtime. If the applications see transient disconnects from Service Bus, the retry logic in the SDK will automatically reconnect to Service Bus.

**Resources**

- [Service Bus and reliability](https://learn.microsoft.com/en-us/azure/well-architected/services/messaging/service-bus/reliability)
- [Azure Service Bus Geo-disaster recovery](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-geo-dr#availability-zones)
- [Insulate Azure Service Bus applications against outages and disasters](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-outages-disasters)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sbns-1/sbns-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
