+++
title = "Azure NetApp Files"
description = "Best practices and resiliency recommendations for Azure NetApp Files and associated resources and settings."
date = "3/5/24"
author = "seanluce"
msAuthor = "b-sluce"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure NetApp Files and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State   | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------: | :-----------------: |
| [ANF-1 - Use the correct service level and volume quota size for the expected performance level](#anf-1---use-the-correct-service-level-and-volume-quota-size-for-the-expected-performance-level) | System Efficiency | High | Preview  |         No         |
| [ANF-2 - Use standard network features for production in Azure NetApp Files](#anf-2---use-standard-network-features-for-production-in-azure-netapp-files) | Networking | High | Preview  |         Yes         |
| [ANF-3 - Use availability zones for high availability in Azure NetApp Files](#anf-3---use-availability-zones-for-high-availability-in-azure-netapp-files) | Availability | High | Preview  |         Yes         |
| [ANF-4 - Use snapshot and backup for in-region data protection in Azure NetApp Files](#anf-4---use-snapshot-and-backup-for-in-region-data-protection-in-azure-netapp-files) | Availability | High | Preview  |         No         |
| [ANF-5 - Enable Cross-region replication of Azure NetApp Files volumes](#anf-5---enable-cross-region-replication-of-azure-netapp-files-volumes) | Disaster Recovery | High | Preview  |         Yes         |
| [ANF-6 - Enable Cross-zone replication of Azure NetApp Files volumes](#anf-6---enable-cross-zone-replication-of-azure-netapp-files-volumes) | Availability | High | Preview  |         Yes         |
| [ANF-7 - Monitor Azure NetApp Files metrics to better understand usage pattern and performance](#anf-7---monitor-azure-netapp-files-metrics-to-better-understand-usage-pattern-and-performance) | Monitoring | Medium | Preview  |         No         |
| [ANF-8 - Use Azure policy to enforce organizational standards and to assess compliance at-scale in Azure NetApp Files](#anf-8---use-azure-policy-to-enforce-organizational-standards-and-to-assess-compliance-at-scale-in-azure-netapp-files) | Governance | Medium | Preview  |         No         |
| [ANF-9 - Restrict default access to Azure NetApp Files volumes](#anf-9---restrict-default-access-to-azure-netapp-files-volumes) | Access & Security | High | Preview  |         No         |
| [ANF-10 - Make use of SMB continuous availability for supported applications](#anf-10---make-use-of-smb-continuous-availability-for-supported-applications) | Application Resilience | High | Preview  |         No         |
| [ANF-11 - Ensure application resilience for service maintenance events](#anf-11---ensure-application-resilience-for-service-maintenance-events) | Application Resilience | High | Preview  |         No         |
| [ANF-12 - Make use of appropriate file locking](#anf-12---make-use-of-appropriate-file-locking) | Storage | Medium | Preview  |         No         |
| [ANF-13 - Appropriately determine your delegated subnet size](#anf-13---appropriately-determine-your-delegated-subnet-size) | Networking | Medium | Preview  |         No         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ANF-1 - Use the correct service level and volume quota size for the expected performance level

**Category: System Efficiency**

**Impact: High**

**Guidance**

Service levels are an attribute of a capacity pool. Service levels are defined and differentiated by the allowed maximum throughput for a volume in the capacity pool based on the quota that is assigned to the volume. Throughput is a combination of read and write speed. Azure NetApp Files supports three service levels:

- Standard (16 MiB/s per 1TiB) throughput
- Premium (64 MiB/s per 1TiB) throughput
- Ultra (128 MiB/s per 1TiB) throughput

**Resources**

- [Service levels for Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-service-levels)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-1/anf-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-2 - Use standard network features for production in Azure NetApp Files

**Category: Networking**

**Impact: High**

**Guidance**

Standard network feature enables higher IP limits and standard VNet features such as network security groups and user-defined routes on delegated subnets, and additional connectivity patterns.
Please check the supported regions for standard network feature [here](https://docs.microsoft.com/azure/azure-netapp-files/azure-netapp-files-network-topologies#supported-regions-for-standard-network-feature)

**Resources**

- [Guidelines for Azure NetApp Files network planning | Microsoft Learn](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-network-topologies)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-2/anf-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-3 - Use availability zones for high availability in Azure NetApp Files

**Category: Availability**

**Impact: High**

**Guidance**

Azure availability zones are physically separate locations within each supporting Azure region that are tolerant to local failures. Failures can range from software and hardware failures to events such as earthquakes, floods, and fires. Tolerance to failures is achieved because of redundancy and logical isolation of Azure services. To ensure resiliency, a minimum of three separate availability zones are present in all availability zone-enabled regions.

**Resources**

- [Use availability zones for high availability in Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/azure/azure-netapp-files/use-availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-3/anf-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-4 - Use snapshot and backup for in-region data protection in Azure NetApp Files

**Category: Availability**

**Impact: High**

**Guidance**

Azure NetApp Files snapshot technology delivers stability, scalability, and swift recoverability without impacting performance.
Azure NetApp Files supports a fully managed backup solution for long-term recovery, archive, and compliance. Backups can be restored to new volumes in the same region as the backup. Backups created by Azure NetApp Files are stored in Azure storage, independent of volume snapshots that are available for near-term recovery or cloning.

**Resources**

- [Snapshots](https://learn.microsoft.com/azure/azure-netapp-files/data-protection-disaster-recovery-options#snapshots)
- [Backup](https://learn.microsoft.com/azure/azure-netapp-files/data-protection-disaster-recovery-options#backups)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-4/anf-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-5 - Enable Cross-region replication of Azure NetApp Files volumes

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

The Azure NetApp Files replication functionality provides data protection through cross-region volume replication. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one region to another Azure NetApp Files volume (destination) in another region. This capability enables you to fail over your critical application if a region-wide outage or disaster happens.

**Resources**

- [Cross-zone replication of Azure NetApp Files volumes | Microsoft Learn](https://learn.microsoft.com/azure/azure-netapp-files/cross-region-replication-introduction)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-5/anf-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-6 - Enable Cross-zone replication of Azure NetApp Files volumes

**Category: Availability**

**Impact: High**

**Guidance**

The cross-zone replication (CZR) capability provides data protection between volumes in different availability zones. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one availability zone to another Azure NetApp Files volume (destination) in another availability. This capability enables you to fail over your critical application if a zone-wide outage or disaster happens.

**Resources**

- [Cross-zone replication of Azure NetApp Files volumes | Microsoft Learn](https://learn.microsoft.com/azure/azure-netapp-files/cross-zone-replication-introduction)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-6/anf-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-7 - Monitor Azure NetApp Files metrics to better understand usage pattern and performance

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Azure NetApp Files provides metrics on allocated storage, actual storage usage, volume IOPS, and latency. With these metrics, you can gain a better understanding on the usage pattern and volume performance of your NetApp accounts.

**Resources**

- [Ways to monitor Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/azure/azure-netapp-files/monitor-azure-netapp-files)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-7/anf-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-8 - Use Azure policy to enforce organizational standards and to assess compliance at-scale in Azure NetApp Files

**Category: Governance**

**Impact: Medium**

**Guidance**

Azure NetApp Files supports Azure Policy. You can integrate Azure NetApp Files with Azure Policy through [creating custom policy definitions](https://learn.microsoft.com/azure/governance/policy/tutorials/create-custom-policy-definition). You can find examples in [Enforce Snapshot Policies with Azure Policy](https://anfcommunity.com/2021/08/30/enforce-snapshot-policies-with-azure-policy/) and [Azure Policy now available for Azure NetApp Files](https://anfcommunity.com/2021/04/19/azure-policy-now-available-for-azure-netapp-files/).

**Resources**

- [Azure Policy definitions for Azure NetApp Files | Microsoft Learn](https://learn.microsoft.com/azure/azure-netapp-files/azure-policy-definitions)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-8/anf-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-9 - Restrict default access to Azure NetApp Files volumes

**Category: Governance**

**Impact: High**

**Guidance**

Access to the delegated subnet should be granted to specific Azure Virtual Networks only whenever possible. Reference [Configure network features for an Azure NetApp Files volume](https://learn.microsoft.com/azure/azure-netapp-files/configure-network-features) for more information.
Share permissions on SMB-enabled volumes should be restricted from the default 'Everyone – Full control'. See [Manage SMB share ACLs in Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/manage-smb-share-access-control-lists) for more information.
Access to NFS-enabled volumes should be restricted by using export policies and/or NFSv4.1 ACLs. See [Configure export policy for NFS or dual-protocol volumes](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-configure-export-policy) and [Configure access control lists on NFSv4.1 volumes for Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/configure-access-control-lists) for more information.
Mount path change permissions should be further restricted. See [Configure Unix permissions and change ownership mode for NFS and dual-protocol volumes](https://learn.microsoft.com/azure/azure-netapp-files/configure-unix-permissions-change-ownership-mode) for more information.


**Resources**

- [Configure network features for an Azure NetApp Files volume](https://learn.microsoft.com/azure/azure-netapp-files/configure-network-features)
- [Manage SMB share ACLs in Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/manage-smb-share-access-control-lists)
- [Configure export policy for NFS or dual-protocol volumes](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-configure-export-policy)
- [Configure access control lists on NFSv4.1 volumes for Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/configure-access-control-lists)
- [Configure Unix permissions and change ownership mode for NFS and dual-protocol volumes](https://learn.microsoft.com/azure/azure-netapp-files/configure-unix-permissions-change-ownership-mode)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-9/anf-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-10 - Make use of SMB continuous availability for supported applications

**Category: Application Resilience**

**Impact: High**

**Guidance**

Certain SMB-based applications require SMB Transparent Failover. SMB Transparent Failover enables maintenance operations on the Azure NetApp Files service without interrupting connectivity to server applications storing and accessing data on SMB volumes. To support SMB Transparent Failover for specific applications, Azure NetApp Files supports the SMB Continuous Availability shares option. See [Do I need to take special precautions for SMB-based applications?](https://learn.microsoft.com/azure/azure-netapp-files/faq-application-resilience#do-i-need-to-take-special-precautions-for-smb-based-applications) for more information.

**Resources**

- [Do I need to take special precautions for SMB-based applications?](https://learn.microsoft.com/azure/azure-netapp-files/faq-application-resilience#do-i-need-to-take-special-precautions-for-smb-based-applications)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-10/anf-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-11 - Ensure application resilience for service maintenance events

**Category: Application Resilience**

**Impact: High**

**Guidance**

Azure NetApp Files might undergo occasional planned maintenance (for example, platform updates, service or software upgrades). As such, ensure that you're aware of the application’s resiliency settings to cope with the storage service maintenance events. See [What do you recommend for handling potential application disruptions due to storage service maintenance events?](https://learn.microsoft.com/azure/azure-netapp-files/faq-application-resilience#what-do-you-recommend-for-handling-potential-application-disruptions-due-to-storage-service-maintenance-events) for more information.

**Resources**

- [What do you recommend for handling potential application disruptions due to storage service maintenance events?](https://learn.microsoft.com/azure/azure-netapp-files/faq-application-resilience#what-do-you-recommend-for-handling-potential-application-disruptions-due-to-storage-service-maintenance-events)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-11/anf-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-12 - Make use of appropriate file locking

**Category: Storage**

**Impact: Medium**

**Guidance**

In NAS environments, multiple clients access files in the same volume. The NAS volume isn't application aware, so to protect data against potential corruption when more than one client attempts to write to the same file at the same time, applications send lock requests to the NAS server to prevent other clients from making changes while the file is in use. See [Understand file locking and lock types in Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/understand-file-locks) for more information.

**Resources**

- [Understand file locking and lock types in Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/understand-file-locks)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-12/anf-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ANF-13 - Appropriately determine your delegated subnet size

**Category: Networking**

**Impact: Medium**

**Guidance**

When creating the delegated subnet for Azure NetApp Files, the size of the subnet matters. [Ensuring future-proof sizing](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-delegate-subnet#considerations) ensures long-term resiliency of your design.

**Resources**

- [Delegate a subnet to Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-delegate-subnet#considerations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/anf-13/anf-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

