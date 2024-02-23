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
| [SAP-1 - Ensure SAP production systems are designed for high availability using availability zones.](#sap-1---ensure-sap-production-systems-are-designed-for-high-availability-using-availability-zones) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-2 - Run SAP application servers on two or more VMS using VMSS Flex.](#sap-2---run-sap-application-servers-on-two-or-more-vms-using-vmss-flex) | Availability | High | Published |[SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-3 - When using Virtual Machines Scale Set (VMSS), follow our recommendations for SAP workload using the right mode and correct settings.](#sap-3---when-using-virtual-machines-scale-set-vmss-it-is-configured-following-our-recommendations-for-sap-workload-using-the-right-mode-and-correct-settings) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-5 - In a zonal high availability setup if we can't use VMSS, then ensure  the SAP application server VMs of each zone are placed in an availability set using a proximity placement group so that VMs are distributed across multiple fault domains and update domains within each zone.](#sap-5---in-a-zonal-high-availability-setup-if-we-cant-use-vmss-then-ensure-the-sap-application-server-vms-of-each-zone-are-placed-in-an-availability-set-using-a-proximity-placement-group-so-vms-are-distributed-across-multiple-fault-domains-and-update-domains-within-each-zone)  | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-6 - Avoid placing application server and database VMs in one Proximity Placement Group.](#sap-6---avoid-placing-application-server-and-database-vms-in-one-proximity-placement-group) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group.](#sap-7---avoid-placing-vms-from-multiple-sap-systems-in-a-single-proximity-placement-group) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-8 - When creating availability sets, ensure to use the maximum number of fault domains available and a high enough number of update domains, we also audit our VMs to avoid unexpected deviation.](#sap-8---when-creating-availability-sets-ensure-to-use-the-maximum-number-of-fault-domains-available-and-a-high-enough-number-of-update-domains-we-also-audit-our-vms-to-avoid-unexpected-deviation) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-9 - If using single-instance VMs,  all OS and data disks must be Premium SSD or Ultra Disk to avail the single-instance SLA of 99.9% availability.](#sap-9---if-using-single-instance-vms-all-os-and-data-disks-must-be-premium-ssd-or-ultra-disk-to-avail-the-single-instance-sla-of-99-9-availability) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-14 - In case of database, ensure that the data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes.](#sap-14---in-case-of-database-ensure-that-the-data-is-replicated-synchronously-sync-mode-between-the-primary-and-secondary-database-hosting-vm-nodes) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-15 - Ensure that the SAP shared files systems such as /sapmnt, /usr/trans, interfaces have been made highly available, and in a zonal deployment, they are replicated to another zone.](#sap-15---ensure-that-the-sap-shared-files-systems-such-as-sapmnt-interfaces-have-been-made-highly-available-and-in-a-zonal-deployment-they-are-replicated-to-another-zone) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-16 - Test all our HA solutions thoroughly (including kernel panic in Linux VMs and also fail-back), fail overs are smooth and meet the expected fail over times. The failback can be either automatic or manual.](#sap-16---test-all-our-ha-solutions-thoroughly-including-kernel-panic-in-linux-vms-and-also-fail-back-fail-overs-are-smooth-and-meet-the-expected-fail-over-times-the-failback-can-be-either-automatic-or-manual) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-20 - Where we have a zonal SAP deployment, all components and Azure services are deployed with zone redundancy (for example ER GW, Azure LB, AppGW, Reverse proxy, IP addresses, firewalls, ANF, VMSS running any shared services like firewalls, backup infrastructure, and so on).](#sap-20---where-we-have-a-zonal-sap-deployment-all-components-and-azure-services-are-deployed-with-zone-redundancy-for-example-er-gw-azure-lb-appgw-reverse-proxy-ip-addresses-firewalls-anf-vmss-running-any-shared-services-like-firewalls-backup-infrastructure-and-so-on) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)   |
| [SAP-22 - Ensure that the SAP production workloads are protected by a cross-region DR solution.](#sap-22---ensure-that-the-sap-production-workloads-are-protected-by-a-cross-region-dr-solution) | Disaster Recovery | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-23 - For Customers leveraging Zonal DR, ensure that SAP production workloads are protected by a cross-zone DR solution.](#sap-23---for-customers-leveraging-zonal-dr-ensure-that-sap-production-workloads-are-protected-by-a-cross-zone-dr-solution) | Disaster Recovery | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-24 - Implementing an offsite backup strategy by utilizing the second Azure region for our backups.](#sap-24---implementing-an-offsite-backup-strategy-by-utilizing-the-second-azure-region-for-our-backups) | Disaster Recovery | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-26 - Consider On-demand Capacity Reservation to reserve our DR compute capacity.](#sap-26---consider-on-demand-capacity-reservation-to-reserve-our-dr-compute-capacity) | Disaster Recovery | Medium | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-27 - Ensure that the production databases are replicated (ASYNC) to DR location using the database vendor's replication technology.](#sap-27---ensure-that-the-production-databases-are-replicated-async-to-dr-location-using-the-database-vendors-replication-technology) | Disaster Recovery | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-28 - SAP components such as (A)SCS, application servers, WebDispatchers, etc are backed up to DR location using an appropriate backup tool or ASR.](#sap-28---sap-components-such-as-ascs-application-servers-webdispatchers-etc-are-backed-up-to-dr-location-using-an-appropriate-backup-tool-or-asr) | Disaster Recovery | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-29 - SAP shared files systems such as /sapmnt, /usr/trans, interfaces and any other critical to DR are replicated or backed up to DR location.](#sap-29---sap-shared-files-systems-such-as-sapmnt-usr-trans-interfaces-and-any-other-critical-to-dr-are-replicated-or-backed-up-to-dr-location) | Disaster Recovery | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-30 - Cross Region Restore for our Geo-redundant Recovery Services Vaults has been enabled so we can restore backed up data in the secondary region when the primary region is still available.](#sap-30---cross-region-restore-for-our-geo-redundant-recovery-services-vaults-has-been-enabled-so-we-can-restore-backed-up-data-in-the-secondary-region-when-the-primary-region-is-still-available) | Disaster Recovery | Medium | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-31 - Conduct backup testing to confirm that all the production systems can be backed up  simultaneously (or as needed) and the restore  is working within an expected time frame.](#sap-31---conduct-backup-testing-to-confirm-that-all-the-production-systems-can-be-backed-up-simultaneously-or-as-needed-and-the-restore-is-working-within-an-expected-time-frame) | Disaster Recovery | Medium | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-32 - Automate DR infrastructure build (or have pre-deployed DR resources) and SAP service recovery as much as possible.](#sap-32---automate-dr-infrastructure-build-or-have-pre-deployed-dr-resources-and-sap-service-recovery-as-much-as-possible) | Disaster Recovery | Medium | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-33 - Documented and tested our DR procedure,  ensure to meet our RPO and RTO targets.](#sap-33---documented-and-tested-our-dr-procedure-ensure-to-meet-our-rpo-and-rto-targets) | Disaster Recovery | Medium | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-36 - Configure scheduled events so you are notified of upcoming maintenance events for example reboot. Resource agent azure-events can also integrate with Pacemaker clusters.](#sap-36---configure-scheduled-events-so-you-are-notified-of-upcoming-maintenance-events-for-example-reboot) | Monitoring | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-37 - Defined a procedure on how to react to Scheduled events.](#sap-37---defined-a-procedure-on-how-to-react-to-scheduled-events) | Monitoring | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-39 - Setup Service Health alerts for all critical subscriptions so that you are notified of issues impacting availability of our Azure services and resources.](#sap-39---setup-service-health-alerts-for-all-critical-subscriptions-so-that-you-are-notified-of-issues-impacting-availability-of-our-azure-services-and-resources) | Monitoring | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-40 - Defined a procedure on how to react to Service Heath Alerts and the  SAP applications can automatically start in correct sequence.](#sap-40---defined-a-procedure-on-how-to-react-to-service-heath-alerts-and-the--sap-applications-can-automatically-start-in-correct-sequence) | Monitoring | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-42 - ASCS-Pacemaker - Central Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability.](#sap-42---ascs-pacemaker-central-server-instance-ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availability) | Automation | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-43 - ASCS-Pacemaker-SLES Central Server Instance ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on SLES.](#sap-43---ascs-pacemaker-sles-central-server-instance-ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availability-when-running-on-sles) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-44 -ASCS-Pacemaker-RH- Central Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on Red Hat.](#sap-44---ascs-pacemaker-rh-central-server-instance-ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availability-when-running-on-red-hat) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-45 - ASCS-LB - Central Server Instance - Ensure the load balancer is configured correctly for SAP ASCS High availability.](#sap-45---ascs-lb---central-server-instance---ensure-the-load-balancer-is-configured-correctly-for-sap-ascs-high-availability) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-46 - DBHANA-Pacemaker- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP HANA DB high availability.](#sap-46---dbhana-pacemaker-database-instance-ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-hana-db-high-availability) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-47 - DBHANA-Pacemaker-SLES- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP HANA DB high availability when running on SLES.](#sap-47---dbhana-pacemaker-sles-database-instance-ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-hana-db-high-availability-when-running-on-sles) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-48 - DBHANA-Pacemaker-RH- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on Red Hat"](#sap-48---dbhana-pacemaker-rh--database-instance---ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availability-when-running-on-red-hat) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-49 - DBHANA-LB- Database Instance - Ensure the load balancer is configured correctly for SAP HANA DB High availability.](#sap-49---dbhana-lb-database-instance-ensure-the-load-balancer-is-configured-correctly-for-sap-hana-db-high-availability) | Availability | High | Published | [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |




{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SAP-1 - Ensure SAP production systems are designed for high availability using availability zones

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-2 - Run SAP application servers on two or more VMS using VMSS Flex

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

In a zonal high availability setup,  use Virtual Machines Scale Set (VMSS) with flexible orchestration to distribute the virtual machines across specified zones and within each zone to also distribute VMs across different fault domains within the zone on a best effort basis.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-3 - When using Virtual Machines Scale Set (VMSS), it is configured following our recommendations for SAP workload using the right mode and correct settings

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-5 - In a zonal high availability setup if we can't use VMSS, then ensure the SAP application server VMs of each zone are placed in an availability set using a proximity placement group so VMs are distributed across multiple fault domains and update domains within each zone

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-6 - Avoid placing application server and database VMs in one Proximity Placement Group

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-8 - When creating availability sets, Ensure to use the maximum number of fault domains available and a high enough number of update domains, we also audit our VMs to avoid unexpected deviation

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-9 - If using single-instance VMs, all OS and data disks must be Premium SSD or Ultra Disk to avail the single-instance SLA of 99-9 availability

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-14 - In case of database, Ensure that the data is replicated synchronously SYNC mode between the primary and secondary database hosting VM nodes

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-15 - Ensure that the SAP shared files systems such as sapmnt interfaces have been made highly available and in a zonal deployment they are replicated to another zone

**Category:  Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-16 - Test all our HA solutions thoroughly (including kernel panic in Linux VMs and also fail-back), fail overs are smooth and meet the expected fail over times. The failback can be either automatic or manual

**Category:  Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-20 - Where we have a zonal SAP deployment, all components and Azure services are deployed with zone redundancy for example ER GW, Azure LB, AppGW, Reverse proxy, IP addresses, firewalls, ANF, VMSS running any shared services like firewalls, backup infrastructure, and so on

**Category:  Availability**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-22 - Ensure that the SAP production workloads are protected by a cross-region DR solution

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-23 - For Customers leveraging Zonal DR, ensure that SAP production workloads are protected by a cross-zone DR solution

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-24 - Implementing an offsite backup strategy by utilizing the second Azure region for our backups

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-26 - Consider On-demand Capacity Reservation to reserve our DR compute capacity

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-27 - Ensure that the production databases are replicated ASYNC to DR location using the database vendors replication technology

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-28 - SAP components such as (A)SCS, application servers, WebDispatchers, etc are backed up to DR location using an appropriate backup tool or ASR

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-29 - SAP shared files systems such as sapmnt, usr trans, interfaces and any other critical to DR are replicated or backed up to DR location

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-30 - Cross Region Restore for our Geo-redundant Recovery Services Vaults has been enabled so we can restore backed up data in the secondary region when the primary region is still available

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-31 - Conduct backup testing to confirm that all the production systems can be backed up simultaneously or as needed and the restore is working within an expected time frame

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-32 - Automate DR infrastructure build or have pre-deployed DR resources and SAP service recovery as much as possible

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-33 - Documented and tested our DR procedure, ensure to meet our RPO and RTO targets

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-36 - Configure scheduled events so you are notified of upcoming maintenance events for example reboot

**Category: Monitoring**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)


<br><br>

### SAP-37 - Defined a procedure on how to react to Scheduled events

**Category: Monitoring**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-39 - Setup Service Health alerts for all critical subscriptions so that you are notified of issues impacting availability of our Azure services and resources

**Category: Monitoring**

**Impact: High**

**Recommendation/Guidance**

.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-40 - Defined a procedure on how to react to Service Heath Alerts and the  SAP applications can automatically start in correct sequence

**Category: Monitoring**

**Impact: High**

**Recommendation/Guidance**

.


**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

<br><br>

### SAP-42 - ASCS-Pacemaker Central Server Instance Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**
- [SAP ACSS checks](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)
- [OpenSource Quality checks](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)

* [ASCS-Pacemaker - Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

<br><br>

### SAP-43 - ASCS-Pacemaker SLES Central server instance ensure the pacemaker cluster configuration parameters have been setup for sap ascs high availability when running on SLES

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**

* [ASCS-Pacemaker-SLESCentral Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

<br><br>

### SAP-44 - ASCS Pacemaker RH Central Server Instance Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on Red Hat

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**

* [ASCS-Pacemaker-RH Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)


<br><br>

### SAP-45 - ASCS-LB - Central Server Instance - Ensure the load balancer is configured correctly for SAP ASCS High availability

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**

* [ASCS-LB - Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

<br><br>

### SAP-46 - DBHANA Pacemaker Database Instance ensure the pacemaker cluster configuration parameters have been setup for SAP HANA Db high availability

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**

* [DBHANA-Pacemaker- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

<br><br>

### SAP-47 - DBHANA-Pacemaker SLES database instance ensure the pacemaker cluster configuration parameters have been setup for SAP HANA Db high availability when running on SLES

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**

* [DBHANA-Pacemaker-SLES- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

<br><br>

### SAP-48 - DBHANA-Pacemaker-RH- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on Red Hat

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**

* [DBHANA-Pacemaker-RH- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

<br><br>

### SAP-49 - DBHANA-LB Database Instance ensure the load balancer is configured correctly for SAP HANA Db high availability

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**
.

**Resources**

* [DBHANA-LB- Database Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

<br><br>
