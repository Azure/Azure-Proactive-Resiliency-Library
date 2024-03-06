+++
title = "Functions"
description = "Best practices and resiliency recommendations for Azure Functions and associated resources and settings."
date = ":date_short"
author = "CHANGE ME TO YOUR GITHUB USERNAME"
msAuthor = "CHANGE ME TO YOUR MICROSOFT ALIAS"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Functions and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |                                Category                                 |     Impact      |      State       | ARG Query Available |
|:--------------------------------------------------|:-----------------------------------------------------------------------:|:---------------:|:----------------:|:-------------------:|
| [FUNC-1 - Plan needs to be Premium or Dedicated](#func-1---plan-needs-to-be-premium-or-dedicated)                                                                                                   |   Availability    |  High  | Preview |         Yes         |
| [FUNC-2 - Different Functions should be in different plans](#func-2---different-functions-should-be-in-different-plans)                                                                                                   |   System Efficiency    |  High  | Preview |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### FUNC-1 - Plan needs to be Premium or Dedicated

**Category: Availability**

**Impact: High**

**Guidance**

Azure Functions could be hosted in Consumption, Premium or Dedicated. Premium and Dedicated has lots of advantages especially on Availability, security and cost predictability. Also these Premium and Dedicated have a better CPU and Memory hosting selections.

**Resources**

- [Overview of plans](https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale#overview-of-plans)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FUNC-2 - Different Functions should be in different plans

**Category: System Efficiency**

**Impact: High**

**Guidance**

Functions share the same plan will use same hosting plans power and when Functions scales all the applications inside App Service Plan will scale together. Deploying not depended applications to different Plans will give you more efficiency.

**Resources**

- [Scaling Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/event-driven-scaling?tabs=azure-cli)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
