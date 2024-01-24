+++
title = "Azure High Performance Computing"
description = "Best practices and resiliency recommendations for Azure Virtual Desktop and associated resources and settings."
date = "1/12/24"
author = "lpatel"
msAuthor = "lpatel"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure High Performance Computing and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  Recommendation                                   |      Impact         |  Design Area         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :------:          |
| [HPC-1 Ensure that Storage Account is redundant](#hpc-1---ensure-that-storage-account-is-redundant)    | High | Resiliency/Monitoring |  Preview  |        Yes         |
| [HPC-2 Monitor Azure Batch Pool quota for cross-region disaster recovery and business continuity](#hpc-2---monitor-batch-account-quota)  | Medium |  Resiliency/Monitoring | Preview |       Yes        |
| [HPC-3 Ensure Azure File shares Are active](#hpc-3---ensure-azure-file-shares-are-active)  | High |  Resiliency/Monitoring | Preview |       Yes        |
| [HPC-4 ](#hpc-4---under-development)  | Medium |  Identity | Preview |       No        |
| [HPC-5 ](#hpc-5---under-development)  | Medium |  Networking | Preview |       No        |
| [HPC-6 ](#hpc-6---under-development)  | Medium |  Backup | Preview |       No        |
| [HPC-7 ](#hpc-7---under-development)  | Low |  Backup | Preview |       No        |
| [HPC-8 ](#hpc-8---under-development)  | Low |  Compute | Preview |       No        |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### HPC-1 - Ensure that Storage Account is redundant

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Data in an Azure Storage account is always replicated three times in the primary region. Azure Storage offers other options for how your data is replicated in the primary or paired region:

LRS synchronously replicates data 3 times in single physical location. It is least expensive replication but not recommended for apps with high availability and durability. LRS provides eleven 9 durability.
ZRS copies data synchronously across 3 availability zone in primary region. ZRS is recommended for apps requiring high availability across zones. ZRS provides twelve 9s durability.
GRS replicate additional 3 copies to secondary region and provides sixteen 9s availability.
GZRS provides both high availability and redundancy across geo replication. It provides sixteen 9s durability over a given year.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-1/hpc-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-2 - Monitor batch account quota

**Category: Resiliency/Monitoring**

**Impact: High**

**Recommendation/Guidance**

For Cross-region disaster recovery and business continuity, Make sure ahead of time that the appropriate quotas are set for all user subscription Batch accounts, to allocate the required number of cores using the Batch account.

Precreate all required services in each region, such as the Batch account and the storage account. There's often no charge for having accounts created, and charges accrue only when the account is used or when data is stored.


**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/reliability/reliability-batch#cross-region-disaster-recovery-and-business-continuity)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-2/hpc-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-3 -  Ensure Azure File shares are active

**Category: Application Resilience/Availability**

**Impact: High**

**Recommendation/Guidance**

Currently in all HPC Pack ARM templates we create the cluster share on one of the head node which is not high available as if that head node is down, the share will not be accessible to the HPC Service running on other head node. Basically it will not impact running jobs and managing the nodes.

With Azure Files, these file shares can be moved to Azure Files shares with SMB permissions to make them high available.

\\<HN3>\REMINST <br>
\\<HN3>\HpcServiceRegistration <br>
\\<HN3>\Runtime$ <br>
\\<HN3>\TraceRepository <br>
\\<HN3>\Diagnostics <br>
\\<HN3>\CcpSpoolDir

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#hpc-pack-cluster-shares)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-3/hpc-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-4 - Under Development

**Category: Availability/Identity**

**Impact: Medium**

**Recommendation/Guidance**

Under Development

**Resources**

- [Learn More](TBD)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-4/hpc-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-5 - Under Development

**Category: Networking**

**Impact: Medium**

**Recommendation/Guidance**

Under Development

**Resources**

- [Learn More](TBD)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-5/hpc-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-6 - Under Development

**Category: Backup**

**Impact: Medium**

**Recommendation/Guidance**

Under Development

**Resources**

- [Multi-region BCDR](TBD)
- [Learn More](TBD)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-6/hpc-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>



### HPC-7 - Under Development

**Category: Backup**

**Impact: Low**

**Recommendation/Guidance**

Under Development

**Resources**

- [Golden Image](TBD)
- [Learn More](TBD)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-7/hpc-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-8 - Under Development

**Category: Backup**

**Impact: Low**

**Recommendation/Guidance**

Under Development


**Resources**

- [Capacity Planning](TBD)
- [Learn More](TBD)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-8/hpc-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
