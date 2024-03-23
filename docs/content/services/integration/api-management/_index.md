+++
title = "Api Management"
description = "Best practices and resiliency recommendations for Api Management and associated resources and settings."
date = "10/20/23"
author = "DaFitRobsta"
msAuthor = "rolightn"
draft = false
+++

The presented resiliency recommendations in this guidance include Api Management and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                  |   Category   | Impact |  State  | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------:|:------:|:-------:|:-------------------:|
| [APIM-1 - Migrate API Management services to Premium SKU to support Availability Zones](#apim-1---migrate-api-management-services-to-premium-sku-to-support-availability-zones) | Availability |  High  | Preview |         Yes         |
| [APIM-2 - Enable Availability Zones on Premium API Management instances](#apim-2---enable-availability-zones-on-premium-api-management-instances)                               | Availability |  High  | Preview |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### APIM-1 - Migrate API Management services to Premium SKU to support Availability Zones

**Category: Availability**

**Impact: High**

**Guidance**

Upgrade the API Management instance to the Premium SKU to add support for Availability Zones.

**Resources**

- [Change your API Management service tier](https://learn.microsoft.com/en-us/azure/api-management/upgrade-and-scale#change-your-api-management-service-tier)
- [Migrate Azure API Management to availability zone support](https://learn.microsoft.com/en-us/azure/reliability/migrate-api-mgt)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/apim-1/apim-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### APIM-2 - Enable Availability Zones on Premium API Management instances

**Category: Availability**

**Impact: High**

**Guidance**

Enable zone redundancy for APIM instances. With zone redundancy, the gateway and the control plane of your API Management instance (Management API, developer portal, Git configuration) are replicated across datacenters in physically separated zones, making it resilient to a zone failure.

**Resources**

- [Ensure API Management availability and reliability](https://learn.microsoft.com/en-us/azure/api-management/high-availability#availability-zones)
- [Migrate Azure API Management to availability zone support](https://learn.microsoft.com/en-us/azure/reliability/migrate-api-mgt)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/apim-2/apim-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### APIM-3 - Upgrade to platform version stv2

**Category: Availability**

**Impact: High**

**Guidance**

Upgrade to platform version stv2. The infrastructure associated with the API Management stv1 compute platform version will be retired effective 31 August 2024. A more current compute platform version (stv2) is already available and provides enhanced service capabilities.

**Resources**

- [Azure API Management - stv1 platform retirement (August 2024)](https://learn.microsoft.com/en-us/azure/api-management/breaking-changes/stv1-platform-retirement-august-2024)
- [Azure API Management compute platform](https://learn.microsoft.com/en-us/azure/api-management/compute-infrastructure)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/apim-3/apim-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
