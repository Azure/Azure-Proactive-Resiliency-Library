+++
title = "SAP on Azure"
description = "Best practices and resiliency recommendations for Azure Sap Solution and associated resources and settings."
date = "2/13/24"
author = "humblejay"
msAuthor = "kupole"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Sap Solution and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |                                Category                                 |     Impact      |      State       | ARG Query Available |
|:--------------------------------------------------|:-----------------------------------------------------------------------:|:---------------:|:----------------:|:-------------------:|
| [SAP-1 - Ensure that each SAP production system is designed for high availability using availability zones.](#sap-1---ensure-that-each-sap-production-systems-are-designed-for-high-availability) | Availability | High | Verified | Yes |
| [SAP-2 - Run SAP application servers on two or more VMs using VMSS Flex.](#sap-2---run-sap-application-servers-on-two-or-more-vms-using-vmss-flex) | Availability | High | Verified | No  |
| [SAP-6 - Avoid placing application server and database VMs in one Proximity Placement Group.](#sap-6---avoid-placing-application-server-and-database-in-one-proximity-placement-group) | Availability | High | Verified |  No  |
| [SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group.](#sap-7---avoid-placing-vms-from-multiple-sap-systems-in-a-single-proximity-placement-group) | Availability | High | Verified | No |
| [SAP-8 - When creating availability sets, ensure that you have maximum number of fault domains and a sufficient number of update domains.](#sap-8---when-creating-availability-sets-ensure-that-you-have-maximum-number-of-fault-domains-and-a-sufficient-number-of-update-domains) | Availability | High | Verified | No |
| [SAP-9 - If using single-instance VMs, all OS and data disks must be Premium SSD or Ultra Disk.](#sap-9---if-using-single-instance-vms-all-os-and-data-disks-must-be-premium-ssd-or-ultra-disk) | Availability | High | Verified |  Yes  |
| [SAP-14 - Ensure that each database replicates changes synchronously (SYNC mode) to a stand-by node.](#sap-14---ensure-that-the-data-is-replicated-synchronously-sync-mode-between-the-primary-and-secondary-database-hosting-vm-nodes) | Availability | High | Verified |  No  |
| [SAP-15 - Ensure that SAP shared file systems are designed for high availability, and when possible using availability zones.](#sap-15---ensure-that-the-sap-shared-files-systems-are-made-highly-available) | Availability | High | Verified |  Yes  |
| [SAP-16 - Test high availability solutions thoroughly to ensure fail overs work as expected.](#sap-16---test-high-availability-solutions-thoroughly-to-ensure-fail-overs-work-as-expected) | Availability | High | Verified | No |
| [SAP-18 - Remove unwanted location constraints from your Linux Pacemaker clusters.](#sap-18---remove-unwanted-location-constraints-from-your-linux-pacemaker-clusters) | Availability | High | Verified | No |
| [SAP-22 - Protect SAP production workloads with a cross-region disaster recovery solution.](#sap-22---protect-sap-production-workloads-with-a-cross-region-disaster-recovery-solution) | Disaster Recovery | High | Verified |  No  |
| [SAP-24 - Implement an offsite backup strategy for production workloads by utilizing the second Azure region for backups.](#sap-24---implement-an-offsite-backup-strategy-for-production-workloads-by-utilizing-the-second-azure-region-for-backups) | Disaster Recovery | High | Verified | No  |
| [SAP-26 - Secure compute resource capacity for critical VM roles in DR region.](#sap-26---secure-compute-resource-capacity-for-critical-vm-roles-in-dr-region) | Disaster Recovery | Medium | Verified | No |
| [SAP-27 - Ensure that the production databases are replicated (ASYNC) to DR location, use database vendor's replication.](#sap-27---ensure-that-the-production-databases-are-replicated-async-to-dr-location-use-database-vendors-replication) | Disaster Recovery | High | Verified | No |
| [SAP-28 - SAP components are backed up to DR location using an appropriate backup tool or ASR.](#sap-28---sap-components-are-backed-up-to-dr-location-using-an-appropriate-backup-tool-or-asr) | Disaster Recovery | High | Verified | No |
| [SAP-29 - SAP shared files systems are replicated or backed up to DR location.](#sap-29---sap-shared-files-systems-and-any-other-critical-to-dr-are-replicated-or-backed-up-to-dr-location) | Disaster Recovery | High | Verified | No |
| [SAP-32 - Automate DR infrastructure build or pre-deploy DR resources.](#sap-32---automate-dr-infrastructure-build-or-pre-deploy-dr-resources) | Disaster Recovery | Medium | Verified |  No  |
| [SAP-33 - Document and test DR procedure, ensure it meets RPO and RTO targets.](#sap-33---document-and-test-dr-procedure-ensure-it-meets-rpo-and-rto-targets) | Disaster Recovery | Medium | Verified | No |
| [SAP-34 - Ensure there is a robust monitoring and alerting solution in place for the entire DR solution.](#sap-34---ensure-there-is-a-robust-monitoring-and-alerting-solution-in-place-for-the-entire-dr-solution) | Disaster Recovery | Medium | Verified | No |
| [SAP-36 - Configure scheduled events so you are notified of upcoming maintenance events.](#sap-36---configure-scheduled-events-notification) | Monitoring | High | Verified | No |
| [SAP-42 - ASCS-Pacemaker (Central Server Instance) Ensure Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-42---ascs-pacemaker-central-server-instance-ensure-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Automation | High | Verified | No |
| [SAP-44 - ASCS-Pacemaker-RH (Central Server Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-44---ascs-pacemaker-rh-central-server-instance-ensure-the-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Availability | High | Verified | No  |
| [SAP-45 - ASCS-LB (Central Server Instance) Ensure the load balancer is configured correctly for SAP ASCS High availability.](#sap-45---ascs-lb-central-server-instance-ensure-the-load-balancer-is-configured-correctly-for-sap-ascs-high-availability) | Availability | High | Verified | No |
| [SAP-46 - DBHANA-Pacemaker (Database Instance) Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability.](#sap-46---dbhana-pacemaker-database-instance-ensure-the-pacemaker-cluster-has-been-setup-for-sap-hana-db-high-availability) | Availability | High | Verified | No |
| [SAP-49 - DBHANA-LB (Database Instance) Ensure the load balancer is configured correctly for SAP HANA DB High availability.](#sap-49---dbhana-lb-database-instance-ensure-the-load-balancer-is-configured-correctly-for-sap-hana-db-high-availability) | Availability | High | Verified | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SAP-1 - Ensure that each SAP production systems are designed for high availability

**Category: Availability**

**Impact: High**

**Guidance**

Azure Availability Zones are physically separate locations within each Azure region that are tolerant to local failures. Use availability zones to protect your applications and data against unlikely data center failures. Ensure each single point of failure of each SAP production system is protected with high availability using multiple availability zones. If you cannot deploy across different zones in a region, then  refer to Microsoft guidance for High availability deployment options for SAP workload.

**Resources**

- [Move Regional SAP HA to Zonal](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/Move-VM-from-AvSet-to-AvZone/Move-Regional-SAP-HA-To-Zonal-SAP-HA-WhitePaper)
- [High Availability Deployment Options for SAP](https://learn.microsoft.com/en-us/azure/sap/workloads/sap-high-availability-architecture-scenarios#high-availability-deployment-options-for-sap-workload)
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="../../compute/virtual-machines/code/vm-2/vm-2.kql">}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-2 - Run SAP application servers on two or more VMs using VMSS Flex

**Category: Availability**

**Impact: High**

**Guidance**

Use Virtual Machines Scale Set (VMSS) with flexible orchestration to distribute the virtual machines across specified zones and within each zone to also distribute VMs across different fault domains within the zone on a best effort basis. Configure VMSS Flex following Microsoft recommendation for SAP workload using the right mode and correct settings. If you aren't currently using VMSS Flex for SAP application servers and also not using Availability Sets with Fault domain & Update domain distribution, then you should consider moving to VMSS Flex architecture to improve the resiliency posture of your SAP deployment. The following blog post in links below outlines the details on the process of migrating existing SAP workloads that are deployed in an availability set or availability zone to a flexible scale set with FD=1 deployment option.


**Resources**

- [Virtual machine Scale Set SAP Deployment Guide](https://learn.microsoft.com/en-us/azure/sap/workloads/virtual-machine-scale-set-sap-deployment-guide)
- [Considerations for Flexible VM Scale Sets for SAP](https://learn.microsoft.com/en-us/azure/sap/workloads/virtual-machine-scale-set-sap-deployment-guide?tabs=scaleset-cli#important-consideration-of-flexible-virtual-machine-scale-sets-for-sap-workload)
- [Migrate existing SAP system VMs to VMSS Flex](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/how-to-easily-migrate-an-existing-sap-system-vms-to-flexible/ba-p/3833548)
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-2/sap-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-6 - Avoid placing application server and database in one Proximity Placement Group

**Category: Availability**

**Impact: High**

**Guidance**

Proximity Placement Group (PPG) is a deployment constraint, therefore placing special VM families such as M- or Mv2- series or placing a large number of VMs in one PPG may lead to allocation failures.

**Resources**

- [Proximity Placement Scenarios](https://learn.microsoft.com/en-us/azure/sap/workloads/proximity-placement-scenarios)
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-6/sap-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group

**Category: Availability**

**Impact: High**

**Guidance**

Ensure that VMs from different SAP systems are not colocated within a single Proximity Placement Group

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-7/sap-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-8 - When creating availability sets ensure that you have maximum number of fault domains and a sufficient number of update domains

**Category: Availability**

**Impact: High**

**Guidance**

The default number of fault domains is 2 and changing it later is not possible online.
Important! If you are currently using Availability Sets or Regional VMs for SAP application servers, then you should consider moving to Availability Zones and VMSS Flex architecture to improve the resiliency posture of your SAP deployment. For the details on the process of migrating existing SAP workloads that are deployed in an availability set or availability zone to a flexible scale set with FD=1 deployment option, refer to our public documentation.

**Resources**

- [How availability sets work](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview#how-do-availability-sets-work)
- [Migrate existing SAP system to VMSS Flex](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/how-to-easily-migrate-an-existing-sap-system-vms-to-flexible/ba-p/3833548)
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-8/sap-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-9 - If using single-instance VMs all OS and data disks must be Premium SSD or Ultra Disk

**Category: Availability**

**Impact: High**

**Guidance**

For single-instance VMs, both OS and data disks must be either Premium SSD or Ultra Disk to achieve the single-instance SLA of 99.9% availability.

**Resources**

- [VM SLA](https://www.azure.cn/en-us/support/sla/virtual-machines/)
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="../../compute/virtual-machines/code/vm-8/vm-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-14 - Ensure that the data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes

**Category: Availability**

**Impact: High**

**Guidance**

High availability for databases should be implemented using database native replication technologies and the data should be replicated synchronously that is in SYNC mode from primary database to a stand-by node.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-14/sap-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-15 - Ensure that the SAP shared files systems are made highly available

**Category: Availability**

**Impact: High**

**Guidance**

SAP shared file systems such as /sapmnt, /usr/trans, interfaces should be made highly available.
In case of Azure File Shares, we recommend that you use ZRS (Zone-redundant storage) and for Azure NetApp Files use Zonal replication for your volumes.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="../../storage/storage-account/code/st-1/st-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-16 - Test high availability solutions thoroughly to ensure fail overs work as expected

**Category: Availability**

**Impact: High**

**Guidance**

Test all high availability solutions thoroughly (including kernel panic in Linux VMs and also fail-back). Include zonal failure scenarios in your testing, the testing should confirm that each layer of your SAP solution including database, central services, application servers and shared file systems is configured correctly for zone redundancy, the solution meets RPO = 0 and the application fails over automatically meeting your RTO.
The fail back can be either automatic or manual.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-16/sap-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-18 - Remove unwanted location constraints from your Linux Pacemaker clusters

**Category: Availability**

**Impact: High**

**Guidance**

When executing a migrate command in a Linux Pacemaker cluster, the system generates a temporary "prefer" location constraint, aiming to move a resource to a specified node. This constraint prioritizes the target node for the resource temporarily without permanently altering the cluster’s configuration.

During planned maintenances and fail over testing, you can leverage the migrate command for temporary resource relocation during maintenance or administrative tasks to ensure minimal disruption. This constraint is not permanent and does not survive reboots or cluster resets. It's designed for short-term adjustments.

Once the planned task necessitating the resource migration is complete, manually remove the temporary constraint to revert to the cluster's original resource management policies.
This approach allows for controlled resource movement within the cluster, facilitating maintenance while preserving the integrity and efficiency of the cluster's configuration.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-18/sap-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-22 - Protect SAP production workloads with a cross-region disaster recovery solution

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

To safeguard SAP production workloads against catastrophic events it is imperative to implement a cross-region disaster recovery solution. This approach ensures business continuity by replicating data and applications across geographically diverse regions, minimizing the risk of data loss and downtime in the event of a regional outage.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-22/sap-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-24 - Implement an offsite backup strategy for production workloads by utilizing the second Azure region for backups

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

To bolster your data protection strategy and ensure business continuity, it is important to implement an offsite backup strategy for production workloads leveraging a second Azure region. This approach enhances data security and business continuity by providing geographical redundancy and improved disaster recovery capabilities. This approach also often supports compliance with regulatory requirements ensuring your organization's resilience against data loss and operational disruptions.

Ensure that any Azure Recovery Services vaults used for backing up production VMs are GRS.

In addition, ensure that each of the following technical layers of an SAP system are protected with a suitable backup strategy and backups are also stored in the second region.

Virtual Machine backups
Database
SAP Central Services
SAP Shared File Systems

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-24/sap-24.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-26 - Secure compute resource capacity for critical VM roles in DR region

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

To ensure the availability of compute resources for critical VM roles in a DR region, consider securing capacity either through a warm standby approach or by utilizing Azure's On-demand Capacity Reservation.

Warm standby involves keeping VMs in the DR region running. On-demand Capacity Reservation, on the other hand, reserves compute capacity without having to run the VMs, allowing you to start them when needed. When DR VMs are not needed, the reserved capacity may safely be used to run other workloads without the risk of losing the capacity to other customers. This strategy guarantees resource availability for your critical workloads in the event of a disaster, balancing cost and readiness.

**Resources**

- [Capacity reservation overview](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-overview)
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-26/sap-26.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-27 - Ensure that the production databases are replicated (ASYNC) to DR location, use database vendor's replication

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Replicate production databases (ASYNC) to the DR location using the database vendor’s replication technology.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-27/sap-27.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-28 - SAP components are backed up to DR location using an appropriate backup tool or ASR

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

SAP components such as (A)SCS, application servers, WebDispatchers, etc are backed up to DR location using an appropriate backup tool or ASR.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-28/sap-28.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-29 - SAP shared files systems and any other critical to DR are replicated or backed up to DR location

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Ensure that critical SAP shared file systems, such as /sapmnt, /usr/trans and /interfaces are either replicated or backed up for disaster recovery purposes.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-29/sap-29.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-32 - Automate DR infrastructure build or pre-deploy DR resources

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Automate the build of disaster recovery (DR) infrastructure (or pre-deploy DR resources) and streamline SAP service recovery as much as possible.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-32/sap-32.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-33 - Document and test DR procedure, ensure it meets RPO and RTO targets

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Create detailed documentation of your DR procedures for each layer of the SAP architecture—database, central services, application servers, and shared file systems. This documentation should include configuration details, failover mechanisms, and step-by-step recovery procedures.

Test a wide range of failure scenarios, including regional outages. Testing should confirm that your DR strategy is robust, meets your RPO and RTO targets, and provides seamless failover across all layers of the SAP architecture. This will ensure a comprehensive and resilient DR strategy capable of withstanding regional failures and ensuring business continuity.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-33/sap-33.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-34 - Ensure there is a robust monitoring and alerting solution in place for the entire DR solution

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

For an SAP solution hosted on Azure it is imperative to implement a robust monitoring and alerting solution that comprehensively covers DR of each layer of the SAP architecture. Given the complexity of SAP systems, which span multiple layers using diverse technologies and Azure resources, each with potentially distinct DR replication mechanisms, an appropriate monitoring strategy is crucial. The different layers include database, central services, application, and shared file systems.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-34/sap-34.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-36 - Configure scheduled events notification

**Category: Monitoring**

**Impact: High**

**Guidance**

Scheduled events is an Azure Metadata Services that provides proactive notifications about upcoming maintenance events (for example, reboot) so that your application can prepare for them and limit disruption. You should configure scheduled events for all your critical Azure VMs.


Resource agent azure-events-az can also integrate with Pacemaker clusters.

To ensure high availability and service continuity in your Azure VMs, you should configure the azure-events-az resource agent within your Pacemaker clusters. This agent monitors for scheduled Azure maintenance events and can proactively relocate resources for a graceful node shutdown. Configure the agent to monitor specific event types such as Reboot and Redeploy, and enable verbose logging for detailed diagnostics.



In addition, it is also important that you define a procedure on how to react to scheduled events.

**Resources**

- [VM Scheduled Events](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/scheduled-events)
- [Configure Pacemaker for Azure Scheduled Events](https://learn.microsoft.com/en-us/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#configure-pacemaker-for-azure-scheduled-events)
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-36/sap-36.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-42 - ASCS-Pacemaker (Central Server Instance) Ensure Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**

For the ASCS-Pacemaker (Central Server Instance), ensure that the Pacemaker cluster configuration parameters are correctly set up for SAP ASCS high availability.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)
- [ASCS-Pacemaker - Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-42/sap-42.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-44 - ASCS-Pacemaker-RH (Central Server Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**

For the ASCS-Pacemaker-RH (Central Server Instance), ensure that the Pacemaker cluster configuration parameters are correctly set up for SAP ASCS high availability when running on Red Hat.

**Resources**

- [ASCS-Pacemaker-RH Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-44/sap-44.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-45 - ASCS-LB (Central Server Instance) Ensure the load balancer is configured correctly for SAP ASCS High availability

**Category: Availability**

**Impact: High**

**Guidance**

For the ASCS-LB (Central Server Instance), ensure that the load balancer is configured correctly for SAP ASCS high availability.

**Resources**

- [ASCS-LB - Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-45/sap-45.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-46 - DBHANA-Pacemaker (Database Instance) Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability

**Category: Availability**

**Impact: High**

**Guidance**

For the DBHANA-Pacemaker (Database Instance), ensure that the Pacemaker cluster configuration parameters are correctly set up for SAP HANA DB high availability.

**Resources**

- [DBHANA-Pacemaker - Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-46/sap-46.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-49 - DBHANA-LB (Database Instance) Ensure the load balancer is configured correctly for SAP HANA DB High availability

**Category: Availability**

**Impact: High**

**Guidance**

For the DBHANA-LB (Database Instance), make sure the load balancer is configured correctly for SAP HANA DB high availability.

**Resources**

- [DBHANA-LB- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-49/sap-49.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
