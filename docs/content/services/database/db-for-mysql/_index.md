+++
title = "DB for MySQL"
description = "Best practices and resiliency recommendations for Db for Mysql and associated resources and settings."
date = "2/26/24"
author = "ejhenry"
msAuthor = "erhenry"
draft = false
+++

The presented resiliency recommendations in this guidance include DB for MySQL and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |                                Category                                 |     Impact      |      State       | ARG Query Available |
|:--------------------------------------------------|:-----------------------------------------------------------------------:|:---------------:|:----------------:|:-------------------:|
| [MYSQL-1 - Enable HA with zone redundancy](#mysql-1---enable-ha-with-zone-redundancy) | Availability | High | Verified |         Yes         |
| [MYSQL-2 - Enable custom maintenance schedule](#mysql-2---enable-custom-maintenance-schedule) |     System Efficiency      | High | Verified |         Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### MYSQL-1 - Enable HA with zone redundancy

**Category: Availability**

**Impact: High**

**Guidance**

Enable HA with zone redundancy on flexible server instances. Zone redundant high availability deploys a standby replica in a different zone with automatic failover capability.

**Resources**

- [High availability concepts in Azure Database for MySQL - Flexible Server](https://learn.microsoft.com/azure/mysql/flexible-server/concepts-high-availability)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/mysql-1/mysql-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### MYSQL-2 - Enable custom maintenance schedule

**Category: System Efficiency**

**Impact: High**

**Guidance**

Use custom maintenance schedule on flexible server instances to select a preferred time for service updates to be applied.

**Resources**

- [Scheduled maintenance in Azure Database for MySQL - Flexible Server](https://learn.microsoft.com/azure/mysql/flexible-server/concepts-maintenance)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/mysql-2/mysql-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
