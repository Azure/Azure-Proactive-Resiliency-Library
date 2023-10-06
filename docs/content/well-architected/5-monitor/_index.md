+++
title = "5 - Monitor"
description = "Microsoft Azure Well-Architected Framework best practices and recommendations for the Reliability Stage - 5 - Monitor"
date = "9/18/23"
weight = 5
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented Microsoft Azure Well-Architected Framework recommendations in this guidance include Reliability Stage "5 - Monitor (Observability and Monitoring)" and associated resources and their settings.

Ongoing monitoring is essential for maintaining system reliability. Key performance indicators (KPIs) are constantly observed to ensure the system is meeting its defined objectives. Services like Azure Monitor, Network Watcher, and Service Health can be invaluable here.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                             |  Category     |  Impact    |  State    | ARG Query Available |
| :----------------------------------------------------------------------------------------------------------------------------------------- | :-----------: | :------:   | :------:  | :-----------------: |
| [WAMN-1 - Make sure your application's health is being monitored](#wamn-1---make-sure-your-applications-health-is-being-monitored)         | Monitoring    | Medium     | Verified  |         No          |
| [WAMN-2 - Define a health model based on performance, availability, and recovery targets](#wamn-2---define-a-health-model-based-on-performance-availability-and-recovery-targets) | Monitoring    | Low        | Verified  |         No          |
| [WAMN-3 - Create Dashboards and Alerts for Azure Platform resources](#wamn-3---create-dashboards-and-alerts-for-azure-platform-resources) | Monitoring    | Low        | Verified  |         No          |
| [WAMN-4 - Ensure that the right people in your organization will be notified about any future service issues](#wamn-4---ensure-that-the-right-people-in-your-organization-will-be-notified-about-any-future-service-issues) | Monitoring    | Medium     | Verified  |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### WAMN-1 - Make sure your application's health is being monitored

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Monitoring and diagnostics are crucial for availability and resiliency. If something fails, you need to know that it failed, when it failed, and why.

Monitoring isn't the same as failure detection. For example, your application might detect a transient error and retry, avoiding downtime. It should also log the retry operation so that you can monitor the error rate to get an overall picture of application health.

Key points:

- Define alerts that are actionable and effectively prioritized.
- Create alerts that poll for services nearing their limits and quotas.
- Use application instrumentation to detect and resolve performance anomalies.
- Track the progress of long-running processes.
- Troubleshoot issues to gain an overall view of application health.
- Document how to analyze, diagnose, and respond to signals being monitored

**Resources**

- [Monitoring application health for reliability](https://learn.microsoft.com/azure/well-architected/resiliency/monitoring)

<br><br>

### WAMN-2 - Define a health model based on performance, availability, and recovery targets

**Category: Monitoring**

**Impact: Low**

**Recommendation/Guidance**

The health model should be able to surface the health of critical system flows or key subsystems to ensure that appropriate operational prioritization is applied. For example, the health model should be able to represent the current state of the user sign-in transaction flow.

The health model shouldn't treat all failures the same. The health model should distinguish between transient and non transient faults. It should clearly distinguish between expected-transient but recoverable failures and a true disaster state.

Key points:

- Know how to tell if an application is healthy or unhealthy.
- Understand the effects of logs in diagnostic data.
- Ensure the consistent use of diagnostic settings across the application.
- Use critical system flows in your health model.

**Resources**

- [Health modeling for reliability](https://learn.microsoft.com/azure/well-architected/resiliency/monitor-model)

<br><br>

### WAMN-3 - Create Dashboards and Alerts for Azure Platform resources

**Category: Monitoring**

**Impact: Low**

**Recommendation/Guidance**

In this stage, telemetry data is presented so that an operator can quickly notice problems or trends.
Examples include Workbook, Dashboards or email alerts. With Azure Workbooks and/or dashboards, you can build a single pane of glass view of monitoring graphs originating from Application Insights, Log Analytics, Azure Monitor metrics and service health. With Azure Monitor alerts, you can create alerts on service health and resource health.

**Resources**

- [Azure Workbooks templates](https://learn.microsoft.com/azure/azure-monitor/visualize/workbooks-templates)

<br><br>

### WAMN-4 - Ensure that the right people in your organization will be notified about any future service issues

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Azure offers a suite of experiences to keep you informed about the health of your cloud resources. The Service Health portal tracks four types of health events that may impact your resources:

- Service issues - Problems in the Azure services that affect you right now (Outages)
- Planned maintenance - Upcoming maintenance that can affect the availability of your services in the future.
- Health advisories - Changes in Azure services that require your attention. Examples include deprecation of Azure features or upgrade requirements (e.g upgrade to a supported PHP framework).
- Security advisories - Security related notifications or violations that may affect the availability of your Azure services.

**Resources**

- [Create a Service Health alert using the Azure portal](https://learn.microsoft.com/azure/service-health/alerts-activity-log-service-notifications-portal#create-a-service-health-alert-using-the-azure-portal)

<br><br>
