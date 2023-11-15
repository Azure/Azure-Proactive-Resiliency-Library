+++
title = "Azure Virtual Desktop"
description = "Best practices and resiliency recommendations for Azure Virtual Desktop and associated resources and settings."
date = "11/15/23"
author = "yshafner"
msAuthor = "yonahshafner"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Virtual Desktop and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Resource Type                      |  Recommendation                                                 |  Impact         |  State            | ARG Query Available |
| :------------------------------ | :----------------------------------------------------------- | :------:        | :------:          |:-----------------: |
|Virtual Machines|  [VM-2 - Deploy VMs across Availability Zones ](#vm-2---deploy-vms-across-availability-zones)| High | Verified  |         Yes         |
|Virtual Machines | [VM-4 - Replicate VMs using Azure Site Recovery  ](#vm-4---replicate-vms-using-azure-site-recovery)| Medium | Verified  |         Yes          |
| Virtual Machines|  [VM-5 - Use Managed Disks for Virtual Machine disks](#vm-5---use-managed-disks-for-vm-disks)| High | Verified  |         Yes         |
| Virtual Machines               | [VM-7 - Enable Backups on your VMs](#vm-7---backup-vms-with-azure-backup-service)| Medium | Verified  |         Yes          |
| Virtual Machines    |  [VM-8 - Production VMs should be using SSD disks ](#vm-8---production-vms-should-be-using-ssd-disks)| High | Verified  |         Yes         |
|Virtual Machines  | [VM-10 - Accelerated Networking is not enabled](#vm-10---enable-accelerated-networking-accelnet)| Medium | Verified  |         Yes          |
| Virtual Machines|  [VM-11 - Accelerated Networking is enabled, make sure you update the GuestOS NIC driver every 6 months](#vm-11---when-accelnet-is-enabled-you-must-manually-update-the-guestos-nic-driver)| Low | Verified  |         Yes         |
| Virtual Machines| [ VM-12 - VMs should not have a Public IP directly associated](#vm-12---vms-should-not-have-a-public-ip-directly-associated)| Medium | Verified  |         Yes        |
| Virtual Machines |  [ VM-13 - Virtual Network Interfaces have an NSG associated](#vm-13---vm-network-interfaces-have-a-network-security-group-nsg-associated)| Low | Verified  |         Yes         |
|Virtual Machines| [VM-14 - IP Forwarding should only be enabled for Network Virtual Appliances](#vm-14---ip-forwarding-should-only-be-enabled-for-network-virtual-appliances)| Medium | Verified  |         Yes          |
|Virtual Machines  |  [VM-15 - Customer DNS Servers should be configured in the Virtual Network level ](#vm-15---dns-servers-should-be-configured-in-the-virtual-network-level)| Low | Verified  |         Yes         |
| Virtual Machines | [VM-17 - The Network access to the VM disk is set to “Enable Public access from all networks](#vm-17---network-access-to-the-vm-disk-should-be-set-to-disable-public-access-and-enable-private-access)| Low | Verified  |         Yes         |
| Virtual Machines |  [VM-18 - Virtual Machine is not compliant with Azure Policies  ](#vm-18---ensure-that-your-vms-are-compliant-with-azure-policies)| Low | Verified  |         Yes         |
| Virtual Machines   | [VM-19 - Enable disk encryption, Enable data at rest encryption by default ](#vm-19---enable-disk-encryption-and-data-at-rest-encryption-by-default)| Medium | Verified  |         Yes         |
| Virtual Machines  |  [VM-20 - Enable Insights to get more visibility into the health and performance of your virtual machine ](#vm-20---enable-vm-insights)| Low | Verified  |         Yes         |
|Virtual Machines | [VM-21 - Diagnostic Settings should be configured for all Azure Resources](#vm-21---configure-diagnostic-settings-for-all-azure-resources)| Low | Verified  |         Yes         |
| Compute Gallery  | [CG-1 - A minimum of three replicas should be kept for production image versions ](#cg-1---a-minimum-of-three-replicas-should-be-kept-for-production-image-versions)| Medium | Preview  |         Yes   |
|Compute Gallery  |  [CG-2 - Zone redundant storage should be used for image versions](#cg-2---zone-redundant-storage-should-be-used-for-image-versions)| Medium | Preview  |         Yes   |
|Compute Gallery | [CG-3 - Consider using hyper-V generation version 2 images where possible](#cg-3---consider-using-hyper-v-generation-version-2-images-where-possible)| Low | Preview  |         Yes   |
|Image Templates  |  [IT-1 - Use Generation 2 virtual machine source image](#it-1---use-generation-2-virtual-machine-source-image)| Low | Preview  |         Yes   |
|Image Templates | [IT-2 - Replicate your Image Templates to a secondary region](#it-2---replicate-your-image-templates-to-a-secondary-region)| Low | Preview  |         Yes   |
|Virtual Networks| [VNET-1 - All Subnets should have a Network Security Group associated](#vnet-1---all-subnets-should-have-a-network-security-group-associated)| Medium | Preview  |         Yes   |
|Virtual Networks|[VNET-3 - Use Private Link, when available, for shared Azure PaaS services](#vnet-3---when-available-use-private-endpoints-instead-of-service-endpoints-for-paas-services)| Medium | Preview  |         Yes   |
|Private Endpoints| [PEP-1 - Resolve issues with Private Endpoints in non Succeeded connection state](#pep-1---resolve-issues-with-private-endpoints-in-non-succeeded-connection-state)| Medium | Preview  |         Yes   |
|General Networking| [NW-4 - Eliminate all single points of failure from the data path both on-premises and hosted on Azure](#nw-4---eliminate-all-single-points-of-failure-from-the-data-path-both-on-premises-and-hosted-on-azure)| Medium | Preview  |   No   |
|Network Security Group |  [NSG-1 - Configure Diagnostic Settings for all Azure Resources](#nsg-1---configure-diagnostic-settings-for-all-azure-resources) | Medium | Preview  |         No   |
|Network Security Group | [NSG-2 - Monitor changes in Network Security Groups with Azure Monitor](#nsg-2---monitor-changes-in-network-security-groups-with-azure-monitor)  | Low | Preview  | No   |
|Network Security Group | [NSG-3 - Monitor changes in Network Security Groups with Azure Monitor](#nsg-3---configure-locks-for-network-security-groups-to-avoid-accidental-changes-andor-deletion) | Low | Preview  | No   |
|Network Security Group | [NSG-4 - Monitor changes in Network Security Groups with Azure Monitor](#nsg-4---configure-nsg-flow-logs) | Medium | Preview  |         Yes   |
|Network Security Group | [NSG-5 - Monitor changes in Network Security Groups with Azure Monitor](#nsg-5---the-nsg-only-has-default-security-rules-make-sure-to-configure-the-necessary-rules)| Medium | Preview  |         Yes   |
|Storage Account|[ST-1 - Ensure that storage account is redundant](#st-1---ensure-that-storage-account-is-redundant) | High | Preview  |   Yes|
|Storage Account| [ST-2 - Do not use classic storage account](#st-2---do-not-use-classic-storage-account)| High | Preview  |   Yes|
|Storage Account| [ST-3 - Ensure Performance tier is set as per workload](#st-3---ensure-performance-tier-is-set-as-per-workload)| Medium | Preview  |   Yes |
|Storage Account |  [ST-4 - Choose right storage account kind for workload](#st-4---choose-right-storage-account-kind-for-workload) | Medium | Preview  |   No |
|Storage Account | [ST-5 - Enable soft delete for recovery of data](#st-5---enable-soft-delete-for-recovery-of-data)  | Medium | Preview  |   Yes|
|Storage Account | [ST-6 - Enable version for accidental modification and keep the number of versions below 1000](#st-6---enable-version-for-accidental-modification-and-keep-the-number-of-versions-below-1000) | Medium | Preview  |   Yes|
|Storage Account | [ST-7 - Enable point and time restore for containers for recovery](#st-7---enable-point-and-time-restore-for-containers-for-recovery) | Low | Preview |         Yes        |
|Storage Account | [ST-8 - Configure Diagnostic Settings for all Azure Resources](#st-8---configure-diagnostic-settings-for-all-azure-resources) | Low | Preview |         Yes        |
|Azure NetApp Files|[ANF-1 - Enable Cross-region replication of Azure NetApp Files volumes](#anf-1---enable-cross-region-replication-of-azure-netapp-files-volumes) | High | Preview |    No    |
|Azure NetApp Files| [ANF-2 - Use availability zones for high availability in Azure NetApp Files](#anf-2---use-availability-zones-for-high-availability-in-azure-netapp-files)| High | Preview |    No    |
|Azure NetApp Files| [ANF-3 - Use the correct service level and volume quota size for the expected performance level](#anf-3---use-the-correct-service-level-and-volume-quota-size-for-the-expected-performance-level)| High | Preview |    No    |
|Azure NetApp Files|  [ANF-4 - Use standard network feature for Production in Azure NetApp Files](#anf-4---use-standard-network-feature-for-production-in-azure-netapp-files)  | High | Preview |    No    |
|Azure NetApp Files| [ANF-5 - Enable Cross-zone replication of Azure NetApp Files volumes](#anf-5---enable-cross-zone-replication-of-azure-netapp-files-volumes)   | High | Preview |    No    |
|Azure NetApp Files|  [ANF-6 - Use snapshot and backup for in-region data protection in Azure NetApp Files](#anf-6---use-snapshot-and-backup-for-in-region-data-protection-in-azure-netapp-files)  | High | Preview |    No    |
|Azure NetApp Files| [ANF-7 - Monitor Azure Netapp Files metric to better understand usage pattern and performance](#anf-7---monitor-azure-netapp-files-metric-to-better-understand-usage-pattern-and-performance)|High | Preview |    No    |
|Azure NetApp Files| [ANF-8 - Use Azure policy to enforce organizational standards and to assess compliance at-scale in Azure NetApp Files](#anf-8---use-azure-policy-to-enforce-organizational-standards-and-to-assess-compliance-at-scale-in-azure-netapp-files) | High | Preview |    No    |
|Azure Backup| [BK-1 - Migrate from classic alerts to built-in Azure Monitor alerts for Recovery services vaults](#bk-1---migrate-from-classic-alerts-to-built-in-azure-monitor-alerts-for-recovery-services-vaults) | Medium | Preview |    Yes      |
|Azure Site Recovery| [ASR-1 - Ensure static IP addresses configured in VM failover settings are available in the failover subnet](#asr-1---ensure-static-ip-addresses-configured-in-vm-failover-settings-are-available-in-the-failover-subnet) | High | Preview |    Yes    |


{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VM-2 - Deploy VMs across Availability Zones

**Category: Availability**

**Impact: High**

**Guidance**

Azure Availability Zones are physically separate locations within each Azure region that are tolerant to local failures. Use availability zones to protect your applications and data against unlikely datacenter failures.

**Resources**

- [Create virtual machines in an availability zone using the Azure portal](https://learn.microsoft.com/azure/virtual-machines/create-portal-availability-zone?tabs=standard)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-2/vm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-4 - Replicate VMs using Azure Site Recovery

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

When you replicate Azure VMs using Site Recovery, all the VM disks are continuously replicated to the target region asynchronously. The recovery points are created every few minutes. This gives you a Recovery Point Objective (RPO) in the order of minutes. You can conduct disaster recovery drills as many times as you want, without affecting the production application or the ongoing replication.

**Resources**

- [Resiliency checklist for Virtual Machines](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#virtual-machines)
- [Run a test failover (disaster recovery drill) to Azure](https://learn.microsoft.com/azure/site-recovery/site-recovery-test-failover-to-azure)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-4/vm-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-5 - Use Managed Disks for VM disks

**Category: Availability**

**Impact: High**

**Guidance**

Managed disks provide better reliability for VMs in an availability set, because the disks are sufficiently isolated from each other to avoid single points of failure. Also, managed disks aren't subject to the IOPS limits of VHDs created in a storage account.

**Resources**

- [Resiliency checklist for Virtual Machines](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#virtual-machines)
- [Availability options for Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/windows/manage-availability#use-managed-disks-for-vms-in-an-availability-set)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-5/vm-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-7 - Backup VMs with Azure Backup service

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Enable backups for your virtual machines to secure and quickly recover your data. The Azure Backup service provides simple, secure, and cost-effective solutions to back up your data and recover it from the Microsoft Azure cloud.

**Resources**

- [What is the Azure Backup service?](https://learn.microsoft.com/azure/backup/backup-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-7/vm-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-8 - Production VMs should be using SSD disks

**Category: System Efficiency**

**Impact: High**

**Guidance**

Premium SSD disks offer high-performance, low-latency disk support for I/O-intensive applications and production workloads. Standard SSD Disks are a cost-effective storage option optimized for workloads that need consistent performance at lower IOPS levels.

It is recommended that you:

- Use Standard HDD disks for Dev/Test scenarios and less critical workloads at lowest cost.
- Use Premium SSD disks instead of Standard HDD disks with your premium-capable VMs. For any Single Instance VM using premium storage for all Operating System Disks and Data Disks, Azure guarantees VM connectivity of at least 99.9%.

If you want to upgrade from Standard HDD to Premium SSD disks, consider the following issues:

- Upgrading requires a VM reboot and this process takes 3-5 minutes to complete.
- If VMs are mission-critical production VMs, evaluate the improved availability against the cost of premium disks.

**Resources**

- [Azure managed disk types](https://learn.microsoft.com/azure/virtual-machines/disks-types#premium-ssd)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-8/vm-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### VM-10 - Enable Accelerated Networking (AccelNet)

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Accelerated networking enables single root I/O virtualization (SR-IOV) to a VM, greatly improving its networking performance. This high-performance path bypasses the host from the data path, which reduces latency, jitter, and CPU utilization for the most demanding network workloads on supported VM types.

This configuration is not always required, evaluate this option according to the workload requirements.

**Resources**

- [Accelerated Networking (AccelNet) overview](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-10/vm-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-11 - When AccelNet is enabled, you must manually update the GuestOS NIC driver

**Category: Governance**

**Impact: Low**

**Guidance**

When Accelerated Networking is enabled the default Azure Virtual Network interface in the GuestOS is replaced for a Mellanox and consecutively its driver is provided from a 3rd party vendor. Marketplace images maintained by Microsoft are offered with the latest version of Mellanox drivers, however, once the Virtual Machine is deployed, the customer is responsible for maintaining the driver up to date.

**Resources**

- [Accelerated Networking (AccelNet) overview](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-11/vm-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-12 - VMs should not have a Public IP directly associated

**Category: Access & Security**

**Impact: Medium**

**Guidance**

If a Virtual Machine requires outbound internet connectivity we recommend the use of NAT Gateway or Azure Firewall, this will help to increase security and resiliency of the service as both services have much higher availability and SNAT ports. For inbound internet connectivity we recommend using a load balancing solution such as Azure Load Balancer and Application Gateway.

**Resources**

- [Use Source Network Address Translation (SNAT) for outbound connections](https://learn.microsoft.com/azure/load-balancer/load-balancer-outbound-connections)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-12/vm-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-13 - VM network interfaces have a Network Security Group (NSG) associated

**Category: Access & Security**

**Impact: Low**

**Guidance**

Unless you have a specific reason to, we recommend that you associate a network security group to a subnet, or a network interface, but not both. Since rules in a network security group associated to a subnet can conflict with rules in a network security group associated to a network interface, you can have unexpected communication problems that require troubleshooting.

**Resources**

- [How network security groups filter network traffic](https://learn.microsoft.com/azure/virtual-network/network-security-group-how-it-works#intra-subnet-traffic)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-13/vm-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-14 - IP Forwarding should only be enabled for Network Virtual Appliances

**Category: Access & Security**

**Impact: Medium**

**Guidance**

IP forwarding enables the virtual machine network interface to:

Receive network traffic not destined for one of the IP addresses assigned to any of the IP configurations assigned to the network interface.

Send network traffic with a different source IP address than the one assigned to one of a network interface's IP configurations.

The setting must be enabled for every network interface that is attached to the virtual machine that receives traffic that the virtual machine needs to forward. A virtual machine can forward traffic whether it has multiple network interfaces or a single network interface attached to it. While IP forwarding is an Azure setting, the virtual machine must also run an application able to forward the traffic, such as firewall, WAN optimization, and load balancing applications.

**Resources**

- [Enable or disable IP forwarding](https://learn.microsoft.com/azure/virtual-network/virtual-network-network-interface?tabs=network-interface-portal#enable-or-disable-ip-forwarding)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-14/vm-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-15 - DNS Servers should be configured in the Virtual Network level

**Category: Storage**

**Impact: Low**

**Guidance**

Configure the DNS Server in the Virtual Network to avoid inconsistency across the environment.

**Resources**

- [Name resolution for resources in Azure virtual networks](https://learn.microsoft.com/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-15/vm-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-17 - Network access to the VM disk should be set to "Disable public access and enable private access"

**Category: Access & Security**

**Impact: Low**

**Guidance**

Recommended changing to "Disable public access and enable private access" and creating a Private Endpoint

**Resources**

- [Restrict import/export access for managed disks using Azure Private Link](https://learn.microsoft.com/azure/virtual-machines/disks-enable-private-links-for-import-export-portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-17/vm-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-18 - Ensure that your VMs are compliant with Azure Policies

**Category: Governance**

**Impact: Low**

**Guidance**

It's important to keep your virtual machine (VM) secure for the applications that you run. Securing your VMs can include one or more Azure services and features that cover secure access to your VMs and secure storage of your data. This article provides information that enables you to keep your VM and applications secure.

**Resources**

- [Policy-driven governance](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance)
- [Azure Policy Regulatory Compliance controls for Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/security-policy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-18/vm-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-19 - Enable disk encryption and data at rest encryption by default

**Category: Access & Security**

**Impact: Medium**

**Guidance**

There are several types of encryption available for your managed disks, including Azure Disk Encryption (ADE), Server-Side Encryption (SSE) and encryption at host.

- Azure Disk Encryption helps protect and safeguard your data to meet your organizational security and compliance commitments.
- Azure Disk Storage Server-Side Encryption (also referred to as encryption-at-rest or Azure Storage encryption) automatically encrypts data stored on Azure managed disks (OS and data disks) when persisting on the Storage Clusters.
- Encryption at host ensures that data stored on the VM host hosting your VM is encrypted at rest and flows encrypted to the Storage clusters.
- Confidential disk encryption binds disk encryption keys to the virtual machine's TPM and makes the protected disk content accessible only to the VM.

**Resources**

- [Overview of managed disk encryption options](https://learn.microsoft.com/azure/virtual-machines/disk-encryption-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-19/vm-19.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-20 - Enable VM Insights

**Category:  Monitoring**

**Impact: Low**

**Guidance**

VM insights monitors the performance and health of your virtual machines and virtual machine scale sets. It monitors their running processes and dependencies on other resources. VM insights can help deliver predictable performance and availability of vital applications by identifying performance bottlenecks and network issues. It can also help you understand whether an issue is related to other dependencies.

**Resources**

- [Overview of VM insights](https://learn.microsoft.com/azure/azure-monitor/vm/vminsights-overview)
- [Did the extension install properly?](https://learn.microsoft.com/azure/azure-monitor/vm/vminsights-troubleshoot#did-the-extension-install-properly)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-20/vm-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-21 - Configure diagnostic settings for all Azure resources

**Category: Monitoring**

**Impact: Low**

**Guidance**

Platform metrics are sent automatically to Azure Monitor Metrics by default and without configuration.
Platform logs provide detailed diagnostic and auditing information for Azure resources and the Azure platform they depend on:

- Resource logs aren't collected until they're routed to a destination.
- Activity logs exist on their own but can be routed to other locations.

Each Azure resource requires its own diagnostic setting, which defines the following criteria:

- Sources: The type of metric and log data to send to the destinations defined in the setting. The available types vary by resource type.
- Destinations: One or more destinations to send to.

A single diagnostic setting can define no more than one of each of the destinations. If you want to send data to more than one of a particular destination type (for example, two different Log Analytics workspaces), create multiple settings. Each resource can have up to five diagnostic settings.

**Resources**

- [Diagnostic settings in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/diagnostic-settings?tabs=portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-21/vm-21.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CG-1 - A minimum of three replicas should be kept for production image versions

**Category: Availability**

**Impact: Medium**

**Guidance**

Keep a minimum of 3 replicas for production images.  In multi-VM deployment scenarios the VM deployments can be spread to different replicas reducing the chance of instance creation processing being throttled due to overloading of a single replica. For every 20 VMs that you create concurrently, we recommend you keep one replica. For example, if you create 1000 VMs concurrently, you should keep 50 replicas (you can have a maximum of 50 replicas per region). To update the replica count, please go to the gallery -> Image Definition -> Image Version -> Update replication.

**Resources**

- [Compute Gallery best practices](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery#best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cg-1/cg-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CG-2 - Zone redundant storage should be used for image versions

**Category: Availability**

**Impact: Medium**

**Guidance**

Use ZRS wherever available for high availability. You can configure ZRS in the replication tab when you create a version of the image or VM application. Azure Zone Redundant Storage (ZRS) provides resilience against an Availability Zone failure in the region. With the general availability of Azure Compute Gallery, you can choose to store your images in ZRS accounts in [regions with Availability Zones](https://learn.microsoft.com/en-us/azure/availability-zones/az-overview#azure-regions-with-availability-zones).
You can also choose the account type for each of the target regions. The default storage account type is Standard_LRS, but it is recommended to select Standard_ZRS for regions with Availability Zones.

**Resources**

- [Compute Gallery best practices](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery#best-practices)
- [Zone-redundant storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy#zone-redundant-storage)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cg-2/cg-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CG-3 - Consider using hyper-V generation version 2 images where possible

**Category: Availability**

**Impact: Low**

**Guidance**

We recommend that you create a generation 2 virtual machine to take advantage of features like Secure Boot, vTPM, trusted launch VMs, large boot volume. Your choice to create a generation 1 or generation 2 virtual machine depends on which guest operating system you want to install and the boot method you want to use to deploy the virtual machine. You can't change a virtual machine's generation after you've created it. So it is recommended to review the [considerations](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v#which-guest-operating-systems-are-supported) first.

**Resources**

- [Compute Gallery best practices](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery#best-practices)
- [Generation 1 vs Generation 2 in Hyper-V](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v)
- [Images in Compute gallery](https://learn.microsoft.com/en-us/azure/virtual-machines/shared-image-galleries?tabs=azure-cli)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cg-3/cg-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### IT-1 - Use Generation 2 virtual machine source image

**Impact: Availability**

**Impact: Low**

**Guidance**

When building your Image Templates, utilize source images that support generation 2 virtual machines. Generation 2 VMs support key features that aren't supported in generation 1 VMs.These features include increased memory, support for larger >2TB disks, it uses the new UEFI-based boot architecture rather than the BIOS-based architecture used by generation 1 VMs which can improve boot and installation times, Intel Software Guard Extensions (Intel SGX), and virtualized persistent memory (vPMEM).

**Resources**

- [Generation 1 vs generation 2 virtual machines](https://learn.microsoft.com/en-us/azure/virtual-machines/generation-2#features-and-capabilities)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/it-1/it-1.kql" >}} {{< /code >}}

{{< /collapse >}}
<br><br>

### IT-2 - Replicate your Image Templates to a secondary region

**Impact: Low**

**Guidance**

The Azure Image Builder service that is used to deploy Image Templates doesn't currently support availability zones. Therefore, when building your Image Templates, replicate them to a secondary region, preferably to your primary region's paired region. This will allow you to quickly recover from a region failure and continue to deploy virtual machines from your Image Templates.

**Resources**

- [Image Template resiliency](https://learn.microsoft.com/en-us/azure/reliability/reliability-image-builder?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json&bc=%2Fazure%2Fvirtual-machines%2Fbreadcrumb%2Ftoc.json#capacity-and-proactive-disaster-recovery-resiliency)
- [Azure Image Builder Supported Regions](https://learn.microsoft.com/en-us/azure/virtual-machines/image-builder-overview?tabs=azure-powershell#regions)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/it-2/it-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VNET-1 - All Subnets should have a Network Security Group associated

**Impact: High**

**Guidance**

Network security groups: Network security groups and application security groups can contain multiple inbound and outbound security rules that enable you to filter traffic to and from resources by source and destination IP address, port, and protocol. NSG's provide a security layer on Subnet level.

**Resources**

- [Azure Virtual Network - Concepts and best practices | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/concepts-and-best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vnet-1/vnet-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VNET-3 - When available, use Private Endpoints instead of Service Endpoints for PaaS Services

**Impact: Medium**

**Guidance**

Use virtual network service endpoints only when Private Link isn't available and there are no concerns with unauthorized movement of data. The VNet service endpoint feature (turning on VNet service endpoint on the network side and setting up appropriate VNet ACLs on the Azure service side) limits the Azure service access to the allowed VNet and subnet, thus providing a network level security and isolation of the Azure service traffic. All traffic using VNet service endpoints flows over Microsoft backbone, thus providing another layer of isolation from the public internet

**Resources**

- [Azure Virtual Network FAQ | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/virtual-networks-faq)
- [Reliability and Network connectivity - Microsoft Azure Well-Architected Framework | Microsoft LearnNetworking Reliability](https://learn.microsoft.com/azure/architecture/framework/services/networking/network-connectivity/reliability)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vnet-3/vnet-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### PEP-1 - Resolve issues with Private Endpoints in non Succeeded connection state

**Category: Networking**

**Impact: Medium**

**Guidance**

A private endpoint has two custom properties, static IP address and the network interface name. These properties must be set when the private endpoint is created. I the state is not in Succeeded state, there might be a problem with the private endpoint or with the associated resource.

**Resources**

- [Private endpoint connections](https://learn.microsoft.com/azure/private-link/manage-private-endpoint?tabs=manage-private-link-powershell#private-endpoint-connections)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/pep-1/pep-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NW-4 - Eliminate all single points of failure from the data path both on-premises and hosted on Azure

**Category: Networking**

**Impact: High**

**Guidance**

Single-instance Network Virtual Appliances (NVAs) introduce significant connectivity risk, whether deployed in Azure or within an on-premises datacenter.

**Resources**

- [Design requirements connectivity](https://learn.microsoft.com/en-us/azure/well-architected/resiliency/design-requirements#connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nw-4/nw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-1 - Configure Diagnostic Settings for all Azure Resources

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Resource Logs are not collected and stored until you create a diagnostic setting and route them to one or more locations.

**Resources**

- [Diagnostic settings in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/diagnostic-settings)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-1/nsg-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-2 - Monitor changes in Network Security Groups with Azure Monitor

**Category: Monitoring**

**Impact: Low**

**Guidance**

Create Alerts for administrative operations such as Create or Update Network Security Group rules with Azure Monitor to detect unauthorized/undesired changes to production resources, this alert can help identify undesired changes in the default security, such as attempts to by-pass firewalls or from accessing resources externally.

**Resources**

- [Azure Monitor activity log](https://learn.microsoft.com/azure/azure-monitor/essentials/activity-log?tabs=powershell)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-2/nsg-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-3 - Configure locks for Network Security Groups to avoid accidental changes and/or deletion

**Category: **

**Impact: Medium**

**Guidance**

As an administrator, you can lock an Azure subscription, resource group, or resource to protect them from accidental user deletions and modifications. The lock overrides any user permissions.
You can set locks that prevent either deletions or modifications. In the portal, these locks are called Delete and Read-only.

**Resources**

- [Lock your resources to protect your infrastructure](https://learn.microsoft.com/azure/azure-resource-manager/management/lock-resources?toc=%2Fazure%2Fvirtual-network%2Ftoc.json&tabs=json)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-3/nsg-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-4 - Configure NSG Flow Logs

**Category: Monitoring**

**Impact: Medium**

**Guidance**

It's vital to monitor, manage, and know your own network so that you can protect and optimize it. You need to know the current state of the network, who's connecting, and where users are connecting from. You also need to know which ports are open to the internet, what network behavior is expected, what network behavior is irregular, and when sudden rises in traffic happen.

Flow logs are the source of truth for all network activity in your cloud environment. Whether you're in a startup that's trying to optimize resources or a large enterprise that's trying to detect intrusion, flow logs can help. You can use them for optimizing network flows, monitoring throughput, verifying compliance, detecting intrusions, and more.

**Resources**

- [Flow logging for network security groups](https://learn.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-4/nsg-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-5 - The NSG only has Default Security Rules, make sure to configure the necessary rules

**Category: Access & Security**

**Impact: Medium**

**Guidance**

You can use an Azure network security group to filter network traffic between Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.

**Resources**

- [Security rules](https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview#security-rules)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-5/nsg-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-1 - Ensure that Storage Account is redundant

**Category: Availability**

**Impact: High**

**Guidance**

Data in an Azure Storage account is always replicated three times in the primary region. Azure Storage offers other options for how your data is replicated in the primary or paired region:

- LRS synchronously replicates data 3 times in single physical location. It is least expensive replication but not recommended for apps with high availability and durability. LRS provides eleven 9 durability.
- ZRS copies data synchronously across 3 availability zone in primary region. ZRS is recommended for apps requiring high availability across zones. ZRS provides twelve 9s durability.
- GRS replicate additional 3 copies to secondary region and provides sixteen 9s availability.
- GZRS provides both high availability and redundancy across geo replication. It provides sixteen 9s durability over a given year.

**Resources**

- [Azure Storage redundancy](https://learn.microsoft.com/azure/storage/common/storage-redundancy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-1/st-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-2 - Do not use classic Storage Account

**Category: Governance**

**Impact: High**

**Guidance**

Azure classic Storage Account will retire 31 august 2024. So migrate all workload from classic storage to v2.

**Resources**

- [storage account retirement announcement](https://azure.microsoft.com/updates/classic-azure-storage-accounts-will-be-retired-on-31-august-2024/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-2/st-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-3 - Ensure Performance tier is set as per workload

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Consider using appropriate storage performance tier for standard storage / block blob / append blob / file-share and page blob. Each workload scenario requires appropriate Performance tier and its important that based on the type of transaction and blob type/file type appropriate performance tier is selected. Failing to do so will create performance bottleneck.

**Resources**

- [Performance Tier](https://learn.microsoft.com/azure/storage/common/storage-account-overview#performance-tiers )

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-3/st-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-4 - Choose right storage account kind for workload

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Block blobs are optimized for uploading large amounts of data efficiently. Block blobs are composed of blocks, each of which is identified by a block ID. A block blob can include up to 50,000 blocks

**Resources**

- [Storage Account Kind docs](https://learn.microsoft.com/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs )

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/st-4/st-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-5 - Enable soft delete for recovery of data

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Soft delete option allow for recovering data if its deleted by mistaken. Moreover Lock will prevent accidentally deleting storage account.

**Resources**

- [Soft delete detail docs](https://learn.microsoft.com//azure/storage/blobs/soft-delete-blob-enable?tabs=azure-portal )

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/st-5/st-5.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-6 - Enable version for accidental modification and keep the number of versions below 1000

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

To recover data from accidental modification or deletion enable versioning.
Having a large number of versions per blob can increase the latency for blob listing operations. Microsoft recommends maintaining fewer than 1000 versions per blob. You can use lifecycle management to automatically delete old versions.

**Resources**

- [Blob versioning](https://learn.microsoft.com/azure/storage/blobs/versioning-overview )

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/st-6/st-6.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-7 - Enable point and time restore for containers for recovery

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

You can use point-in-time restore to restore one or more sets of block blobs to a previous state
Point and time restore support general purpose v2 account in standard performance tier. Its a mechanism to protect data

**Resources**

- [Restore overview](https://learn.microsoft.com/azure/storage/blobs/point-in-time-restore-manage?tabs=portal)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/st-7/st-7.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ST-8 - Configure Diagnostic Settings for all Azure Resources

**Category: Monitoring**

**Impact: Low**

**Guidance**

Enabling diagnostic settings allow you to capture and view diagnostic information so that you can troubleshoot any failures.

**Resources**

- [Diagnostic Setting for Storage Account](https://learn.microsoft.com/en-us/azure/storage/blobs/monitor-blob-storage)

**Script**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="/code/st-8/st-8.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-1 - Enable Cross-region replication of Azure NetApp Files volumes

**Category: Disaster Recovery/High Availability**

**Impact: High**

**Guidance**

The Azure NetApp Files replication functionality provides data protection through cross-region volume replication. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one region to another Azure NetApp Files volume (destination) in another region. This capability enables you to fail over your critical application if a region-wide outage or disaster happens.

**Resources**

- [Cross-zone replication of Azure NetApp Files volumes | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-netapp-files/cross-zone-replication-introduction)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-1/anf-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-2 - Use availability zones for high availability in Azure NetApp Files

**Category: High Availability**

**Impact: High**

**Guidance**

Azure availability zones are physically separate locations within each supporting Azure region that are tolerant to local failures. Failures can range from software and hardware failures to events such as earthquakes, floods, and fires. Tolerance to failures is achieved because of redundancy and logical isolation of Azure services. To ensure resiliency, a minimum of three separate availability zones are present in all availability zone-enabled regions.

**Resources**

- [Use availability zones for high availability in Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-netapp-files/use-availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-2/anf-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-3 - Use the correct service level and volume quota size for the expected performance level

**Category: System Efficiency**

**Impact: High**

**Guidance**

Service levels are an attribute of a capacity pool. Service levels are defined and differentiated by the allowed maximum throughput for a volume in the capacity pool based on the quota that is assigned to the volume.The throughput limit for a volume is determined by the combination of the following factors:

The service level of the capacity pool to which the volume belongs
The quota assigned to the volume
The QoS type (auto or manual) of the capacity pool

**Resources**

- [Service levels for Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-service-levels)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-3/anf-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-4 - Use standard network feature for Production in Azure NetApp Files

**Category: Networking**

**Impact: High**

**Guidance**

Standard network feature enables higher IP limits and standard VNet features such as network security groups and user-defined routes on delegated subnets, and additional connectivity patterns.
Please check the supported regions for standard network feature [here](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-network-topologies#supported-regions-for-standard-network-feature)

**Resources**

- [Guidelines for Azure NetApp Files network planning | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-network-topologies)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-4/anf-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-5 - Enable Cross-zone replication of Azure NetApp Files volumes

**Category: High Availability**

**Impact: High**

**Guidance**

The cross-zone replication (CZR) capability provides data protection between volumes in different availability zones. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one availability zone to another Azure NetApp Files volume (destination) in another availability. This capability enables you to fail over your critical application if a zone-wide outage or disaster happens.

**Resources**

- [Cross-zone replication of Azure NetApp Files volumes | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-netapp-files/cross-zone-replication-introduction)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-5/anf-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-6 - Use snapshot and backup for in-region data protection in Azure NetApp Files

**Category: High Availability**

**Impact: High**

**Guidance**

Azure NetApp Files snapshot technology delivers stability, scalability, and swift recoverability without impacting performance.
Azure NetApp Files supports a fully managed backup solution for long-term recovery, archive, and compliance. Backups can be restored to new volumes in the same region as the backup. Backups created by Azure NetApp Files are stored in Azure storage, independent of volume snapshots that are available for near-term recovery or cloning.

**Resources**

- [Snapshots](https://learn.microsoft.com/en-us/azure/azure-netapp-files/data-protection-disaster-recovery-options#snapshots)
- [Backup](https://learn.microsoft.com/en-us/azure/azure-netapp-files/data-protection-disaster-recovery-options#backups)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-6/anf-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-7 - Monitor Azure Netapp Files metric to better understand usage pattern and performance

**Category: Monitoring**

**Impact: High**

**Guidance**

Azure NetApp Files provides metrics on allocated storage, actual storage usage, volume IOPS, and latency. With these metrics, you can gain a better understanding on the usage pattern and volume performance of your NetApp accounts.

**Resources**

- [Ways to monitor Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-netapp-files/monitor-azure-netapp-files)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-7/anf-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-8 - Use Azure policy to enforce organizational standards and to assess compliance at-scale in Azure NetApp Files

**Category: Governance**

**Impact: High**

**Guidance**

The Azure Policy built-in definitions for Azure NetApp Files enable organization admins to restrict creation of unsecure volumes or audit existing volumes. Each policy definition in Azure Policy has a single effect. That effect determines what happens when the policy rule is evaluated to match.

The following effects of Azure Policy can be used with Azure NetApp Files:

Deny creation of non-compliant volumes
Audit existing volumes for compliance
Disable a policy definition

**Resources**

- [Azure Policy definitions for Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-policy-definitions)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-8/anf-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### BK-1 - Migrate from classic alerts to built-in Azure Monitor alerts for Recovery services vaults

**Category: Monitoring**

**Impact: Medium**

**Guidance**

On 31 March 2026, classic alerts for Recovery Services vaults in Azure Backup will be retired and no longer supported. Before that date, transition to built-in Azure monitor alerting solution.
Using Azure Monitor Alerts you can:

- Configure notifications to a wide range of notification channels.
- Enable notifications for selective scenarios.
- Monitor alerts at-scale via Backup center.
- Manage alerts and notifications programmatically.
- Consistent alert management for multiple Azure services, including backup.

**Resources**

- [Move to Azure monitor Alerts](https://learn.microsoft.com/en-us/azure/backup/move-to-azure-monitor-alerts)
- [Classic alerts retirement announcement](https://azure.microsoft.com/en-us/updates/transition-to-builtin-azure-monitor-alerts-for-recovery-services-vaults-in-azure-backup-by-31-march-2026/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/bk-1/bk-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

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


