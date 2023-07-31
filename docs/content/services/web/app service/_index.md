+++
title = "App Service"
description = "Best practices and resiliency recommendations for App Service and associated resources."
date = "6/27/23"
author = "kunalbabre"
msAuthor = "kunalbabre"
draft = true
+++

The presented resiliency recommendations in this guidance include App Service and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Impact | State | ARG Query Available |
| :------------------------------------------------ | :------: | :------: | :-----------------: |
| [App-1 - Enable diagnostics logging](#app-1---enable-diagnostics-logging) | High | Preview | No |
| [App-2 - Monitor performance](#app-2---monitor-performance) | Medium | Preview | No |
| [App-3 - Separate web apps from web APIs ](#app-3---separate-web-apps-from-web-apis) | Low | Preview | Yes |
| [App-4 - Create a separate storage account for logs](#app-4---create-a-separate-storage-account-for-logs) | Medium | Preview | No |
| [App-5 - Deploy to a staging slot. ](#app-5---deploy-to-a-staging-slot) | Medium | Preview | Yes |
| [App-6 - Store configuration as app settings ](#app-6---store-configuration-as-app-settings) | Medium | Preview | No |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### App-1 - Enable diagnostics logging

**Impact: High**

**Recommendation/Guidance**

Enabling diagnostics logging for your Azure App Service is important for monitoring and diagnostics purposes. It includes application logging and web server logging.

**Resources**

- [Enable diagnostics logging for apps in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs)

<br><br>

### App-2 - Monitor Performance

**Impact: Medium**

**Recommendation/Guidance**

Use a performance monitoring service such [Application Insights](https://learn.microsoft.com/en-us/azure/application-insights/app-insights-overview) to monitor application performance and behavior under load. Performance monitoring gives you real-time insight into the application. It enables you to diagnose issues and perform root-cause analysis of failures.

Enable monitoring on your web applications based on ASP.NET, ASP.NET Core, Java, and Node.js running on Azure App Service. Previously, you needed to manually instrument your app, but the latest extension/agent is now built into the App Service image by default.

**Resources**

- [Application Insights](https://learn.microsoft.com/en-us/azure/application-insights/app-insights-overview)
- [Application monitoring for Azure App Service](https://learn.microsoft.com/en-us/azure/azure-monitor/app/azure-web-apps)

<br><br>

### App-3 - Separate web apps from web APIs

**Impact: Low**

**Recommendation/Guidance**

If your solution has both a web front end and a web API, consider decomposing them into separate App Service apps. This design makes it easier to decompose the solution by workload. You can run the web app and the API in separate App Service plans, so they can be scaled independently. If you don't need that level of scalability at first, you can deploy the apps into the same plan, and move them into separate plans later, if needed.

**Resources**

- [Resiliency checklist for specific Azure services](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#app-service)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/app-2/app-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### App-4 - Create a separate storage account for logs

**Impact: Medium**

**Recommendation/Guidance**

Create a separate storage account for logs. Don't use the same storage account for logs and application data. This helps to prevent logging from reducing application performance.

**Resources**

- [Resiliency checklist](https://learn.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service#app-service)

<br><br>

### App-5 - Deploy to a staging slot

**Impact: Medium**

**Recommendation/Guidance**

Create a deployment slot for staging. Deploy application updates to the staging slot, and verify the deployment before swapping it into production. This reduces the chance of a bad update in production. It also ensures that all instances are warmed up before being swapped into production. Many applications have a significant warmup and cold-start time. For more information

Consider creating a deployment slot to hold the last-known-good (LKG) deployment. When you deploy an update to production, move the previous production deployment into the LKG slot. This makes it easier to roll back a bad deployment. If you discover a problem later, you can quickly revert to the LKG version.
**Resources**

- [Set up staging environments in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service-web/web-sites-staged-publishing)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/app-2/app-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### App-6 - Store configuration as app settings

**Impact: Medium**

**Recommendation/Guidance**

Use app settings to hold configuration settings as app settings. Define the settings in your Resource Manager templates, or using PowerShell, so that you can apply them as part of an automated deployment / update process, which is more reliable.

**Resources**

- [Configure web apps in Azure App Service](https://learn.microsoft.com/en-us/azure/app-service-web/web-sites-configure)

<br><br>
