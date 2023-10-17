+++
title = "Event Hub"
description = "Best practices and resiliency recommendations for Event Hub and associated resources and settings."
date = "10/6/23"
author = "ejhenry"
msAuthor = "ejhenry"
draft = false
+++

The presented resiliency recommendations in this guidance include Event Hub and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :-----------------: |
| [EVHNS-1 - Enable zone redundancy for Event Hub namespace](#evhns-1---enable-zone-redundancy-for-event-hub-namespace) | High Availability | High | Preview  |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### EVHNS-1 - Enable zone redundancy for Event Hub namespace

**Category: Availability**

**Impact: High**

**Recommendation**

Event Hubs supports Availability Zones, providing fault-isolated locations within an Azure region. The Availability Zones support is only available in Azure regions with availability zones. Both metadata and data (events) are replicated across data centers in the availability zone.

**Resources**

- [Azure Event Hubs - Geo-disaster recovery](https://learn.microsoft.com/azure/event-hubs/event-hubs-geo-dr?tabs=portal#availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/evhns-1/evhns-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
