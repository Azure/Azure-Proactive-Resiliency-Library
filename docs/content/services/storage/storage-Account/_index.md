+++
title = "Storage Account"
description = "Best practices and resiliency recommendations for Storage Account and associated resources."
date = "4/13/23"
author = "CHANGE ME TO YOUR GITHUB USERNAME"
msAuthor = "CHANGE ME TO YOUR MICROSOFT ALIAS"
draft = false
+++

The presented resiliency recommendations in this guidance include Storage Account and associated Storage Account settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Storage Account and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                     |  State  | ARG Query Available |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-----: | :-----------------: |
|[SA-1 Ensure that storage account is redundant](#sa-1-ensure-that-storage-account-is-redundant)|  Preview  |         Yes         |
|[SA-2 Do not use classic storage account](#sa-2-do-not-use-classic-storage-account) | Preview  |         Yes          |
|[SA-3 Ensure Performance tier is set as per workload](#sa-3-ensure-performance-tier-is-set-as-per-workload) | Preview  |         No          |
|[SA-4 Choose right storage account kind for workload](#sa-4-choose-right-storage-account-kind-for-workload) | Preview  |         No          |
|[SA-5 Enable soft delete for recovery of data](#sa-5-enable-soft-delete-for-recovery-of-data) | Preview  |         No          |
|[SA-6 enable version for accidental modification](#sa-6-enable-version-for-accidental-modification) | Preview  |         No          |
|[SA-7 Enable point and time restore for containers for recovery](#sa-7-enable-point-and-time-restore-for-containers-for-recovery) | Preview  |         No          |
|[SA-8 Keep versioning below 100 for performance](#sa-8-keep-versioning-below-100-for-performance) |Preview   |         No          |
{{< /table >}}


{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SA-1 Ensure that storage account is redundant

#### Importance: Critical

#### Recommendation /Guidance
 LRS synchronously replicate data 3 times in single physical location. It is least expensive replication but not recommended for apps with high availability and durability. LRS provides eleven 9 durability.  ZRS copies data synchronously across 3 availability zone in primary region. ZRS is recommended for apps requiring high availability. ZRS provides twelve 9 durability. GRS replicate additional 3 copies to secondary region and provides sixteen 9 availability. GZRS provides both high availability and redundancy across geo replication. It provides sixteen 9s durability over a given year.  in addition data can be put in read mode in case of failure by additional RA-GRS/RA-GZRS.



##### Resources

- [Azure Storage redundancy](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)

#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sa-1/sa-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### SA-2 Do not use classic storage account

#### Importance: High

#### Recommendation/Guidance

Azure classic storage account will retire 31 august 2024. So migrate all workload from classic storage to v2.

##### Resources

- [storage account retirement announcement](https://azure.microsoft.com/en-us/updates/classic-azure-storage-accounts-will-be-retired-on-31-august-2024/)

#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sa-2/sa-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>




### SA-3 Ensure Performance tier is set as per workload

#### Importance: Medium

#### Recommendation/Guidance

Consider using appropriate storage performance tier for standard storage/ block blob/append blob/ file-share and page blob. Each workload scenario requires appropriate  Performance tier and its important that based on the type of transaction and blob type/file type appropriate  performance tier is selected. Failing to do so will create performance bottleneck


##### Resources

- [Performance Tier](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview#performance-tiers )

#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/sa-3/sa-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### SA-4 Choose right storage account kind for workload

#### Importance: Medium

#### Recommendation/Guidance


Block blobs are optimized for uploading large amounts of data efficiently. Block blobs are composed of blocks, each of which is identified by a block ID. A block blob can include up to 50,000 blocks


##### Resources

- [Account Kind docs](https://learn.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs )

#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/sa-4/sa-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

<br><br>


### SA-5 Enable soft delete for recovery of data

#### Importance: Medium

#### Recommendation/Guidance


Soft delete option allow for recovering data if its deleted by mistaken. Moreover Lock will prevent accidently deleting storage account


##### Resources

- [Soft delete detail docs](https://learn.microsoft.com/en-us/azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal )

#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/sa-5/sa-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>



<br><br>


### SA-6 enable version for accidental modification



#### Importance: Medium

#### Recommendation/Guidance

to recover data from accidental modification, enable versioning.

##### Resources

- [Blob versioning](https://learn.microsoft.com/en-us/azure/storage/blobs/versioning-overview )

#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/sa-6/sa-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>



<br><br>






### SA-7 Enable point and time restore for containers for recovery

#### Importance: Low

#### Recommendation/Guidance
You can use point-in-time restore to restore one or more sets of block blobs to a previous state
Point and time restore support general purpose v2 account in standard performance tier. Its a mechanism to protect data

##### Resources

- [Restore overview](https://learn.microsoft.com/en-us/azure/storage/blobs/point-in-time-restore-manage?tabs=portal )


#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/sa-7/sa-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


<br><br>


### SA-8 Keep versioning below 100 for performance

#### Importance: Low

#### Recommendation/Guidance
Using more version increase the latency of the blob listing operation and hence effect reliability of application. Use lifecycle policy to delete older version

##### Resources

- [Blob Versioning](https://learn.microsoft.com/en-us/azure/storage/blobs/versioning-overview )


<br><br>
#### Queries/Scripts



{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/sa-8/sa-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
