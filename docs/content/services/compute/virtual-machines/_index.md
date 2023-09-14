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
| Recommendation                                                                                                                                                                                                                     | Impact |  State  | ARG Query Available |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :-----------------: |
| [VM-1 - Run production workloads on two or more VMs](#vm-1---run-production-workloads-on-two-or-more-vms)                                                                                                                          |  High  | Preview |         Yes         |
| [VM-2 - Deploy Virtual Machines across Availability Zones](#vm-2---deploy-virtual-machines-across-availability-zones)                                                                                                              |  High  | Preview |         Yes         |
| [VM-3 - If AvailabilitySet is required, then put each application tier into a separate Availability Set](#vm-3---if-availabilityset-is-required-then-put-each-application-tier-into-a-separate-availabilityset)                    |  High  | Preview |         Yes         |
| [VM-4 - Replicate Virtual Machines using Azure Site Recovery](#vm-4---replicate-virtual-machines-using-azure-site-recovery)                                                                                                        | Medium | Preview |         Yes         |
| [VM-5 - Use Managed Disks for Virtual Machine disks](#vm-5---use-managed-disks-for-virtual-machine-disks)                                                                                                                |  High  | Preview |         Yes         |
| [VM-6 - Host application or database data on a data disk](#vm-6---host-application-or-database-data-on-a-data-disk)                                                                                                                |  Low   | Preview |         Yes         |
| [VM-7 - Enable Backups on your Virtual Machines](#vm-7---enable-backups-on-your-virtual-machines)                                                                                                                                  | Medium | Preview |         Yes         |
| [VM-8 - Production VMs should be using SSD disks](#vm-8---production-vms-should-be-using-ssd-disks)                                                                                                                        |  High  | Preview |         Yes         |
| [VM-9 - There are Virtual Machines in Stopped state](#vm-9---there-are-virtual-machines-in-stopped-state)                                                                                                                          |  Low   | Preview |         Yes         |
| [VM-10 - Accelerated Networking is not enabled](#vm-10---accelerated-networking-is-not-enabled)                                                                                                                                    | Medium | Preview |         Yes          |
| [VM-11 - Accelerated Networking is enabled, make sure you update the GuestOS NIC driver every 6 months](#vm-11---accelerated-networking-is-enabled-make-sure-you-update-the-guestos-nic-driver-every-6-months)                     |  Low   | Preview |         Yes         |
| [VM-12 - Virtual Machines should not have a Public IP directly associated](#vm-12---virtual-machines-should-not-have-a-public-ip-directly-associated)                                                                              | Medium | Preview |         Yes          |
| [VM-13 - Virtual Network Interfaces have an NSG associated](#vm-13---virtual-network-interfaces-have-an-nsg-associated)                                                                                                            |  Low   | Preview |         Yes          |
| [VM-14 - IP Forwarding should only be enabled for Network Virtual Appliances](#vm-14---ip-forwarding-should-only-be-enabled-for-network-virtual-appliances)                                                                        | Medium | Preview |         Yes          |
| [VM-15 - Customer DNS Servers should be configured in the Virtual Network level](#vm-15---customer-dns-servers-should-be-configured-in-the-virtual-network-level)                                                                  |  Low   | Preview |         Yes          |
| [VM-16 - Shared disks should only be enabled in Clustered servers](#vm-16---shared-disks-should-only-be-enabled-in-clustered-servers)                                                                                              | Medium | Preview |         Yes          |
| [VM-17 - The Network access to the VM disk is set to "Enable Public access from all networks"](#vm-17---the-network-access-to-the-vm-disk-is-set-to-enable-public-access-from-all-networks)                                        |  Low   | Preview |         Yes          |
| [VM-18 - Virtual Machine is not compliant with Azure Policies](#vm-18---virtual-machine-is-not-compliant-with-azure-policies)                                                                                                      |  Low   | Preview |         Yes          |
| [VM-19 - Enable disk encryption, Enable data at rest encryption by default](#vm-19---enable-disk-encryption-enable-data-at-rest-encryption-by-default)                                                                             | Medium | Preview |         No          |
| [VM-20 - Enable Insights to get more visibility into the health and performance of your virtual machine](#vm-20---enable-insights-to-get-more-visibility-into-the-health-and-performance-of-your-virtual-machine)                  |  Low   | Preview |         No          |
| [VM-21 - Diagnostic Settings should be configured for all Azure Resources](#vm-21---diagnostic-settings-should-be-configured-for-all-azure-resources)                                                                              |  Low   | Preview |         No          |
| [VM-22 - Use maintenance configurations for the Virtual Machine](#vm-22---use-maintenance-configurations-for-the-virtual-machine) | High | Preview | Yes |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VM-1 - Run production workloads on two or more VMs

**Impact: High**

**Recommendation/Guidance**

To safeguard application workloads from downtime due to the temporary unavailability of a disk or VM, customers can use availability sets. Two or more virtual machines in an availability set provide redundancy for the application. Azure then creates these VMs and disks in separate fault domains with different power, network, and server components. Then, deploy multiple VMs in different Availability Zones, or put them into an Availability Set or Virtual Machine Scale Set, with a Load Balancer in front of them.

**Resources**

- [Resiliency checklist for Virtual Machines](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#virtual-machines)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-1/vm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-2 - Deploy Virtual Machines across Availability Zones

**Impact: High**

**Recommendation/Guidance**

Azure Availability Zones are physically separate locations within each Azure region that are tolerant to local failures. Use availability zones to protect your applications and data against unlikely datacenter failures.

**Resources**

- [Create virtual machines in an availability zone using the Azure portal](https://learn.microsoft.com/azure/virtual-machines/create-portal-availability-zone?tabs=standard)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-2/vm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-3 - If AvailabilitySet is required, then put each application tier into a separate AvailabilitySet

**Impact: High**

**Recommendation/Guidance**

If the region where you are running your application doesn't support Availablity Zones, then put your VMs into an Availability Set. In an N-tier application, don't put VMs from different tiers into the same availability set. VMs in an availability set are placed across fault domains (FDs) and update domains (UD). However, to get the redundancy benefit of FDs and UDs, every VM in the availability set must be able to handle the same client requests.

**Resources**

- [Resiliency checklist for Virtual Machines](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#virtual-machines)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-3/vm-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-4 - Replicate Virtual Machines using Azure Site Recovery

**Impact: Medium**

**Recommendation/Guidance**

When you replicate Azure VMs using Site Recovery, all the VM disks are continuously replicated to the target region asynchronously. The recovery points are created every few minutes. This gives you a Recovery Point Objective (RPO) in the order of minutes. You can conduct disaster recovery drills as many times as you want, without affecting the production application or the ongoing replication.

**Resources**

- [Resiliency checklist for Virtual Machines](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#virtual-machines)
- [Run a test failover (disaster recovery drill) to Azure](https://learn.microsoft.com/azure/site-recovery/site-recovery-test-failover-to-azure)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-4/vm-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-5 - Use Managed Disks for Virtual Machine disks

**Impact: High**

**Recommendation/Guidance**

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

**Impact: Low**

**Recommendation/Guidance**

A data disk is a managed disk that's attached to a virtual machine to store application data, or other data you need to keep. Data disks are registered as SCSI drives and are labeled with a letter that you choose. Hosting you data on a data disk also helps with flexibility when backuping or restoring data, as well as migrating the disk without having to migrate the entire Virtual Machine and Operating System. You will be able to also select a different disk sku, with different type, size, and performance that meet your requirements.

**Resources**

- [Introduction to Azure managed disks - Data disks](https://learn.microsoft.com/azure/virtual-machines/managed-disks-overview#data-disk)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-6/vm-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-7 - Enable Backups on your Virtual Machines

**Impact: Medium**

**Recommendation/Guidance**

Enable backups for your virtual machines and secure your data

**Resources**

- [What is the Azure Backup service?](https://learn.microsoft.com/azure/backup/backup-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-7/vm-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-8 - Production VMs should be using SSD disks

**Impact: High**

**Recommendation/Guidance**

We have identified that you are using standard hard disks with your premium-capable Virtual Machines and we recommend you consider upgrading the standard-hdd disks to standard-ssd or premium disks. For any Single Instance Virtual Machine using premium storage for all Operating System Disks and Data Disks, we guarantee you will have Virtual Machine Connectivity of at least 99.9%. Consider these factors when making your upgrade decision. The first is that upgrading requires a VM reboot and this process takes 3-5 minutes to complete. The second is if the VMs in the list are mission-critical production VMs, evaluate the improved availability against the cost of premium disks.

Premium SSD disks offer high-performance, low-latency disk support for I/O-intensive applications and production workloads. Standard SSD Disks are a cost effective storage option optimized for workloads that need consistent performance at lower IOPS levels. Use Standard HDD disks for Dev/Test scenarios and less critical workloads at lowest cost.

Standard SSDs are acceptable for some Production workloads as well. Please refer to the reference link for more information.

**Resources**

- [Azure managed disk types](https://learn.microsoft.com/azure/virtual-machines/disks-types#premium-ssd)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-8/vm-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-9 - There are Virtual Machines in Stopped state

**Impact: Low**

**Recommendation/Guidance**

Azure Virtual Machines (VM) instances go through different states. There are provisioning and power states. If a Virtual Machine is not running that indicates the Virtual Machine might facing an issue or is no longer necessary and could be removed helping to reduce costs.

**Resources**

- [States and billing status of Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/states-billing?context=%2Ftroubleshoot%2Fazure%2Fvirtual-machines%2Fcontext%2Fcontext#power-states-and-billing)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-9/vm-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-10 - Accelerated Networking is not enabled

**Impact: Medium**

**Recommendation/Guidance**

Accelerated networking enables single root I/O virtualization (SR-IOV) to a VM, greatly improving its networking performance. This high-performance path bypasses the host from the data path, which reduces latency, jitter, and CPU utilization for the most demanding network workloads on supported VM types.

This configuration is not always required, evaluate this option according to the workload requirements.

**Resources**

- [Accelerated Networking (AccelNet) overview](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-10/vm-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-11 - Accelerated Networking is enabled, make sure you update the GuestOS NIC driver every 6 months

**Impact: Low**

**Recommendation/Guidance**

When Accelerated Networking is enabled the default Azure Virtual Network interface in the GuestOS is replaced for a Mellanox and consecutively its driver is provided from a 3rd party vendor. Marketplace images maintained by Microsoft are offered with the latest version of Mellanox drivers, however, once the Virtual Machine is deployed, the customer is responsible for maintaining the driver up to date.

**Resources**

- [Accelerated Networking (AccelNet) overview](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-11/vm-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-12 - Virtual Machines should not have a Public IP directly associated

**Impact: Medium**

**Recommendation/Guidance**

If a Virtual Machine requires outbound internet connectivity we recommend the use of NAT Gateway or Azure Firewall, this will help to increase security and resiliency of the service as both services have much higher availability and SNAT ports. For inbound internet connectivity we recommend using a load balancing solution such as Azure Load Balancer and Application Gateway.

**Resources**

- [Use Source Network Address Translation (SNAT) for outbound connections](https://learn.microsoft.com/azure/load-balancer/load-balancer-outbound-connections)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-12/vm-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-13 - Virtual Network Interfaces have an NSG associated

**Impact: Low**

**Recommendation/Guidance**

Unless you have a specific reason to, we recommend that you associate a network security group to a subnet, or a network interface, but not both. Since rules in a network security group associated to a subnet can conflict with rules in a network security group associated to a network interface, you can have unexpected communication problems that require troubleshooting.

**Resources**

- [How network security groups filter network traffic](https://learn.microsoft.com/azure/virtual-network/network-security-group-how-it-works#intra-subnet-traffic)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-13/vm-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-14 - IP Forwarding should only be enabled for Network Virtual Appliances

**Impact: Medium**

**Recommendation/Guidance**

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

**Impact: Low**

**Recommendation/Guidance**

Configure the DNS Server in the Virtual Network to avoid inconsistency across the environment.

**Resources**

- [Name resolution for resources in Azure virtual networks](https://learn.microsoft.com/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-15/vm-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-16 - Shared disks should only be enabled in Clustered servers

**Impact: Medium**

**Recommendation/Guidance**

Azure shared disks is a feature for Azure managed disks that enables you to attach a managed disk to multiple virtual machines (VMs) simultaneously. Attaching a managed disk to multiple VMs allows you to either deploy new or migrate existing clustered applications to Azure, and should only be used in those situations where the disk will be assigned to more than one Virtual Machine member of a Cluster.

**Resources**

- [Azure Shared Disks](https://learn.microsoft.com/azure/virtual-machines/disks-shared-enable?tabs=azure-portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-16/vm-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-17 - The Network access to the VM disk is set to "Enable Public access from all networks

**Impact: Low**

**Recommendation/Guidance**

Recommended changing to "Disable public access and enable private access" and creating a Private Endpoint

**Resources**

- [Restrict import/export access for managed disks using Azure Private Link](https://learn.microsoft.com/azure/virtual-machines/disks-enable-private-links-for-import-export-portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-17/vm-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-18 - Virtual Machine is not compliant with Azure Policies

**Impact: Low**

**Recommendation/Guidance**

It's important to keep your virtual machine (VM) secure for the applications that you run. Securing your VMs can include one or more Azure services and features that cover secure access to your VMs and secure storage of your data. This article provides information that enables you to keep your VM and applications secure.

**Resources**

- [Policy-driven governance](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance)
- [Azure Policy Regulatory Compliance controls for Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/security-policy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-18/vm-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-19 - Enable disk encryption, Enable data at rest encryption by default

**Impact: Medium**

**Recommendation/Guidance**

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

### VM-20 - Enable Insights to get more visibility into the health and performance of your virtual machine

**Impact: Low**

**Recommendation/Guidance**

VM insights monitors the performance and health of your virtual machines and virtual machine scale sets. It monitors their running processes and dependencies on other resources. VM insights can help deliver predictable performance and availability of vital applications by identifying performance bottlenecks and network issues. It can also help you understand whether an issue is related to other dependencies.

**Resources**

- [Overview of VM insights](https://learn.microsoft.com/azure/azure-monitor/vm/vminsights-overview)
- [Did the extension install properly?](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-troubleshoot#did-the-extension-install-properly)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-20/vm-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-21 - Diagnostic Settings should be configured for all Azure Resources

**Impact: Low**

**Recommendation/Guidance**

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

### VM-22 - Use maintenance configurations for the Virtual Machine

**Impact: High**

**Recommendation/Guidance**

The maintenance configuration settings allows user to schedule and manage updates, ensuring the VM updates/interruptions are done in planned timeframe.

**Resources**

- [Use maintenance configurations to control and manage the VM updates](https://learn.microsoft.com/azure/virtual-machines/maintenance-configurations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-22/vm-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
