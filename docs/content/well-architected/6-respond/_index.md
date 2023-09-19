+++
title = "6 - Respond"
description = "Microsoft Azure Well-Architected Framework best practices and recommendations for the Reliability Stage - 6 - Respont"
date = "9/18/23"
weight = 6
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented Microsoft Azure Well-Architected Framework recommendations in this guidance include Reliability Stage "6 - Respond (Responding to Failures)" and associated resources and their settings.

This final stage involves having plans and procedures in place to react to incidents affecting reliability. This includes automated failovers, backup restoration, and escalation protocols for manual intervention.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                              |  Category          |  Impact   |  State   | ARG Query Available |
| :---------------------------------------------------------------------------------------------------------- | :---------:        | :------:  | :------: | :-----------------: |
| [WARD-1 - Implement proactive Incident Response](#ward-1---implement-proactive-incident-response)           |  Disaster Recovery |   High    | Verified |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### WARD-1 - Implement proactive Incident Response

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

Prevention of all problems is a laudable, but impossible goal. Things will go wrong, so we need a plan to limit the impact on our end users and return operations to normal as quickly as possible.

The key is to respond with urgency, rather than react. A reaction tends to be more impulsive and based in the present moment, without consideration of long-term effects. A response is well-thought-out, organized, and information based.

Your incident response approach determines your effectiveness at:

Understanding what’s going on (diagnosing the problem)
Triaging (determining the urgency) and prioritizing the problem
Engaging the right resources to mitigate the issue(s), and
Communicating with stakeholders about the problem
After the problem has been remediated, you can then learn from the incident through a post-incident review process. That's an important subject which has a whole separate module worth of discussion.

**Resources**

- [Importance of incident response](https://learn.microsoft.com/training/modules/improve-reliability-incidents/2-importance)
- [Incident tracking](https://learn.microsoft.com/training/modules/improve-reliability-incidents/5-tracking)

<br><br>
