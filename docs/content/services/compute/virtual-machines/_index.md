+++
title = "Virtual Machines"
description = "Best practices and resiliency recommendations for Virtual Machines and associated resources."
date = "3/30/23"
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented resiliency recommendations in this guidance include Virtual Machines, Virtual Machine Scale Sets, and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  ID   |        Resource Type         | Recommendation | Verified by Microsoft Product Group |
| :---: | :--------------------------: | :------------- | :---------------------------------: |
| vm01 | VirtualMachines | Avoid running a production workload on a single VM | No |
| vm02 | VirtualMachines | Deploy Virtual Machines across Availability Zones | No |
| vm03 | VirtualMachines | If Availability Zones are not available, then put each application tier into a separate Availability Set | No |
| vm04 | VirtualMachines | Replicate Virtual Machines using Azure Site Recovery | No |
| vm05 | VirtualMachines | Use Managed Disks for Virtual Machine hard disks | No |
| vm06 | VirtualMachines | Host application or database data on a data disk | No |
| vm07 | VirtualMachines | Enable Backups on your Virtual Machines | No |
| vm08 | VirtualMachines | Production VMs should be using Premium disks | No |
| vm09 | VirtualMachines | There are Virtual Machines in Stopped state | No |
| vm10 | VirtualMachines | Accelerated Networking is not enabled | No |
| vm11 | VirtualMachines | Accelerated Networking is enabled, make sure you update the GuestOS NIC driver every 6 months | No |
| vm12 | VirtualMachines | Virtual Machines should not have a Public IP directly associated | No |
| vm13 | VirtualMachines | Virtual Network Interfaces have an NSG associated | No |
| vm14 | VirtualMachines | IP Forwarding should only be enabled for Network Virtual Appliances | No |
| vm15 | VirtualMachines | Customer DNS Servers should be configured in the Virtual Network level | No |
| vm16 | VirtualMachines | Private IP Address should be configured as Static | No |
| vm17 | VirtualMachines | Shared disks should only be enabled in Clustered servers | No |
| vm18 | VirtualMachines | The Network access to the VM disk is set to "Enable Public access from all networks" | No |
| vm19 | VirtualMachines | Virtual Machine is not compliant with Azure Policies | No |
| vm20 | VirtualMachines | Enable disk encryption, Enable data at rest encryption by default | No |
| vm21 | VirtualMachines | Enable Insights to get more visibility into the health and performance of your virtual machine | No |
| vm22 | VirtualMachines | Diagnostic Settings should be configured for all Azure Resources | No |
| vm23 | VirtualMachines | Tags are inconsistent across Virtual Machines | No |
| vm24 | VirtualMachines | Tag shows incorrect value for the Availability Zone number for a Virtual Machine | No |
{{< /table >}}

## Recommendations Details

### VM01 - Avoid running a production workload on a single VM

#### Importance:
Critical
#### Recommendation/Guidance:
A single VM deployment is not resilient to planned or unplanned Azure maintenances. Instead, deploy multiple VMs in different Availability Zones, or put them into an Availability Set or Virtual Machine Scale Set, with a Load Balancer in front of them.
#### Resources:

- [https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines)

#### Queries/Scripts:

##### Azure Resource Graph:

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/vm-01.kql" >}} {{< /code >}}

{{< /collapse >}}

<br>

### VM02 - Deploy Virtual Machines across Availability Zones

#### Importance:
High
#### Recommendation/Guidance:
Azure availability zones are physically separate locations within each Azure region that are tolerant to local failures. Use availability zones to protect your applications and data against unlikely datacenter failures.
#### Resources:

- [https://learn.microsoft.com/en-us/azure/virtual-machines/create-portal-availability-zone](https://learn.microsoft.com/en-us/azure/virtual-machines/create-portal-availability-zone?tabs=standard)

#### Queries/Scripts:

##### Azure Resource Graph:

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/vm-01.kql" >}} {{< /code >}}

{{< /collapse >}}
