+++
title = "Azure High Performance Computing"
description = "Best practices and resiliency recommendations for Azure High Performance Computing and associated resources and settings."
date = "1/12/24"
author = "lapate"
msAuthor = "lapate"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure High Performance Computing and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  Recommendation                                   |      Impact         |  Design Area         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :------:          |
| [HPC-1 Monitor Batch account quota](#hpc-1---monitor-batch-account-quota)  | Medium |  Monitoring | Preview |       No        |
| [HPC-2 Ensure File shares that store jobs metadata are accessible from all head nodes](#hpc-2---ensure-file-shares-that-store-jobs-metadata-are-accessible-from-all-head-nodes)  | High |  Availability | Preview |       No        |
| [HPC-3 Create an Azure Batch pool across Availability Zones](#hpc-3---create-an-azure-batch-pool-across-availability-zones)  | Medium |  Availability | Preview |       No        |
| [HPC-4 Automatically grow and shrink HPC Pack cluster resources](#hpc-4---automatically-grow-and-shrink-hpc-pack-cluster-resources)  | Medium |  System Efficiency | Preview |       No        |
| [HPC-5 HPC Pack - Use multiple head nodes](#hpc-5---hpc-pack---use-multiple-head-nodes)  | Medium |  Availability | Preview |       No        |
| [HPC-6 Use HPC Pack Azure AD Integration or other highly available AD configuration](#hpc-6---use-hpc-pack-azure-ad-integration-or-other-highly-available-ad-configuration)  | High |  Availability | Preview |       No        |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### HPC-1 - Monitor Batch account quota

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

To enable Cross-region disaster recovery and business continuity, ensure that the appropriate quotas are set for all user subscription Batch accounts. This will allocate the required number of cores made available upfront. Without enough allocated cores capacity a job execution will be interrupted with operational errors indicating "Quota Reached".

Pre-create all required services in each region, such as the Batch account and the storage account. There's often no charge for having accounts created, and charges accrue only when the account is used or when data is stored.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/reliability/reliability-batch#cross-region-disaster-recovery-and-business-continuity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-1/hpc-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-2 - Ensure file shares that store jobs metadata are accessible from all head nodes

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Currently in all HPC Pack ARM templates we create the cluster share on one of the head nodes which is not highly available. If that head node is down, the share will not be accessible to the HPC Service running on the other head node.

With Azure Files, the following file shares can be moved to Azure Files shares with SMB permissions to make them highly available:

- `\\<HN3>\REMINST`
- `\\<HN3>\HpcServiceRegistration`
- `\\<HN3>\Runtime$`
- `\\<HN3>\TraceRepository`
- `\\<HN3>\Diagnostics`
- `\\<HN3>\CcpSpoolDir`

With the above setup, all nodes can access the file shares independently of the head nodes

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#hpc-pack-cluster-shares)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-2/hpc-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-3 - Create an Azure Batch pool across Availability Zones

**Category: Availability**

**Impact: Medium**

**Recommendation/Guidance**

When you create an Azure Batch pool using Virtual Machine Configuration, you can choose to provision your Batch pool across Availability Zones. Creating your pool with this zonal policy helps protect your Batch compute nodes from Azure datacenter-level failures.
For example, you could create your pool with zonal policy in an Azure region that supports three Availability Zones. If an Azure datacenter in one Availability Zone has an infrastructure failure, your Batch pool will still have healthy nodes in the other two Availability Zones, so the pool will remain available for task scheduling.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/batch/create-pool-availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-3/hpc-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-4 - Automatically grow and shrink HPC Pack cluster resources

**Category: System Efficiency**

**Impact: Medium**

**Recommendation/Guidance**

By deploying Azure "burst" nodes (both Windows and Linux) in your HPC Pack cluster or creating your HPC Pack cluster in Azure, you can automatically grow or shrink the cluster's resources such as nodes or cores according to the workload on the cluster. Scaling the cluster resources in this way allows you to execute jobs without any interruptions. In addition, it helps using the resources efficiently.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-auto-grow-shrink?view=hpc19-ps)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-4/hpc-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-5 - HPC Pack - Use multiple head nodes

**Category: Availability**

**Impact: Medium**

**Recommendation/Guidance**

Establish a cluster with a minimum of two head nodes. In the event of a head node failure, the active HPC Service will be automatically transferred from the affected head node to another functioning one.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#dealing-with-head-node-failure)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-5/hpc-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-6 - Use HPC Pack Azure AD Integration or other highly available AD configuration

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

When HPC fails to connect to the Domain Controller, admins and users will not be able to connect to the HPC Service thus not able to manage and submit jobs to the cluster. New jobs will not be able to start on the domain-joined computer nodes as the NodeManager service failed to validate the job's credentials. Thus you need to consider below options:

- Having a highly available domain controller deployed with your HPC Pack Cluster in Azure

- Using Azure AD Domain service. During cluster deployment, you could just join all your cluster nodes into this domain and you get the highly available domain service from Azure.

- Using HPC Pack Azure AD integration solution without having the cluster nodes join any domain. Thus as long as the HPC Service has connectivity to the Azure AD service.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#dealing-with-ad-failure)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-6/hpc-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
