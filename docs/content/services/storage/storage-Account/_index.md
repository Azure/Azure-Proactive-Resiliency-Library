+++
title = "Storage Account"
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
| [ST-1 - Ensure that Storage Account configuration is at least Zone redundant](#st-1---ensure-that-storage-account-configuration-is-at-least-zone-redundant)                                   |   Availability    |  High  | Preview |          Yes         |
| [ST-2 - Do not use classic storage account](#st-2---do-not-use-classic-storage-account)                                                                                                       |    Governance     |  High  | Preview |         Yes          |
| [ST-3 - Ensure Performance tier is set as per workload](#st-3---ensure-performance-tier-is-set-as-per-workload)                                                                               | System Efficiency | Medium | Preview |         Yes          |
| [ST-4 - Choose right storage account kind for workload](#st-4---choose-right-storage-account-kind-for-workload)                                                                               | System Efficiency | Medium | Preview |          No          |
| [ST-5 - Enable soft delete for recovery of data](#st-5---enable-soft-delete-for-recovery-of-data)                                                                                             | Disaster Recovery | Medium | Preview |          No        |
| [ST-6 - Enable version for accidental modification and keep the number of versions below 1000](#st-6---enable-version-for-accidental-modification-and-keep-the-number-of-versions-below-1000) | Disaster Recovery | Medium | Preview |          No         |
| [ST-7 - Enable point and time restore for containers for recovery](#st-7---enable-point-and-time-restore-for-containers-for-recovery)                                                         | Disaster Recovery |  Low   | Preview |          No         |
| [ST-8 - Configure Diagnostic Settings for all storage accounts](#st-8---configure-diagnostic-settings-for-all-storage-accounts)                                                               |    Monitoring     |  Low   | Preview |          No         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ST-1 - Ensure that Storage Account configuration is at least Zone redundant

**Category: Availability**

**Impact: High**

**Guidance**

Data in an Azure Storage account is always replicated three times in the primary region. Azure Storage offers other options for how your data is replicated in the primary or paired region:

- LRS synchronously replicates data 3 times in single physical location. It is least expensive replication but not recommended for apps with high availability and durability. LRS provides eleven 9 durability.
- ZRS copies data synchronously across 3 availability zone in primary region. ZRS is recommended for apps requiring high availability across zones. ZRS provides twelve 9s durability.
- GRS replicate additional 3 copies to secondary region and provides sixteen 9s availability.
- GZRS provides both high availability and redundancy across geo replication. It provides sixteen 9s durability over a given year.

**Resources**

- [Azure Storage redundancy](https://learn.microsoft.com/azure/storage/common/storage-redundancy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-1/st-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-2 - Do not use classic Storage Account

**Category: Governance**

**Impact: High**

**Guidance**

Azure classic Storage Account will retire 31 august 2024. So migrate all workload from classic storage to v2.

**Resources**

- [storage account retirement announcement](https://azure.microsoft.com/updates/classic-azure-storage-accounts-will-be-retired-on-31-august-2024/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-2/st-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-3 - Ensure Performance tier is set as per workload

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Consider using appropriate storage performance tier for standard storage / block blob / append blob / file-share and page blob. Each workload scenario requires appropriate Performance tier and its important that based on the type of transaction and blob type/file type appropriate performance tier is selected. Failing to do so will create performance bottleneck.

**Resources**

- [Performance Tier](https://learn.microsoft.com/azure/storage/common/storage-account-overview#performance-tiers )

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-3/st-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-4 - Choose right storage account kind for workload

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Block blobs are optimized for uploading large amounts of data efficiently. Block blobs are composed of blocks, each of which is identified by a block ID. A block blob can include up to 50,000 blocks

**Resources**

- [Storage Account Kind docs](https://learn.microsoft.com/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs )

**Resource Graph Query/Scripts**

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

{{< code lang="powershell" file="code/st-5/st-5.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-6 - Enable version for accidental modification and keep the number of versions below 1000

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

To recover data from accidental modification or deletion enable versioning.
Having a large number of versions per blob can increase the latency for blob listing operations. Microsoft recommends maintaining fewer than 1000 versions per blob. You can use lifecycle management to automatically delete old versions.

**Resources**

- [Blob versioning](https://learn.microsoft.com/azure/storage/blobs/versioning-overview )

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="powershell" file="code/st-6/st-6.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-7 - Enable point and time restore for containers for recovery

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

You can use point-in-time restore to restore one or more sets of block blobs to a previous state
Point and time restore support general purpose v2 account in standard performance tier. Its a mechanism to protect data

**Resources**

- [Restore overview](https://learn.microsoft.com/azure/storage/blobs/point-in-time-restore-manage?tabs=portal)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="powershell" file="code/st-7/st-7.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-8 - Configure Diagnostic Settings for all storage accounts

**Category: Monitoring**

**Impact: Low**

**Guidance**

Enabling diagnostic settings allow you to capture and view diagnostic information so that you can troubleshoot any failures.

**Resources**

- [Diagnostic Setting for Storage Account](https://learn.microsoft.com/en-us/azure/storage/blobs/monitor-blob-storage)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="powershell" file="code/st-8/st-8.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
