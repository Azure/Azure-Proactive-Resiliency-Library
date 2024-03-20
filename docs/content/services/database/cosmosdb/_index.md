+++
title = "Cosmos DB"
description = "Best practices and resiliency recommendations for Cosmos DB and associated resources and settings."
date = "6/30/23"
author = "kovarikthomas"
msAuthor = "tokovari"
draft = false
+++

The presented resiliency recommendations in this guidance include Cosmos DB and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                  |        Category        | Impact |  State  | ARG Query Available |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------:|:------:|:-------:|:-------------------:|
| [COSMOS-1 – Configure at least two regions for high availability](#cosmos-1---configure-at-least-two-regions-for-high-availability)                                                             |      Availability      |  High  | Preview |         Yes         |
| [COSMOS-2 – Enable service-managed failover for multi-region accounts with single write region](#cosmos-2---enable-service-managed-failover-for-multi-region-accounts-with-single-write-region) |   Disaster Recovery    |  High  | Preview |         No          |
| [COSMOS-3 – Evaluate multi-region write capability](#cosmos-3---evaluate-multi-region-write-capability)                                                                                         |   Disaster Recovery    |  High  | Preview |         Yes         |
| [COSMOS-4 – Choose appropriate consistency mode reflecting data durability requirements](#cosmos-4---choose-appropriate-consistency-mode-reflecting-data-durability-requirements)               |   Disaster Recovery    |  High  | Preview |         No          |
| [COSMOS-5 – Configure continuous backup mode](#cosmos-5---configure-continuous-backup-mode)                                                                                                     |   Disaster Recovery    |  High  | Preview |         Yes         |
| [COSMOS-6 – Ensure query results are fully drained](#cosmos-6---ensure-query-results-are-fully-drained)                                                                                         |   System Efficiency    |  High  | Preview |         No          |
| [COSMOS-7 – Maintain singleton pattern in your client](#cosmos-7---maintain-singleton-pattern-in-your-client)                                                                                   |   System Efficiency    | Medium | Preview |         No          |
| [COSMOS-8 – Implement retry logic in your client](#cosmos-8---implement-retry-logic-in-your-client)                                                                                             | Application Resilience | Medium | Preview |         No          |
| [COSMOS-9 – Monitor Cosmos DB health and set up alerts](#cosmos-9---monitor-cosmos-db-health-and-set-up-alerts)                                                                                 |       Monitoring       | Medium | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### COSMOS-1 - Configure at least two regions for high availability

**Category: Availability**

**Impact: High**

**Guidance**

Azure implements multi-tier isolation approach with rack, DC, zone, and region isolation levels. Cosmos DB is by default highly resilient by running four replicas, but it is still susceptible to failures or issues with entire regions or availability zones. As such, it is crucial to enable at least a secondary region on your Cosmos DB to achieve higher SLA. Doing so does not incur any downtime at all and it is as easy as selecting a pin on map.

**Resources**

- [Distribute data globally with Azure Cosmos DB | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/distribute-data-globally)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-1/cosmos-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-2 - Enable service-managed failover for multi-region accounts with single write region

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Cosmos DB is a battle-tested service with extremely high uptime and resiliency, but even the most resilient of systems sometimes run into a small hiccup. Should a region become unavailable, the Service-Managed failover option allows Azure Cosmos DB to fail over automatically to the next available region with no user action needed.

**Resources**

- [Manage an Azure Cosmos DB account by using the Azure portal | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-manage-database-account#automatic-failover)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-2/cosmos-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-3 - Evaluate multi-region write capability

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Multi-region write capability enables you to design multi-region application that is inherently highly available by virtue of being active in multiple regions. This, however, requires that you pay close considerations to consistency requirements and handle potential writes conflicts by way of conflict resolution policy. On the flip side, blindly enabling this configuration can lead to decreased availability due to unexpected application behavior and data corruption due to unhandled conflicts.

**Resources**

- [Distribute data globally with Azure Cosmos DB | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/distribute-data-globally)
- [Conflict resolution types and resolution policies in Azure Cosmos DB | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/conflict-resolution-policies)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-3/cosmos-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-4 - Choose appropriate consistency mode reflecting data durability requirements

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Within a globally distributed database environment, there is a direct relationship between the consistency level and data durability in the presence of a region-wide outage. As you develop your business continuity plan, you need to understand the maximum period of recent data updates the application can tolerate losing when recovering after a disruptive event. We recommend using Session consistency unless you have established that stronger consistency mode is needed, you are willing to tolerate higher write latencies, and understand that outages on read-only regions can affect the ability of write region to accept writes.

**Resources**

- [Consistency level choices - Azure Cosmos DB | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/consistency-levels)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-4/cosmos-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-5 - Configure continuous backup mode

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Cosmos DB automatically backs up your data and there is no way to turn back ups off. In short, you are always protected. But should any mishap occur – a process that went haywire and deleted data it shouldn’t, customer data was overwritten by accident, etc. – minimizing the time it takes to revert the changes is of the essence. With continuous mode, you can self-serve restore your database/collection to a point in time before such mishap occurred. With periodic mode, however, you must contact Microsoft support, which despite us striving to provide speedy help will inevitably increase the restore time.

**Resources**

- [Continuous backup with point in time restore feature in Azure Cosmos DB | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/continuous-backup-restore-introduction)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-5/cosmos-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-6 - Ensure query results are fully drained

**Category: System Efficiency**

**Impact: High**

**Guidance**

Cosmos DB limits single response to 4 MB. If your query requests a large amount of data or data from multiple backend partitions, the results will span multiple pages for which separate requests must be issued. Each result page will indicate whether more results are available and provide a continuation token to access the next page. You must include a while loop in your code and traverse the pages until no more results are available.

**Resources**

- [Pagination in Azure Cosmos DB | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/query/pagination#handling-multiple-pages-of-results)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-6/cosmos-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-7 - Maintain singleton pattern in your client

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Not only is establishing a new database connection expensive, so is maintaining it. As such it is critical to maintain only one instance, a so-called “singleton”, of the SDK client per account per application. Connections, both HTTP and TCP, are scoped to the client instance. Most compute environments have limitations in terms of the number of connections that can be open at the same time and when these limits are reached, connectivity will be affected.

**Resources**

- [Designing resilient applications with Azure Cosmos DB SDKs | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/conceptual-resilient-sdk-applications)
**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-7/cosmos-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-8 - Implement retry logic in your client

**Category: Application Resilience**

**Impact: Medium**

**Guidance**

Cosmos DB SDKs by default handle large number of transient errors and automatically retry operations, where possible. That said, your application should add retry policies for certain well-defined cases that cannot be generically handled by the SDKs.

**Resources**

- [Designing resilient applications with Azure Cosmos DB SDKs | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/conceptual-resilient-sdk-applications)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-8/cosmos-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### COSMOS-9 - Monitor Cosmos DB health and set up alerts

**Category: Monitoring**

**Impact: Medium**

**Guidance**

It is good practice to monitor the availability and responsiveness of your Azure Cosmos DB resources and have alerts in place for your workload to stay proactive in case an unforeseen event occurs.

**Resources**

- [Create alerts for Azure Cosmos DB using Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cosmos-db/create-alerts)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cosmos-9/cosmos-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
