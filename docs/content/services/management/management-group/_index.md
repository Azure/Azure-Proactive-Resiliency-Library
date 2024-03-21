+++
title = "Management Groups"
description = "Best practices and resiliency recommendations for Management Groups and associated resources and settings."
date = "11/6/23"
author = "pesousa"
msAuthor = "pesousa"
draft = false
+++

The presented resiliency recommendations in this guidance include Management Groups and its associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                        |  Category  | Impact |  State  | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------:|:------:|:-------:|:-------------------:|
| [MG-1 - Subscriptions should not be placed under the Tenant Root Management Group](#mg-1---subscriptions-should-not-be-placed-under-the-tenant-root-management-group) | Governance | Medium | Preview |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### MG-1 - Subscriptions should not be placed under the Tenant Root Management Group

**Category: Governance**

**Impact: Medium**

**Guidance**

 The root management group is built into the hierarchy to have all management groups and subscriptions fold up to it.
Create management groups under your root-level management group to represent the types of workloads that you'll host.

These groups are based on the security, compliance, connectivity, and feature needs of the workloads. With this grouping structure, you can have a set of Azure policies applied at the management group level. This grouping structure is for all workloads that require the same security, compliance, connectivity, and feature settings.

**Resources**

- [Management group recommendations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups#management-group-recommendations)
- [Root management group for each directory](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview#root-management-group-for-each-directory)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/mg-1/mg-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
