+++
title = "Azure Site Recovery"
description = "Best practices and resiliency recommendations for Azure Site Recovery and associated resources."
date = "11/23/23"
author = "pesousa"
msAuthor = "pesousa"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Site Recovery and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                      |     Category      | Impact |  State  | ARG Query Available |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [ASR-1 - Ensure static IP addresses configured in VM failover settings are available in the failover subnet](#asr-1---ensure-static-ip-addresses-configured-in-vm-failover-settings-are-available-in-the-failover-subnet)           | Disaster Recovery |  High  | Preview |         No          |
| [ASR-2 - Perform a test failover to validate the functionality and performance of the VMs in the target location](#asr-2---perform-a-test-failover-to-validate-the-functionality-and-performance-of-the-vms-in-the-target-location) | Disaster Recovery |  High  | Preview |         Yes         |
| [ASR-3 - Monitor Source VMs for high data change rates](#asr-3---monitor-source-vms-for-high-data-change-rates) | Disaster Recovery |  High  | Preview |         Yes         |
| [ASR-4 - Ensure sufficient resource quotas in the target region](#asr-4---ensure-sufficient-resource-quotas-in-the-target-region) | Disaster Recovery |  High  | Preview |         Yes         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ASR-1 - Ensure static IP addresses configured in VM failover settings are available in the failover subnet

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Ensure static IP addresses configured in VM failover settings are available in the failover subnet. During failover if the target subnet has the same address space as source then the same static ip address is assigned to target VM provided it is available, otherwise the next available IP address in the target subnet is set as the target VM NIC address. You can modify the target IP address in the Network settings of the VM.

**Resources**

- [Setup network mapping for site recovery](https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-network-mapping#set-up-ip-addressing-for-target-vms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asr-1/asr-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ASR-2 - Perform a test failover to validate the functionality and performance of the VMs in the target location

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Perform a test failover to validate your BCDR strategy and ensure that your applications are functioning correctly in the target region. This can be done without impacting your production environment.
Test your Disaster Recovery plan periodically without any data loss or downtime, using test failovers.

**Resources**

- [Run a test failover](https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-dr-drill#run-a-test-failover)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asr-2/asr-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ASR-3 - Monitor source VMs for high data change rates

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Azure Site Recovery has limits on data change rates, depending on the type of disk. To determine if this is a recurring or temporary problem, find the data change rate of the affected virtual machine. Go to the source virtual machine and monitor the **OS Disk Write Bytes/Sec** and **Data Disk Write Bytes/Sec** metrics for OS and Data disks.

For a single VM, Site Recovery can handle 5 MB/s of churn per disk with a maximum of five such disks. Site Recovery has a limit of 54 MB/s of total churn per VM. Alternatively enable High Churn Support to support churn up to 100 MB/s per VM.

**Resources**

- [High data change rate on the source virtual machine](https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-troubleshoot-replication#high-data-change-rate-on-the-source-virtual-machine)

- [Azure VM Disaster Recovery - High Churn Support](https://learn.microsoft.com/en-us/azure/site-recovery/concepts-azure-to-azure-high-churn-support)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asr-3/asr-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ASR-4 - Ensure sufficient resource quotas in the target region

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Make sure your subscription is enabled to create Azure VMs in the target region that you plan to use as your disaster recovery (DR) region. Your subscription needs sufficient quota to create VMs of the necessary sizes. By default, Site Recovery chooses a target VM size that's the same as the source VM size.

If the target location has a capacity constraint, disable replication to that location. Then, enable replication to a different location where your subscription has sufficient quota to create VMs of the required sizes.

**Resources**

- [Azure resource quota issues](https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-troubleshoot-errors#azure-resource-quota-issues-error-code-150097)

<br><br>



