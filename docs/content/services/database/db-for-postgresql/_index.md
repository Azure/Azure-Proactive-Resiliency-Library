+++
title = "DB for PostgreSQL"
description = "Best practices and resiliency recommendations for Database for PostgreSQL and associated resources and settings."
date = "10/11/23"
author = "ejhenry"
msAuthor = "ejhenry"
draft = false
+++

The presented resiliency recommendations in this guidance include Database for PostgreSQL and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :-----------------: |
| [PSQL-1 - Enable HA with zone redundancy](#psql-1---enable-ha-with-zone-redundancy) | Availability | High | Verified  |         Yes         |
| [PSQL-2 - Enable custom maintenance schedule](#psql-1---enable-ha-with-zone-redundancy) | System Efficiency | High | Verified  |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### PSQL-1 - Enable HA with zone redundancy

**Category: Availability**

**Impact: High**

**Recommendation**

Enable HA with zone redundancy on flexible server instances. Zone redundant high availability deploys a standby replica in a different zone with automatic failover capability.

**Resources**

- [Overview of high availability with Azure Database for PostgreSQL](https://learn.microsoft.com/azure/postgresql/flexible-server/concepts-high-availability)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/psql-1/psql-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### PSQL-2 - Enable custom maintenance schedule

**Category: System Efficiency**

**Impact: High**

**Recommendation**

Use custom maintenance schedule on flexible server instances to select a preferred time for service updates to be applied.

**Resources**

- [Scheduled maintenance in Azure Database for PostgreSQL - Flexible Server](https://learn.microsoft.com/azure/postgresql/flexible-server/concepts-maintenance)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/psql-2/psql-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
