+++
title = "DDoS Protection Plans"
description = "Best practices and resiliency recommendations for DDoS Protection Plans and associated resources and settings."
date = "3/7/2024"
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented resiliency recommendations in this guidance include DDoS Protection Plans and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                      |  Category       |  Impact     |  State    | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :-------------: | :------:    | :------:  | :-----------------: |
| [DDOS-1 - Monitor Azure DDoS Protection Plan metrics](#ddos-1---monitor-azure-ddos-protection-plan-metrics) | Access & Security      | Medium      | Preview   |         No         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### DDOS-1 - Monitor Azure DDoS Protection Plan metrics

**Category: Access & Security**

**Impact: Medium**

**Guidance**

The metric names present different packet types, and bytes vs. packets, with a basic construct of tag names on each metric as follows:

- Dropped tag name (for example, Inbound Packets Dropped DDoS): The number of packets dropped/scrubbed by the DDoS protection system.
- Forwarded tag name (for example Inbound Packets Forwarded DDoS): The number of packets forwarded by the DDoS system to the destination VIP – traffic that wasn't filtered.
- No tag name (for example Inbound Packets DDoS): The total number of packets that came into the scrubbing system – representing the sum of the packets dropped and forwarded.

**Resources**

- [Monitoring Azure DDoS Protection](https://learn.microsoft.com/en-us/azure/ddos-protection/monitor-ddos-protection-reference)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ddos-1/ddos-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
