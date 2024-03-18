+++
title = "Virtual Machines"
description = "Best practices and resiliency recommendations for Virtual Machines and associated resources."
date = "3/30/23"
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented resiliency recommendations in this guidance include Virtual Machines and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Category | Impact | State | ARG Query Available |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------:|:------:|:--------:|:-------------------:|
| [VM-1 - Run production workloads on two or more VMs using VMSS Flex](#vm-1---run-production-workloads-on-two-or-more-vms-using-vmss-flex) | Availability | High | Verified | Yes |
| [VM-2 - Deploy VMs across Availability Zones](#vm-2---deploy-vms-across-availability-zones) | Availability | High | Verified | Yes |
| [VM-3 - Migrate VMs using availability sets to VMSS Flex](#vm-3---migrate-vms-using-availability-sets-to-vmss-flex) | Availability | High | Verified | Yes |
| [VM-4 - Replicate VMs using Azure Site Recovery](#vm-4---replicate-vms-using-azure-site-recovery) | Disaster Recovery | Medium | Verified | Yes |
| [VM-5 - Use Managed Disks for Virtual Machine disks](#vm-5---use-managed-disks-for-vm-disks) | Availability | High | Verified | Yes |
| [VM-6 - Host application or database data on a data disk](#vm-6---host-application-or-database-data-on-a-data-disk) | System Efficiency | Low | Verified | Yes |
| [VM-7 - Enable Backups on your VMs](#vm-7---backup-vms-with-azure-backup-service) | Disaster Recovery | Medium | Verified | Yes |
| [VM-8 - Production VMs should be using SSD disks](#vm-8---production-vms-should-be-using-ssd-disks) | System Efficiency | High | Verified | Yes |
| [VM-9 - There are VMs in Stopped state](#vm-9---review-vms-in-stopped-state) | Governance | Low | Verified | Yes |
| [VM-10 - Accelerated Networking is not enabled](#vm-10---enable-accelerated-networking-accelnet) | System Efficiency | Medium | Verified | Yes |
| [VM-11 - Accelerated Networking is enabled, make sure you update the GuestOS NIC driver every 6 months](#vm-11---when-accelnet-is-enabled-you-must-manually-update-the-guestos-nic-driver) | Governance | Low | Verified | No |
| [VM-12 - VMs should not have a Public IP directly associated](#vm-12---vms-should-not-have-a-public-ip-directly-associated) | Access & Security | Medium | Verified | Yes |
| [VM-13 - VM network interfaces and associated subnets both have a Network Security Group (NSG) associated](#vm-13---vm-network-interfaces-and-associated-subnets-both-have-a-network-security-group-nsg-associated) | Access & Security | Low | Verified | No |
| [VM-14 - IP Forwarding should only be enabled for Network Virtual Appliances](#vm-14---ip-forwarding-should-only-be-enabled-for-network-virtual-appliances) | Access & Security | Medium | Verified | Yes |
| [VM-15 - Customer DNS Servers should be configured in the Virtual Network level](#vm-15---customer-dns-servers-should-be-configured-in-the-virtual-network-level) | Networking | Low | Verified | Yes |
| [VM-16 - Shared disks should only be enabled in Clustered servers](#vm-16---shared-disks-should-only-be-enabled-in-clustered-servers) | Storage | Medium | Verified | Yes |
| [VM-17 - The Network access to the VM disk is set to Enable Public access from all networks](#vm-17---network-access-to-the-vm-disk-should-be-set-to-disable-public-access-and-enable-private-access) | Access & Security | Low | Verified | Yes |
| [VM-18 - Virtual Machine is not compliant with Azure Policies](#vm-18---ensure-that-your-vms-are-compliant-with-azure-policies) | Governance | Low | Verified | Yes |
| [VM-19 - Enable disk encryption, Enable data at rest encryption by default](#vm-19---enable-disk-encryption-and-data-at-rest-encryption-by-default) | Access & Security | Medium | Verified | Yes |
| [VM-20 - Enable Insights to get more visibility into the health and performance of your virtual machine](#vm-20---enable-vm-insights) | Monitoring | Low | Verified | Yes |
| [VM-21 - Configure diagnostic settings for all Azure Virtual Machines](#vm-21---configure-diagnostic-settings-for-all-azure-virtual-machines) | Monitoring | Low | Preview | Yes |
| [VM-22 - Use maintenance configurations for the Virtual Machine](#vm-22---use-maintenance-configurations-for-the-vms) | Governance | High | Preview | Yes |
| [VM-23 - Avoid using A or B-Series VM Sku for production VMs that need the full performance of the CPU continuously](#vm-23---avoid-using-a-or-b-series-vm-sku-for-production-vms-that-need-the-full-performance-of-the-cpu-continuously) | System Efficiency | High | Preview | Yes |
| [VM-24 - Mission Critical Workloads should be using Premium or Ultra Disks](#vm-24---mission-critical-workloads-should-be-using-premium-or-ultra-disks) | System Efficiency | High | Preview | Yes |
| [VM-25 - Do not create more than 2500 Citrix VDA servers per subscription](#vm-25---do-not-create-more-than-2500-citrix-vda-servers-per-subscription) | Application Resiliency | High | Preview | Yes |
| [VM-26 - Ensure all VMs part of a SQL Always-on cluster have the same specifications and configurations](#vm-26---ensure-all-vms-part-of-a-sql-always-on-cluster-have-the-same-specifications-and-configurations) | Application Resiliency | High | Preview | No |
| [VM-27 - Use Azure Boost VMs for Maintenance sensitive workload](#vm-27---use-azure-boost-vms-for-maintenance-sensitive-workload) | Availability | Medium | Preview | No |
| [VM-28 - Enable Scheduled Events for Maintenance sensitive workload VMs](#vm-28---enable-scheduled-events-for-maintenance-sensitive-workload-vms) | Availability | Medium | Preview | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VM-1 - Run production workloads on two or more VMs using VMSS Flex

**Category: Availability**

**Impact: High**

**Guidance**

Production VM workloads should be deployed on multiple VMs and grouped together in a VMSS Flex instance. VMSS Flex intelligently distributes VMs across the platform to minimize the impact of platform faults and platform updates on a workload. A workload running on single instance VMs, even when those instances are spread across availability zones, cannot receive the same protection because the platform has no way of knowing the VMs are related to each other.

**Resources**

- [What has changed with Flexible orchestration mode](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#what-has-changed-with-flexible-orchestration-mode)
- [Attach or detach a Virtual Machine to or from a Virtual Machine Scale Set](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-attach-detach-vm?branch=main&tabs=portal-1%2Cportal-2%2Cportal-3)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-1/vm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

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

### VM-3 - Migrate VMs using availability sets to VMSS Flex

**Category: Availability**

**Impact: High**

**Guidance**

Availability sets will be retired in the near future. Modernize your workloads by migrating them from VMs to VMSS Flex. With VMSS Flex, you can deploy your VMs in one of two ways:

. Across zones
. In the same zone, but across fault domains (FDs) and update domains (UD) automatically.

In an N-tier application, it's recommended that you place each application tier into its own VMSS Flex.

**Resources**

- [Resiliency checklist for Virtual Machines](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#virtual-machines)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-3/vm-3.kql" >}} {{< /code >}}

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

### VM-6 - Host application or database data on a data disk

**Category: System Efficiency**

**Impact: Low**

**Guidance**

A data disk is a managed disk that's attached to a virtual machine to store application data, or other data you need to keep. Data disks are registered as SCSI drives and are labeled with a letter that you choose. Hosting you data on a data disk also helps with flexibility when backuping or restoring data, as well as migrating the disk without having to migrate the entire Virtual Machine and Operating System. You will be able to also select a different disk sku, with different type, size, and performance that meet your requirements.

**Resources**

- [Introduction to Azure managed disks - Data disks](https://learn.microsoft.com/azure/virtual-machines/managed-disks-overview#data-disk)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-6/vm-6.kql" >}} {{< /code >}}

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

### VM-9 - Review VMs in stopped state

**Category: Governance**

**Impact: Low**

**Guidance**

Azure Virtual Machines (VM) instances go through different states. There are provisioning and power states. If a Virtual Machine is not running that indicates the Virtual Machine might facing an issue or is no longer necessary and could be removed helping to reduce costs.

**Resources**

- [States and billing status of Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/states-billing?context=%2Ftroubleshoot%2Fazure%2Fvirtual-machines%2Fcontext%2Fcontext#power-states-and-billing)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-9/vm-9.kql" >}} {{< /code >}}

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

### VM-13 - VM network interfaces and associated subnets both have a Network Security Group (NSG) associated

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

### VM-15 - Customer DNS Servers should be configured in the Virtual Network level

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

### VM-16 - Shared disks should only be enabled in clustered servers

**Category: Storage**

**Impact: Medium**

**Guidance**

Azure shared disks is a feature for Azure managed disks that enables you to attach a managed disk to multiple virtual machines (VMs) simultaneously. Attaching a managed disk to multiple VMs allows you to either deploy new or migrate existing clustered applications to Azure, and should only be used in those situations where the disk will be assigned to more than one Virtual Machine member of a Cluster.

**Resources**

- [Azure Shared Disks](https://learn.microsoft.com/azure/virtual-machines/disks-shared-enable?tabs=azure-portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-16/vm-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-17 - Network access to the VM disk should be set to Disable public access and enable private access

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

**Category: Monitoring**

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

### VM-21 - Configure diagnostic settings for all Azure Virtual Machines

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

### VM-22 - Use maintenance configurations for the VMs

**Category: Governance**

**Impact: High**

**Guidance**

The maintenance configuration settings allows user to schedule and manage updates, ensuring the VM updates/interruptions are done in planned timeframe.

**Resources**

- [Use maintenance configurations to control and manage the VM updates](https://learn.microsoft.com/azure/virtual-machines/maintenance-configurations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-22/vm-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-23 - Avoid using A or B-Series VM Sku for production VMs that need the full performance of the CPU continuously

**Category: System Efficiency**

**Impact: High**

**Guidance**

A-series VMs have CPU performance and memory configurations best suited for entry level workloads like development and test. Some example use cases include development and test servers, low traffic web servers, small to medium databases, proof-of-concepts, and code repositories.

B-series VMs are ideal for workloads that do not need the full performance of the CPU continuously, like web servers, proof of concepts, small databases and development build environments. These workloads typically have burstable performance requirements. To determine the physical hardware on which this size is deployed, query the virtual hardware from within the virtual machine. The B-series provides you with the ability to purchase a VM size with baseline performance that can build up credits when it is using less than its baseline. When the VM has accumulated credits, the VM can burst above the baseline using up to 100% of the vCPU when your application requires higher CPU performance. Upon consuming all the CPU credits, a B-series virtual machine is throttled back to its base CPU performance until it accumulates the credits to CPU burst again.

**Resources**

- [B-series burstable virtual machine sizes](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes-b-series-burstable)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-23/vm-23.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-24 - Mission Critical Workloads should be using Premium or Ultra Disks

**Category: System Efficiency**

**Impact: High**

**Guidance**

Azure Premium SSDs deliver high-performance and low-latency disk support for virtual machines (VMs) with input/output (IO)-intensive workloads.

Premium SSD v2 offers higher performance than Premium SSDs while also generally being less costly. You can individually tweak the performance (capacity, throughput, and IOPS) of Premium SSD v2 disks at any time, allowing workloads to be cost efficient while meeting shifting performance needs. You should use Premium solid-state drives (SSDs) as operating system (OS) disks as the V2 is not supported as OS Disk.

Azure ultra disks are the highest-performing storage option for Azure virtual machines (VMs). You can change the performance parameters of an ultra disk without having to restart your VMs. Ultra disks are suited for data-intensive workloads such as SAP HANA, top-tier databases, and transaction-heavy workloads. Ultra disks must be used as data disks and can only be created as empty disks. You should use Premium solid-state drives (SSDs) as operating system (OS) disks.

**Resources**

- [Disk type comparison and decision tree](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types#disk-type-comparison)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-24/vm-24.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-25 - Do not create more than 2500 Citrix VDA servers per subscription

**Category: Application Resilience**

**Impact: High**

**Guidance**

A Citrix Managed Azure subscription supports the number of machines indicated in Limits. (In this context, machines refers to VMs that have a Citrix VDA installed. These machines deliver apps and desktops to users. It does not include other machines in a resource location, such as Cloud Connectors.)

If your Citrix Managed Azure subscription is likely to reach its limit soon, and you have enough Citrix licenses, you can request another Citrix Managed Azure subscription. The dashboard contains a notification when you’re close to the limit.

You can’t create a catalog (or add machines to a catalog) if the total number of machines for all catalogs that use that Citrix Managed Azure subscription would exceed the value indicated in Limits.

**Resources**

- [Citrix Limits](https://docs.citrix.com/en-us/citrix-daas-azure/limits)
- [Citrix Managed Azure subscriptions](https://docs.citrix.com/en-us/citrix-daas-azure/limits)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-25/vm-25.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-26 - Ensure all VMs part of a SQL Always-on cluster have the same specifications and configurations

**Category: Availability**

**Impact: High**

**Guidance**

All VMs that are members or a SQL Always-on cluster must use the same VM Sku, same number of data disks, same disks Skus, same number of Network Interfaces, same VM Extensions, etc.

**Resources**

- [Prerequisites, restrictions, and recommendations for Always On availability groups](https://learn.microsoft.com/en-us/sql/database-engine/availability-groups/windows/prereqs-restrictions-recommendations-always-on-availability?view=sql-server-ver16)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-26/vm-26.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-27 - Use Azure Boost VMs for Maintenance sensitive workload

**Category: Availability**

**Impact: Medium**

**Guidance**

If the workload is Maintenance sensitive, please consider using Azure Boost compatible VMs. Azure Boost is designed to lessen the impact on customers when Azure maintenance activities occur.

**Resources**

- [Microsoft Azure Boost](https://learn.microsoft.com/azure/azure-boost/overview)
- [Announcing the general availability of Azure Boost](https://aka.ms/AzureBoostGABlog)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-27/vm-27.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-28 - Enable Scheduled Events for Maintenance sensitive workload VMs

**Category: Availability**

**Impact: Medium**

**Guidance**

If the workload is Maintenance sensitive, please enable Scheduled Events. Scheduled Events is an Azure Metadata Service that gives your application time to prepare for virtual machine maintenance. It provides information about upcoming maintenance events (for example, reboot) so that your application can prepare for them and limit disruption. It's available for all Azure Virtual Machines types, including PaaS and IaaS on both Windows and Linux.

**Resources**

- [Monitor scheduled events for your Azure VMs](https://learn.microsoft.com/azure/virtual-machines/windows/scheduled-event-service)
- [Azure Metadata Service: Scheduled Events for Linux VMs](https://learn.microsoft.com/azure/virtual-machines/linux/scheduled-events)
- [Azure Metadata Service: Scheduled Events for Windows VMs](https://learn.microsoft.com/azure/virtual-machines/windows/scheduled-events)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-28/vm-28.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
