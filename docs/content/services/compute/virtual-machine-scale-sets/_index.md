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
| Recommendation                                                                                                                                                                  | Impact  |  State  | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :----:  | :-----: | :-----------------: |
| [VMSS-1 - Deploy using Flexible scale set instead of simple Virtual Machines](#vmss-1---deploy-using-flexible-scale-set-instead-of-simple-virtual-machines)                     | Medium  | Preview |         No          |
| [VMSS-2 - Protection Policy is disabled for all VMSS instances](#vmss-2---protection-policy-is-disabled-for-all-vmss-instances)                                                 |  Low    | Preview |         No          |
| [VMSS-3 - VMSS Application health monitoring is not enabled](#vmss-3---vmss-application-health-monitoring-is-not-enabled)                                                       | Medium  | Preview |         No          |
| [VMSS-4 - Automatic repair policy is not enabled](#vmss-4---automatic-repair-policy-is-not-enabled)                                                                             |  High   | Preview |         No          |
| [VMSS-5 - VMSS Autoscale is set to Manual scale](#vmss-5---vmss-autoscale-is-set-to-manual-scale)                                                                               |  High   | Preview |         No          |
| [VMSS-6 - VMSS Custom scale-in policies is not set to default](#vmss-6---vmss-custom-scale-in-policies-is-not-set-to-default)                                                   |  Low    | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### VMSS-1 - Deploy using Flexible scale set instead of simple Virtual Machines

#### Impact: Medium

#### Recommendation/Guidance

Even single instance VMs should be deployed into a scale set using the Flexible orchestration mode to future-proof your application for scaling and availability. Flexible orchestration offers high availability guarantees (up to 1000 VMs) by spreading VMs across fault domains in a region or within an Availability Zone.

#### Resources

- [When to use VMSS instead of VMs](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-design-overview#when-to-use-scale-sets-instead-of-virtual-machines)
- [Azure Well-Architected Framework review - Virtual Machines and Scale Setgs](https://learn.microsoft.com/en-us/azure/well-architected/services/compute/virtual-machines/virtual-machines-review)
- [Azure Well-Architected Framework review - Virtual Machines](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview#why-use-virtual-machine-scale-sets)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-1/vmss-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-2 - Protection Policy is disabled for all VMSS instances

#### Impact: Low

#### Recommendation/Guidance

Use VMSS Protection Policy in case you want specific instances to be treated differently from the rest of the scale set instance.

As your application processes traffic, there can be situations where you want specific instances to be treated differently from the rest of the scale set instance. For example, certain instances in the scale set could be performing long-running operations, and you don't want these instances to be scaled-in until the operations complete. You might also have specialized a few instances in the scale set to perform additional or different tasks than the other members of the scale set. You require these 'special' VMs not to be modified with the other instances in the scale set. Instance protection provides the additional controls to enable these and other scenarios for your application.

#### Resources

- [Instance Protection for Azure Virtual Machine Scale Set instances](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-instance-protection)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-2/vmss-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-3 - VMSS Application health monitoring is not enabled

#### Impact: Medium

#### Recommendation/Guidance

Monitoring your application health is an important signal for managing and upgrading your deployment. Azure Virtual Machine Scale Sets provide support for Rolling Upgrades including Automatic OS-Image Upgrades and Automatic VM Guest Patching, which rely on health monitoring of the individual instances to upgrade your deployment. You can also use Application Health Extension to monitor the application health of each instance in your scale set and perform instance repairs using Automatic Instance Repairs.

#### Resources

- [Using Application Health extension with Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-health-extension?tabs=rest-api)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-3/vmss-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-4 - Automatic repair policy is not enabled

#### Impact: High

#### Recommendation/Guidance

Enabling automatic instance repairs for Azure Virtual Machine Scale Sets helps achieve high availability for applications by maintaining a set of healthy instances. The Application Health extension or Load balancer health probes may find that an instance is unhealthy. Automatic instance repairs will automatically perform instance repairs by deleting the unhealthy instance and creating a new one to replace it.

Grace period is specified in minutes in ISO 8601 format and can be set using the property automaticRepairsPolicy.gracePeriod. Grace period can range between 10 minutes and 90 minutes, and has a default value of 30 minutes.

#### Resources

- [Automatic instance repairs for Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#requirements-for-using-automatic-instance-repairs)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-4/vmss-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-5 - VMSS Autoscale is set to Manual scale

**Impact: High**

**Recommendation:**

Use Custom autoscale based on metrics and schedules.

Autoscale is a built-in feature that helps applications perform their best when demand changes. You can choose to scale your resource manually to a specific instance count, or via a custom Autoscale policy that scales based on metric(s) thresholds, or schedule instance count which scales during designated time windows. Autoscale enables your resource to be performant and cost effective by adding and removing instances based on demand.

**Resources:**

- [Get started with autoscale in Azure](https://learn.microsoft.com/en-us/azure/azure-monitor/autoscale/autoscale-get-started?WT.mc_id=Portal-Microsoft_Azure_Monitoring)
- [Overview of autoscale in Azure](https://learn.microsoft.com/en-us/azure/azure-monitor/autoscale/autoscale-overview)

**Queries/Scripts:**

**Azure Resource Graph:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-5/vmss-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### VMSS-6 - VMSS Custom scale-in policies is not set to default

#### Impact: Low

#### Recommendation/Guidance

The default custom scale-in policy provides the best algorithm and flexibility for the majority of the scenarios. Use the Newest and Oldest policies when workload requires oldest or newest VMs to be deleted.

A Virtual Machine Scale Set deployment can be scaled-out or scaled-in based on an array of metrics, including platform and user-defined custom metrics. While a scale-out creates new virtual machines based on the scale set model, a scale-in affects running virtual machines that may have different configurations and/or functions as the scale set workload evolves.

Users do not need to specify a scale-in policy if they just want the default ordering to be followed.

Note that balancing across availability zones or fault domains does not move instances across availability zones or fault domains. The balancing is achieved through deletion of virtual machines from the unbalanced availability zones or fault domains until the distribution of virtual machines becomes balanced.

The scale-in policy feature provides users a way to configure the order in which virtual machines are scaled-in, by way of three scale-in configurations:

- Default
- NewestVM
- OldestVM

#### Resources

- [Use custom scale-in policies with Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-scale-in-policy?WT.mc_id=Portal-Microsoft_Azure_Monitoring)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/vmss-6/vmss-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
