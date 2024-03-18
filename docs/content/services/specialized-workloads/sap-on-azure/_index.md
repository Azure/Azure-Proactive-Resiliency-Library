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
| [SAP-1 - Ensure SAP production systems are designed for high availability.](#sap-1---ensure-sap-production-systems-are-designed-for-high-availability) | Availability | High | Published | No |
| [SAP-2 - Run SAP application servers on two or more VMS.](#sap-2---run-sap-application-servers-on-two-or-more-vms) | Availability | High | Published | No  |
| [SAP-3 - When using Virtual Machines Scale Set (VMSS), review recommendations for SAP workload.](#sap-3---when-using-virtual-machines-scale-set-review-recommendations-for-sap-workload) | Availability | High | Published | No |
| [SAP-5 - In a zonal high availability setup if we can't use VMSS, check use if availability zone and proximity placement group.](#sap-5---in-a-zonal-high-availability-setup-if-we-cant-use-vmss-check-use-if-availability-zone-and-proximity-placement-group)  | Availability | High | Published | No |
| [SAP-6 - Avoid placing application server and database in one Proximity Placement Group.](#sap-6---avoid-placing-application-server-and-database-in-one-proximity-placement-group) | Availability | High | Published |  No  |
| [SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group.](#sap-7---avoid-placing-vms-from-multiple-sap-systems-in-a-single-proximity-placement-group) | Availability | High | Published | No |
| [SAP-8 - When creating availability sets, enable fault domains.](#sap-8---when-creating-availability-sets-enable-fault-domains) | Availability | High | Published | No |
| [SAP-9 - If using single-instance VMs, all OS and data disks must be Premium SSD or Ultra Disk.](#sap-9---if-using-single-instance-vms-all-os-and-data-disks-must-be-premium-ssd-or-ultra-disk) | Availability | High | Published |  No  |
| [SAP-14 - Ensure that the data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes.](#sap-14---ensure-that-the-data-is-replicated-synchronously-sync-mode-between-the-primary-and-secondary-database-hosting-vm-nodes) | Availability | High | Published |  No  |
| [SAP-15 - Ensure that the SAP shared files systems are made highly available.](#sap-15---ensure-that-the-sap-shared-files-systems-are-made-highly-available) | Availability | High | Published |  No  |
| [SAP-16 - Test all HA solutions end to end.](#sap-16---test-all-ha-solutions-end-to-end) | Availability | High | Published | No |
| [SAP-20 - In zonal SAP deployment, ensure all components and Azure services are deployed with zone redundancy.](#sap-20---in-zonal-sap-deployment-ensure-all-components-and-azure-services-are-deployed-with-zone-redundancy) | Availability | High | Published | No  |
| [SAP-22 - Ensure that the SAP production workloads are protected by a cross-region DR solution.](#sap-22---ensure-that-the-sap-production-workloads-are-protected-by-a-cross-region-dr-solution) | Disaster Recovery | High | Published |  No  |
| [SAP-23 - If using Zonal DR, ensure that SAP production workloads are protected by cross-zone DR solution.](#sap-24---implementing-an-offsite-backup-strategy-by-utilizing-the-second-azure-region-for-our-backups) | Disaster Recovery | High | Published |  No  |
| [SAP-24 - Implementing an offsite backup strategy by utilizing the second Azure region for our backups.](#sap-24---implementing-an-offsite-backup-strategy-by-utilizing-the-second-azure-region-for-our-backups) | Disaster Recovery | High | Published | No  |
| [SAP-26 - Consider On-demand Capacity Reservation to reserve DR compute capacity.](#sap-26---consider-on-demand-capacity-reservation-to-reserve-dr-compute-capacity) | Disaster Recovery | Medium | Published | No |
| [SAP-27 - Ensure that the production databases are replicated (ASYNC) to DR location, use database vendor's replication.](#sap-27---ensure-that-the-production-databases-are-replicated-async-to-dr-location-use-database-vendors-replication) | Disaster Recovery | High | Published | No |
| [SAP-28 - SAP components are backed up to DR location using an appropriate backup tool or ASR.](#sap-28---sap-components-are-backed-up-to-dr-location-using-an-appropriate-backup-tool-or-asr) | Disaster Recovery | High | Published | No |
| [SAP-29 - SAP shared files systems and any other critical to DR are replicated or backed up to DR location.](#sap-29---sap-shared-files-systems-and-any-other-critical-to-dr-are-replicated-or-backed-up-to-dr-location) | Disaster Recovery | High | Published | No |
| [SAP-30 - Ensure Cross Region Restore of Recovery Services Vaults has been enabled.](#sap-30---ensure-cross-region-restore-of-recovery-services-vaults-has-been-enabled) | Disaster Recovery | Medium | Published |  No |
| [SAP-31 - Conduct backup testing, all the systems are backed up and restore is working within an expected time frame.](#sap-31---conduct-backup-testing-all-the-systems-are-backed-up-and-restore-is-working-within-an-expected-time-frame) | Disaster Recovery | Medium | Published |  No |
| [SAP-32 - Automate DR infrastructure build or pre-deploy DR resources.](#sap-32---automate-dr-infrastructure-build-or-pre-deploy-dr-resources) | Disaster Recovery | Medium | Published |  No  |
| [SAP-33 - Document and test DR procedure, ensure it meets RPO and RTO targets.](#sap-33---document-and-test-dr-procedure-ensure-it-meets-rpo-and-rto-targets) | Disaster Recovery | Medium | Published | No |
| [SAP-36 - Configure scheduled events notification.](#sap-36---configure-scheduled-events-notification) | Monitoring | High | Published | No |
| [SAP-37 - Defined a procedure on how to react to Scheduled events.](#sap-37---defined-a-procedure-on-how-to-react-to-scheduled-events) | Monitoring | High | Published | No  |
| [SAP-39 - Setup Service Health alerts for all critical subscriptions.](#sap-39---setup-service-health-alerts-for-all-critical-subscriptions) | Monitoring | High | Published |  No |
| [SAP-40 - Defined a procedure on how to react to Service Heath Alerts.](#sap-40---defined-a-procedure-on-how-to-react-to-service-heath-alerts) | Monitoring | High | Published | No  |
| [SAP-42 - ASCS-Pacemaker (Central Server Instance) Ensure Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-42---ascs-pacemaker-central-server-instance-ensure-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Automation | High | Published | No |
| [SAP-43 - ASCS-Pacemaker-SLES (Central Server Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-43---ascs-pacemaker-sles-central-server-instance-ensure-the-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Availability | High | Published | No  |
| [SAP-44 - ASCS-Pacemaker-RH (Central Server Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-44---ascs-pacemaker-rh-central-server-instance-ensure-the-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Availability | High | Published | No  |
| [SAP-45 - ASCS-LB (Central Server Instance) Ensure the load balancer is configured correctly for SAP ASCS High availability.](#sap-45---ascs-lb-central-server-instance-ensure-the-load-balancer-is-configured-correctly-for-sap-ascs-high-availability) | Availability | High | Published | No |
| [SAP-46 - DBHANA-Pacemaker (Database Instance) Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability.](#sap-46---dbhana-pacemaker-database-instance-ensure-the-pacemaker-cluster-has-been-setup-for-sap-hana-db-high-availability) | Availability | High | Published | No |
| [SAP-47 - DBHANA-Pacemaker-SLES (Database Instance) Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability.](#sap-46---dbhana-pacemaker-database-instance-ensure-the-pacemaker-cluster-has-been-setup-for-sap-hana-db-high-availability) | Availability | High | Published | No |
| [SAP-48 - DBHANA-Pacemaker-RH (Database Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-48---dbhana-pacemaker-rh-database-instance-ensure-the-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Availability | High | Published | No |
| [SAP-49 - DBHANA-LB (Database Instance) Ensure the load balancer is configured correctly for SAP HANA DB High availability.](#sap-49---dbhana-lb-database-instance-ensure-the-load-balancer-is-configured-correctly-for-sap-hana-db-high-availability) | Availability | High | Published | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SAP-1 - Ensure SAP production systems are designed for high availability

**Category: Availability**

**Impact: High**

**Guidance**

Ensure SAP production systems are designed for high availability using availability zones.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-1/sap-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-2 - Run SAP application servers on two or more VMS

**Category: Availability**

**Impact: High**

**Guidance**

Deploy SAP application servers on two or more virtual machines (VMs) using VMSS Flex.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-2/sap-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-3 - When using Virtual Machines Scale Set review recommendations for SAP workload

**Category: Availability**

**Impact: High**

**Guidance**

If utilizing Virtual Machine Scale Sets (VMSS), adhere to our guidelines for SAP workloads, ensuring you select the appropriate mode and configure the correct settings.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-3/sap-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-5 - In a zonal high availability setup if we can't use VMSS check use if availability zone and proximity placement group

**Category: Availability**

**Impact: High**

**Guidance**

In a zonal high availability setup if we can't use VMSS, then ensure the SAP application server VMs of each zone are placed in an availability set using a proximity placement group so that VMs are distributed across multiple fault domains and update domains within each zone.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-5/sap-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-6 - Avoid placing application server and database in one Proximity Placement Group

**Category: Availability**

**Impact: High**

**Guidance**

Ensure that you do not colocate application server and database virtual machines (VMs) within the same Proximity Placement Group.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

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

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-7/sap-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-8 - When creating availability sets enable fault domains

**Category: Availability**

**Impact: High**

**Guidance**

When creating availability sets, ensure you utilize the maximum number of fault domains available and a sufficient number of update domains. Additionally, conduct regular audits of VMs to prevent unexpected deviations.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

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

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-9/sap-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-14 - Ensure that the data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes

**Category: Availability**

**Impact: High**

**Guidance**

In the case of databases, ensure that data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-14/sap-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-15 - Ensure that the SAP shared files systems are made highly available

**Category: Availability**

**Impact: High**

**Guidance**

Make sure that SAP shared file systems, such as /sapmnt, /usr/trans and /interfaces are highly available. In zonal deployments, replicate them to another zone.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-15/sap-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-16 - Test all HA solutions end to end

**Category: Availability**

**Impact: High**

**Guidance**

Thoroughly test all high-availability (HA) solutions, including scenarios like kernel panic in Linux VMs and fail-back procedures. Failovers should be smooth and meet the expected failover times. Failback can be either automatic or manual.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-16/sap-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-20 - In zonal SAP deployment, ensure all components and Azure services are deployed with zone redundancy

**Category: Availability**

**Impact: High**

**Guidance**

In zonal SAP deployments, deploy all components and Azure services with zone redundancy. Examples include ER GW, Azure LB, AppGW, Reverse proxy, IP addresses, firewalls, ANF and VMSS running shared services like firewalls and backup infrastructure.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-20/sap-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-22 - Ensure that the SAP production workloads are protected by a cross-region DR solution

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Make sure that SAP production workloads have a disaster recovery (DR) solution spanning across multiple regions.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-22/sap-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-23 - If using Zonal DR, ensure that SAP production workloads are protected by cross-zone DR solution

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

When implementing Zonal Disaster Recovery (DR), make sure that SAP production workloads are safeguarded by a DR solution spanning across different zones.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-23/sap-23.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-24 - Implementing an offsite backup strategy by utilizing the second Azure region for our backups

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Create an offsite backup plan by leveraging the second Azure region for storing backups.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-24/sap-24.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-26 - Consider On-demand Capacity Reservation to reserve DR compute capacity

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

On-demand Capacity Reservation is recommended for disaster recovery (DR) needs.”

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

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

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-27/sap-27.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-28 - SAP components are backed up to DR location using an appropriate backup tool or ASR

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Back up SAP components such as (A)SCS, application servers, and WebDispatchers to the DR location using an appropriate backup tool or Azure Site Recovery (ASR).

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

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

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-29/sap-29.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-30 - Ensure Cross Region Restore of Recovery Services Vaults has been enabled

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Enable Cross Region Restore for Geo-redundant Recovery Services Vaults. This allows restoring backed-up data in the secondary region even when the primary region is still available.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-30/sap-30.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-31 - Conduct backup testing, all the systems are backed up and restore is working within an expected time frame

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Conduct backup testing to verify that all production systems can be backed up simultaneously (or as needed) and that the restore process works within the expected time frame.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-31/sap-31.kql" >}} {{< /code >}}

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

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-32/sap-32.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-33 - Document and test DR procedure, ensure it meets RPO and RTO targets

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Document and tes disaster recovery (DR) procedure to ensure it meets your Recovery Point Objective (RPO) and Recovery Time Objective (RTO) targets.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-33/sap-33.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-36 - Configure scheduled events notification

**Category: Monitoring**

**Impact: High**

**Guidance**

Configure scheduled events to receive notifications about upcoming maintenance events, such as reboots. The resource agent ‘azure-events’ can be integrated with Pacemaker clusters.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-36/sap-36.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-37 - Defined a procedure on how to react to Scheduled events

**Category: Monitoring**

**Impact: High**

**Guidance**

Define a procedure for reacting to scheduled events effectively.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-37/sap-37.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-39 - Setup Service Health alerts for all critical subscriptions

**Category: Monitoring**

**Impact: High**

**Guidance**

Set up Service Health alerts for all critical subscriptions, this will allow quicker response to incidents.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-39/sap-39.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-40 - Defined a procedure on how to react to Service Heath Alerts

**Category: Monitoring**

**Impact: High**

**Guidance**

Define a procedure for reacting to Service Health Alerts, ensuring that SAP applications can automatically start in the correct sequence.

**Resources**

- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-40/sap-40.kql" >}} {{< /code >}}

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

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-42/sap-42.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-43 - ASCS-Pacemaker-SLES (Central Server Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**

For the ASCS-Pacemaker-SLES (Central Server Instance), ensure that the Pacemaker cluster configuration parameters are correctly set up for SAP ASCS high availability when running on SLES.

**Resources**

- [ASCS-Pacemaker-SLESCentral Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-43/sap-43.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-44 - ASCS-Pacemaker-RH (Central Server Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**

For the ASCS-Pacemaker-RH (Central Server Instance), ensure that the Pacemaker cluster configuration parameters are correctly set up for SAP ASCS high availability when running on Red Hat.

**Resources**

- [ASCS-Pacemaker-RH Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

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

**Resource Graph Query/Scripts**

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

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-46/sap-46.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-47 - DBHANA-Pacemaker-SLES (Database Instance) Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability

**Category: Availability**

**Impact: High**

**Guidance**

For the DBHANA-Pacemaker-SLES (Database Instance), ensure that the Pacemaker cluster configuration parameters are correctly set up for SAP HANA DB high availability when running on SLES.

**Resources**

- [DBHANA-Pacemaker-SLES- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-47/sap-47.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-48 - DBHANA-Pacemaker-RH (Database Instance) Ensure the Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**

For the DBHANA-Pacemaker-RH (Database Instance), ensure that the Pacemaker cluster configuration parameters are correctly set up for SAP ASCS high availability when running on Red Hat.

**Resources**

- [DBHANA-Pacemaker-RH- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-48/sap-48.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-49 - DBHANA-LB (Database Instance) Ensure the load balancer is configured correctly for SAP HANA DB High availability

**Category: Availability**

**Impact: High**

**Guidance**

For the DBHANA-LB (Database Instance), make sure the load balancer is configured correctly for SAP HANA DB high availability.

**Resources**

- [DBHANA-LB- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-49/sap-49.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
