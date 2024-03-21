+++
title = "Storage Accounts (Blob/ADLS)"
description = "Best practices and resiliency recommendations for Storage Account and associated resources."
date = "4/13/23"
author = "dost"
msAuthor = "dost"
draft = false
+++

The presented resiliency recommendations in this guidance include Storage Account and associated settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Storage Account and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                |     Category      | Impact |  State  | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:--------------------:|
| [ST-1 - Ensure that storage accounts are zone or region redundant](#st-1---ensure-that-storage-accounts-are-zone-or-region-redundant)                                   |   Availability    |  High  | Preview |          Yes         |
| [ST-2 - Do not use classic storage accounts](#st-2---do-not-use-classic-storage-accounts)                                                                                                       |    Governance     |  High  | Preview |         Yes          |
| [ST-3 - Ensure performance tier is set as per workload](#st-3---ensure-performance-tier-is-set-as-per-workload)                                                                               | System Efficiency | Medium | Preview |          No          |
| [ST-4 - Choose right blob type for workload](#st-4---choose-right-blob-type-for-workload)                                                                                                     | System Efficiency | Medium | Preview |          No          |
| [ST-5 - Enable soft delete for recovery of data](#st-5---enable-soft-delete-for-recovery-of-data)                                                                                             | Disaster Recovery | Medium | Preview |          No          |
| [ST-6 - Enable versioning for accidental modification and keep the number of versions below 1000](#st-6---enable-versioning-for-accidental-modification-and-keep-the-number-of-versions-below-1000) | Disaster Recovery | Medium | Preview |          No          |
| [ST-7 - Enable point in time restore for standard general purpose v2 accounts](#st-7---enable-point-in-time-restore-for-standard-general-purpose-v2-accounts)                                                         | Disaster Recovery |  Low   | Preview |          No          |
| [ST-8 - Monitor all blob storage accounts](#st-8---monitor-all-blob-storage-accounts)                                                               |    Monitoring     |  Low   | Preview |          No          |
| [ST-9 - Upgrade legacy storage accounts to v2 storage accounts](#st-9---upgrade-legacy-storage-accounts-to-v2-storage-accounts)                                                               | System Efficiency | Medium | Preview |         Yes          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ST-1 - Ensure that Storage Accounts are Zone or Region redundant

**Category: Availability**

**Impact: High**

**Guidance**

Data in an Azure Storage account is always replicated three times in the primary region. Azure Storage offers other options for how your data is replicated in the primary or paired region:

- Locally redundant storage (LRS) replicates your storage account three times within a single data center in the primary region. LRS provides at least 99.999999999% (11 nines) durability of objects over a given year.
- Zone-redundant storage (ZRS) replicates your storage account synchronously across three Azure availability zones in the primary region. Each availability zone is a separate physical location with independent power, cooling, and networking. ZRS offers durability for storage resources of at least 99.9999999999% (12 9's) over a given year.
- Geo-redundant storage (GRS) copies your data synchronously three times within a single physical location in the primary region using LRS. It then copies your data asynchronously to a single physical location in a secondary region that is hundreds of miles away from the primary region. GRS offers durability for storage resources of at least 99.99999999999999% (16 9's) over a given year.
- Geo-zone-redundant storage (GZRS) combines the high availability provided by redundancy across availability zones with protection from regional outages provided by geo-replication. Data in a GZRS storage account is copied across three Azure availability zones in the primary region and is also replicated to a secondary geographic region for protection from regional disasters. Microsoft recommends using GZRS for applications requiring maximum consistency, durability, and availability, excellent performance, and resilience for disaster recovery.

**Resources**

- [Azure Storage redundancy](https://learn.microsoft.com/azure/storage/common/storage-redundancy)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-1/st-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-2 - Do not use classic Storage Accounts

**Category: Governance**

**Impact: High**

**Guidance**

Classic storage accounts will be fully retired on August 31, 2024. If you have classic storage accounts, start planning your migration now.

**Resources**

- [Azure classic storage accounts retirement announcement](https://azure.microsoft.com/updates/classic-azure-storage-accounts-will-be-retired-on-31-august-2024/)
- [Migrate your classic storage accounts to Azure Resource Manager](https://learn.microsoft.com/azure/storage/common/classic-account-migration-overview)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-2/st-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-3 - Ensure Performance tier is set as per workload

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Consider using appropriate storage performance tier for workload scenarios. Each workload scenario requires appropriate performance tiers and it's important that appropriate performance tiers are selected based on the storage usage.

**Resources**

- [Types of storage accounts](https://learn.microsoft.com/azure/storage/common/storage-account-overview#types-of-storage-accounts)
- [Scalability and performance targets for standard storage accounts](https://learn.microsoft.com/azure/storage/common/scalability-targets-standard-account)
- [Performance and scalability checklist for Blob storage](https://learn.microsoft.com/azure/storage/blobs/storage-performance-checklist)
- [Scalability and performance targets for Blob storage](https://learn.microsoft.com/azure/storage/blobs/scalability-targets)
- [Premium block blob storage accounts](https://learn.microsoft.com/azure/storage/blobs/storage-blob-block-blob-premium)
- [Scalability targets for premium block blob storage accounts](https://learn.microsoft.com/azure/storage/blobs/scalability-targets-premium-block-blobs)
- [Scalability and performance targets for premium page blob storage accounts](https://learn.microsoft.com/azure/storage/blobs/scalability-targets-premium-page-blobs)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-3/st-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-4 - Choose right blob type for workload

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

The storage service offers three types of blobs, block blobs, append blobs, and page blobs. You specify the blob type when you create the blob.

Block blobs are optimized for uploading large amounts of data efficiently. Block blobs are composed of blocks, each of which is identified by a block ID. A block blob can include up to 50,000 blocks.

An append blob is composed of blocks and is optimized for append operations. When you modify an append blob, blocks are added to the end of the blob only. Updating or deleting of existing blocks is not supported. Unlike a block blob, an append blob does not expose its block IDs.

Page blobs are a collection of 512-byte pages optimized for random read and write operations. To create a page blob, you initialize the page blob and specify the maximum size the page blob will grow. To add or update the contents of a page blob, you write a page or pages by specifying an offset and a range that both align to 512-byte page boundaries.

**Resources**

- [Understanding block blobs, append blobs, and page blobs](https://learn.microsoft.com/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs)
- [Scalability and performance targets for Blob storage](https://learn.microsoft.com/azure/storage/blobs/scalability-targets)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-4/st-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-5 - Enable soft delete for recovery of data

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Soft delete option allow for recovering data if its deleted by mistaken. Moreover Lock will prevent accidentally deleting storage account.

**Resources**

- [Soft delete detail docs](https://learn.microsoft.com//azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal )

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-5/st-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-6 - Enable versioning for accidental modification and keep the number of versions below 1000

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

To recover data from accidental modification or deletion enable versioning.
Having a large number of versions per blob can increase the latency for blob listing operations. Microsoft recommends maintaining fewer than 1000 versions per blob. You can use lifecycle management to automatically delete old versions.

**Resources**

- [Blob versioning](https://learn.microsoft.com/azure/storage/blobs/versioning-overview )

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-6/st-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-7 - Enable point-in-time restore for standard general purpose v2 accounts

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

Enable point-in-time restore for standard general purpose v2 accounts. Point-in-time restore provides protection against accidental deletion or corruption by enabling you to restore block blob data to an earlier state.

**Resources**

- [Point-in-time restore for block blobs](https://learn.microsoft.com/azure/storage/blobs/point-in-time-restore-overview)
- [Perform a point-in-time restore on block blob data](https://learn.microsoft.com/azure/storage/blobs/point-in-time-restore-manage?tabs=portal)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-7/st-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-8 - Monitor all Blob Storage Accounts

**Category: Monitoring**

**Impact: Low**

**Guidance**

When you have critical applications and business processes that rely on Azure resources, you need to monitor and get alerts for your system.
Resource logs aren't collected and stored until you create a diagnostic setting and route the logs to one or more locations. When you create a diagnostic setting, you specify which categories of logs to collect.

**Resources**

- [Monitor Azure Blob Storage](https://learn.microsoft.com/azure/storage/blobs/monitor-blob-storage)
- [Best practices for monitoring Azure Blob Storage](https://learn.microsoft.com/azure/storage/blobs/blob-storage-monitoring-scenarios)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-8/st-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-9 - Upgrade legacy storage accounts to v2 storage accounts

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

General-purpose v2 storage accounts support the latest Azure Storage features and incorporate all of the functionality of general-purpose v1 and Blob storage accounts. General-purpose v2 accounts are recommended for most storage scenarios. General-purpose v2 accounts deliver the lowest per-gigabyte capacity prices for Azure Storage, as well as industry-competitive transaction prices. General-purpose v2 accounts support default account access tiers of hot or cool and blob level tiering between hot, cool, or archive.

Upgrading to a general-purpose v2 storage account from your general-purpose v1 or Blob storage accounts is straightforward. There's no downtime or risk of data loss associated with upgrading to a general-purpose v2 storage account. Upgrading a general-purpose v1 or Blob storage account to general-purpose v2 is permanent and cannot be undone.

**Resources**

- [Legacy storage account types](https://learn.microsoft.com/azure/storage/common/storage-account-overview#legacy-storage-account-types)
- [Upgrade to a general-purpose v2 storage account](https://learn.microsoft.com/azure/storage/common/storage-account-upgrade)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-9/st-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
