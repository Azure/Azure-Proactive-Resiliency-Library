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
| Recommendation                                                                                                                                                                                                                     |  State  | ARG Query Available |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-----: | :-----------------: |
| [VM-1 - Avoid running a production workload on a single VM](#vm-1---avoid-running-a-production-workload-on-a-single-vm)                                                                                                            | Preview |         No          |
| [VM-2 - Deploy Virtual Machines across Availability Zones](#vm-2---deploy-virtual-machines-across-availability-zones)                                                                                                              | Preview |         Yes          |
| [VM-3 - If Availability Zones are not available, then put each application tier into a separate Availability Set](#vm-3---if-availability-zones-are-not-available-then-put-each-application-tier-into-a-separate-availability-set) | Preview |         No          |
| [VM-4 - Replicate Virtual Machines using Azure Site Recovery](#vm-4---replicate-virtual-machines-using-azure-site-recovery)                                                                                                        | Preview |         No          |
| [VM-5 - Use Managed Disks for Virtual Machine hard disks](#vm-5---use-managed-disks-for-virtual-machine-hard-disks)                                                                                                                | Preview |         No          |
| [VM-6 - Host application or database data on a data disk](#vm-6---host-application-or-database-data-on-a-data-disk)                                                                                                                | Preview |         No          |
| [VM-7 - Enable Backups on your Virtual Machines](#vm-7---enable-backups-on-your-virtual-machines)                                                                                                                                  | Preview |         Yes          |
| [VM-8 - Production VMs should be using Premium disks](#vm-8---production-vms-should-be-using-premium-disks)                                                                                                                        | Preview |         No          |
| [VM-9 - There are Virtual Machines in Stopped state](#vm-9---there-are-virtual-machines-in-stopped-state)                                                                                                                          | Preview |         Yes          |
| [VM-10 - Accelerated Networking is not enabled](#vm-10---accelerated-networking-is-not-enabled)                                                                                                                                    | Preview |         No          |
| [VM-11 - Accelerated Networking is enabled, make sure you update the GuestOS NIC driver every 6 months](#vm-11---accelerated-networking-is-enabled-make-sure-you-update-the-guestos-nic-driver-every-6-months)                     | Preview |         Yes          |
| [VM-12 - Virtual Machines should not have a Public IP directly associated](#vm-12---virtual-machines-should-not-have-a-public-ip-directly-associated)                                                                              | Preview |         No          |
| [VM-13 - Virtual Network Interfaces have an NSG associated](#vm-13---virtual-network-interfaces-have-an-nsg-associated)                                                                                                            | Preview |         No          |
| [VM-14 - IP Forwarding should only be enabled for Network Virtual Appliances](#vm-14---ip-forwarding-should-only-be-enabled-for-network-virtual-appliances)                                                                        | Preview |         No          |
| [VM-15 - Customer DNS Servers should be configured in the Virtual Network level](#vm-15---customer-dns-servers-should-be-configured-in-the-virtual-network-level)                                                                  | Preview |         No          |
| [VM-16 - Private IP Address should be configured as Static](#vm-16---private-ip-address-should-be-configured-as-static)                                                                                                            | Preview |         No          |
| [VM-17 - Shared disks should only be enabled in Clustered servers](#vm-17---shared-disks-should-only-be-enabled-in-clustered-servers)                                                                                              | Preview |         No          |
| [VM-18 - The Network access to the VM disk is set to "Enable Public access from all networks"](#vm-18---the-network-access-to-the-vm-disk-is-set-to-enable-public-access-from-all-networks)                                        | Preview |         No          |
| [VM-19 - Virtual Machine is not compliant with Azure Policies](#vm-19---virtual-machine-is-not-compliant-with-azure-policies)                                                                                                      | Preview |         No          |
| [VM-20 - Enable disk encryption, Enable data at rest encryption by default](#vm-20---enable-disk-encryption-enable-data-at-rest-encryption-by-default)                                                                             | Preview |         No          |
| [VM-21 - Enable Insights to get more visibility into the health and performance of your virtual machine](#vm-21---enable-insights-to-get-more-visibility-into-the-health-and-performance-of-your-virtual-machine)                  | Preview |         No          |
| [VM-22 - Diagnostic Settings should be configured for all Azure Resources](#vm-22---diagnostic-settings-should-be-configured-for-all-azure-resources)                                                                              | Preview |         No          |
| [VM-23 - Tags are inconsistent across Virtual Machines](#vm-23---tags-are-inconsistent-across-virtual-machines)                                                                                                                    | Preview |         No          |
| [VM-24 - Tag shows incorrect value for the Availability Zone number for a Virtual Machine](#vm-24---tag-shows-incorrect-value-for-the-availability-zone-number-for-a-virtual-machine)                                              | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VM-1 - Avoid running a production workload on a single VM

#### Importance: Critical

#### Recommendation/Guidance

To safeguard application workloads from downtime due to the temporary unavailability of a disk or VM, customers can use availability sets. Two or more virtual machines in an availability set provide redundancy for the application. Azure then creates these VMs and disks in separate fault domains with different power, network, and server components. Then, deploy multiple VMs in different Availability Zones, or put them into an Availability Set or Virtual Machine Scale Set, with a Load Balancer in front of them.

#### Resources

- [https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-1/vm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-2 - Deploy Virtual Machines across Availability Zones

#### Importance: High

#### Recommendation/Guidance

Azure Availability Zones are physically separate locations within each Azure region that are tolerant to local failures. Use availability zones to protect your applications and data against unlikely datacenter failures.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/create-portal-availability-zone](https://learn.microsoft.com/en-us/azure/virtual-machines/create-portal-availability-zone?tabs=standard)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-2/vm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-3 - If Availability Zones are not available, then put each application tier into a separate Availability Set

#### Importance: High

#### Recommendation/Guidance

If the region where you are running your application doesn't support Availablity Zones, then put your VMs into an Availability Set. In an N-tier application, don't put VMs from different tiers into the same availability set. VMs in an availability set are placed across fault domains (FDs) and update domains (UD). However, to get the redundancy benefit of FDs and UDs, every VM in the availability set must be able to handle the same client requests.

#### Resources

- [https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-3/vm-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-4 - Replicate Virtual Machines using Azure Site Recovery

#### Importance: Low

#### Recommendation/Guidance

When you replicate Azure VMs using Site Recovery, all the VM disks are continuously replicated to the target region asynchronously. The recovery points are created every few minutes. This gives you a Recovery Point Objective (RPO) in the order of minutes. You can conduct disaster recovery drills as many times as you want, without affecting the production application or the ongoing replication.

#### Resources

- ["<https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines>
<https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-test-failover-to-azure>"]("<https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines>
<https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-test-failover-to-azure>")

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-4/vm-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-5 - Use Managed Disks for Virtual Machine hard disks

#### Importance: High

#### Recommendation/Guidance

Managed disks provide better reliability for VMs in an availability set, because the disks are sufficiently isolated from each other to avoid single points of failure. Also, managed disks aren't subject to the IOPS limits of VHDs created in a storage account.

#### Resources

- ["<https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines>
<https://learn.microsoft.com/en-us/azure/virtual-machines/windows/manage-availability#use-managed-disks-for-vms-in-an-availability-set>"]("<https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#virtual-machines>
<https://learn.microsoft.com/en-us/azure/virtual-machines/windows/manage-availability#use-managed-disks-for-vms-in-an-availability-set>")

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-5/vm-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-6 - Host application or database data on a data disk

#### Importance: Informational

#### Recommendation/Guidance

A data disk is a managed disk that's attached to a virtual machine to store application data, or other data you need to keep. Data disks are registered as SCSI drives and are labeled with a letter that you choose. Hosting you data on a data disk also helps with flexibility when backuping or restoring data, as well as migrating the disk without having to migrate the entire Virtual Machine and Operating System. You will be able to also select a different disk sku, with different type, size, and performance that meet your requirements.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview#data-disk](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview#data-disk)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-6/vm-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-7 - Enable Backups on your Virtual Machines

#### Importance: Medium

#### Recommendation/Guidance

Enable backups for your virtual machines and secure your data

#### Resources

- [https://learn.microsoft.com/en-us/azure/backup/backup-overview](https://learn.microsoft.com/en-us/azure/backup/backup-overview)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-7/vm-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-8 - Production VMs should be using Premium disks

#### Importance: Critical

#### Recommendation/Guidance

We have identified that you are using standard disks with your premium-capable Virtual Machines and we recommend you consider upgrading the standard disks to premium disks. For any Single Instance Virtual Machine using premium storage for all Operating System Disks and Data Disks, we guarantee you will have Virtual Machine Connectivity of at least 99.9%. Consider these factors when making your upgrade decision. The first is that upgrading requires a VM reboot and this process takes 3-5 minutes to complete. The second is if the VMs in the list are mission-critical production VMs, evaluate the improved availability against the cost of premium disks.

Premium SSD disks offer high-performance, low-latency disk support for I/O-intensive applications and production workloads. Standard SSD Disks are a cost effective storage option optimized for workloads that need consistent performance at lower IOPS levels. Use Standard HDD disks for Dev/Test scenarios and less critical workloads at lowest cost.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types#premium-ssd](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types#premium-ssd)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-8/vm-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-9 - There are Virtual Machines in Stopped state

#### Importance: Informational

#### Recommendation/Guidance

Azure Virtual Machines (VM) instances go through different states. There are provisioning and power states. If a Virtual Machine is not running that indicates the Virtual Machine might facing an issue or is no longer necessary and could be removed helping to reduce costs.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/](https://learn.microsoft.com/en-us/azure/virtual-machines/states-billing?context=%2Ftroubleshoot%2Fazure%2Fvirtual-machines%2Fcontext%2Fcontext)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-9/vm-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-10 - Accelerated Networking is not enabled

#### Importance: Medium

#### Recommendation/Guidance

Accelerated networking enables single root I/O virtualization (SR-IOV) to a VM, greatly improving its networking performance. This high-performance path bypasses the host from the data path, which reduces latency, jitter, and CPU utilization for the most demanding network workloads on supported VM types.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview](https://learn.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-10/vm-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-11 - Accelerated Networking is enabled, make sure you update the GuestOS NIC driver every 6 months

#### Importance: Low

#### Recommendation/Guidance

When Accelerated Networking is enabled the default Azure Virtual Network interface in the GuestOS is replaced for a Mellanox and consecutively its driver is provided from a 3rd party vendor. Marketplace images maintained by Microsoft are offered with the latest version of Mellanox drivers, however, once the Virtual Machine is deployed, the customer is responsible for maintaining the driver up to date.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview](https://learn.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-11/vm-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-12 - Virtual Machines should not have a Public IP directly associated

#### Importance: Medium

#### Recommendation/Guidance

If a Virtual Machine requires outbound internet connectivity we recommend the use of NAT Gateway or Azure Firewall, this will help to increase security and resiliency of the service as both services have much higher availability and SNAT ports. For inbound internet connectivity we recommend using a load balancing solution such as Azure Load Balancer and Application Gateway.

#### Resources

- [https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-outbound-connections](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-outbound-connections)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-12/vm-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-13 - Virtual Network Interfaces have an NSG associated

#### Importance: Informational

#### Recommendation/Guidance

Unless you have a specific reason to, we recommend that you associate a network security group to a subnet, or a network interface, but not both. Since rules in a network security group associated to a subnet can conflict with rules in a network security group associated to a network interface, you can have unexpected communication problems that require troubleshooting.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-network/network-security-group-how-it-works#intra-subnet-traffic](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-group-how-it-works#intra-subnet-traffic)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-13/vm-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-14 - IP Forwarding should only be enabled for Network Virtual Appliances

#### Importance:Medium

#### Recommendation/Guidance

IP forwarding enables the virtual machine network interface to:

Receive network traffic not destined for one of the IP addresses assigned to any of the IP configurations assigned to the network interface.

Send network traffic with a different source IP address than the one assigned to one of a network interface's IP configurations.

The setting must be enabled for every network interface that is attached to the virtual machine that receives traffic that the virtual machine needs to forward. A virtual machine can forward traffic whether it has multiple network interfaces or a single network interface attached to it. While IP forwarding is an Azure setting, the virtual machine must also run an application able to forward the traffic, such as firewall, WAN optimization, and load balancing applications.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-network-interface?tabs=network-interface-portal#enable-or-disable-ip-forwarding](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-network-interface?tabs=network-interface-portal#enable-or-disable-ip-forwarding)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-14/vm-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-15 - Customer DNS Servers should be configured in the Virtual Network level

#### Importance: Informational

#### Recommendation/Guidance

Configure the DNS Server in the Virtual Network to avoid inconsistency across the environment.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-15/vm-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-16 - Private IP Address should be configured as Static

#### Importance: Low

#### Recommendation/Guidance

By default, the Azure DHCP servers assign the private IPv4 address for the primary IP configuration of the Azure network interface to the network interface within the virtual machine operating system. Dynamic is the default allocation method. Once assigned, dynamic IP addresses are only released if a network interface is deleted, assigned to a different subnet within the same virtual network, or the allocation method is changed to static, and a different IP address is specified. In order to increase consistency and guaranteed IP reservation, we highly recommend configuring Static IPs.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/virtual-network-network-interface-addresses?tabs=nic-address-portal#static](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/virtual-network-network-interface-addresses?tabs=nic-address-portal#static)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-16/vm-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-17 - Shared disks should only be enabled in Clustered servers

#### Importance: High

#### Recommendation/Guidance

Azure shared disks is a feature for Azure managed disks that enables you to attach a managed disk to multiple virtual machines (VMs) simultaneously. Attaching a managed disk to multiple VMs allows you to either deploy new or migrate existing clustered applications to Azure, and should only be used in those situations where the disk will be assigned to more than one Virtual Machine member of a Cluster.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/disks-shared-enable?tabs=azure-portal](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-shared-enable?tabs=azure-portal)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-17/vm-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-18 - The Network access to the VM disk is set to "Enable Public access from all networks

#### Importance: Informational

#### Recommendation/Guidance

Recommended changing to "Disable public access and enable private access" and creating a Private Endpoint

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/disks-enable-private-links-for-import-export-portal](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-enable-private-links-for-import-export-portal)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-18/vm-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-19 - Virtual Machine is not compliant with Azure Policies

#### Importance: Medium

#### Recommendation/Guidance

It's important to keep your virtual machine (VM) secure for the applications that you run. Securing your VMs can include one or more Azure services and features that cover secure access to your VMs and secure storage of your data. This article provides information that enables you to keep your VM and applications secure.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/security-controls-policy](https://learn.microsoft.com/en-us/azure/virtual-machines/security-controls-policy)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-19/vm-19.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-20 - Enable disk encryption, Enable data at rest encryption by default

#### Importance: Medium

#### Recommendation/Guidance

There are several types of encryption available for your managed disks, including Azure Disk Encryption (ADE), Server-Side Encryption (SSE) and encryption at host.

- Azure Disk Encryption helps protect and safeguard your data to meet your organizational security and compliance commitments.
- Azure Disk Storage Server-Side Encryption (also referred to as encryption-at-rest or Azure Storage encryption) automatically encrypts data stored on Azure managed disks (OS and data disks) when persisting on the Storage Clusters.
- Encryption at host ensures that data stored on the VM host hosting your VM is encrypted at rest and flows encrypted to the Storage clusters.
- Confidential disk encryption binds disk encryption keys to the virtual machine's TPM and makes the protected disk content accessible only to the VM.

#### Resources

- [https://learn.microsoft.com/en-us/azure/virtual-machines/disk-encryption-overview](https://learn.microsoft.com/en-us/azure/virtual-machines/disk-encryption-overview)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-20/vm-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-21 - Enable Insights to get more visibility into the health and performance of your virtual machine

#### Importance: Informational

#### Recommendation/Guidance

VM insights monitors the performance and health of your virtual machines and virtual machine scale sets. It monitors their running processes and dependencies on other resources. VM insights can help deliver predictable performance and availability of vital applications by identifying performance bottlenecks and network issues. It can also help you understand whether an issue is related to other dependencies.

#### Resources

- [https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-overview](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-overview)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-21/vm-21.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-22 - Diagnostic Settings should be configured for all Azure Resources

#### Importance: Low

#### Recommendation/Guidance

Platform metrics are sent automatically to Azure Monitor Metrics by default and without configuration.
Platform logs provide detailed diagnostic and auditing information for Azure resources and the Azure platform they depend on:

- Resource logs aren't collected until they're routed to a destination.
- Activity logs exist on their own but can be routed to other locations.

Each Azure resource requires its own diagnostic setting, which defines the following criteria:

- Sources: The type of metric and log data to send to the destinations defined in the setting. The available types vary by resource type.
- Destinations: One or more destinations to send to.

A single diagnostic setting can define no more than one of each of the destinations. If you want to send data to more than one of a particular destination type (for example, two different Log Analytics workspaces), create multiple settings. Each resource can have up to five diagnostic settings.

#### Resources

- [https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings?tabs=portal](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings?tabs=portal)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-22/vm-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-23 - Tags are inconsistent across Virtual Machines

#### Importance: Informational

#### Recommendation/Guidance

The Tags assigned to the Virtual Machines are different and if used for automation, or billing, or support purposes it could led to incorrect actions.

#### Resources

- [https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-23/vm-23.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VM-24 - Tag shows incorrect value for the Availability Zone number for a Virtual Machine

#### Importance: Medium

#### Recommendation/Guidance

The Tags assigned to the Virtual Machines are different and if used for automation, or billing, or support purposes it could led to incorrect actions.

#### Resources

- [https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vm-24/vm-24.kql" >}} {{< /code >}}

{{< /collapse >}}
