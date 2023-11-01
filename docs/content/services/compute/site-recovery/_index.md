+++
title = "Azure site recovery"
description = "Best practices and resiliency recommendations for Azure Site recovery and associated resources."
date = "10/20/23"
author = "poven"
msAuthor = "poven"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure site recovery and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                     | Impact |  State  | ARG Query Available |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :-----------------: |
| [ASR-1 - Ensure static IP addresses configured in VM failover settings are available in the failover subnet](#asr-1---ensure-static-ip-addresses-configured-in-vm-failover-settings-are-available-in-the-failover-subnet)                                                                                                                          |  High  | Preview |         Yes         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ASR-1 - Ensure static IP addresses configured in VM failover settings are available in the failover subnet

**Category: Availability**

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
