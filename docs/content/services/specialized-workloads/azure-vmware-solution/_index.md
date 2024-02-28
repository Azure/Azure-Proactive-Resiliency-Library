+++
title = "Azure VMware Solution"
description = "Best practices and resiliency recommendations for Azure VMware Solution and associated resources and settings."
date = "02/27/2024"
author = "michielvanschaik"
msAuthor = "mivansch"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure VMware Solution and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  Recommendation                                   |      Category         |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :------:          |
|[AVS-3 Configure Azure Monitor Alert warning thresholds for vSAN datastore consumption](#avs-3---configure-azure-monitor-alert-warning-thresholds-for-vsan-datastore-consumption) | Monitoring | High | Preview | No |
|[AVS-4 Enable Stretched Clusters for High Availability of the vSAN Datastore](#avs-4---enable-stretched-clusters-for-high-availability-of-the-vsan-datastore) | Availability | Low | Preview | No |
|[AVS-5 Monitor CPU Utilization to ensure sufficient resources](#avs-5---monitor-cpu-utilization-to-ensure-sufficient-resources) | Monitoring | Medium | Preview | No |
|[AVS-6 Monitor Memory Utilization to ensure sufficient resources](#avs-6---monitor-memory-utilization-to-ensure-sufficient-resources) | Monitoring | Medium | Preview | No |
|[AVS-7 Monitor when AVS Cluster Size is approaching the host limit](#avs-7---monitor-when-avs-cluster-size-is-approaching-the-host-limit) | Monitoring | Medium | Preview | No |
|[AVS-8 Monitor when AVS Private Cloud is reaching capacity](#avs-8---monitor-when-avs-private-cloud-is-reaching-capacity) | Monitoring | Medium | Preview | No |
|[AVS-9 Apply Resource lock on the resource group hosting the private cloud](#avs-9---apply-resource-lock-on-the-resource-group-hosting-the-private-cloud) | Governance | High | Preview | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AVS-3 - Configure Azure Monitor Alert warning thresholds for vSAN datastore consumption

**Category: Monitoring**

**Impact: High**

**Recommendation/Guidance**

Ensure storage utilization is monitored, and alerts are configured so that VMware vSAN datastore slack space is maintained at the levels that the service-level agreement (SLA) mandates.

For service-level agreement (SLA) purposes, Azure VMware Solution requires slack space of 25% available on vSAN. vSAN storage utilization should be regularly monitored and alerts configured at 70% utilization (30% slack space available on vSAN) and 75% utilization (25% slack space available on vSAN) in order to provide enough time for capacity planning.

To expand the vSAN datastore additional hosts can be added, up to the maximum supported cluster size (16 hosts). Note, you may need to request host quota.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-3/avs-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-4 - Enable Stretched Clusters for High Availability of the vSAN Datastore

**Category: Availability**

**Impact: Low**

**Recommendation/Guidance**

If you are in a region that supports stretched clusters, consider enabling this feature to spread the VSAN datastore across two availability zones. Note: Configuring an SDDC as a stretched cluster can only be done during initial implementation and requires twice the amount of quota. This is due to a stretch cluster deploying a secondary cluster in the second availability zone of the same size as the primary cluster.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/infrastructure#implement-high-availability)
- [Stretched Clusters](https://learn.microsoft.com/en-us/azure/azure-vmware/deploy-vsan-stretched-clusters)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-4/avs-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-5 - Monitor CPU Utilization to ensure sufficient resources

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure there are enough compute resources to avoid host failure.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-5/avs-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-6 - Monitor Memory Utilization to ensure sufficient resources

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure there are enough memory resources to avoid host failure.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-6/avs-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-7 - Monitor when AVS Cluster Size is approaching the host limit

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Alert when the cluster size of 10 hosts is reached. Periodically fire up alerts, to prompt the customer to plan for a new cluster or additional datastore, if growth driven solely by storage. Beyond 10 hosts, every time a new host is added, surface an alert.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-7/avs-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-8 - Monitor when AVS Private Cloud is reaching capacity

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

### AVS-9 - Apply Resource lock on the resource group hosting the private cloud

**Category: Governance**

**Impact: High**

**Recommendation/Guidance**

Anyone with contributor access on the resource group hosting AVS Private Cloud can delete it. Applying a resource lock AVS Private Cloud  resource group to prevent deletion of the AVS Private Cloud.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-9/avs-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
