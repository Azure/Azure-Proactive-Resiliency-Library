+++
title = "Web Application Firewall"
description = "Best practices and resiliency recommendations for Web Application Firewall and associated resources."
date = "5/30/23"
author = "min-git"
msAuthor = "min-git"
draft = false
+++

The presented resiliency recommendations in this guidance include Web Application Firewall and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Impact | State | ARG Query Available |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :-----------------: |
| [WAF-1 - Review best practice for Web Application Firewall on Azure Application Gateway](#waf-1---review-best-practice-for-web-application-firewall-on-azure-application-gateway) | Medium | GA | No |
| [WAF-2 - Review best practice for Web Application Firewall on Azure Front Door](#waf-2---review-best-practice-for-web-application-firewall-on-azure-front-door) | Medium | GA | No |
| [WAF-3 - Review logs for Web Application Firewall on Azure Front Door for legitimate requests that are blocked](#waf-3---review-logs-for-web-application-firewall-on-azure-front-door-for-legitimate-requests-that-are-blocked) | High | GA | No |
| [WAF-4 - Review logs for Web Application Firewall on Azure Application Gateway for legitimate requests that are blocked](#waf-4---review-logs-for-web-application-firewall-on-azure-application-gateway-for-legitimate-requests-that-are-blocked) | High | GA | No |
| [WAF-5 - Monitor Web Application Firewall](#waf-5---monitor-web-application-firewall) | Medium | GA | No |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### WAF-1 - Review best practice for Web Application Firewall on Azure Application Gateway

**Impact: Medium**

**Guidance**

Review and apply best practices for Web Application Firewall (WAF) on Azure Application Gateway.

**Resources**

- [Best practices for Web Application Firewall on Application Gateway](https://learn.microsoft.com/azure/web-application-firewall/ag/best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-1/waf-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-2 - Review best practice for Web Application Firewall on Azure Front Door

**Impact: Medium**

**Guidance**

Review and apply best practices for Web Application Firewall (WAF) on Azure Front Door.

**Resources**

- [Best practices for Web Application Firewall (WAF) on Azure Front Door](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-2/waf-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-3 - Review logs for Web Application Firewall on Azure Front Door for legitimate requests that are blocked

**Impact: High**

**Guidance**

WAF could block a legitimate request that it shouldn't (a false positive). You can identify requests that have been blocked within the last 24 hours through Log Analytics.

**Resources**

- [Azure Web Application Firewall monitoring and logging - Access Log](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-monitor?pivots=front-door-standard-premium#access-logs)
- [Understanding WAF logs](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-tuning?pivots=front-door-standard-premium#understanding-waf-logs)
- [Web Application Firewall exclusion lists](https://learn.microsoft.com/azure/web-application-firewall/ag/application-gateway-waf-configuration?tabs=portal)
- [Fixing a false positive](https://learn.microsoft.com/azure/web-application-firewall/ag/web-application-firewall-troubleshoot#fixing-false-positives)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-3/waf-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-4 - Review logs for Web Application Firewall on Azure Application Gateway for legitimate requests that are blocked

**Impact: High**

**Guidance**

WAF could block a legitimate request that it shouldn't (a false positive). You can identify requests that have been blocked within the last 24 hours through Log Analytics.

**Resources**

- [Azure Web Application Firewall Monitoring and Logging](https://learn.microsoft.com/azure/web-application-firewall/ag/application-gateway-waf-metrics#logs-and-diagnostics)
- [Diagnostic logs](https://learn.microsoft.com/azure/web-application-firewall/ag/web-application-firewall-logs#diagnostic-logs)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-4/waf-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-5 - Monitor Web Application Firewall

**Impact: Medium**

**Guidance**

Monitoring the health of your WAF and the applications that it protects is important. Health monitoring is supported by integration with Microsoft Defender for Cloud, Azure Monitor, and Azure Monitor logs.

**Resources**

- [WAF monitoring](https://learn.microsoft.com/azure/web-application-firewall/ag/ag-overview#waf-monitoring)
- [Azure Monitor Workbook for WAF](https://github.com/Azure/Azure-Network-Security/tree/master/Azure%20WAF/Workbook%20-%20WAF%20Monitor%20Workbook)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-5/waf-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
