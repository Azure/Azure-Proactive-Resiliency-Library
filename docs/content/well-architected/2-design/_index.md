+++
title = "2 - Design"
description = "Microsoft Azure Well-Architected Framework best practices and recommendations for the Reliability Stage - 2 - Design"
date = "9/18/23"
weight = 2
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented Microsoft Azure Well-Architected Framework recommendations in this guidance include Reliability Stage "2 - Design (Workload Design)" and associated resources and their settings.

In this Stage, the architecture and design decisions are made to meet the requirements defined earlier. Best practices for resilient and scalable systems are implemented, often including redundancy, failover strategies, and load balancing. In this phase failure mode and point analysis are coordinated in order to identify and mitigate possible failures, and single points of failures.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                          |  Category         |  Impact   |  State   | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--------------:  | :------:  | :------: | :-----------------: |
| [WADS-1 - Consider deploying your application across multiple zones](#wads-1---consider-deploying-your-application-across-multiple-zones)                                                               | Availability      |   High    | Verified |         No          |
| [WADS-2 - Consider deploying your application across multiple regions](#wads-2---consider-deploying-your-application-across-multiple-regions)                                                           | Disaster Recovery |   High    | Verified |         No          |
| [WADS-3 - Ensure that all fault-points and fault-modes are understood and operationalized](#wads-3---ensure-that-all-fault-points-and-fault-modes-are-understood-and-operationalized)                   | Availability      |   High    | Verified |         No          |
| [WADS-4 - Use PaaS Azure services instead of IaaS](#wads-4---use-paas-azure-services-instead-of-iaas)                                                                                                    | System Efficiency |   Medium  | Verified |         No          |
| [WADS-5 - Design the application to scale out](#wads-5---design-the-application-to-scale-out)                                                                                                           | System Efficiency |   High    | Verified |         No          |
| [WADS-6 - Create a landing zone for the workload following the Microsoft Cloud Adoption Framework](#wads-6---create-a-landing-zone-for-the-workload-following-the-microsoft-cloud-adoption-framework)   | Governance        |   Low     | Verified |         No          |
| [WADS-7 - Design a BCDR strategy that will help to meet the business requirements](#wads-7---design-a-bcdr-strategy-that-will-help-to-meet-the-business-requirements)                                   | Disaster Recovery |   High    | Verified |         No          |
| [WADS-8 - Provide security assurance through identity management](#wads-8---provide-security-assurance-through-identity-management)                                                                     | Access & Security |   Medium  | Verified |         No          |
| [WADS-9 - Ensure you address security-related risks helps to minimize application downtime and data loss caused by unexpected security exposures](#wads-9---ensure-you-address-security-related-risks-helps-to-minimize-application-downtime-and-data-loss-caused-by-unexpected-security-exposures) |  Access & Security |   High    | Verified |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### WADS-1 - Consider deploying your application across multiple zones

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Design your application architecture to use availability zones within a region. Availability zones can be used to optimize application availability within a region by providing datacenter-level fault tolerance. However, the application architecture must not share dependencies between zones to use them effectively.

Consider if component proximity is required for application performance reasons. If all or part of the application is highly sensitive to latency, components might need to be co-located which can limit the applicability of multi-region and multi-zone strategies.

**Resources**

- [Use Availability Zones](https://learn.microsoft.com/azure/reliability/availability-zones-overview#availability-zones)

<br><br>

### WADS-2 - Consider deploying your application across multiple regions

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

If your application is deployed to a single region, and the region becomes unavailable, your application will also be unavailable. This might be unacceptable under the terms of your application's SLA.

If so, consider deploying your application and its services across multiple regions. A multiregional deployment can use an active-active or active-passive configuration.

An active-active configuration distributes requests across multiple active regions. An active-passive configuration keeps warm instances in the secondary region, but doesn't send traffic there unless the primary region fails.

**Resources**

- [Design reliable Azure applications](https://learn.microsoft.com/azure/well-architected/resiliency/app-design)
- [Cross-region replication in Azure: Business continuity and disaster recovery](https://learn.microsoft.com/azure/reliability/cross-region-replication-azure)

<br><br>

### WADS-3 - Ensure that all fault-points and fault-modes are understood and operationalized

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Ensure that all fault-points and fault-modes are understood and operationalized.

Failure mode analysis (FMA) is a process for building resiliency into a system, by identifying possible failure points in the system. The FMA should be part of the architecture and design phases, so that you can build failure recovery into the system from the beginning.

Identify all fault-points and fault-modes. Fault-points describe the elements within an application architecture which can fail, while fault-modes capture the various ways by which a fault-point may fail. To ensure an application is resilient to end-to-end failures, it is essential that all fault-points and fault-modes are understood and operationalized .

**Resources**

- [Failure mode analysis for Azure applications](https://learn.microsoft.com/azure/architecture/resiliency/failure-mode-analysis)

<br><br>

### WADS-4 - Use PaaS Azure services instead of IaaS

**Category: System Efficiency**

**Impact: Medium**

**Recommendation/Guidance**

PaaS provides a framework for developing and running apps. As with IaaS, the PaaS provider hosts and maintains the platform's servers, networks, storage, and other computing resources. But PaaS also includes tools, services, and systems that support the web application lifecycle. Developers use the platform to build apps without having to manage backups, security solutions, upgrades, and other administrative tasks.

**Resources**

- [Use platform as a service (PaaS) options](https://learn.microsoft.com/azure/architecture/guide/design-principles/managed-services)

<br><br>

### WADS-5 - Design the application to scale out

**Category: System Efficiency**

**Impact: High**

**Recommendation/Guidance**

Azure provides elastic scalability and you should design to scale out. However, applications must leverage a scale-unit approach to navigate service and subscription limits to ensure that individual components and the application as a whole can scale horizontally. Don't forget about scale in, which is important to reduce cost. For example, scale in and out for App Service is done via rules. Often customers write scale out rules and never write scale in rules, which leaves the App Service more expensive.

**Resources**

- [Design to scale out](https://learn.microsoft.com/azure/architecture/guide/design-principles/scale-out)

<br><br>

### WADS-6 - Create a landing zone for the workload following the Microsoft Cloud Adoption Framework

**Category: Governance**

**Impact: Low**

**Recommendation/Guidance**

From a workload perspective, a landing zone refers to a prepared platform into which the application gets deployed. A landing zone implementation can have compute, data sources, access controls, and networking components already provisioned. With the required plumbing ready in place; the workload needs to plug into it.

When considering the overall security, a landing zone offers centralized security capabilities that adds a threat mitigation layer for the workload. Implementations can vary but here are some common strategies that enhance the security posture.

- Isolation through segmentation. You can isolate assets at several layers from Azure enrollment down to a subscription that has the resources for the workload.
- Consistent adoption of organizational policies, enforce creation and deletion of services and their configuration through Azure Policy.
- Configurations that align with principles of Zero Trust . For instance an implementation might have network connectivity to on-premises data centers.

**Resources**

- [Azure landing zone integration](https://learn.microsoft.com/azure/well-architected/security/design-governance-landing-zone)

<br><br>

### WADS-7 - Design a BCDR strategy that will help to meet the business requirements

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

Disaster recovery is the process of restoring application functionality after a catastrophic loss. In cloud environments, we acknowledge up front that failures happen. Instead of trying to prevent failures altogether, the goal is to minimize the effects of a single failing component.

Testing is one way to minimize these effects. You should automate testing of your applications where possible, but you also need to be prepared for when they fail. When a failure happens, having backup and recovery strategies becomes important. Your tolerance for reduced functionality during a disaster is a business decision that varies from one application to the next.

It might be acceptable for some applications to be temporarily unavailable, or partially available with reduced functionality or delayed processing. For other applications, any reduced functionality is unacceptable.

Key points:

- Create and test a disaster recovery plan regularly using key failure scenarios.
- Design a disaster recovery strategy to run most applications with reduced functionality.
- Design a backup strategy that's tailored for the business requirements and circumstances of the application.
- Automate failover and failback steps and processes.
- Test and validate the failover and failback approach successfully at least once.

**Resources**

- [Backup and disaster recovery for Azure applications](https://learn.microsoft.com/azure/well-architected/resiliency/backup-and-recovery)

<br><br>

### WADS-8 - Provide security assurance through identity management

**Category: Access & Security**

**Impact: Medium**

**Recommendation/Guidance**

Provide security assurance through identity management: the process of authenticating and authorizing security principals. Use identity management services to authenticate and grant permission to users, partners, customers, applications, services, and other entities. Identity management is typically a centralized function not controlled by the workload team as a part of the workload's architecture.

- Define clear lines of responsibility and separation of duties for each function. Restrict access based on a need-to-know basis and least privilege security principles.
- Assign permissions to users, groups, and applications at a certain scope through Azure RBAC. Use built-in roles when possible.
- Prevent deletion or modification of a resource, resource group, or subscription through management locks.
- Use managed identities to access resources in Azure.

**Resources**

- [Azure identity and access management considerations](https://learn.microsoft.com/azure/well-architected/security/design-identity)

<br><br>

### WADS-9 - Ensure you address security-related risks helps to minimize application downtime and data loss caused by unexpected security exposures

**Category: Access & Security**

**Impact: High**

**Recommendation/Guidance**

Security is one of the most important aspects of any architecture. It provides the following assurances against deliberate attacks and abuse of your valuable data and systems: Confidentiality ,Integrity, and Availability.
The security of complex systems depends on understanding the business context, social context, and technical context. As you design your system, cover these areas:

- Ensure that the identity provider (AAD/ADFS/AD/Other) is highly available and aligns with application availability and recovery targets.
- All external application endpoints are secured.
- Communication to Azure PaaS services secured using Virtual Network Service Endpoints or Private Link.
- Keys and secrets are backed-up to geo-redundant storage, and are still available in a failover case.
- Ensure that the process for key rotation is automated and tested.
- Emergency access break glass accounts have been tested and secured for recovering from Identity provider failure scenarios.

**Resources**

- [Security design principles](https://learn.microsoft.com/azure/well-architected/security/security-principles)

<br><br>
