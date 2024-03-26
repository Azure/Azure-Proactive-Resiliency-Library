+++
title = "SQL DB"
description = "Best Practices and Resiliency Recommendations for Azure SQL Database"
date = "2023-05-30"
author = "temalo"
msAuthor = "temalo"

draft = false
+++

The presented resiliency recommendations in this guidance include Azure Database Services

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                                 |        Category        | Impact |  State  | ARG Query Available |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------:|:------:|:-------:|:-------------------:|
| [SQLDB-1 - Use Active Geo Replication to Create a Readable Secondary in Another Region](#sqldb-1---use-active-geo-replication-to-create-a-readable-secondary-in-another-region)                                                                |   Disaster Recovery    |  High  | Preview |         Yes         |
| [SQLDB-2 - Use Auto Failover Groups that can include one or multiple databases, typically used by the same application](#sqldb-2---use-auto-failover-groups-that-can-include-one-or-multiple-databases-typically-used-by-the-same-application) |   Disaster Recovery    |  High  | Preview |         Yes         |
| [SQLDB-3 - Use a Zone-Redundant database](#sqldb-3---use-a-zone-redundant-database)                                                                                                                                                            |      Availability      | Medium | Preview |         Yes         |
| [SQLDB-4 - Implement Retry Logic](#sqldb-4---implement-retry-logic)                                                                                                                                                                            | Application Resilience |  High  | Preview |         Yes         |
| [SQLDB-5 - Monitor your Azure SQL Database in near-real time to detect reliability incidents](#sqldb-5---monitor-your-azure-sql-database-in-near-real-time-to-detect-reliability-incidents)                                                    |       Monitoring       |  High  | Preview |         Yes         |
| [SQLDB-6 - Back up your keys](#sqldb-6---back-up-your-keys)                                                                                                                                                                                    |   Disaster Recovery    | Medium | Preview |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SQLDB-1 - Use Active Geo Replication to Create a Readable Secondary in Another Region

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

If your primary database fails, perform a manual failover to the secondary database. Until you fail over, the secondary database remains read-only. Active geo-replication enables you to create readable replicas and manually failover to any replica if there is a datacenter outage or application upgrade. Up to four secondaries are supported in the same or different regions, and the secondaries can also be used for read-only access queries. The failover must be initiated manually by the application or the user. After failover, the new primary has a different connection end point.

**Resources**

- [Active Geo Replication](https://learn.microsoft.com/en-us/azure/azure-sql/database/active-geo-replication-overview)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sqldb-1/sqldb-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SQLDB-2 - Use Auto Failover Groups that can include one or multiple databases, typically used by the same application

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

You can use the readable secondary databases to offload read-only query workloads. Because autofailover groups involve multiple databases, these databases must be configured on the primary server. Autofailover groups support replication of all databases in the group to only one secondary server or instance in a different region.

**Resources**

- [AutoFailover Groups](https://learn.microsoft.com/en-us/azure/azure-sql/database/auto-failover-group-overview?tabs=azure-powershell)
- [DR Design](https://learn.microsoft.com/en-us/azure/azure-sql/database/designing-cloud-solutions-for-disaster-recovery)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sqldb-2/sqldb-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SQLDB-3 - Use a Zone-Redundant Database

**Category: Availability**

**Impact: Medium**

**Guidance**

By default, the cluster of nodes for the premium availability model is created in the same datacenter. With the introduction of Azure Availability Zones, SQL Database can place different replicas of the Business Critical database to different availability zones in the same region. To eliminate a single point of failure, the control ring is also duplicated across multiple zones as three gateway rings (GW). The routing to a specific gateway ring is controlled by Azure Traffic Manager (ATM). Because the zone redundant configuration in the Premium or Business Critical service tiers doesn't create extra database redundancy, you can enable it at no extra cost.

**Resources**

-[Zone Redundant Databases](https://learn.microsoft.com/en-us/azure/azure-sql/database/high-availability-sla)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sqldb-3/sqldb-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SQLDB-4 - Implement Retry Logic

**Category: Application Resilience**

**Impact: High**

**Guidance**

Although Azure SQL Database is resilient when it concerns transitive infrastructure failures, these failures might affect your connectivity. When a transient error occurs while working with SQL Database, make sure your code can retry the call.

**Resources**

- [How to Implement Retry Logic](https://learn.microsoft.com/en-us/azure/azure-sql/database/troubleshoot-common-connectivity-issues)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sqldb-4/sqldb-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SQLDB-5 - Monitor your Azure SQL Database in Near Real-Time to Detect Reliability Incidents

**Category: Monitoring**

**Impact: High**

**Guidance**

Use one of the available solutions to monitor SQL DB to detect potential reliability incidents early and make your databases more reliable. Choose a near real-time monitoring solution to quickly react to incidents.

**Resources**

- [Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/insights/azure-sql#analyze-data-and-create-alerts)
- [Azure SQL Database Monitoring](https://learn.microsoft.com/en-us/azure/azure-sql/database/monitoring-sql-database-azure-monitor)
- [Monitoring SQL Database Reference](https://learn.microsoft.com/en-us/azure/azure-sql/database/monitoring-sql-database-azure-monitor-reference)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sqldb-5/sqldb-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SQLDB-6 - Back Up Your Keys

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

It is highly recommended to use Azure Key Vault (AKV) to store encryption keys related to Always Encrypted configurations, however it is not required. If you are not using AKV, then ensure that your keys are properly backed up.

**Resources**

- [Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview)
- [Getting Started with Always Encrypted](https://learn.microsoft.com/en-us/azure/azure-sql/database/always-encrypted-landing?view=azuresql)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sqldb-6/sqldb-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
