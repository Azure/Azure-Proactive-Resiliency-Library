+++
title = "Azure Netapp Files"
description = "Best practices and resiliency recommendations for Azure Netapp Files and associated resources and settings."
date = "8/30/23"
author = "maheshbenke"
msAuthor = "maheshbenke"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Netapp Files and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State   | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------: | :-----------------: |
| [ANF-1 - Enable Cross-region replication of Azure NetApp Files volumes](#anf-1---enable-cross-region-replication-of-azure-netapp-files-volumes) | Disaster Recovery/High Availability | High | Preview  |         No         |
| [ANF-2 - Use availability zones for high availability in Azure NetApp Files](#anf-2---use-availability-zones-for-high-availability-in-azure-netapp-files) | Disaster Recovery/High Availability | High | Preview  |         No         |
| [ANF-3 - Use the correct service level and volume quota size for the expected performance level](#anf-3---use-the-correct-service-level-and-volume-quota-size-for-the-expected-performance-level) | System Efficiency | High | Preview  |         No         |
| [ANF-4 - Use standard network feature for Production in Azure NetApp Files](#anf-4---use-standard-network-feature-for-production-in-azure-netapp-files) | Networking | High | Preview  |         No         |
| [ANF-5 - Enable Cross-zone replication of Azure NetApp Files volumes](#anf-5---enable-cross-zone-replication-of-azure-netapp-files-volumes) | High Availability | High | Preview  |         No         |
| [ANF-6 - Use snapshot and backup for in-region data protection in Azure NetApp Files](#anf-6---use-snapshot-and-backup-for-in-region-data-protection-in-azure-netapp-files) | High Availability | High | Preview  |         No         |
| [ANF-7 - Monitor Azure Netapp Files metric to better understand usage pattern and performance](#anf-7---monitor-azure-netapp-files-metric-to-better-understand-usage-pattern-and-performance) | Monitoring | High | Preview  |         No         |
| [ANF-8 - Use Azure policy to enforce organizational standards and to assess compliance at-scale in Azure NetApp Files](#anf-8---use-azure-policy-to-enforce-organizational-standards-and-to-assess-compliance-at-scale-in-azure-netapp-files) | Governance | High | Preview  |         No         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ANF-1 - Enable Cross-region replication of Azure NetApp Files volumes

**Category: Disaster Recovery/High Availability**

**Impact: High**

**Recommendation/Guidance**

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

**Recommendation/Guidance**

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

**Recommendation/Guidance**

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

**Recommendation/Guidance**

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

**Recommendation/Guidance**

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

**Recommendation/Guidance**

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

**Recommendation/Guidance**

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

**Recommendation/Guidance**

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
