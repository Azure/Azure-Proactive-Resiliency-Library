+++
title = "Front Door"
description = "Best practices and resiliency recommendations for Front Door and associated resources."
date = "5/23/23"
author = "khushal08"
msAuthor = "khushkaviraj"
draft = false
+++

The presented resiliency recommendations in this guidance include Front Door and associated Front Door settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Front Door and associated resources.

{{< table style="table-striped" >}}

| Recommendation                                    | Impact  | State   | ARG Query Available |
| :------------------------------------------------ | :------: |:------: | :-----------------: |
| [AFD-1 - Avoid combining Traffic Manager and Front Door](#afd-1---avoid-combining-traffic-manager-and-front-door) | High |Preview  |         No        |
| [AFD-2 - Restrict traffic to your origins](#afd-2---restrict-traffic-to-your-origins) | High | Preview |         No          |
| [AFD-3 - Use the latest API version and SDK version](#afd-3---use-the-latest-api-version-and-sdk-version) | High | Preview |         No          |
| [AFD-4 - Configure logs](#afd-4---configure-logs) | Medium | Preview |         No          |
| [AFD-5 - Use end-to-end TLS](#afd-5---use-end-to-end-tls) | High | Preview |         No          |
| [AFD-6 - Use HTTP to HTTPS redirection](#afd-6---use-http-to-https-redirection) | High | Preview |         No          |
| [AFD-7 - Use managed TLS certificates](#afd-7---use-managed-tls-certificates) | Medium | Preview |         No          |
| [AFD-8 - Use latest version for customer-managed certificates](#afd-8---use-latest-version-for-customer-managed-certificates) | Medium | Preview |         No          |
| [AFD-9 - Use the same domain name on Front Door and your origin](#afd-9---use-the-same-domain-name-on-front-door-and-your-origin) | Medium | Preview |         No          |
| [AFD-10 - Enable the WAF](#afd-10---enable-the-waf) | Medium | Preview |         No          |
| [AFD-11 - Disable health probes when there is only one origin in an origin group](#afd-12---disable-health-probes-when-there-is-only-one-origin-in-an-origin-group) | Low | Preview |         No          |
| [AFD-12 - Select good health probe endpoints](#afd-13---select-good-health-probe-endpoints) | Medium | Preview |         No          |
| [AFD-13 - Use HEAD health probes](#afd-14---use-head-health-probes) | Medium | Preview |         No          |
| [AFD-14 - Lock down Application Gateway to receive traffic only from Azure Front Door](#afd-15---lock-down-application-gateway-to-receive-traffic-only-from-azure-front-door) | Medium | Preview |         No          |
| [AFD-15 - Use geo-filtering in Azure Front Door](#afd-16---use-geo-filtering-in-azure-front-door) | Medium | Preview |         No          |
| [AFD-16 - Secure your Origin with Private Link in Azure Front Door](#afd-17---secure-your-origin-with-private-link-in-azure-front-door) | Medium | Preview |         No          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AFD-1 - Avoid combining Traffic Manager and Front Door

**Category: Networking**

**Impact: High**

**Guidance**

For most solutions, you should use either Front Door or Azure Traffic Manager, but not both. Traffic Manager is a DNS-based load balancer. It sends traffic directly to your origin's endpoints. In contrast, Front Door terminates connections at points of presence (PoPs) near to the client and establishes separate long-lived connections to the origins. The products work differently and are intended for different use cases.

If you need content caching and delivery (CDN), TLS termination, advanced routing capabilities, or a web application firewall (WAF), consider using Front Door. For simple global load balancing with direct connections from your client to your endpoints, consider using Traffic Manager.

However, as part of a complex architecture, you might choose to use Traffic Manager in front of Front Door. In the unlikely event that Front Door is unavailable, Traffic Manager can route traffic to an alternative destination, such as Azure Application Gateway or a partner content delivery network (CDN). These architectures are difficult to implement and most customers don't need them.

**Resources**

- [Azure Load Balancing Options](https://learn.microsoft.com/azure/architecture/guide/technology-choices/load-balancing-overview)
- [Azure Traffic Manager](https://learn.microsoft.com/azure/traffic-manager/traffic-manager-overview)
- [Azure Front Door](https://learn.microsoft.com/azure/frontdoor/front-door-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-1/afd-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-2 - Restrict traffic to your origins

**Category: Access & Security**

**Impact: High**

**Guidance**

Front Door's features work best when traffic only flows through Front Door. You should configure your origin to block traffic that hasn't been sent through Front Door.

**Resources**

- [Secure traffic to Azure Front Door origins](https://learn.microsoft.com/azure/frontdoor/origin-security?tabs=app-service-functions&pivots=front-door-standard-premium)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-2/afd-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-3 - Use the latest API version and SDK version

**Category: Networking**

**Impact: Medium**

**Guidance**

When you work with Front Door by using APIs, ARM templates, Bicep, or Azure SDKs, it's important to use the latest available API or SDK version. API and SDK updates occur when new functionality is available, and also contain important security patches and bug fixes.

**Resources**

- [REST API Reference](https://learn.microsoft.com/rest/api/frontdoor/)
- [Client library for Java](https://learn.microsoft.com/java/api/overview/azure/resourcemanager-frontdoor-readme?view=azure-java-preview)
- [SDK for Python](https://learn.microsoft.com/python/api/overview/azure/front-door?view=azure-python)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-3/afd-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-4 - Configure logs

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Front Door tracks extensive telemetry about every request. When you enable caching, your origin servers might not receive every request, so it's important that you use the Front Door logs to understand how your solution is running and responding to your clients.

**Resources**

- [Monitor metrics and logs in Azure Front Door](https://learn.microsoft.com/azure/frontdoor/front-door-diagnostics?pivots=front-door-standard-premium)
- [WAF logs](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-monitor?pivots=front-door-standard-premium#waf-logs)
- [Configure Azure Front Door logs](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-logs)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-4/afd-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-5 - Use end-to-end TLS

**Category: Security**

**Impact: High**

**Guidance**

Front Door terminates TCP and TLS connections from clients. It then establishes new connections from each point of presence (PoP) to the origin. It's a good practice to secure each of these connections with TLS, even for origins that are hosted in Azure. This approach ensures that your data is always encrypted during transit.

**Resources**

- [End-to-end TLS with Azure Front Door](https://learn.microsoft.com/azure/frontdoor/end-to-end-tls?pivots=front-door-standard-premium)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-5/afd-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-6 - Use HTTP to HTTPS redirection

**Category: Access & Security**

**Impact: High**

**Guidance**

It's a good practice for clients to use HTTPS to connect to your service. However, sometimes you need to accept HTTP requests to allow for older clients or clients who might not understand the best practice.

You can configure Front Door to automatically redirect HTTP requests to use the HTTPS protocol. You should enable the Redirect all traffic to use HTTPS setting on your route.

**Resources**

- [Create HTTP to HTTPS redirect rule](https://learn.microsoft.com/azure/frontdoor/front-door-how-to-redirect-https#create-http-to-https-redirect-rule)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-6/afd-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-7 - Use managed TLS certificates

**Category: Access & Security**

**Impact: Medium**

**Guidance**

When Front Door manages your TLS certificates, it reduces your operational costs, and helps you to avoid costly outages caused by forgetting to renew a certificate. Front Door automatically issues and rotates the managed TLS certificates.

**Resources**

- [Configure HTTPS on an Azure Front Door custom domain using the Azure portal](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-7/afd-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-8 - Use latest version for customer-managed certificates

**Category: Access & Security**

**Impact: Medium**

**Guidance**

If you decide to use your own TLS certificates, then consider setting the Key Vault certificate version to 'Latest'. By using 'Latest', you avoid having to reconfigure Front Door to use new versions of your certificate and waiting for the certificate to be deployed throughout Front Door's environments.

**Resources**

- [Select the certificate for Azure Front Door to deploy](https://learn.microsoft.com/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell#select-the-certificate-for-azure-front-door-to-deploy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-8/afd-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-9 - Use the same domain name on Front Door and your origin

**Category: Networking**

**Impact: Medium**

**Guidance**

Front Door can rewrite the Host header of incoming requests. This feature can be helpful when you manage a set of customer-facing custom domain names that route to a single origin. This feature can also help when you want to avoid configuring custom domain names in Front Door and at your origin. However, when you rewrite the Host header, request cookies and URL redirections might break. In particular, when you use platforms like Azure App Service, features like session affinity and authentication and authorization might not work correctly.

Before you rewrite the Host header of your requests, carefully consider whether your application is going to work correctly.

**Resources**

- [Preserve the original HTTP host name between a reverse proxy and its back-end web application](https://learn.microsoft.com/azure/architecture/best-practices/host-name-preservation)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-9/afd-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-10 - Enable the WAF

**Category: Access & Security**

**Impact: Medium**

**Guidance**

For internet-facing applications, we recommend you enable the Front Door web application firewall (WAF) and configure it to use managed rules. When you use a WAF and Microsoft-managed rules, your application is protected from a wide range of attacks.

**Resources**

- [https://learn.microsoft.com/azure/frontdoor/web-application-firewall](https://learn.microsoft.com/azure/frontdoor/web-application-firewall)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-10/afd-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-11 - Disable health probes when there is only one origin in an origin group

**Category: Availability**


**Impact: Low**

**Guidance**

Front Door's health probes are designed to detect situations where an origin is unavailable or unhealthy. When a health probe detects a problem with an origin, Front Door can be configured to send traffic to another origin in the origin group.

If you only have a single origin, Front Door always routes traffic to that origin even if its health probe reports an unhealthy status. The status of the health probe doesn't do anything to change Front Door's behavior. In this scenario, health probes don't provide a benefit and you should disable them to reduce the traffic on your origin.

**Resources**

- [Health probes](https://learn.microsoft.com/azure/frontdoor/health-probes)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-11/afd-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-12 - Select good health probe endpoints


**Category: Availability**


**Impact: Medium**

**Guidance**

Consider the location where you tell Front Door's health probe to monitor. It's usually a good idea to monitor a webpage or location that you specifically design for health monitoring. Your application logic can consider the status of all of the critical components required to serve production traffic including application servers, databases, and caches. That way, if any component fails, Front Door can route your traffic to another instance of your service

**Resources**

- [Health Endpoint Monitoring pattern](https://learn.microsoft.com/azure/architecture/patterns/health-endpoint-monitoring)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-12/afd-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-13 - Use HEAD health probes


**Category: System Efficiency**


**Impact: Medium**

**Guidance**

Health probes can use either the GET or HEAD HTTP method. It's a good practice to use the HEAD method for health probes, which reduces the amount of traffic load on your origins.

**Resources**

- [Supported HTTP methods for health probes](https://learn.microsoft.com/azure/frontdoor/health-probes#supported-http-methods-for-health-probes)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-13/afd-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### AFD-14 - Lock down Application Gateway to receive traffic only from Azure Front Door

**Impact: Medium**

**Guidance**

Lock down Application Gateway to receive traffic only from Azure Front Door when using Azure Front Door and Application Gateway to protect HTTP/S applications.
Certain scenarios can force a customer to implement rules specifically on AppGateway: For example, if ModSec Core Rule Set (CRS) 2.2.9, CRS 3.0, or CRS 3.1 rules are required, rules can be only implemented on AppGatway. Rate-limiting and geo-filtering are available only on Azure Front Door, not on AppGateway.

**Resources**

- [Application Gateway behind Front Door](https://learn.microsoft.com/azure/frontdoor/front-door-faq#how-do-i-lock-down-the-access-to-my-backend-to-only-azure-front-door)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-15/afd-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AFD-15 - Use geo-filtering in Azure Front Door

**Category: Access & Security**


**Impact: Medium**

**Guidance**

By default, Azure Front Door will respond to all user requests regardless of the location where the request is coming from. In some scenarios, you may want to restrict the access to your web application by countries/regions. The Web application firewall (WAF) service in Front Door enables you to define a policy using custom access rules for a specific path on your endpoint to either allow or block access from specified countries/regions.

A WAF policy contains a set of custom rules. The rule consists of match conditions, an action, and a priority. In a match condition, you define a match variable, operator, and match value.
For a geo filtering rule, a match variable is either RemoteAddr or SocketAddr. RemoteAddr is the original client IP that is usually sent via X-Forwarded-For request header. SocketAddr is the source IP address WAF sees. If your user is behind a proxy, SocketAddr is often the proxy server address. The operator in the case of this geo filtering rule is GeoMatch, and the value is a two letter country/region code of interest. "ZZ" country code or "Unknown" country captures IP addresses that are not yet mapped to a country in our dataset. You may add ZZ to your match condition to avoid false positives. You can combine a GeoMatch condition and a REQUEST_URI string match condition to create a path-based geo-filtering rule.

**Resources**

- [Geo filter WAF policy - GeoMatch](https://learn.microsoft.com/azure/web-application-firewall/afds/waf-front-door-geo-filtering)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-14/afd-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### AFD-16 - Secure your Origin with Private Link in Azure Front Door

**Category: Access & Security**


**Impact: Medium**

**Guidance**

Azure Private Link enables you to access Azure PaaS services and services hosted in Azure over a private endpoint in your virtual network. Traffic between your virtual network and the service goes over the Microsoft backbone network, eliminating exposure to the public Internet.

Azure Front Door Premium can connect to your origin using Private Link. Your origin can be hosted in a virtual network or hosted as a PaaS service such as Azure App Service or Azure Storage. Private Link removes the need for your origin to be accessed publicly.

**Resources**

- [Private link for Azure Front Door](https://learn.microsoft.com/azure/frontdoor/private-link)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/afd-15/afd-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
