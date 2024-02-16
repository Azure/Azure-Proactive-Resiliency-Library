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
| [SAP-1 - Ensure SAP production systems are designed for high availability using availability zones.](#sap-1---ensure-sap-production-systems-are-designed-for-high-availability-using-availability-zones) | Compute | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-2 - Run SAP application servers on two or more VMS using VMSS Flex.](#sap-2---run-sap-application-servers-on-two-or-more-vms-using-vmss-flex) | Compute | High | Published |[SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-3 - When using Virtual Machines Scale Set (VMSS), follow our recommendations for SAP workload using the right mode and correct settings.](#sap-3---when-using-virtual-machines-scale-set-vmss-it-is-configured-following-our-recommendations-for-sap-workload-using-the-right-mode-and-correct-settings) | Compute | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-5 - In a zonal high availability setup if we can't use VMSS, then ensure  the SAP application server VMs of each zone are placed in an availability set using a proximity placement group so that VMs are distributed across multiple fault domains and update domains within each zone.](#sap-5---in-a-zonal-high-availability-setup-if-we-cant-use-vmss-then-ensure-the-sap-application-server-vms-of-each-zone-are-placed-in-an-availability-set-using-a-proximity-placement-group-so-vms-are-distributed-across-multiple-fault-domains-and-update-domains-within-each-zone)  | Compute | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-6 - Avoid placing application server and database VMs in one Proximity Placement Group.](#sap-6---avoid-placing-application-server-and-database-vms-in-one-proximity-placement-group) | Compute | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group.](#sap-7---avoid-placing-vms-from-multiple-sap-systems-in-a-single-proximity-placement-group) | Compute | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-8 - When creating availability sets, ensure to use the maximum number of fault domains available and a high enough number of update domains, we also audit our VMs to avoid unexpected deviation.](#sap-8---when-creating-availability-sets-ensure-to-use-the-maximum-number-of-fault-domains-available-and-a-high-enough-number-of-update-domains-we-also-audit-our-vms-to-avoid-unexpected-deviation) | Compute | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-9 - If using single-instance VMs,  all OS and data disks must be Premium SSD or Ultra Disk to avail the single-instance SLA of 99.9% availability.](#sap-9---if-using-single-instance-vms-all-os-and-data-disks-must-be-premium-ssd-or-ultra-disk-to-avail-the-single-instance-sla-of-99.9%-availability) | Compute | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-14 - In case of database, ensure that the data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes.](#sap-14---in-case-of-database,-esnure-that-the-data-is-replicated-synchronously-(sync-mode)-between-the-primary-and-secondary-database-hosting-vm-nodes) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-15 - Ensure that the SAP shared files systems such as /sapmnt, /usr/trans, interfaces have been made highly available, and in a zonal deployment, they are replicated to another zone.](#sap-15---ensure-that-the-sap-shared-files-systems-such-as-/-sapmnt,-/-usr/trans,-interfaces-have-been-made-highly-available,-and-in-a-zonal-deployment,-they-are-replicated-to-another-zone.) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-16 - Test all our HA solutions thoroughly (including kernel panic in Linux VMs and also fail-back), fail overs are smooth and meet the expected fail over times. The failback can be either automatic or manual.](#sap-16---test-all-our-ha-solutions-thoroughly-(including-kernel-panic-in-linux-vms-and-also-fail-back),-fail-overs-are-smooth-and-meet-the-expected-fail-over-times.-the-failback-can-be-either-automatic-or-manual.) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-20 - Where we have a zonal SAP deployment, all components and Azure services are deployed with zone redundancy (for example ER GW, Azure LB, AppGW, Reverse proxy, IP addresses, firewalls, ANF, VMSS running any shared services like firewalls, backup infrastructure, and so on).](#sap-20---where-we-have-a-zonal-sap-deployment,-all-components-and-azure-services-are-deployed-with-zone-redundancy-(for-example-er-gw,-azure-lb,-appgw,-reverse-proxy,-ip-addresses,-firewalls,-anf,-vmss-running-any-shared-services-like-firewalls,-backup-infrastructure,-and-so-on).) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)  |
| [SAP-22 - Ensure that the SAP production workloads are protected by a cross-region DR solution.](#sap-22---ensure-that-the-sap-production-workloads-are-protected-by-a-cross-region-dr-solution.) | Disaster Recover | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-23 - For Customers leveraging Zonal DR, ensure that SAP production workloads are protected by a cross-zone DR solution.](#sap-23---for-customers-leveraging-zonal-dr,-ensure-that-sap-production-workloads-are-protected-by-a-cross-zone-dr-solution.) | Disaster Recover | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-24 - Implementing an offsite backup strategy by utilizing the second Azure region for our backups.](#sap-24---implementing-an-offsite-backup-strategy-by-utilizing-the-second-azure-region-for-our-backups.) | Disaster Recover | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-26 - Consider On-demand Capacity Reservation to reserve our DR compute capacity.](#sap-26---consider-on-demand-capacity-reservation-to-reserve-our-dr-compute-capacity.”) | Disaster Recover | Medium | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-27 - Ensure that the production databases are replicated (ASYNC) to DR location using the database vendor's replication technology.](#sap-27---ensure-that-the-production-databases-are-replicated-(async)-to-dr-location-using-the-database-vendor’s-replication-technology.) | Disaster Recover | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-28 - SAP components such as (A)SCS, application servers, WebDispatchers, etc are backed up to DR location using an appropriate backup tool or ASR.](#sap-28---sap-components-such-as-(a)scs,-application-servers,-webdispatchers,-etc-are-backed-up-to-dr-location-using-an-appropriate-backup-tool-or-asr.) | Disaster Recover | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-29 - SAP shared files systems such as /sapmnt, /usr/trans, interfaces and any other critical to DR are replicated or backed up to DR location.](#sap-29---sap-shared-files-systems-such-as-/sapmnt,-/usr/trans,-interfaces-and-any-other-critical-to-dr-are-replicated-or-backed-up-to-dr-location.) | Disaster Recover | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-30 - Cross Region Restore for our Geo-redundant Recovery Services Vaults has been enabled so we can restore backed up data in the secondary region when the primary region is still available.](#sap-30---cross-region-restore-for-our-geo-redundant-recovery-services-vaults-has-been-enabled-so-we-can-restore-backed-up-data-in-the-secondary-region-when-the-primary-region-is-still-available.) | Disaster Recover | Medium | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-31 - Conduct backup testing to confirm that all the production systems can be backed up  simultaneously (or as needed) and the restore  is working within an expected time frame.](#sap-31---conduct-backup-testing-to-confirm-that-all-the-production-systems-can-be-backed-up--simultaneously-(or-as-needed)-and-the-restore--is-working-within-an-expected-time-frame.) | Disaster Recover | Medium | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-32 - Automat DR infrastructure build (or have pre-deployed DR resources) and SAP service recovery as much as possible.](#sap-32---automat-dr-infrastructure-build-(or-have-pre-deployed-dr-resources)-and-sap-service-recovery-as-much-as-possible.) | Disaster Recover | Medium | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-33 - Documented and tested our DR procedure,  ensure to meet our RPO and RTO targets.](#sap-33---documented-and-tested-our-dr-procedure,--ensure-to-meet-our-rpo-and-rto-targets.) | Disaster Recover | Medium | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-36 - Documented and tested our DR procedure,  ensure to meet our RPO and RTO targets.](#sap-36---documented-and-tested-our-dr-procedure,--ensure-to-meet-our-rpo-and-rto-targets.) | Azure Health | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights) <br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-37 - Defined a procedure on how to react to Scheduled events.](#sap-37---defined-a-procedure-on-how-to-react-to-scheduled-events.) | Azure Health | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-39 - Setup Service Health alerts for all critical subscriptions so that you are notified of issues impacting availability of our Azure services and resources.](#sap-39---setup-service-health-alerts-for-all-critical-subscriptions-so-that-you-are-notified-of-issues-impacting-availability-of-our-azure-services-and-resources.) | Azure Health | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-40 - Defined a procedure on how to react to Service Heath Alerts and the  SAP applications can automatically start in correct sequence.](#sap-40---defined-a-procedure-on-how-to-react-to-service-heath-alerts-and-the--sap-applications-can-automatically-start-in-correct-sequence.) | Azure Health | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-42 - ASCS-Pacemaker - Central Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability.](#sap-42---ascs-pacemaker---central-server-instance---ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availability.-) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) |
| [SAP-43 - ASCS-Pacemaker-SLESCentral Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on SLES.](#sap-43---ascs-pacemaker-slescentral-server-instance---ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availablility-when-running-on-sles.) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-44 -ASCS-Pacemaker-RH- Central Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on Red Hat.](#sap-44---ascs-pacemaker-rh--central-server-instance---ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availability-when-running-on-red-hat.) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-45 - ASCS-LB - Central Server Instance - Ensure the load balancer is configured correctly for SAP ASCS High availability.](#sap-45---ascs-lb---central-server-instance---ensure-the-load-balancer-is-configured-correctly-for-sap-ascs-high-availability) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-46 - DBHANA-Pacemaker- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP HANA DB high availability.](#sap-46---dbhana-pacemaker--database-instance---ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-hana-db-high-availability.) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-47 - DBHANA-Pacemaker-SLES- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP HANA DB high availability when running on SLES.](#sap-47---dbhana-pacemaker-sles--database-instance---ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-hana-db-high-availablility-when-running-on-sles.) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-48 - DBHANA-Pacemaker-RH- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availability when running on Red Hat"](#sap-48---dbhana-pacemaker-rh--database-instance---ensure-the-pacemaker-cluster-configuration-parameters-have-been-setup-for-sap-ascs-high-availablility-when-running-on-red-hat) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |
| [SAP-49 - DBHANA-LB- Database Instance - Ensure the load balancer is configured correctly for SAP HANA DB High availability.](#sap-49---dbhana-lb--database-instance---ensure-the-load-balancer-is-configured-correctly-for-sap-hana-db-high-availability.) | High Availability | High | Published | [SAP ACSS checks](#https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights)<br>[OpenSource Quality checks](#https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck)  |




{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SAP-1 - Ensure SAP production systems are designed for high availability using availability zones

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

Ensure SAP production systems are designed for high availability using availability zones.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-2 - Run SAP application servers on two or more VMS using VMSS Flex.

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

In a zonal high availability setup,  use Virtual Machines Scale Set (VMSS) with flexible orchestration to distribute the virtual machines across specified zones and within each zone to also distribute VMs across different fault domains within the zone on a best effort basis.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-3 - When using Virtual Machines Scale Set (VMSS), it is configured following our recommendations for SAP workload using the right mode and correct settings.

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

When using Virtual Machines Scale Set (VMSS), it is configured following our recommendations for SAP workload using the right mode and correct settings.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-5 - In a zonal high availability setup if we can't use VMSS, then ensure the SAP application server VMs of each zone are placed in an availability set using a proximity placement group so VMs are distributed across multiple fault domains and update domains within each zone

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

In a zonal high availability setup if we can't use VMSS, then application server VMs of each zone are placed in an availability set using a proximity placement group so VMs are distributed across multiple fault domains and update domains within each zone.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-6 - Avoid placing application server and database VMs in one Proximity Placement Group

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

Avoid placing application server and database VMs in one Proximity Placement Group.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-7 - Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group.

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

Avoid placing VMs from multiple SAP systems in a single Proximity Placement Group.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-8 - When creating availability sets, Ensure to use the maximum number of fault domains available and a high enough number of update domains, we also audit our VMs to avoid unexpected deviation.

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

If using single-instance VMs,  all OS and data disks must be Premium SSD or Ultra Disk to avail the single-instance SLA of 99.9% availability.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-9 - If using single-instance VMs, all OS and data disks must be Premium SSD or Ultra Disk to avail the single-instance SLA of 99.9% availability

**Category: Compute**

**Impact: High**

**Recommendation/Guidance**

If using single-instance VMs,  all OS and data disks must be Premium SSD or Ultra Disk to avail the single-instance SLA of 99.9% availability.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-14 - In case of database, Esnure that the data is replicated synchronously (SYNC mode) between the primary and secondary database hosting VM nodes.

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

In case of database, the data is replicated synchronously (SYNC mode) between our database hosting VM nodes.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-15 - Ensure that the SAP shared files systems such as /sapmnt, /usr/trans, interfaces have been made highly available, and in a zonal deployment, they are replicated to another zone.

**Category:  High Availability**

**Impact: High**

**Recommendation/Guidance**

Ensure that the SAP shared files systems such as /sapmnt, /usr/trans, interfaces have been made highly available, and in a zonal deployment, they are replicated to another zone.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-16 - Test all our HA solutions thoroughly (including kernel panic in Linux VMs and also fail-back), fail overs are smooth and meet the expected fail over times. The failback can be either automatic or manual.

**Category:  High Availability**

**Impact: High**

**Recommendation/Guidance**

Test all our HA solutions thoroughly (including kernel panic in Linux VMs and also fail-back), fail overs are smooth and meet the expected fail over times. The failback can be either automatic or manual.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-20 - Where we have a zonal SAP deployment, all components and Azure services are deployed with zone redundency (for example ER GW, Azure LB, AppGW, Reverse proxy, IP addresses, firewalls, ANF, VMSS running any shared services like firewalls, backup infrastructure, and so on).

**Category:  High Availability**

**Impact: High**

**Recommendation/Guidance**

Where we have a zonal SAP deployment, all components and Azure services are deployed with zone redundency (for example ER GW, Azure LB, AppGW, Reverse proxy, IP addresses, firewalls, ANF, VMSS running any shared services like firewalls, backup infrastructure, and so on).

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-22 - Ensure that the SAP production workloads are protected by a cross-region DR solution.

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

SAP production workloads are protected by a cross-region DR solution.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-23 - For Customers leveraging Zonal DR, ensure that SAP production workloads are protected by a cross-zone DR solution.

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

SAP production workloads are protected by a cross-zone DR solution.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-24 - Implementing an offsite backup strategy by utilizing the second Azure region for our backups.

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

Implementing an offsite backup strategy by utilizing the second Azure region for our backups.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-26 - Consider On-demand Capacity Reservation to reserve our DR compute capacity.

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

We considered On-demand Capacity Reservation to reserve our DR compute capacity.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-27 - Ensure that the production databases are replicated (ASYNC) to DR location using the database vendor's replication technology.

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

The  production databases are replicated (ASYNC) to DR location using the database vendor's replication technology.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-28 - SAP components such as (A)SCS, application servers, WebDispatchers, etc are backed up to DR location using an appropriate backup tool or ASR.

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

SAP components such as (A)SCS, applicatoin servers, WebDispatchers, etc are backed up to DR location using an appropriate backup tool or ASR.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-29 - SAP shared files systems such as /sapmnt, /usr/trans, interfaces and any other critical to DR are replicated or backed up to DR location.

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

SAP shared files systems such as /sapmnt, /usr/trans, interfaces and any other critical to DR are replicated or backed up to DR location.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-30 - Cross Region Restore for our Geo-redundant Recovery Services Vaults has been enabled so we can restore backed up data in the secondary region when the primary region is still available.

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

Cross Region Restore for our Geo-redundant Recovery Services Vaults has been enabled so we can restore backed up data in the secondary region when the primary region is still available.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-31 - Conduct backup testing to confirm that all the production systems can be backed up  simultaneously (or as needed) and the restore  is working within an expected time frame.

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

Our backup testing confirmed that we can back up all production systems simultaneously (or as needed) and when needed restore them, both within an expected time frame.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-32 - Automat DR infrastructure build (or have pre-deployed DR resources) and SAP service recovery as much as possible.

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

Automat DR infrastructure build (or have pre-deployed DR resources) and SAP service recovery as much as possible.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-33 - Documented and tested our DR procedure,  ensure to meet our RPO and RTO targets.

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

Documented and tested our DR procedure,  ensure to meet our RPO and RTO targets.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-36 - Configure scheduled events so you are notified of upcoming maintenance events (for example, reboot). Resource agent azure-events can also integrate with Pacemaker clusters.

**Category: Azure Health**

**Impact: High**

**Recommendation/Guidance**

Configure scheduled events so you are notified of upcoming maintenance events (for example, reboot). Resource agent azure-events can also integrate with Pacemaker clusters.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-37 - Defined a procedure on how to react to Scheduled events.

**Category: Azure Health**

**Impact: High**

**Recommendation/Guidance**

Defined a procedure on how to react to Scheduled events.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-39 - Setup Service Health alerts for all critical subscriptions so that you are notified of issues impacting availability of our Azure services and resources.

**Category: Azure Health**

**Impact: High**

**Recommendation/Guidance**

Setup Service Health alerts for all critical subscriptions so that you are notified of issues impacting availability of our Azure services and resources.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-40 - Defined a procedure on how to react to Service Heath Alerts and the  SAP applications can automatically start in correct sequence.

**Category: Azure Health**

**Impact: High**

**Recommendation/Guidance**

Defined a procedure on how to react to Service Heath Alerts and the  SAP applications can automatically start in correct sequence.

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-42 - ASCS-Pacemaker - Central Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availablility.

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[ASCS-Pacemaker - Central Server Instance](https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-43 - ASCS-Pacemaker-SLESCentral Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availablility when running on SLES.

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[ASCS-Pacemaker-SLESCentral Server Instance](#https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-44 - ASCS-Pacemaker-RH- Central Server Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availablility when running on Red Hat.

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[ASCS-Pacemaker-RH Central Server Instance](#https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-45 - ASCS-LB - Central Server Instance - Ensure the load balancer is configured correctly for SAP ASCS High availability

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[ASCS-LB - Central Server Instance](#https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-46 - DBHANA-Pacemaker- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP HANA DB high availablility."

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[DBHANA-Pacemaker- Database Instance](#https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-47 - DBHANA-Pacemaker-SLES- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP HANA DB high availablility when running on SLES.

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[DBHANA-Pacemaker-SLES- Database Instance](#https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-48 - DBHANA-Pacemaker-RH- Database Instance - Ensure the pacemaker cluster configuration parameters have been setup for SAP ASCS high availablility when running on Red Hat"

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[DBHANA-Pacemaker-RH- Database Instance](#https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### SAP-49 - DBHANA-LB- Database Instance - Ensure the load balancer is configured correctly for SAP HANA DB High availability

**Category: High Availability**

**Impact: High**

**Recommendation/Guidance**

[DBHANA-LB- Database Instance](#https://docs.microsoft.com/en-us/azure/advisor/advisor-reference-reliability-recommendations)

**Resources**

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
