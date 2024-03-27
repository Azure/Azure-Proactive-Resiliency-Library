+++
title = "Azure High Performance Computing"
description = "Best practices and resiliency recommendations for Azure High Performance Computing and associated resources and settings."
date = "1/12/24"
author = "ztrocinski"
msAuthor = "ztrocinski"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure High Performance Computing and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Impact | Design Area | State | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------: | :------: | :------: |
| [HPC-1 - Ensure File shares that stores jobs metadata are accessible from all head nodes](#hpc-1---ensure-file-shares-that-stores-jobs-metadata-are-accessible-from-all-head-nodes) | High | Application Resilience | Preview | No |
| [HPC-2 - Automatically grow and shrink HPC Pack cluster resources](#hpc-2---automatically-grow-and-shrink-hpc-pack-cluster-resources) | Medium | System Efficiency | Preview | No |
| [HPC-3 - Use multiple head nodes for HPC Pack](#hpc-3---use-multiple-head-nodes-for-hpc-pack) | Medium | Application Resilience | Preview | No |
| [HPC-4 - Use HPC Pack Azure AD Integration or other highly available AD configuration](#hpc-4---use-hpc-pack-azure-ad-integration-or-other-highly-available-ad-configuration) | High | Application Resilience | Preview | No |
| [BA-1 Monitor Batch account quota](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/batch/batch-accounts/#ba-1---monitor-batch-account-quota) | Medium | Monitoring | Preview | No |
| [BA-3 Create an Azure Batch pool across Availability Zones](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/batch/batch-accounts/#ba-3---create-an-azure-batch-pool-across-availability-zones) | High | Availability | Preview | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### HPC-1 - Ensure File shares that stores jobs metadata are accessible from all head nodes

**Category: Application Resilience**

**Impact: High**

**Recommendation/Guidance**

Currently in all HPC Pack ARM templates we create the cluster share on one of the head node which is not highly available. If that head node is down, the share will not be accessible to the HPC Service running on other head node.

With Azure Files, the following file shares can be moved to Azure Files shares with SMB permissions to make them highly available:

- `\\<HN3>\REMINST`
- `\\<HN3>\HpcServiceRegistration`
- `\\<HN3>\Runtime$`
- `\\<HN3>\TraceRepository`
- `\\<HN3>\Diagnostics`
- `\\<HN3>\CcpSpoolDir`

With above setup all nodes can access the file shares independent of the the head nodes

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#hpc-pack-cluster-shares)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-1/hpc-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-2 - Automatically grow and shrink HPC Pack cluster resources

**Category: System Efficiency**

**Impact: Medium**

**Recommendation/Guidance**

By deploying Azure "burst" nodes (both Windows and Linux) in your HPC Pack cluster or creating your HPC Pack cluster in Azure, you can automatically grow or shrink the cluster's resources such as nodes or cores according to the workload on the cluster. Scaling the cluster resources in this way allows you to execute jobs without any interruptions. In addition it helps using the resources efficiently.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-auto-grow-shrink?view=hpc19-ps)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-2/hpc-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-3 - Use multiple head nodes for HPC Pack

**Category: Application Resilience**

**Impact: Medium**

**Recommendation/Guidance**

Establish a cluster with a minimum of two head nodes. In the event of a head node failure, the active HPC Service will be automatically transferred from the affected head node to another functioning one.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#dealing-with-head-node-failure)

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-3/hpc-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### HPC-4 - Use HPC Pack Azure AD Integration or other highly available AD configuration

**Category: Application Resilience**

**Impact: High**

**Recommendation/Guidance**

When HPC failed to connect to the Domain controller, admin and user will not be able to connect to the HPC Service thus not able to manage and submit jobs to the cluster. And new jobs will not be able started on the domain joined computer nodes as the NodeManager service failed to validate the job's credential. Thus you need consider below options:

- Having a high available domain controller deployed with your HPC Pack Cluster in Azure

- Using Azure AD Domain service. During cluster deployment, you could just join all your cluster nodes into this domain and you get the high available domain service from Azure.

- Using HPC Pack Azure AD integration solution without having the cluster nodes joining any domain. Thus as long as the HPC Service has connectivity to the Azure AD service.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/powershell/high-performance-computing/hpcpack-ha-cloud?view=hpc19-ps#dealing-with-ad-failure)

<br><br>

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/hpc-4/hpc-4.kql" >}} {{< /code >}}

{{< /collapse >}}
