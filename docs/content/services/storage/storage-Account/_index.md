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
|[SA-1 - Redundancy of storage account](#sa-1---redudancy)|  Preview  |         Yes         |
|[SA-2 - v1 classic storage?  ](#sa-2---v1-classic-storage) | Preview  |         Yes          |
|[SA-3 - Performance Tier of Storage account](#sa-3---Performance-Tier) | Preview  |         Yes          |
|[SA-4 - Account Kind](#sa-4---Account-Kind) | Preview  |         Yes          |
|[SA-5 - Soft delete ](#sa-5---Soft-delete) | Preview  |         Yes          |
|[SA-6 - Versioning ](#sa-6---Versioning) | Preview  |         Yes          |
|[SA-7 - Point and time restore for containers](#sa-6---point-and-time-restore-containers) | Preview  |         Yes          |
|[SA-8 -Keep versioning below 100](#sa-6---keep-versioning-below-100) |Preview   |         Yes          |
{{< /table >}}


{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SA-1 - Redundancy of storage account

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


### SA-2-Are you using v1 classic storage?

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




### SA-3 - Performance Tier

#### Importance: Medium

#### Recommendation/Guidance

Consider using appropriate storage performance tier for standard storage/ block blob/append blob/ file-share and page blob. Each workload scenario requires appropriate  Performance tier and its important that based on the type of transaction and blob type/file type appropriate  performance tier is selected. Failing to do so will create performance bottleneck


##### Resources

- [Performance Tier](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview#performance-tiers )

#### Queries/Scripts





<br><br>


### SA-4 - Account Kind

#### Importance: Medium

#### Recommendation/Guidance


Block blobs are optimized for uploading large amounts of data efficiently. Block blobs are composed of blocks, each of which is identified by a block ID. A block blob can include up to 50,000 blocks


##### Resources

- [Account Kind docs](https://learn.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs )



<br><br>


### SA-5 - Soft Delete

#### Importance: Medium

#### Recommendation/Guidance


Soft delete option allow for recovering data if its deleted by mistaken. Moreover Lock will prevent accidently deleting storage account


##### Resources

- [Soft delete detail docs](https://learn.microsoft.com/en-us/azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal )





<br><br>


### SA-5 - Versioning

#### Importance: Low

#### Recommendation/Guidance
Versioning will recover the data which has been modified.


##### Resources

- [Versioning](https://learn.microsoft.com/en-us/azure/storage/blobs/versioning-overview )





<br><br>


### SA-6 - Soft Delete

#### Importance: Medium

#### Recommendation/Guidance


Soft delete option allow for recovering data if its deleted by mistaken. Moreover Lock will prevent accidently deleting storage account


##### Resources

- [Soft delete detail docs](https://learn.microsoft.com/en-us/azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal )





<br><br>


### SA-7 - Point and time restore for block blob

#### Importance: Low

#### Recommendation/Guidance
You can use point-in-time restore to restore one or more sets of block blobs to a previous state
Point and time restore support general purpose v2 account in standard performance tier. Its a mechanism to protect data

##### Resources

- [Restore overview](https://learn.microsoft.com/en-us/azure/storage/blobs/point-in-time-restore-manage?tabs=portal )





<br><br>


### SA-8 - Keep versioning below 100 to avoid degrading performance

#### Importance: Low

#### Recommendation/Guidance 
Using more version increase the latency of the blob listing operation and hence effect reliability of application. Use lifecycle policy to delete older version

##### Resources

- [Blob Versioning](https://learn.microsoft.com/en-us/azure/storage/blobs/versioning-overview )


<br><br>
