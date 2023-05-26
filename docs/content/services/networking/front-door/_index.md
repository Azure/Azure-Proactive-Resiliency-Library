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
| Recommendation                                    |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [FD-1 - Avoid combining Traffic Manager and Front Door](#fd-1---avoid-combining-traffic-manager-and-front-door) | Verified  |         Yes         |
| [FD-2 - Restrict traffic to your origins](#fd-2---restrict-traffic-to-your-origins) | Verified |         No          |
| [FD-3 - Use the latest API version and SDK version](#fd-3---use-the-latest-api-version-and-sdk-version) | Verified |         No          |
| [FD-4 - Configure logs](#fd-4---configure-logs) | Verified |         No          |
| [FD-5 - Use end-to-end TLS](#fd-5---use-end-to-end-tls) | Verified |         No          |
| [FD-6 - Use HTTP to HTTPS redirection](#fd-6---use-http-to-https-redirection) | Verified |         No          |
| [FD-7 - Use managed TLS certificates](#fd-7---use-managed-tls-certificates) | Verified |         No          |
| [FD-8 - Use 'Latest' version for customer-managed certificates](#fd-8---use-'latest'-version-for-customer-managed-certificates) | Verified |         No          |
| [FD-9 - Use the same domain name on Front Door and your origin](#fd-9---use-the-same-domain-name-on-front-door-and-your-origin) | Verified |         No          |
| [FD-10 - Enable the WAF](#fd-10---enable-the-waf) | Verified |         Yes          |
| [FD-11 - Follow WAF best practices](#fd-11---follow-waf-best-practices) | Verified |         Yes          |
| [FD-12 - Disable health probes when there’s only one origin in an origin group](#fd-12---disable-health-probes-when-there’s-only-one-origin-in-an-origin-group) | Verified |         No          |
| [FD-13 - Select good health probe endpoints](#fd-13---select-good-health-probe-endpoints) | Verified |         No          |
| [FD-14 - Use HEAD health probes](#fd-14---use-head-health-probes) | Verified |         No          |
| [FD-15 - Lock down Application Gateway to receive traffic only from Azure Front Door](#fd-15---lock-down-application-gateway-to-receive-traffic-only-from-azure-front-door) | Verified |         No          |
| [FD-16 - Use geo-filtering in Azure Front Door](#fd-16---use-geo-filtering-in-azure-front-door) | Verified |         No          |
| [FD-17 - Secure your Origin with Private Link in Azure Front Door](#fd-17---secure-your-origin-with-private-link-in-azure-front-door) | Verified |         Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### FD-1 - Avoid combining Traffic Manager and Front Door

#### Importance: Critical

#### Recommendation/Guidance

For most solutions, you should use either Front Door or Azure Traffic Manager, but not both. Traffic Manager is a DNS-based load balancer. It sends traffic directly to your origin's endpoints. In contrast, Front Door terminates connections at points of presence (PoPs) near to the client and establishes separate long-lived connections to the origins. The products work differently and are intended for different use cases.

If you need content caching and delivery (CDN), TLS termination, advanced routing capabilities, or a web application firewall (WAF), consider using Front Door. For simple global load balancing with direct connections from your client to your endpoints, consider using Traffic Manager.

However, as part of a complex architecture, you might choose to use Traffic Manager in front of Front Door. In the unlikely event that Front Door is unavailable, Traffic Manager can route traffic to an alternative destination, such as Azure Application Gateway or a partner content delivery network (CDN). These architectures are difficult to implement and most customers don't need them.

##### Resources

- [Azure Load Balancing Options](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/load-balancing-overview)
- [Azure Traffic Manager](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview)
- [Azure Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-overview)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/fd-1/fd-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-2 - Restrict traffic to your origins

#### Importance: High

#### Recommendation/Guidance

Front Door's features work best when traffic only flows through Front Door. You should configure your origin to block traffic that hasn't been sent through Front Door.

##### Resources

- [Secure traffic to Azure Front Door origins](https://learn.microsoft.com/en-us/azure/frontdoor/origin-security?tabs=app-service-functions&pivots=front-door-standard-premium)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-3 - Use the latest API version and SDK version

#### Importance: High

#### Recommendation/Guidance

When you work with Front Door by using APIs, ARM templates, Bicep, or Azure SDKs, it's important to use the latest available API or SDK version. API and SDK updates occur when new functionality is available, and also contain important security patches and bug fixes.

##### Resources

- [REST API Reference](https://learn.microsoft.com/en-us/rest/api/frontdoor/)
- [Client library for Java](https://learn.microsoft.com/en-us/java/api/overview/azure/resourcemanager-frontdoor-readme?view=azure-java-preview)
- [SDK for Python](https://learn.microsoft.com/en-us/python/api/overview/azure/front-door?view=azure-python)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-4 - Configure logs

#### Importance: Medium

#### Recommendation/Guidance

Front Door tracks extensive telemetry about every request. When you enable caching, your origin servers might not receive every request, so it's important that you use the Front Door logs to understand how your solution is running and responding to your clients.

##### Resources

- [Monitor metrics and logs in Azure Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-diagnostics?pivots=front-door-standard-premium)
- [WAF logs](https://learn.microsoft.com/en-us/azure/web-application-firewall/afds/waf-front-door-monitor?pivots=front-door-standard-premium#waf-logs)
- [Configure Azure Front Door logs](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-logs)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-5 - Use end-to-end TLS

#### Importance: High

#### Recommendation/Guidance

Front Door terminates TCP and TLS connections from clients. It then establishes new connections from each point of presence (PoP) to the origin. It's a good practice to secure each of these connections with TLS, even for origins that are hosted in Azure. This approach ensures that your data is always encrypted during transit.

##### Resources

- [End-to-end TLS with Azure Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/end-to-end-tls?pivots=front-door-standard-premium)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-6 - Use HTTP to HTTPS redirection

#### Importance: High

#### Recommendation/Guidance

It's a good practice for clients to use HTTPS to connect to your service. However, sometimes you need to accept HTTP requests to allow for older clients or clients who might not understand the best practice.

You can configure Front Door to automatically redirect HTTP requests to use the HTTPS protocol. You should enable the Redirect all traffic to use HTTPS setting on your route.

##### Resources

- [Create HTTP to HTTPS redirect rule](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-how-to-redirect-https#create-http-to-https-redirect-rule)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-7 - Use managed TLS certificates

#### Importance: Medium

#### Recommendation/Guidance

When Front Door manages your TLS certificates, it reduces your operational costs, and helps you to avoid costly outages caused by forgetting to renew a certificate. Front Door automatically issues and rotates the managed TLS certificates.

##### Resources

- [Configure HTTPS on an Azure Front Door custom domain using the Azure portal](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-8 - Use 'Latest' version for customer-managed certificates

#### Importance: Medium

#### Recommendation/Guidance

If you decide to use your own TLS certificates, then consider setting the Key Vault certificate version to 'Latest'. By using 'Latest', you avoid having to reconfigure Front Door to use new versions of your certificate and waiting for the certificate to be deployed throughout Front Door's environments.

##### Resources

- [Select the certificate for Azure Front Door to deploy](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell#select-the-certificate-for-azure-front-door-to-deploy)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-9 - Use the same domain name on Front Door and your origin

#### Importance: Medium

#### Recommendation/Guidance

Front Door can rewrite the Host header of incoming requests. This feature can be helpful when you manage a set of customer-facing custom domain names that route to a single origin. This feature can also help when you want to avoid configuring custom domain names in Front Door and at your origin. However, when you rewrite the Host header, request cookies and URL redirections might break. In particular, when you use platforms like Azure App Service, features like session affinity and authentication and authorization might not work correctly.

Before you rewrite the Host header of your requests, carefully consider whether your application is going to work correctly.

##### Resources

- [Preserve the original HTTP host name between a reverse proxy and its back-end web application](https://learn.microsoft.com/en-us/azure/architecture/best-practices/host-name-preservation)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-10 - Enable the WAF

#### Importance: Medium

#### Recommendation/Guidance

For internet-facing applications, we recommend you enable the Front Door web application firewall (WAF) and configure it to use managed rules. When you use a WAF and Microsoft-managed rules, your application is protected from a wide range of attacks.

##### Resources

- [https://learn.microsoft.com/en-us/azure/frontdoor/web-application-firewall](https://learn.microsoft.com/en-us/azure/frontdoor/web-application-firewall)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/fd-10/fd-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-11 - Follow WAF best practices

#### Importance: High

#### Recommendation/Guidance

The WAF for Front Door has its own set of best practices for its configuration and use.

##### Resources

- [Best practices for Web Application Firewall (WAF) on Azure Front Door](https://learn.microsoft.com/en-us/azure/web-application-firewall/afds/waf-front-door-best-practices)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/fd-11/fd-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-12 - Disable health probes when there’s only one origin in an origin group

#### Importance: Low

#### Recommendation/Guidance

Front Door's health probes are designed to detect situations where an origin is unavailable or unhealthy. When a health probe detects a problem with an origin, Front Door can be configured to send traffic to another origin in the origin group.

If you only have a single origin, Front Door always routes traffic to that origin even if its health probe reports an unhealthy status. The status of the health probe doesn't do anything to change Front Door's behavior. In this scenario, health probes don't provide a benefit and you should disable them to reduce the traffic on your origin.

##### Resources

- [Health probes](https://learn.microsoft.com/en-us/azure/frontdoor/health-probes)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-13 - Select good health probe endpoints

#### Importance: Medium

#### Recommendation/Guidance

Consider the location where you tell Front Door's health probe to monitor. It's usually a good idea to monitor a webpage or location that you specifically design for health monitoring. Your application logic can consider the status of all of the critical components required to serve production traffic including application servers, databases, and caches. That way, if any component fails, Front Door can route your traffic to another instance of your service

##### Resources

- [Health Endpoint Monitoring pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-14 - Use HEAD health probes

#### Importance: Medium

#### Recommendation/Guidance

Health probes can use either the GET or HEAD HTTP method. It's a good practice to use the HEAD method for health probes, which reduces the amount of traffic load on your origins.

##### Resources

- [Supported HTTP methods for health probes](https://learn.microsoft.com/en-us/azure/frontdoor/health-probes#supported-http-methods-for-health-probes)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-15 - Lock down Application Gateway to receive traffic only from Azure Front Door

#### Importance: Medium

#### Recommendation/Guidance

Lock down Application Gateway to receive traffic only from Azure Front Door when using Azure Front Door and Application Gateway to protect HTTP/S applications.
Certain scenarios can force a customer to implement rules specifically on AppGateway: For example, if ModSec Core Rule Set (CRS) 2.2.9, CRS 3.0, or CRS 3.1 rules are required, rules can be only implemented on AppGatway. Rate-limiting and geo-filtering are available only on Azure Front Door, not on AppGateway.

##### Resources

- [Application Gateway behind Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-faq#how-do-i-lock-down-the-access-to-my-backend-to-only-azure-front-door)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-16 - Use geo-filtering in Azure Front Door

#### Importance: Medium

#### Recommendation/Guidance

By default, Azure Front Door will respond to all user requests regardless of the location where the request is coming from. In some scenarios, you may want to restrict the access to your web application by countries/regions. The Web application firewall (WAF) service in Front Door enables you to define a policy using custom access rules for a specific path on your endpoint to either allow or block access from specified countries/regions.

A WAF policy contains a set of custom rules. The rule consists of match conditions, an action, and a priority. In a match condition, you define a match variable, operator, and match value. For a geo filtering rule, a match variable is either RemoteAddr or SocketAddr. RemoteAddr is the original client IP that is usually sent via X-Forwarded-For request header. SocketAddr is the source IP address WAF sees. If your user is behind a proxy, SocketAddr is often the proxy server address. The operator in the case of this geo filtering rule is GeoMatch, and the value is a two letter country/region code of interest. "ZZ" country code or "Unknown" country captures IP addresses that are not yet mapped to a country in our dataset. You may add ZZ to your match condition to avoid false positives. You can combine a GeoMatch condition and a REQUEST_URI string match condition to create a path-based geo-filtering rule.

##### Resources

- [Geo filter WAF policy - GeoMatch](https://learn.microsoft.com/en-us/azure/web-application-firewall/afds/waf-front-door-geo-filtering)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### FD-17 - Secure your Origin with Private Link in Azure Front Door

#### Importance: Medium

#### Recommendation/Guidance

Azure Private Link enables you to access Azure PaaS services and services hosted in Azure over a private endpoint in your virtual network. Traffic between your virtual network and the service goes over the Microsoft backbone network, eliminating exposure to the public Internet.

Azure Front Door Premium can connect to your origin using Private Link. Your origin can be hosted in a virtual network or hosted as a PaaS service such as Azure App Service or Azure Storage. Private Link removes the need for your origin to be accessed publicly.

##### Resources

- [Private link for Azure Front Door](https://learn.microsoft.com/en-us/azure/frontdoor/private-link)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>



