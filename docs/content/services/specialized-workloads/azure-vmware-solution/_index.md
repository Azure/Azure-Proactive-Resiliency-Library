+++
title = "Azure VMware Solution"
description = "Best practices and resiliency recommendations for Azure VMware Solution and associated resources and settings."
date = "02/29/2024"
author = "michielvanschaik"
msAuthor = "mivansch"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure VMware Solution and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  Recommendation                                   |      Category         |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :------:          |
|[AVS-1 Configure Azure Service Health notification and alerts for AVS](#avs-1---configure-azure-service-health-notification-and-alerts-for-avs) | Monitoring | Medium | Preview | Yes |
|[AVS-2 Configure Syslog in Diagnostic Settings for AVS](#avs-2---configure-syslog-in-diagnostic-settings-for-avs) | Monitoring | Medium | Preview | Yes |
|[AVS-3 Configure Azure Monitor Alert warning thresholds for vSAN datastore utilization](#avs-3---configure-azure-monitor-alert-warning-thresholds-for-vsan-datastore-utilization) | Monitoring | High | Preview | Yes |
|[AVS-4 Enable Stretched Clusters for Multi-AZ Availability of the vSAN Datastore](#avs-4---enable-stretched-clusters-for-multi-az-availability-of-the-vsan-datastore) | Availability | Low | Preview | Yes |
|[AVS-5 Monitor CPU Utilization to ensure sufficient resources for workloads](#avs-5---monitor-cpu-utilization-to-ensure-sufficient-resources-for-workloads) | Monitoring | Medium | Preview | Yes |
|[AVS-6 Monitor Memory Utilization to ensure sufficient resources for workloads](#avs-6---monitor-memory-utilization-to-ensure-sufficient-resources-for-workloads) | Monitoring | Medium | Preview | Yes |
|[AVS-7 Monitor when Azure VMware Solution Cluster Size is approaching the host limit](#avs-7---monitor-when-azure-vmware-solution-cluster-size-is-approaching-the-host-limit) | Monitoring | Medium | Preview | No |
|[AVS-8 Monitor when Azure VMware Solution Private Cloud is reaching capacity limit](#avs-8---monitor-when-azure-vmware-solution-private-cloud-is-reaching-capacity-limit) | Monitoring | Medium | Preview | No |
|[AVS-9 Apply Resource delete lock on the resource group hosting the private cloud](#avs-9---apply-resource-delete-lock-on-the-resource-group-hosting-the-private-cloud) | Governance | High | Preview | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AVS-1 - Configure Azure Service Health notification and alerts for AVS

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure Azure Service Health notifications and alerts are configured for the Azure VMware Solution(AVS) service in the subscriptions and regions where AVS is deployed.

Azure Service Health is the mechanism used to inform customers of any service or security issues affecting their private cloud deployment.  Additionally, Azure Service Health is used to inform customers of maintenance activities in their AVS environments including host replacements, upgrades, and any service updates which could potentially impact customer operations. Proper configuration of Azure Service Health notifications and alerts ensures that customers receive relevant notifications and can reduce service request submissions due to AVS maintenance.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-management-and-monitoring#design-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-1/avs-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-2 - Configure Syslog in Diagnostic Settings for AVS

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure Diagnostic Settings are configured for each private cloud to send the syslogs to one or more external sources for analysis and/or archiving.

Azure VMware Solution Syslogs have useful data for troubleshooting and performance that can help with quicker issue resolution and can also enable early detection of some kinds of issues. Configure Diagnostic Settings on the private cloud to send the Syslogs to one or more external sources for querying and/or archiving in case of an audit.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#manage-logs-and-archives)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="powershell" file="code/avs-2/avs-2.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-3 - Configure Azure Monitor Alert warning thresholds for vSAN datastore utilization

**Category: Monitoring**

**Impact: High**

**Recommendation/Guidance**

Ensure storage utilization is monitored, and alerts are configured so that VMware vSAN datastore slack space is maintained at the level the service-level agreement (SLA) mandates.

For service-level agreement (SLA) purposes, Azure VMware Solution requires slack space of 25% available on vSAN. vSAN storage utilization should be regularly monitored and alerts configured at 70% utilization (30% slack space available on vSAN) and 75% utilization (25% slack space available on vSAN) in order to provide enough time for capacity planning.

To expand the vSAN datastore additional hosts can be added, up to the maximum supported cluster size (16 hosts). Note, you may need to request host quota. In addition, external storage can be added (e.g. Azure Elastic SAN, Azure NetApp Files, Pure Cloud Block Storage) if the CPU and RAM requirements are being met by the Azure VMware Solution cluster.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-3/avs-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-4 - Enable Stretched Clusters for Multi-AZ Availability of the vSAN Datastore

**Category: Availability**

**Impact: Low**

**Recommendation/Guidance**

If the customer has a requirement for Multi-AZ deployment of Azure VMware Solution, need an infrastructure SLA of 99.99%, or need synchronous storage replication between AZs (RPO=0), then Azure VMware Solution Stretched Clusters should be considered. If you are in a region that supports stretched clusters, consider enabling this feature to spread the VMware vSAN datastore across two availability zones. Note: Configuring an Azure VMware Solution private cloud as a stretched cluster can only be done during initial implementation and requires twice the amount of quota. This is due to a stretched cluster extending the cluster to the second availability zone.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/infrastructure#implement-high-availability)
- [Stretched Clusters](https://learn.microsoft.com/en-us/azure/azure-vmware/deploy-vsan-stretched-clusters)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-4/avs-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-5 - Monitor CPU Utilization to ensure sufficient resources for workloads

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure there are enough compute resources to avoid host resource exhaustion. Azure VMware Solution uses vSphere DRS and vSphere HA to manage workload resources dynamically, however sustained host CPU utilization of over 95% can contribute to high CPU Ready times which will impact running workloads.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-5/avs-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-6 - Monitor Memory Utilization to ensure sufficient resources for workloads

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure there are enough memory resources to avoid host resource exhaustion. Azure VMware Solution uses vSphere DRS and vSphere HA to manage workload resources dynamically, however sustained host memory utilization of over 95% can contribute to host memory swapping to disk which will impact running workloads.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-6/avs-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-7 - Monitor when Azure VMware Solution Cluster Size is approaching the host limit

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Alert when the cluster size of 14 hosts is reached. Periodically fire up alerts, to prompt the customer to plan for a new cluster or additional datastore, if growth driven solely by storage. Beyond 14 hosts, every time a new host is added, surface an alert.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-7/avs-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-8 - Monitor when Azure VMware Solution Private Cloud is reaching capacity limit

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Alert when the total node count is greater than or equal to 90 hosts so that it's clear when to start planning for a new private cloud.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-8/avs-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-9 - Apply Resource delete lock on the resource group hosting the private cloud

**Category: Governance**

**Impact: High**

**Recommendation/Guidance**

Anyone with contributor access on the resource group hosting Azure VMware Solution Private Cloud can delete it. Applying a resource delete lock to the Azure VMware Solution Private Cloud resource group to prevent deletion of the Azure VMware Solution Private Cloud.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-9/avs-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
