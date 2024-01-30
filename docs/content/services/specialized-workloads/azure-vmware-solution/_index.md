+++
title = "Azure VMware Solution"
description = "Best practices and resiliency recommendations for Azure VMware Solution and associated resources and settings."
date = "01/10/2024"
author = "michielvanschaik"
msAuthor = "mivansch"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure VMware Solution and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  Recommendation                                   |      Impact         |  Design Area         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :------:          |
| [AVS-1 Monitor Service Health](#avs-1---monitor-service-health)    | Medium | Resiliency/Monitoring |  Preview  |        No         |
| [AVS-2 Configure syslog in Diagnostic Settings](#avs-2---configure-syslog-in-diagnostic-settings)    | Medium | Resiliency/Monitoring |  Preview  |        No         |
| [AVS-3 Azure Monitor Alert for vSAN datastore consumption](#avs-3---azure-monitor-alert-for-vsan-datastore-consumption)    | High | Infrastructure |  Preview  |        No         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AVS-1 - Monitor Service Health

**Category: Application Resilience/Availability**

**Impact: Medium**

**Recommendation/Guidance**

Configure the VMware vSphere Health Status to get a high-level view of the Azure VMware Solution private cloud health status. This tool helps ensure that proactive issue detection and remediation are continually performed in your Azure VMware Solution environment. In particular, this tool finds misconfigurations in the VMware vSphere infrastructure and detects performance bottlenecks. It also provides insight into resource utilization and overall environmental health performance.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#collect-infrastructure-data)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-1/avs-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-2 - Configure syslog in Diagnostic Settings

**Category: Application Resilience/Availability**

**Impact: Medium**

**Recommendation/Guidance**

Collect logs from the VMware syslog service to get health data from VMware solution components such as VMware ESXi, VMware vSAN, VMware NSX-T Data Center, and VMware vCenter Server. Configure the syslogs in the Diagnostic Settings.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#manage-logs-and-archives)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-2/avs-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-3 - Azure Monitor Alert for vSAN datastore consumption

**Category: Application Resilience/Availability**

**Impact: Medium**

**Recommendation/Guidance**

Ensure that alerts are configured so that VMware vSAN datastore slack space is maintained at the levels that your service-level agreement (SLA) mandates.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)
- [vSAN Datastores](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/infrastructure#deploy-vmware-vsan)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-3/avs-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
