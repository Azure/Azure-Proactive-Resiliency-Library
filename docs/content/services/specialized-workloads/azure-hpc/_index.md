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
| [HPC-4 Use Availability Zone for batch pool](#hpc-4---create-an-azure-batch-pool-across-availability-zones)  | Medium |  Availability | Preview |       No        |
| [HPC-5 Automatically grow and shrink HPC Pack cluster resources](#hpc-5---automatically-grow-and-shrink-hpc-pack-cluster-resources)  | Medium |  Availability | Preview |       No        |
| [HPC-6 HPC Pack - Dealing with database failure](#hpc-6---hpc-pack---dealing-with-database-failure)  | Medium |  Resiliency | Preview |       No        |
| [HPC-7 HPC Pack - Dealing with Head node failure](#hpc-7---hpc-pack---dealing-with-head-node-failure)  | Medium |  Resiliency | Preview |       No        |
| [HPC-8 HPC Pack - Dealing with AD failure](#hpc-8---hpc-pack---dealing-with-ad-failure)  | High |  Resiliency | Preview |       No        |

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

**Impact: Medium**

**Recommendation/Guidance**

For Cross-region disaster recovery and business continuity, Make sure ahead of time that the appropriate quotas are set for all user subscription Batch accounts, to allocate the required number of cores using the Batch account.

Pre-create all required services in each region, such as the Batch account and the storage account. There's often no charge for having accounts created, and charges accrue only when the account is used or when data is stored.


**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/reliability/reliability-batch#cross-region-disaster-recovery-and-business-continuity)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-2/hpc-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-3 - Ensure Azure File shares are active

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

### HPC-4 - Create an Azure Batch pool across Availability Zones

**Category: Availability/Identity**

**Impact: Medium**

**Recommendation/Guidance**

When you create an Azure Batch pool using Virtual Machine Configuration, you can choose to provision your Batch pool across Availability Zones. Creating your pool with this zonal policy helps protect your Batch compute nodes from Azure datacenter-level failures.
For example, you could create your pool with zonal policy in an Azure region which supports three Availability Zones. If an Azure datacenter in one Availability Zone has an infrastructure failure, your Batch pool will still have healthy nodes in the other two Availability Zones, so the pool will remain available for task scheduling.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/batch/create-pool-availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-4/hpc-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-5 - Automatically grow and shrink HPC Pack cluster resources

**Category: Availability**

**Impact: Medium**

**Recommendation/Guidance**

By deploying Azure "burst" nodes (both Windows and Linux) in your HPC Pack cluster or creating your HPC Pack cluster in Azure, you can automatically grow or shrink the cluster's resources such as nodes or cores according to the workload on the cluster. Scaling the cluster resources in this way allows you to use your Azure resources more efficiently.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-auto-grow-shrink?view=hpc19-ps)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-5/hpc-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-6 - HPC Pack - Dealing with database failure

**Category: Resiliency**

**Impact: Medium**

**Recommendation/Guidance**

Using Azure SQL Database

Using ARM template to deploy a SQL AlwaysOn Cluster

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#dealing-with-database-failure)

<br><br>



### HPC-7 - HPC Pack - Dealing with Head node failure

**Category: Resiliency**

**Impact: Medium**

**Recommendation/Guidance**

Set up at least 2 head nodes in a cluster. With this configuration, any head node failure will result in moving the active HPC Service from this head node to another.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#dealing-with-head-node-failure)

<br><br>

### HPC-8 - HPC Pack - Dealing with AD failure

**Category: Resiliency**

**Impact: High**

**Recommendation/Guidance**

When HPC failed to connect to the Domain controller, admin and user will not be able to connect to the HPC Service thus not able to manage and submit jobs to the cluster. And new jobs will not be able started on the domain joined computer nodes as the NodeManager service failed to validate the job's credential. Thus you need consider below options:

Having a high available domain controller deployed with your HPC Pack Cluster in Azure

Using Azure AD Domain service. During cluster deployment, you could just join all your cluster nodes into this domain and you get the high available domain service from Azure.

Using HPC Pack Azure AD integration solution without having the cluster nodes joining any domain. Thus as long as the HPC Service has connectivity to the Azure AD service.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#dealing-with-ad-failure)

<br><br>
