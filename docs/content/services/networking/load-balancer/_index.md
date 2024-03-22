+++
title = "Load Balancer"
description = "Best practices and resiliency recommendations for Load Balancer and associated resources."
date = "10/19/23"
author = "lachaves"
msAuthor = "luchaves"
draft = false
+++

The presented resiliency recommendations in this guidance include Load Balancer and associated Load Balancer settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Load Balancer and associated resources.

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                          |   Category   | Impact |  State  | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------|:------------:|:------:|:-------:|:-------------------:|
| [LB-1 - Use Standard Load Balancer SKU](#lb-1---use-standard-load-balancer-sku)                                                                         | Availability |  High  | Verified |         Yes         |
| [LB-2 - Ensure the Backend Pool contains at least two instances](#lb-2---ensure-the-backend-pool-contains-at-least-two-instances)                       | Availability |  High  | Verified |         Yes         |
| [LB-3 - Use NAT Gateway instead of Outbound Rules for Production Workloads](#lb-3---use-nat-gateway-instead-of-outbound-rules-for-production-workloads) | Availability | Medium | Verified |         Yes         |
| [LB-4 - Ensure Standard Load Balancer is zone-redundant](#lb-4---ensure-standard-load-balancer-is-zone-redundant)                                       | Availability |  High  | Verified |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### LB-1 - Use Standard Load Balancer SKU

**Category: Availability**

**Impact: High**

**Guidance**

Select Standard SKU Standard Load Balancer provides a dimension of reliability that Basic does not - that of availability zones and zone resiliency. This means when a zone goes down, your zone-redundant Standard Load Balancer will not be impacted. This ensures your deployments can withstand zone failures within a region. In addition, Standard Load Balancer supports global load balancing ensuring your application is not impacted by region failures either. Basic load balancers don't have a Service Level Agreement (SLA).

**Resources**

- [Reliability and Azure Load Balancer](https://learn.microsoft.com/azure/architecture/framework/services/networking/azure-load-balancer/reliability)
- [Resiliency checklist for specific Azure services- Azure Load Balancer](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#azure-load-balancer)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/lb-1/lb-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LB-2 - Ensure the Backend Pool contains at least two instances

**Category: Availability**

**Impact: High**

**Guidance**

 Deploy Azure LB with at least two instances in the backend. A single instance could result in a single point of failure. In order to build for scale, you might want to pair LB with Virtual Machine Scale Sets.

**Resources**

- [Resiliency checklist for specific Azure services- Azure Load Balancer](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#azure-load-balancer)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/lb-2/lb-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LB-3 - Use NAT Gateway instead of Outbound Rules for Production Workloads

**Category: Availability**

**Impact: Medium**

**Guidance**

Outbound rules for Standard Public Load Balancer requires you to manually allocate fixed amounts of ports to each of your backend pool instances. Because the SNAT port allocation is fixed, outbound rules does not provide the most scalable method for outbound connectivity. For production workloads, we recommend using NAT Gateway instead in order to prevent the risk of connection failures due to SNAT port exhaustion. NAT Gateway scales dynamically and provides secure connectivity to the internet.

**Resources**

- [Resiliency checklist for specific Azure services- Azure Load Balancer](https://learn.microsoft.com/azure/architecture/checklist/resiliency-per-service#azure-load-balancer)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/lb-3/lb-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### LB-4 - Ensure Standard Load Balancer is zone-redundant

**Category: Availability**

**Impact: High**

**Guidance**

In a region with Availability Zones, a Standard Load Balancer can be made zone-redundant by assigning it with a zone-redundant frontend IP address. With a zone-redundant frontend IP, the load balancer will continue to distribute traffic even when one availability zone fails, as long as there are other healthy zones and corresponding healthy backend instances in these zones that can receive traffic.

**Resources**

- [Load Balancer and Availability Zones](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-standard-availability-zones#zone-redundant)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/lb-4/lb-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
