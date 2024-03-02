+++
title = "4 - Deploy"
description = "Microsoft Azure Well-Architected Framework best practices and recommendations for the Reliability Stage - 4 - Deploy"
date = "9/18/23"
weight = 4
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented Microsoft Azure Well-Architected Framework recommendations in this guidance include Reliability Stage "4 - Deploy (Automation and Deployment)" and associated resources and their settings.

At this stage, the system is launched into a production environment. Proper deployment strategies, like blue-green or canary deployments, are used to minimize risks associated with releasing new versions.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                           |  Category  |  Impact   |  State    | ARG Query Available |
| :----------------------------------------------------------------------------------------------------------------------- | :--------: | :------:  | :------:  | :-----------------: |
| [WADP-1 - Avoid manual configuration to enforce consistency with Infrastructure as code](#wadp-1---avoid-manual-configuration-to-enforce-consistency-with-infrastructure-as-code)        | Automation | Medium    | Verified  |         No          |
| [WADP-2 - Validated all changes in development environments before applying them to Production](#wadp-2---validated-all-changes-in-development-environments-before-applying-them-to-production) | Automation | Medium    | Verified  |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### WADP-1 - Avoid manual configuration to enforce consistency with Infrastructure as code

**Category: Automation**

**Impact: Medium**

**Recommendation/Guidance**

Infrastructure as code (IaC) uses DevOps methodology and versioning with a descriptive model to define and deploy infrastructure, such as networks, virtual machines, load balancers, and connection topologies. Just as the same source code always generates the same binary, an IaC model generates the same environment every time it deploys.

IaC is a key DevOps practice and a component of continuous delivery. With IaC, DevOps teams can work together with a unified set of practices and tools to deliver applications and their supporting infrastructure rapidly and reliably at scale.

Key Points:

- Avoid manual configuration to enforce consistency
- Deliver stable test environments rapidly at scale
- Use declarative definition files

**Resources**

- [Avoid manual configuration to enforce consistency](https://learn.microsoft.com/devops/deliver/what-is-infrastructure-as-code#avoid-manual-configuration-to-enforce-consistency)

<br><br>

### WADP-2 - Validated all changes in development environments before applying them to production

**Category: Automation**

**Impact: Medium**

**Recommendation/Guidance**

Continuously delivering value has become a mandatory requirement for organizations. To deliver value to your end users, you must release continually and without errors. Continuous delivery (CD) is the process of automating build, test, configuration, and deployment from a build to a production environment. A release pipeline can create multiple testing or staging environments to automate infrastructure creation and deploy new builds. Successive environments support progressively longer-running integration, load, and user acceptance testing activities.

**Resources**

- [Safe deployment practices](https://learn.microsoft.com/devops/operate/safe-deployment-practices)

<br><br>
