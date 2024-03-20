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

**Resource Graph Query**

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

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asr-2/asr-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
