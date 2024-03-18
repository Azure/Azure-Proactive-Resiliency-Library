+++
title = "Batch Accounts"
description = "Best practices and resiliency recommendations for Batch Accounts and associated resources and settings."
date = "1/12/24"
author = "lapate"
msAuthor = "lapate"
draft = false
+++

The presented resiliency recommendations in this guidance include Batch Accounts (Azure High Performance Computing) and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Impact | Design Area | State | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------|:------:|:------------:|:-------:|:-------------------:|
| [BA-1 Monitor Batch account quota](#ba-1---monitor-batch-account-quota) | Medium | Monitoring | Preview | No |
| [BA-3 Create an Azure Batch pool across Availability Zones](#ba-3---create-an-azure-batch-pool-across-availability-zones) | High | Availability | Preview | No |

{{< /table >}}

{{< alert style="info" >}}
Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})
{{< /alert >}}

## Recommendations Details

### BA-1 - Monitor Batch Account quota

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

To enable Cross-region disaster recovery and business continuity, ensure that the appropriate quotas are set for all user subscription Batch accounts. This will allocate the required number of cores made available upfront. Without enough allocated cores capacity a job execution will be interrupted with operational errors indicating "Quota Reached".

Pre-create all required services in each region, such as the Batch account and the storage account. There's often no charge for having accounts created, and charges accrue only when the account is used or when data is stored.

**Resources**

- [Learn More](https://learn.microsoft.com/azure/reliability/reliability-batch#cross-region-disaster-recovery-and-business-continuity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ba-1/ba-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### BA-3 - Create an Azure Batch pool across Availability Zones

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

When you create an Azure Batch pool using Virtual Machine Configuration, you can choose to provision your Batch pool across Availability Zones. Creating your pool with this zonal policy helps protect your Batch compute nodes from Azure datacenter-level failures.
For example, you could create your pool with zonal policy in an Azure region that supports three Availability Zones. If an Azure datacenter in one Availability Zone has an infrastructure failure, your Batch pool will still have healthy nodes in the other two Availability Zones, so the pool will remain available for task scheduling.

**Resources**

- [Learn More](https://learn.microsoft.com/azure/batch/create-pool-availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ba-3/ba-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
