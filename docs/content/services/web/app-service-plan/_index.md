+++
title = "App Service Plan"
description = "Best practices and resiliency recommendations for App Service Plan and associated resources."
date = "6/27/23"
author = "kunalbabre"
msAuthor = "kunalbabre"
draft = false
+++

The presented resiliency recommendations in this guidance include App Service Plan and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                         |     Category      | Impact |  State  | ARG Query Available |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [ASP-1 - Migrate App Service to availability Zone Support](#asp-1---migrate-app-service-to-availability-zone-support)                                                                                                  |   Availability    |  High  | Preview |         Yes         |
| [ASP-2 - Use Standard or Premium tier](#asp-2---use-standard-or-premium-tier)                                                                                                                                          |   Availability    |  High  | Preview |         Yes         |
| [ASP-3 - Avoid scaling up or down](#asp-3---avoid-scaling-up-or-down)                                                                                                                                                  | System Efficiency | Medium | Preview |         Yes         |
| [ASP-4 - Create separate App Service plans for production and test](#asp-4---create-separate-app-service-plans-for-production-and-test)                                                                                |    Governance     |  High  | Preview |         No          |
| [ASP-5 - Enable Autoscale/Automatic scaling to ensure adequate resources are available to service requests](#asp-5---enable-autoscaleautomatic-scaling-to-ensure-adequate-resources-are-available-to-service-requests) | System Efficiency | Medium | Preview |         Yes         |
{{< /table >}}
{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### ASP-1 - Migrate App Service to availability Zone Support

**Category: Availability**

**Impact: High**

**Guidance**

Deploying your App Service plans and App Service Environments across availability zones (AZ) is a feature provided by Azure to enhance the resiliency and reliability of your business-critical workloads. By distributing your applications across multiple availability zones, you can ensure their continued operation even in the event of a datacenter-level failure. This approach offers excellent redundancy without the need for deploying your applications in different Azure regions. Availability zones provide a higher level of fault tolerance, helping to safeguard your applications and minimize downtime. This enables your business to maintain continuity and deliver uninterrupted services to your customers.

**Resources**

- [Migrate App Service to availability zone support](https://learn.microsoft.com/en-us/azure/reliability/migrate-app-service)
- [High availability enterprise deployment using App Service Environment](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/enterprise-integration/ase-high-availability-deployment)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asp-1/asp-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ASP-2 - Use Standard or Premium tier

**Category: Availability**

**Impact: High**

**Guidance**

The use of the Standard or Premium tier for Azure App Service Plan is crucial for highly resilient applications, as it provides advanced scaling, high availability, traffic management, enhanced performance, networking features, and multiple deployment slots, ensuring uninterrupted operation and robustness in the face of potential failures or increased demands.

**Resources**

- [Resiliency checklist for specific Azure services](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#app-service)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asp-2/asp-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ASP-3 - Avoid scaling up or down

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

It is recommended to avoid scaling up or down your Azure App Service instances frequently. Instead, choose an appropriate tier and instance size that can handle your typical workload, and scale out the instances to accommodate changes in traffic volume. Scaling up or down can potentially trigger an application restart, which may result in service disruptions.

**Resources**

- [Resiliency checklist for specific Azure services](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#app-service)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asp-3/asp-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ASP-4 - Create separate App Service plans for production and test

**Category: Governance**

**Impact: High**

**Guidance**

It is strongly recommended to create separate App Service plans for production and test environments. Avoid using slots within your production deployment for testing purposes. When apps within the same App Service plan share VM instances, combining production and test deployments can have adverse effects on the production environment. For instance, load tests conducted on the test deployment may degrade the live production site. By isolating test deployments in a separate plan, you ensure the separation and protection of the production version.

**Resources**

- [Resiliency checklist for specific Azure services](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#app-service)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asp-4/asp-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### ASP-5 - Enable Autoscale/Automatic scaling to ensure adequate resources are available to service requests

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

It is highly recommended to enable Autoscale/Automatic Scaling for your Azure App Service to ensure that sufficient resources are available to handle incoming requests. Autoscaling is rule based scaling while Automatic Scaling newer platform feature that performs automatic scale out and in based on HTTP traffic.

**Resources**

- [Automatic scaling in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/manage-automatic-scaling?tabs=azure-portal)
- [Auto Scale Web Apps](https://learn.microsoft.com/en-us/azure/azure-monitor/autoscale/autoscale-get-started)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/asp-5/asp-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
