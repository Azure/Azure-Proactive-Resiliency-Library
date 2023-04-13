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
|[SA1 Storage account Redundancy](#sa1-storage-account-redundancy)|  Preview  |         Yes         |
|[SA2 v1 Classic Storage Account  ](#sa2-v1-classic-storage-account) | Preview  |         Yes          |
|[SA3 Performance Tier of Storage account](#sa3-performance-tier-of-storage-account) | Preview  |         Yes          |
|[SA4 Account Kind](#sa4-account-kind) | Preview  |         Yes          |
|[SA5 Soft delete ](#sa5-soft-delete) | Preview  |         Yes          |
|[SA6 Versioning ](#sa6-versioning) | Preview  |         Yes          |
|[SA7 Point and time restore for containers](#sa7-point-and-time-restore-for-containers) | Preview  |         Yes          |
|[SA8 Keep versioning below 100](#sa8-keep-versioning-below-100) |Preview   |         Yes          |
{{< /table >}}


{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SA1 Storage account Redundancy

#### Importance: Critical

#### Recommendation /Guidance
 LRS synchronously replicate data 3 times in single physical location. It is least expensive replication but not recommended for apps with high availability and durability. LRS provides eleven 9 durability.  ZRS copies data synchronously across 3 availability zone in primary region. ZRS is recommended for apps requiring high availability. ZRS provides twelve 9 durability. GRS replicate additional 3 copies to secondary region and provides sixteen 9 availability. GZRS provides both high availability and redundancy across geo replication. It provides sixteen 9s durability over a given year.  in addition data can be put in read mode in case of failure by additional RA-GRS/RA-GZRS.



##### Resources

- [Azure Storage redundancy](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)

#### Queries/Scripts

##### Azure Resource Graph
resources
| where type =="microsoft.storage/storageaccounts"
| project StorageAccountName=name,location,id,
redudancy=sku.name

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### SA2 v1 Classic Storage Account

#### Importance: High

#### Recommendation/Guidance

Azure classic storage account will retire 31 august 2024. So migrate all workload from classic storage to v2.

##### Resources

- [storage account retirement announcement](https://azure.microsoft.com/en-us/updates/classic-azure-storage-accounts-will-be-retired-on-31-august-2024/)

#### Queries/Scripts

##### Azure Resource Graph
 resources
| where type == "microsoft.classicstorage/storageaccounts"

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>




### SA3 Performance Tier of Storage account

#### Importance: Medium

#### Recommendation/Guidance

Consider using appropriate storage performance tier for standard storage/ block blob/append blob/ file-share and page blob. Each workload scenario requires appropriate  Performance tier and its important that based on the type of transaction and blob type/file type appropriate  performance tier is selected. Failing to do so will create performance bottleneck


##### Resources

- [Performance Tier](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview#performance-tiers )

#### Queries/Scripts





<br><br>


### SA4 Account Kind

#### Importance: Medium

#### Recommendation/Guidance


Block blobs are optimized for uploading large amounts of data efficiently. Block blobs are composed of blocks, each of which is identified by a block ID. A block blob can include up to 50,000 blocks


##### Resources

- [Account Kind docs](https://learn.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs )



<br><br>


### SA5 Soft delete

#### Importance: Medium

#### Recommendation/Guidance


Soft delete option allow for recovering data if its deleted by mistaken. Moreover Lock will prevent accidently deleting storage account


##### Resources

- [Soft delete detail docs](https://learn.microsoft.com/en-us/azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal )





<br><br>


### SA6 Versioning

#### Importance: Low

#### Recommendation/Guidance
Versioning will recover the data which has been modified.


##### Resources

- [Versioning](https://learn.microsoft.com/en-us/azure/storage/blobs/versioning-overview )





<br><br>



### SA7 Point and time restore for containers

#### Importance: Low

#### Recommendation/Guidance
You can use point-in-time restore to restore one or more sets of block blobs to a previous state
Point and time restore support general purpose v2 account in standard performance tier. Its a mechanism to protect data

##### Resources

- [Restore overview](https://learn.microsoft.com/en-us/azure/storage/blobs/point-in-time-restore-manage?tabs=portal )





<br><br>


### SA8 Keep versioning below 100

#### Importance: Low

#### Recommendation/Guidance
Using more version increase the latency of the blob listing operation and hence effect reliability of application. Use lifecycle policy to delete older version

##### Resources

- [Blob Versioning](https://learn.microsoft.com/en-us/azure/storage/blobs/versioning-overview )


<br><br>
