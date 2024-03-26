+++
title = "Resource Groups"
description = "Best practices and resiliency recommendations for Resource Groups and associated resources and settings."
date = "2/22/24"
author = "edknox"
msAuthor = "edknox"
draft = false
+++

The presented resiliency recommendations in this guidance include Resource Groups and its associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                        |  Category  | Impact |  State  | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------:|:------:|:-------:|:-------------------:|
| [RG-1 - Ensure Resource Group and its Resources are located in the same Region](#rg-1---ensure-resource-group-and-its-resources-are-located-in-the-same-region) | Disaster Recovery | High | Preview |         Yes         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### RG-1 - Ensure Resource Group and its Resources are located in the same Region

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Ensure your resource locations match that of the containing resource group. This ensures that, in the event of a regional outage, you will still be able to manage your resource. ARM stores resource data for resources in a resource group and, if the region is unavailable, updates to this data could fail, making the resource effectively read-only.

**Resources**

- [Azure Resource Manager Overview](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview#resource-group-location-alignment)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/rg-1/rg-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
