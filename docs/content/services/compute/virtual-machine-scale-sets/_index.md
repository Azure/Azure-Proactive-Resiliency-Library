+++
title = "Virtual Machine Scale Sets"
description = "Best practices and resiliency recommendations for Virtual Machine Scale Sets and associated resources."
date = "5/23/23"
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented resiliency recommendations in this guidance include Virtual Machine Scale Sets, and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                              | Impact  |  State  | ARG Query Available |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----:  | :-----: | :-----------------: |
| [VMSS-1 - Deploy VMSS with Flex orchestration mode instead of Uniform](#vmss-1---deploy-vmss-with-flex-orchestration-mode-instead-of-uniform)                                                              |  Medium | Preview |         Yes         |
| [VMSS-2 - Enable VMSS application health monitoring](#vmss-2---enable-vmss-application-health-monitoring)                                                                                                   |  Medium | Preview |         No          |
| [VMSS-3 - Enable Automatic Repair policy](#vmss-3---enable-automatic-repair-policy)                                                                                                                         |  High   | Preview |         No          |
| [VMSS-4 - Configure VMSS autoscale to custom and configure the scaling metrics](#vmss-4---configure-vmss-autoscale-to-custom-and-configure-the-scaling-metrics)                                             |  High   | Preview |         Yes         |
| [VMSS-5 - Enable Predictive Autoscale and configure at least for Forecast Only](#vmss-5---enable-predictive-autoscale-and-configure-at-least-for-forecast-only)                                             |  Low    | Preview |         Yes         |
| [VMSS-6 - Disable Force strictly even balance across zones to avoid scale in and out fail attempts](#vmss-6---disable-force-strictly-even-balance-across-zones-to-avoid-scale-in-and-out-fail-attempts)     |  High   | Preview |         Yes         |
| [VMSS-7 - Configure Allocation Policy Spreading algorithm to Max Spreading](#vmss-7---configure-allocation-policy-spreading-algorithm-to-max-spreading)                                                     |  Medium | Preview |         Yes         |
| [VMSS-8 - Deploy VMSS across availability zones with VMSS Flex](#vmss-8---deploy-vmss-across-availability-zones-with-vmss-flex)                                                                             |  High   | Preview |         Yes         |
| [VMSS-9 - Set Patch orchestration options to Azure-orchestrated](#vmss-9---set-patch-orchestration-options-to-azure-orchestrated)                                                                           |  Low    | Preview |         No          |
| [VMSS-10 - Keep VMSS Image Version Up to Date](#vmss-10---keep-vmss-image-version-up-to-date)                                                                           |  Low    | Preview |         Yes          |
| [VMSS-11 - Use SSD Disks for VMSS Instances in Prod Environments](#vmss-9---use-ssd-disks-for-vmss-instances-in-prod-environments)                                                                           |  Low    | Preview |         Yes          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VMSS-1 - Deploy VMSS with Flex orchestration mode instead of Uniform

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Even single instance VMs should be deployed into a scale set using the Flexible orchestration mode to future-proof your application for scaling and availability. Flexible orchestration offers high availability guarantees (up to 1000 VMs) by spreading VMs across fault domains in a region or within an Availability Zone.

**Resources**

- [When to use VMSS instead of VMs](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-design-overview#when-to-use-scale-sets-instead-of-virtual-machines)
- [Azure Well-Architected Framework review - Virtual Machines and Scale Sets](https://learn.microsoft.com/azure/well-architected/services/compute/virtual-machines/virtual-machines-review)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-1/vmss-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-2 - Enable VMSS application health monitoring

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Monitoring your application health is an important signal for managing and upgrading your deployment. Azure Virtual Machine Scale Sets provide support for Rolling Upgrades including Automatic OS-Image Upgrades and Automatic VM Guest Patching, which rely on health monitoring of the individual instances to upgrade your deployment. You can also use Application Health Extension to monitor the application health of each instance in your scale set and perform instance repairs using Automatic Instance Repairs.

**Resources**

- [Using Application Health extension with Virtual Machine Scale Sets](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-health-extension?tabs=rest-api)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-2/vmss-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-3 - Enable Automatic Repair policy

**Category: Automation**

**Impact: High**

**Guidance**

Enabling automatic instance repairs for Azure Virtual Machine Scale Sets helps achieve high availability for applications by maintaining a set of healthy instances. The Application Health extension or Load balancer health probes may find that an instance is unhealthy. Automatic instance repairs will automatically perform instance repairs by deleting the unhealthy instance and creating a new one to replace it.

Grace period is specified in minutes in ISO 8601 format and can be set using the property automaticRepairsPolicy.gracePeriod. Grace period can range between 10 minutes and 90 minutes, and has a default value of 30 minutes.

**Resources**

- [Automatic instance repairs for Azure Virtual Machine Scale Sets](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#requirements-for-using-automatic-instance-repairs)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-3/vmss-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-4 - Configure VMSS Autoscale to custom and configure the scaling metrics

**Category: System Efficiency**

**Impact: High**

**Recommendation**

Use Custom autoscale based on metrics and schedules.

Autoscale is a built-in feature that helps applications perform their best when demand changes. You can choose to scale your resource manually to a specific instance count, or via a custom Autoscale policy that scales based on metric(s) thresholds, or schedule instance count which scales during designated time windows. Autoscale enables your resource to be performant and cost effective by adding and removing instances based on demand.

**Resources**

- [Get started with autoscale in Azure](https://learn.microsoft.com/azure/azure-monitor/autoscale/autoscale-get-started?WT.mc_id=Portal-Microsoft_Azure_Monitoring)
- [Overview of autoscale in Azure](https://learn.microsoft.com/azure/azure-monitor/autoscale/autoscale-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-4/vmss-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-5 - Enable Predictive autoscale and configure at least for Forecast Only

**Category: System Efficiency**

**Impact: Low**

**Guidance**

Predictive autoscale uses machine learning to help manage and scale Azure Virtual Machine Scale Sets with cyclical workload patterns. It forecasts the overall CPU load to your virtual machine scale set, based on your historical CPU usage patterns. It predicts the overall CPU load by observing and learning from historical usage. This process ensures that scale-out occurs in time to meet the demand.

**Resources**

- [Use predictive autoscale to scale out before load demands in virtual machine scale sets](https://learn.microsoft.com/azure/azure-monitor/autoscale/autoscale-predictive)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-5/vmss-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-6 - Disable Force strictly even balance across zones to avoid scale in and out fail attempts

**Category: Availability**

**Impact: High**

**Guidance**

Microsoft recommends disabling the setting that enforces strictly even distribution of VM instances across Availability Zones within a region in your VMSS configuration. In other words, you should allow Azure to distribute VM instances unevenly across Availability Zones.

Force strictly even balance across zones: Azure provides the option to distribute VM instances in a VMSS evenly across Availability Zones within a region. An Availability Zone is a physically separate data center within an Azure region with independent power, cooling, and networking. This configuration enhances the availability and fault tolerance of your applications.

Scale in and out fail attempts: In the context of VMSS, "scaling in" refers to reducing the number of VM instances when demand decreases, while "scaling out" refers to increasing the number of instances when demand increases. Scaling is an important feature of VMSS, and it can be automatic based on various scaling rules and metrics.

While Azure VMSS provides the option to enforce even distribution of VM instances across Availability Zones for increased resilience, there may be scenarios where disabling this option makes sense to better align with your application's load distribution and scaling requirements.

**Resources**

- [Use scale-in policies with Azure Virtual Machine Scale Sets](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-scale-in-policy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-6/vmss-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-7 - Configure Allocation Policy Spreading algorithm to Max Spreading

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

With max spreading, the scale set spreads your VMs across as many fault domains as possible within each zone. This spreading could be across greater or fewer than five fault domains per zone. With static fixed spreading, the scale set spreads your VMs across exactly five fault domains per zone. If the scale set cannot find five distinct fault domains per zone to satisfy the allocation request, the request fails.

**Resources**

- [Availability Considerations](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-use-availability-zones#availability-considerations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-7/vmss-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-8 - Deploy VMSS across availability zones with VMSS Flex

**Category: Availability**

**Impact: High**

**Guidance**

When you create your VMSS, use availability zones to protect your applications and data against unlikely datacenter failure.

**Resources**

- [Create a Virtual Machine Scale Set that uses Availability Zones](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-use-availability-zones)
- [Update scale set to add availability zones](https://learn.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-use-availability-zones?tabs=cli-1%2Cportal-2#update-scale-set-to-add-availability-zones)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-8/vmss-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-9 - Set Patch orchestration options to Azure-orchestrated

**Category: Automation**

**Impact: Low**

**Guidance**

Enabling automatic VM guest patching for your Azure VMs helps ease update management by safely and automatically patching virtual machines to maintain security compliance, while limiting the blast radius of VMs.

**Resources**

- [Automatic VM Guest Patching for Azure VMs](https://learn.microsoft.com/azure/virtual-machines/automatic-vm-guest-patching)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-9/vmss-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-10 - Keep VMSS Image Version Up to Date

**Category: Availability**

**Impact: Medium**

**Guidance**

Ensure current versions of images are in use to avoid disruption after image deprecation. This ensurest that if these images are deprecated that you will not be impacted as you will no longer be able to deploy any additional VMs or VMSS once the image has been deprecated.

**Resources**

- [Deprecated Azure Marketplace Images](https://learn.microsoft.com/en-us/azure/virtual-machines/deprecated-images)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-10/vmss-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-11 - Use SSD Disks for VMSS Instances in Prod Environments

**Category: Availability**

**Impact: High**

**Guidance**

It is advised that you use SSD disks for Production workloads. Using HDD could impact your resources as it should only be used for non-critical resources and for resources that require infrequent access.

**Resources**

- [Managed Disks Overview](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview)
- [Disk Type Comparison](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-11/vmss-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
