+++
title = "Load Balancer"
description = "Best practices and resiliency recommendations for Load Balancer and associated resources."
date = "4/12/23"
author = "lachaves"
msAuthor = "luchaves"
draft = false
+++

The presented resiliency recommendations in this guidance include Load Balancer and associated Load Balancer settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Load Balancer and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                    |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [LB-1 - Use Standard SKU](#lb-1---use-standard-load-balancer-sku) | Preview  |         Yes         |
| [LB-2 - Provision at least two instances](#lb-2---provision-at-least-two-instances) | Preview |         Yes          |
| [LB-3 - Use outbound rules](#lb-3---use-outbound-rules) | Preview |         Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### LB-1 - Use Standard Load Balancer SKU

#### Importance: High

#### Recommendation/Guidance

Select Standard SKU Standard Load Balancer provides a dimension of reliability that Basic does not - that of availability zones and zone resiliency. This means when a zone goes down, your zone-redundant Standard Load Balancer will not be impacted. This ensures your deployments can withstand zone failures within a region. In addition, Standard Load Balancer supports global load balancing ensuring your application is not impacted by region failures either. Basic load balancers don't have a Service Level Agreement (SLA).

##### Resources

- [Reliability and Azure Load Balancer](https://learn.microsoft.com/en-us/azure/architecture/framework/services/networking/azure-load-balancer/reliability)
- [Resiliency checklist for specific Azure services- Azure Load Balancer](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#azure-load-balancer)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/lb-1/lb-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LB-2 - Provision at least two instances

#### Importance: High

#### Recommendation/Guidance

 Deploy Azure LB with at least two instances in the backend. A single instance could result in a single point of failure. In order to build for scale, you might want to pair LB with Virtual Machine Scale Sets.
##### Resources

- [Resiliency checklist for specific Azure services- Azure Load Balancer](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#azure-load-balancer)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/lb-2/lb-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LB-3 - Use outbound rules
#### Importance: Medium

#### Recommendation/Guidance

Outbound rules ensure that you are not faced with connection failures as a result of SNAT port exhaustion. While outbound rules will help improve the solution for small to mid size deployments, for production workloads, we recommend coupling Standard Load Balancer or any subnet deployment with VNet NAT.
##### Resources

- [Resiliency checklist for specific Azure services- Azure Load Balancer](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#azure-load-balancer)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/lb-3/lb-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
