+++
title = "Redis Cache"
description = "Best practices and resiliency recommendations for Redis Cache and associated resources and settings."
date = "10/2/23"
author = "ejhenry"
msAuthor = "ejhenry"
draft = false
+++

The presented resiliency recommendations in this guidance include Redis Cache and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :-----------------: |
| [REDIS-1 - Enable zone redundancy for Azure Cache for Redis](#redis-1---enable-zone-redundancy-for-azure-cache-for-redis) | High Availability | High | Preview  |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### REDIS-1 - Enable zone redundancy for Azure Cache for Redis

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Azure Cache for Redis supports zone redundancy in its Premium and Enterprise tiers. A zone-redundant cache runs on VMs spread across multiple Availability Zones. Zone redundancy provides higher resilience and availability.

**Resources**

- [Enable zone redundancy for Azure Cache for Redis](https://learn.microsoft.com/azure/azure-cache-for-redis/cache-how-to-zone-redundancy)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/redis-1/redis-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
