+++
title = "Route Table"
description = "Best practices and resiliency recommendations for Route Table and associated resources and settings."
date = "8/31/23"
author = "beheath"
msAuthor = "benheath"
draft = false
+++

The presented resiliency recommendations in this guidance include Route Table and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State   | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------: | :-----------------: |
| [RT-1 - Monitor changes in Route Tables with Azure Monitor](#rt-1---monitor-changes-in-route-tables-with-azure-monitor) | Monitoring | Low | Preview  |         Yes         |
| [RT-2 - Configure locks for Route Tables to avoid accidental changes or deletion](#rt-2---configure-locks-for-route-tables-to-avoid-accidental-changes-or-deletion) | Governance         | Low | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### RT-1 - Monitor changes in Route Tables with Azure Monitor

**Category: Monitoring**

**Impact: Low**

**Guidance**

Create Alerts for administrative operations such as Create or Update Route Table with Azure Monitor to detect unauthorized/undesired changes to production resources, this alert can help identify undesired changes in routing, such as attempts to by-pass firewalls or from accessing resources externally.

**Resources**

- [Azure activity log - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/activity-log?tabs=powershell)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/rt-1/rt-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### RT-2 - Configure locks for Route Tables to avoid accidental changes or deletion

**Category: Governance**

**Impact: Low**

**Guidance**

As an administrator, you can lock an Azure subscription, resource group, or resource to protect them from accidental user deletions and modifications. The lock overrides any user permissions.
You can set locks that prevent either deletions or modifications. In the portal, these locks are called Delete and Read-only.

**Resources**

- [Protect your Azure resources with a lock - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?toc=%2Fazure%2Fvirtual-network%2Ftoc.json&tabs=json)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/rt-2/rt-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
