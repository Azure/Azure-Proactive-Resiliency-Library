+++
title = "Databases"
description = "Best Practices and Resiliency Recommendations for Database Services"
date = "2023-05-30"
author = "temalo"
msAuthor = "temalo"

draft = false
+++

The presented resiliency recommendations in this guidance include Azure Database Services

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                  | Impact  |  State  | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :----:  | :-----: | :-----------------: |
| [SQLDB-1 - Use Active Geo Replication to Create a Readable Secondary in Another Region] (#sqldb-1---Use Active Geo Replication to create a readable secondary in another region)                     | High  | Preview |         No          |
| [SQLDB-2 - Use Auto Failover Groups that can include one or multiple databases, typically used by the same application](#sqldb-2---)                                                 |  High    | Preview |         No          |
| [SQLDB-3 - Use a Zone-Redundant database](#sqldb-3---)                                                       | Medium  | Preview |         No          |
| [SQLDB-4 - Implement Retry Logic](#sqldb-4---)                                                                             |  High   | Preview |         No          |
| [SQLDB-5 - Monitor your Azure SQL Database in near-real time to detect reliability incidents](#sqldb-5---)                                                                               |  High   | Preview |         No          |
| [SQLDB-6 - Back up your keys](#sqldb-6---)                                                   |  Medium    | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SQLDB-1 - Use Active Geo Replication to Create a Readable Secondary in Another Region

#### Impact: High

#### Recommendation/Guidance
If your primary database fails, perform a manual failover to the secondary database. Until you fail over, the secondary database remains read-only. Active geo-replication enables you to create readable replicas and manually failover to any replica if there is a datacenter outage or application upgrade. Up to four secondaries are supported in the same or different regions, and the secondaries can also be used for read-only access queries. The failover must be initiated manually by the application or the user. After failover, the new primary has a different connection end point.

#### Resources
- [Active Geo Replication] (https://learn.microsoft.com/en-us/azure/azure-sql/database/active-geo-replication-overview)

### SQLDB-2 - Use Auto Failover Groups that can include one or multiple databases, typically used by the same application

#### Impact: High

#### Recommendation/Guidance
You can use the readable secondary databases to offload read-only query workloads. Because autofailover groups involve multiple databases, these databases must be configured on the primary server. Autofailover groups support replication of all databases in the group to only one secondary server or instance in a different region.

#### Resources
- [AutoFailover Groups](https://learn.microsoft.com/en-us/azure/azure-sql/database/auto-failover-group-overview?tabs=azure-powershell)
- [DR Design](https://learn.microsoft.com/en-us/azure/azure-sql/database/designing-cloud-solutions-for-disaster-recovery)

### SQLDB-3 - Use a Zone-Redundant Database

#### Impact: Medium

#### Recommendation/Guidance
By default, the cluster of nodes for the premium availability model is created in the same datacenter. With the introduction of Azure Availability Zones, SQL Database can place different replicas of the Business Critical database to different availability zones in the same region. To eliminate a single point of failure, the control ring is also duplicated across multiple zones as three gateway rings (GW). The routing to a specific gateway ring is controlled by Azure Traffic Manager (ATM). Because the zone redundant configuration in the Premium or Business Critical service tiers doesn't create extra database redundancy, you can enable it at no extra cost.

#### Resources
- [Azure Traffic Manager] (https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview)
-[Zone Redundant Databases] (https://learn.microsoft.com/en-us/azure/azure-sql/database/high-availability-sla)

