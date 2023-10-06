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
| Recommendation                                                                                                                                                                                                                     | Impact |  State  | ARG Query Available |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :-----------------: |
| [WAF-1 - Associate Web Application Firewall policy with Azure Application Gateway](#waf-1---associate-web-application-firewall-policy-with-azure-application-gateway)                                                                                                                          |  High  | GA |         Yes         |
| [WAF-2 - Associate Web Application Firewall with Azure Front Door](#waf-2---associate-web-application-firewall-with-azure-front-door)                                                                                                              |  High  | GA |         Yes         |
| [WAF-3 - Review best practice for Web Application Firewall on Azure Application Gateway](#waf-3---review-best-practice-for-web-application-firewall-on-azure-application-gateway)                    |  Medium  | GA |         No         |
| [WAF-4 - Review best practice for Web Application Firewall on Azure Front Door](#waf-4---review-best-practice-for-web-application-firewall-on-azure-front-door)                                                                                                        | Medium | GA |         No         |
| [WAF-5 - Identify a blocked legitimate request for Web Application Firewall on Azure Front Door](#waf-5---identify-a-blocked-legitimate-request-for-web-application-firewall-on-azure-front-door)                                                                                                                |  High  | GA |         Yes         |
| [WAF-6 - Identify a blocked legitimate request for Web Application Firewall on Azure Application Gateway](#waf-6---identify-a-blocked-legitimate-request-for-web-application-firewall-on-azure-application-gateway)                                                                                                                |  High  | GA |         Yes         |
| [WAF-7 - Fixing a false positive for Web Application Firewall on Azure Application Gateway](#waf-7---fixing-a-false-positive-for-web-application-firewall-on-azure-application-gateway)                                                                                                                |  High  | GA |         No         |
| [WAF-8 - Monitor Web Application Firewall](#waf-8---monitor-web-application-firewall)                                                                                                                |  Medium  | GA |         No         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### WAF-1 - Associate Web Application Firewall policy with Azure Application Gateway

**Impact: High**

**Guidance**

When you create a policy of WAF, it must be associated to an application gateway to take effect. Application Gateway has two versions of the WAF sku: Application Gateway WAF_v1 and Application Gateway WAF_v2. WAF policy associations are only supported for the Application Gateway WAF_v2 sku.

**Resources**

- [Web Application Firewall policy overview](https://learn.microsoft.com/azure/web-application-firewall/ag/policy-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-1/waf-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-2 - Associate Web Application Firewall with Azure Front Door

**Impact: High**

**Guidance**

Azure Web Application Firewall (WAF) on Azure Front Door provides centralized protection for your web applications. WAF defends your web services against common exploits and vulnerabilities. It keeps your service highly available for your users and helps you meet compliance requirements.
Azure Front Door has two tiers: Front Door Standard and Front Door Premium. WAF is natively integrated with Front Door Premium with full capabilities. For Front Door Standard, only custom rules are supported.

**Resources**

- [Azure Web Application Firewall on Azure Front Door](https://learn.microsoft.com/azure/web-application-firewall/afds/afds-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-2/waf-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-3 - Review best practice for Web Application Firewall on Azure Application Gateway

**Impact: Medium**

**Guidance**

Review and apply best practices for using the web application firewall (WAF) on Azure Application Gateway.

**Resources**

- [Best practices for Web Application Firewall on Application Gateway](https://learn.microsoft.com/azure/web-application-firewall/ag/best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-3/waf-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-4 - Review best practice for Web Application Firewall on Azure Front Door

**Impact: Medium**

**Guidance**

Review and apply best practices for using the web application firewall (WAF) on Azure Front Door.

**Resources**

- [Best practices for Web Application Firewall (WAF) on Azure Front Door](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-4/waf-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-5 - Identify a blocked legitimate request for Web Application Firewall on Azure Front Door

**Impact: High**

**Guidance**

WAF could blocks a legitimate request that it shouldn't (a false positive). You can identify requests that have been blocked within the last 24 hours through Log Analytics.

**Resources**

- [Azure Web Application Firewall monitoring and logging - Access Log](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-monitor?pivots=front-door-standard-premium#access-logs)
- [Understanding WAF logs](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-tuning?pivots=front-door-standard-premium#understanding-waf-logs)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-5/waf-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-6 - Identify a blocked legitimate request for Web Application Firewall on Azure Application Gateway

**Impact: High**

**Guidance**

WAF could blocks a legitimate request that it shouldn't (a false positive). You can identify requests that have been blocked within the last 24 hours through Log Analytics.

**Resources**

- [Azure Web Application Firewall Monitoring and Logging](https://learn.microsoft.com/azure/web-application-firewall/ag/application-gateway-waf-metrics#logs-and-diagnostics)
- [Diagnostic logs](https://learn.microsoft.com/azure/web-application-firewall/ag/web-application-firewall-logs#diagnostic-logs)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-6/waf-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-7 - Fixing a false positive for Web Application Firewall on Azure Application Gateway

**Impact: High**

**Guidance**

WAF could blocks a legitimate request that it shouldn't (a false positive). The rule 942130 is the one that matched the 1=1 string, you can do a few things to stop this from blocking your traffic.

**Resources**

- [Web Application Firewall exclusion lists](https://learn.microsoft.com/azure/web-application-firewall/ag/application-gateway-waf-configuration?tabs=portal)
- [Fixing a false positive](https://learn.microsoft.com/azure/web-application-firewall/ag/web-application-firewall-troubleshoot#fixing-false-positives)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-7/waf-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### WAF-8 - Monitor Web Application Firewall

**Impact: Medium**

**Guidance**

Monitoring the health of your application gateway is important. Monitoring the health of your WAF and the applications that it protects are supported by integration with Microsoft Defender for Cloud, Azure Monitor, and Azure Monitor logs.

**Resources**

- [WAF monitoring](https://learn.microsoft.com/azure/web-application-firewall/ag/ag-overview#waf-monitoring)
- [Azure Monitor Workbook for WAF](https://github.com/Azure/Azure-Network-Security/tree/master/Azure%20WAF/Workbook%20-%20WAF%20Monitor%20Workbook)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/waf-8/waf-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
