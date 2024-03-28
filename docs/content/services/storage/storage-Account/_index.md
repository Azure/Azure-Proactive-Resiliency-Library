+++
title = "Storage Accounts (Blob/Azure Data Lake Storage Gen2)"
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
| [ST-1 - Ensure that storage accounts are zone or region redundant](#st-1---ensure-that-storage-accounts-are-zone-or-region-redundant)                                   |   Availability    |  High  | Verified |          Yes         |
| [ST-2 - Do not use classic storage accounts](#st-2---do-not-use-classic-storage-accounts)                                                                                                       |    Governance     |  High  | Verified |         Yes          |
| [ST-3 - Ensure performance tier is set as per workload](#st-3---ensure-performance-tier-is-set-as-per-workload)                                                                               | System Efficiency | Medium | Verified |          No          |
| [ST-5 - Enable soft delete for recovery of data](#st-5---enable-soft-delete-for-recovery-of-data)                                                                                             | Disaster Recovery | Medium | Verified |          No          |
| [ST-6 - Enable versioning for accidental modification and keep the number of versions below 1000](#st-6---enable-versioning-for-accidental-modification-and-keep-the-number-of-versions-below-1000) | Disaster Recovery | Low | Verified |          No          |
| [ST-7 - Consider enabling point-in-time restore for standard general purpose v2 accounts with flat namespace](#st-7---consider-enabling-point-in-time-restore-for-standard-general-purpose-v2-accounts-with-flat-namespace)                                                         | Disaster Recovery |  Low   | Verified |          No          |
| [ST-8 - Monitor all blob storage accounts](#st-8---monitor-all-blob-storage-accounts)                                                               |    Monitoring     |  Low   | Verified |          No          |
| [ST-9 - Consider upgrading legacy storage accounts to v2 storage accounts](#st-9---consider-upgrading-legacy-storage-accounts-to-v2-storage-accounts)                                                               | System Efficiency | Low | Verified |         Yes          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ST-1 - Ensure that storage accounts are zone or region redundant

**Category: Availability**

**Impact: High**

**Guidance**

Redundancy ensures that your storage account meets its availability and durability targets even in the face of failures. When deciding which redundancy option is best for your scenario, consider the tradeoffs between lower costs and higher availability.
Locally redundant storage (LRS) is the lowest-cost redundancy option and offers the least durability compared to other options. Microsoft recommends using zone-redundant storage (ZRS), geo-redundant storage (GRS), or geo-zone-redundant storage (GZRS) to ensure your storage accounts are available if an availability zone or region becomes unavailable.


**Resources**

- [Azure Storage redundancy](https://learn.microsoft.com/azure/storage/common/storage-redundancy)
- [Change the redundancy configuration for a storage account](https://learn.microsoft.com/azure/storage/common/redundancy-migration)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-1/st-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-2 - Do not use classic storage accounts

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

**Impact: Low**

**Guidance**

Consider enabling versioning to recover data from accidental modification or deletion.
Having a large number of versions per blob can increase the latency for blob listing operations. Microsoft recommends maintaining fewer than 1000 versions per blob. You can use lifecycle management to automatically delete old versions.

**Resources**

- [Blob versioning](https://learn.microsoft.com/azure/storage/blobs/versioning-overview )

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-6/st-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-7 - Consider enabling point-in-time restore for standard general purpose v2 accounts with flat namespace

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

Consider enabling point-in-time restore for standard general purpose v2 accounts with flat namespace. Point-in-time restore provides protection against accidental deletion or corruption by enabling you to restore block blob data to an earlier state.

**Resources**

- [Point-in-time restore for block blobs](https://learn.microsoft.com/azure/storage/blobs/point-in-time-restore-overview)
- [Perform a point-in-time restore on block blob data](https://learn.microsoft.com/azure/storage/blobs/point-in-time-restore-manage?tabs=portal)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-7/st-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-8 - Monitor all blob storage accounts

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

### ST-9 - Consider upgrading legacy storage accounts to v2 storage accounts

**Category: System Efficiency**

**Impact: Low**

**Guidance**

General-purpose v2 accounts are recommended for most storage scenarios with the latest features or the lowest per-gigabyte pricing. Legacy account types (Standard general-purpose v1 and Blob Storage) aren’t recommended by Microsoft, but may be used in certain scenarios.
Please consider the scenarios (classic compatibility, transaction-intensive, etc.) listed in the documentation and upgrade legacy storage accounts to v2 storage accounts when applicable.

Upgrading to a general-purpose v2 storage account from your general-purpose v1 or Blob storage accounts is straightforward. There's no downtime or risk of data loss associated with upgrading to a general-purpose v2 storage account. Upgrading a general-purpose v1 or Blob storage account to general-purpose v2 is permanent and cannot be undone.

**Resources**

- [Legacy storage account types](https://learn.microsoft.com/azure/storage/common/storage-account-overview#legacy-storage-account-types)
- [Upgrade to a general-purpose v2 storage account](https://learn.microsoft.com/azure/storage/common/storage-account-upgrade)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-9/st-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
