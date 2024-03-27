+++
title = "SignalR"
description = "Best practices and resiliency recommendations for SignalR and associated resources and settings."
date = "10/3/23"
author = "ejhenry"
msAuthor = "ejhenry"
draft = false
+++

The presented resiliency recommendations in this guidance include SignalR and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :-----------------: |
| [SIGR-1 - Enable zone redundancy for SignalR](#sigr-1---enable-zone-redundancy-for-signalr) | High Availability | High | Preview  |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### SIGR-1 - Enable zone redundancy for SignalR

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Use SignalR with zone redundancy for production workloads. Zone redundancy is a Premium tier feature. It is implicitly enabled when you create or upgrade to a Premium tier resource. Standard tier resources can be upgraded to Premium tier without downtime.

**Resources**

- [Availability zones support in Azure SignalR Service](https://learn.microsoft.com/azure/azure-signalr/availability-zones)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/sigr-1/sigr-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
