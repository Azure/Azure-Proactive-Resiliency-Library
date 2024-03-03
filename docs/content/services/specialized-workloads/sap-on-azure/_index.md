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
| [SAP-1 - Ensure SAP production systems are designed for high availability.](#sap-1---ensure-sap-production-systems-are-designed-for-high-availability) | Availability | High | Published | Yes |
| [SAP-2 - Run SAP application servers on two or more VMS.](#sap-2---run-sap-application-servers-on-two-or-more-vms) | Availability | High | Published |Yes  |
| [SAP-3 - When using Virtual Machines Scale Set (VMSS), review recommendations for SAP workload.](#sap-3---when-using-virtual-machines-scale-set-review-recommendations-for-sap-workload) | Availability | High | Published |Yes |
| [SAP-5 - In a zonal high availability setup if we can't use VMSS, check use if availability zone and proximity placement group.](#sap-5---in-a-zonal-high-availability-setup-if-we-cant-use-vmss-check-use-if-availability-zone-and-proximity-placement-group)  | Availability | High | Published | Yes |
| [SAP-6 - Avoid placing application server and database in one Proximity Placement Group.](#sap-6---avoid-placing-application-server-and-database-in-one-proximity-placement-group) | Availability | High | Published | Yes  |
| [SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group.](#sap-7---avoid-placing-vms-from-multiple-sap-systems-in-a-single-proximity-placement-group) | Availability | High | Published | Yes |
| [SAP-8 - When creating availability sets, enable fault domains.](#sap-8---when-creating-availability-sets-enable-fault-domains) | Availability | High | Published | Yes |
| [SAP-9 - If using single-instance VMs, all OS and data disks must be Premium SSD or Ultra Disk.](#sap-9---if-using-single-instance-vms-all-os-and-data-disks-must-be-premium-ssd-or-ultra-disk) | Availability | High | Published | Yes  |
| [SAP-14 - Ensure that the data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes.](#sap-14---ensure-that-the-data-is-replicated-synchronously-sync-mode-between-the-primary-and-secondary-database-hosting-vm-nodes) | Availability | High | Published | Yes  |
| [SAP-15 - Ensure that the SAP shared files systems are made highly available.](#sap-15---ensure-that-the-sap-shared-files-systems-are-made-highly-available) | Availability | High | Published | Yes  |
| [SAP-16 - Test all  HA solutions end to end.](#sap-16---test-all--ha-solutions-end-to-end) | Availability | High | Published | Yes  |
| [SAP-20 -In zonal SAP deployment, ensure all components and Azure services are deployed with zone redundancy.](#sap-20--in-zonal-sap-deployment-ensure-all-components-and-azure-services-are-deployed-with-zone-redundancy) | Availability | High | Published | Yes   |
| [SAP-22 - Ensure that the SAP production workloads are protected by a cross-region DR solution.](#sap-22---ensure-that-the-sap-production-workloads-are-protected-by-a-cross-region-dr-solution) | Disaster Recovery | High | Published | Yes  |
| [SAP-23 - If using Zonal DR, ensure that SAP production workloads are protected by cross-zone DR solution.](#sap-24---implementing-an-offsite-backup-strategy-by-utilizing-the-second-azure-region-for-our-backups) | Disaster Recovery | High | Published | Yes  |
| [SAP-24 - Implementing an offsite backup strategy by utilizing the second Azure region for our backups.](#sap-24---implementing-an-offsite-backup-strategy-by-utilizing-the-second-azure-region-for-our-backups) | Disaster Recovery | High | Published | Yes  |
| [SAP-26 - Consider On-demand Capacity Reservation to reserve DR compute capacity.](#sap-26---consider-on-demand-capacity-reservation-to-reserve-dr-compute-capacity) | Disaster Recovery | Medium | Published | Yes  |
| [SAP-27 - Ensure that the production databases are replicated (ASYNC) to DR location, use database vendor's replication.](#sap-27---ensure-that-the-production-databases-are-replicated-async-to-dr-location-use-database-vendors-replication) | Disaster Recovery | High | Published | Yes |
| [SAP-28 - SAP components are backed up to DR location using an appropriate backup tool or ASR.](#sap-28---sap-components-are-backed-up-to-dr-location-using-an-appropriate-backup-tool-or-asr) | Disaster Recovery | High | Published | Yes|
| [SAP-29 - SAP shared files systems and any other critical to DR are replicated or backed up to DR location.](#sap-29---sap-shared-files-systems-and-any-other-critical-to-dr-are-replicated-or-backed-up-to-dr-location) | Disaster Recovery | High | Published |Yes |
| [SAP-30 - Ensure Cross Region Restore of Recovery Services Vaults has been enabled.](#sap-30---ensure-cross-region-restore-of-recovery-services-vaults-has-been-enabled) | Disaster Recovery | Medium | Published | Yes  |
| [SAP-31 - Conduct backup testing, all the systems are backed up and restore is working within an expected time frame.](#sap-31---conduct-backup-testing-all-the-systems-are-backed-up-and-restore-is-working-within-an-expected-time-frame) | Disaster Recovery | Medium | Published | Yes  |
| [SAP-32 - Automate DR infrastructure build or pre-deploy DR resources.](#sap-32---automate-dr-infrastructure-build-or-pre-deploy-dr-resources) | Disaster Recovery | Medium | Published | Yes  |
| [SAP-33 - Document and test DR procedure, ensure it  meets RPO and RTO targets.](#sap-33---document-and-test-dr-procedure-ensure-it--meets-rpo-and-rto-targets) | Disaster Recovery | Medium | Published | Yes  |
| [SAP-36 - Configure scheduled events notification.](#sap-36---configure-scheduled-events-notification) | Monitoring | High | Published |Yes |
| [SAP-37 - Defined a procedure on how to react to Scheduled events.](#sap-37---defined-a-procedure-on-how-to-react-to-scheduled-events) | Monitoring | High | Published | Yes  |
| [SAP-39 - Setup Service Health alerts for all critical subscriptions.](#sap-39---setup-service-health-alerts-for-all-critical-subscriptions) | Monitoring | High | Published | Yes  |
| [SAP-40 - Defined a procedure on how to react to Service Heath Alerts.](#sap-40---defined-a-procedure-on-how-to-react-to-service-heath-alerts) | Monitoring | High | Published | Yes  |
| [SAP-42 - ASCS-Pacemaker - Central Server Instance - Ensure Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-42---ascs-pacemaker---central-server-instance---ensure-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Automation | High | Published | Yes |
| [SAP-43 - ASCS-Pacemaker-SLES Central Server Instance - Ensure the Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-43---ascs-pacemaker-sles-central-server-instance---ensure-the-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Availability | High | Published | Yes  |
| [SAP-44 -ASCS-Pacemaker-RH- Central Server Instance - Ensure the Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-44--ascs-pacemaker-rh--central-server-instance---ensure-the-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Availability | High | Published | Yes  |
| [SAP-45 - ASCS-LB - Central Server Instance - Ensure the load balancer is configured correctly for SAP ASCS High availability.](#sap-45---ascs-lb---central-server-instance---ensure-the-load-balancer-is-configured-correctly-for-sap-ascs-high-availability) | Availability | High | Published | Yes  |
| [SAP-46 - DBHANA-Pacemaker- Database Instance - Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability.](#sap-46---dbhana-pacemaker--database-instance---ensure-the-pacemaker-cluster-has-been-setup-for-sap-hana-db-high-availability) | Availability | High | Published | Yes  |
| [SAP-47 - DBHANA-Pacemaker-SLES- Database Instance - Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability.](#sap-47---dbhana-pacemaker-sles--database-instance---ensure-the-pacemaker-cluster-has-been-setup-for-sap-hana-db-high-availability) | Availability | High | Published | Yes  |
| [SAP-48 - DBHANA-Pacemaker-RH- Database Instance - Ensure the Pacemaker cluster has been setup for SAP ASCS high availability.](#sap-48---dbhana-pacemaker-rh--database-instance---ensure-the-pacemaker-cluster-has-been-setup-for-sap-ascs-high-availability) | Availability | High | Published | Yes  |
| [SAP-49 - DBHANA-LB- Database Instance - Ensure the load balancer is configured correctly for SAP HANA DB High availability.](#sap-49---dbhana-lb--database-instance---ensure-the-load-balancer-is-configured-correctly-for-sap-hana-db-high-availability) | Availability | High | Published | Yes  |




{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SAP-1 - Ensure SAP production systems are designed for high availability

**Category: Availability**

**Impact: High**

**Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-1/sap-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-2 - Run SAP application servers on two or more VMS.

**Category: Availability**

**Impact: High**

**Guidance**

In a zonal high availability setup,  use Virtual Machines Scale Set (VMSS) with flexible orchestration to distribute the virtual machines across specified zones and within each zone to also distribute VMs across different fault domains within the zone on a best effort basis.

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

.

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

.

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

.

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

.

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

.

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

.

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

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-14/sap-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-15 - Ensure that the SAP shared files systems are made highly available

**Category:  Availability**

**Impact: High**

**Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-15/sap-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-16 - Test all  HA solutions end to end

**Category:  Availability**

**Impact: High**

**Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-16/sap-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-20 -In zonal SAP deployment, ensure all components and Azure services are deployed with zone redundancy

**Category:  Availability**

**Impact: High**

**Guidance**

.

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

.

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

.

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

.

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

.

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

.

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

.

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

.

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

.

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

.

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

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-32/sap-32.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-33 - Document and test DR procedure, ensure it  meets RPO and RTO targets

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

.

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

.

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

.

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

.

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

.


**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-40/sap-40.kql" >}} {{< /code >}}

{{< /collapse >}}
<br><br>

### SAP-42 - ASCS-Pacemaker - Central Server Instance - Ensure Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)
- [ASCS-Pacemaker - Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-42/sap-42.kql" >}} {{< /code >}}

{{< /collapse >}}
<br><br>

### SAP-43 - ASCS-Pacemaker-SLES Central Server Instance - Ensure the Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**

* [ASCS-Pacemaker-SLESCentral Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-43/sap-43.kql" >}} {{< /code >}}

{{< /collapse >}}
<br><br>

### SAP-44 -ASCS-Pacemaker-RH- Central Server Instance - Ensure the Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**

* [ASCS-Pacemaker-RH Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-44/sap-44.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-45 - ASCS-LB - Central Server Instance - Ensure the load balancer is configured correctly for SAP ASCS High availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**

* [ASCS-LB - Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-45/sap-45.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-46 - DBHANA-Pacemaker- Database Instance - Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**

* [DBHANA-Pacemaker- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-46/sap-46.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-47 - DBHANA-Pacemaker-SLES- Database Instance - Ensure the Pacemaker cluster has been setup for SAP HANA DB high availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**

* [DBHANA-Pacemaker-SLES- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-47/sap-47.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-48 - DBHANA-Pacemaker-RH- Database Instance - Ensure the Pacemaker cluster has been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**

* [DBHANA-Pacemaker-RH- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-48/sap-48.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-49 - DBHANA-LB- Database Instance - Ensure the load balancer is configured correctly for SAP HANA DB High availability

**Category: Availability**

**Impact: High**

**Guidance**
.

**Resources**

* [DBHANA-LB- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sap-49/sap-49.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
