+++
title = "3 - Test"
description = "Microsoft Azure Well-Architected Framework best practices and recommendations for the Reliability Stage - 3 - Test"
date = "9/18/23"
weight = 3
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented Microsoft Azure Well-Architected Framework recommendations in this guidance include Reliability Stage "3 - Test (Workload Testing)" and associated resources and their settings.

Before deploying the system, comprehensive tests are conducted to validate the design and implementation. This stage is crucial for identifying any weaknesses that could compromise reliability.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                  |  Category              |  Impact  |  State     | ARG Query Available |
| :---------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------: | :------: | :------:   | :-----------------: |
| [WATS-1 - Test your applications for availability and resiliency](#wats-1---test-your-applications-for-availability-and-resiliency)             | Application Resilience | Medium   |  Verified  |         No          |
| [WATS-2 - Consider building logic into your workload to handle errors](#wats-2---consider-building-logic-into-your-workload-to-handle-errors)   | Application Resilience | High     |  Verified  |         No          |
| [WATS-3 - Perform disaster recovery tests reguarly](#wats-3---perform-disaster-recovery-tests-reguarly)                                         | Disaster Recovery      | Medium   |  Verified  |         No          |
| [WATS-4 - Use chaos engineering to test Azure applications](#wats-4---use-chaos-engineering-to-test-azure-applications)                         | Application Resilience | Medium   |  Verified  |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### WATS-1 - Test your applications for availability and resiliency

**Category: Application Resilience**

**Impact: Medium**

**Recommendation/Guidance**

Applications should be tested to ensure availability and resiliency. Availability describes the amount of time that an application runs in a healthy state without significant downtime. Resiliency describes how quickly an application recovers from failure.

Being able to measure availability and resiliency can answer questions like: How much downtime is acceptable? How much does potential downtime cost your business? What are your availability requirements? How much do you invest in making your application highly available? What is the risk versus the cost? Testing plays a critical role in making sure your applications can meet these requirements.

Key points:

- Test regularly to validate existing thresholds, targets, and assumptions.
- Automate testing as much as possible.
- Perform testing on both key Test environments and the production environment.
- Verify how the end-to-end workload performs under intermittent failure conditions.
- Test the application against critical functional and nonfunctional requirements for performance.
- Conduct load testing with expected peak volumes to Test scalability and performance under load.
- Perform chaos testing by injecting faults.

**Resources**

- [Testing applications for availability and resiliency](https://learn.microsoft.com/azure/well-architected/resiliency/testing)

<br><br>

### WATS-2 - Consider building logic into your workload to handle errors

**Category: Application Resilience**

**Impact: High**

**Recommendation/Guidance**

In a distributed system, ensuring that your application can recover from errors is critical. You can test your applications to prevent errors and failure, but you need to prepare for a wide range of issues. Testing doesn't always catch everything, so you should understand how to handle errors and prevent potential failure.

Many things in a distributed system, such as underlying cloud infrastructure and third-party runtime dependencies, are outside your span of control and your means to test. You can be sure something will fail eventually, so you need to be prepared.

Key points:

- Implement retry logic to handle transient application failures and transient failures with internal or external dependencies.
- Uncover issues or failures in your application's retry logic.
- Configure request timeouts to manage intercomponent calls.
- Configure and test health probes for your load balancers and traffic managers.
- Segregate read operations from update operations across application data stores.

**Resources**

- [Error handling for resilient applications in Azure](https://learn.microsoft.com/azure/well-architected/resiliency/app-design-error-handling)

<br><br>

### WATS-3 - Perform disaster recovery tests reguarly

**Category: Disaster Recovery**

**Impact: Medium**

**Recommendation/Guidance**

Disaster recovery is the process of restoring application functionality after a catastrophic loss.
In cloud environments, we acknowledge up front that failures happen. Instead of trying to prevent failures altogether, the goal is to minimize the effects of a single failing component. Testing is one way to minimize these effects. You should automate testing of your applications where possible, but you also need to be prepared for when they fail. When a failure happens, having backup and recovery strategies becomes important.

Your tolerance for reduced functionality during a disaster is a business decision that varies from one application to the next. It might be acceptable for some applications to be temporarily unavailable, or partially available with reduced functionality or delayed processing. For other applications, any reduced functionality is unacceptable.

Key points

- Create and test a disaster recovery plan regularly using key failure scenarios.
- Design a disaster recovery strategy to run most applications with reduced functionality.
- Design a backup strategy that's tailored for the business requirements and circumstances of the application.
- Automate failover and failback steps and processes.
- Test and validate the failover and failback approach successfully at least once.

**Resources**

- [Backup and disaster recovery for Azure applications](https://learn.microsoft.com/azure/well-architected/resiliency/backup-and-recovery)

<br><br>

### WATS-4 - Use chaos engineering to test Azure applications

**Category: Application Resilience**

**Impact: Medium**

**Recommendation/Guidance**

Ideally, you should apply chaos principles continuously. There's constant change in the environments in which software and hardware run, so monitoring the changes is key. By constantly applying stress or faults on components, you can help expose issues early, before small problems are compounded by many other factors.

Apply chaos engineering principles when you:

- Deploy new code.
- Add dependencies.
- Observe changes in usage patterns.
- Mitigate problems.

**Resources**

- [Use chaos engineering to test Azure applications](https://learn.microsoft.com/azure/well-architected/resiliency/chaos-engineering)

<br><br>
