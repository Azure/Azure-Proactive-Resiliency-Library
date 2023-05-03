+++
title = "Application Gateway"
description = "Best practices and resiliency recommendations for ExpressRoute Gateway and associated resources."
date = "5/1/23"
author = "jimays"
msAuthor = "jimays"
draft = false
+++

The presented resiliency recommendations in this guidance include Application Gateway and associated Application Gateway settings.

## Summary of Recommendations

The below table shows the list of resiliency recommendations for Application Gateway and associated resources.

{{< table style="table-striped" >}}
| Recommendation | State | ARG Query Available |
| :------------------------------------------------ | :------: | :-----------------: |
| [APPGW-1 - Ensure autoscaling is used with a minimum of 2 instance](#appgw-2---Ensure-autoscaling-is-used-with-a-minimum-of-2-instance) | Preview | Yes |
| [APPGW-2 - Secure all incoming connections with SSL/TLS](#appgw-4---secure-all-incoming-connections-with-ssl/tls) | Preview | Yes |
| [APPGW-3 - Enable WAF policies](#appgw-5---enable-waf-policies) | Preview | Yes |
| [APPGW-4 - Use Application GW V2 instead of V1](appgw-1---use-application-gw-v2-instead-of-v1) | Preview | Yes |
| [APPGW-5 - Monitor and Log the configurations and traffic](#appgw-3---monitor-and-log-the-configurations-and-traffic) | Preview | Yes |
| [APPGW-6 - Use Health Probes to detect backend availability](#appgw-6---use-health-probes-to-detect-backend-availability) | Preview | Yes |
| [APPGW-7 - Deploy backends in a zone-redundant configuration](#appgw-7---deploy-backends-in-a-zone---redundant-configuration) | Preview | Yes |
| [APPGW-8 - Plan for backend maintenance by using connection draining](#appgw-7---plan-for-backend-maintenance-by-using-connection-draining) | Preview | Yes |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### APPGW-1 - Ensure autoscaling is used with a minimum of 2 instance

#### Importance: Critical

#### Recommendation/Guidance

 When configuring the Application Gateway you should provision autoscaling and a minimum of two instances to minimize the effects of a single failing component. This allows for the opportunity to leverage the full capabilities of having a Layer 7 Load Balancing services. The creation of every new instance can take several minutes so having a minimum instance count of two ensure if one goes down for any reason that there is not a complete loss of connectivity to the backend services.  Auto scale allows the Application Gateway to scale out based on the traffic requirements without the need of manual intervention.

##### Resources

https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-autoscaling-zone-redundant

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}
{{< code lang="sql" file="code/appgw-1/appgw-1.kql" >}} {{< /code >}}
{{< /collapse >}}
<br><br>


### APPGW-2 - Secure all incoming connections with SSL/TLS

#### Importance: High

#### Recommendation/Guidance

Ensure that all incoming connections are using HTTP/s for production services.  Using end to end SSL/TLS or SSL/TLS termination to ensure the security of all incoming connections to the Application Gateway allows you and your users to be safe from possible attacks as it ensures that all data passed between the web server and browsers remain private and encrypted.


##### Resources

https://learn.microsoft.com/en-us/azure/well-architected/services/networking/azure-application-gateway#security
https://learn.microsoft.com/en-us/azure/application-gateway/ssl-overview
https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-ssl-policy-overview
https://learn.microsoft.com/en-us/azure/application-gateway/key-vault-certs
https://learn.microsoft.com/en-us/azure/application-gateway/ssl-certificate-management

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/appgw-2/appgw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### APPGW-3 - Enable WAF policies

#### Importance: High

#### Recommendation/Guidance

Use Application Gateway with Web Application Firewall (WAF) within an application virtual network to protect inbound HTTP/S traffic from the Internet. The WAF provides centralized protection from possible exploits by using rules based on the OWASP (Open Web Application Security Project) core rule sets.


##### Resources

https://learn.microsoft.com/en-us/azure/well-architected/services/networking/azure-application-gateway
https://learn.microsoft.com/en-us/azure/application-gateway/features#web-application-firewall

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/appgw-3/appgw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### APPGW-4 - Use Application GW V2 instead of V1

#### Importance: High

#### Recommendation/Guidance

You should use Application Gateway v2 unless there is a compelling reason for using v1. V2 has many more built in features such as autoscaling, static VIPs, Azure KeyVault integration for certificate management and many more features listed in our comparison charts.  Leveraging this updated version allows for better performance and control of how your traffic routed and the ability to make changes to the traffic.


##### Resources
https://learn.microsoft.com/en-us/azure/application-gateway/overview-v2
https://learn.microsoft.com/en-us/azure/application-gateway/overview-v2#feature-comparison-between-v1-sku-and-v2-sku
https://azure.microsoft.com/en-us/updates/application-gateway-v1-will-be-retired-on-28-april-2026-transition-to-application-gateway-v2/

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/appgw-4/appgw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### APPGW-5 - Monitor and Log the configurations and traffic

#### Importance: Medium

#### Recommendation/Guidance

Enable logs that can be stored in storage accounts, Log Analytics, and other monitoring services.  If NSGs are applied NSG flow logs can be enabled and stored for traffic audit and to provide insights into the traffic flowing into your Azure Cloud.

##### Resources

https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-metrics
https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-diagnostics

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/appgw-5/appgw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### APPGW-6 - Use Health Probes to detect backend availability

#### Importance: Medium

#### Recommendation/Guidance

Using custom health probes can help with understand the availability of your backends and allows you to monitor the backend services if they are being affected in any way.

##### Resources
https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-probe-overview
https://learn.microsoft.com/en-us/azure/well-architected/services/networking/azure-application-gateway
https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-create-probe-portal

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/appgw-6/appgw-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br> 

### APPGW-7 - Deploy backends in a zone-redundant configuration

#### Importance: Medium

#### Recommendation/Guidance
Deploying your backend services in a zone-aware configurations ensures that if a specific zone goes down that customers will still have access to the services as the other services located in other zones will still be available.

##### Resources
https://learn.microsoft.com/en-us/azure/well-architected/services/networking/azure-application-gateway#reliability
https://learn.microsoft.com/en-us/azure/application-gateway/overview-v2

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/appgw-7/appgw-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### APPGW-8 - Plan for backend maintenance by using connection draining

#### Importance: Medium

#### Recommendation/Guidance
Plan for backend maintenance by using connection draining. Connection draining allows 

##### Resources
https://learn.microsoft.com/en-us/azure/application-gateway/features#connection-draining
https://learn.microsoft.com/en-us/azure/application-gateway/configuration-http-settings#connection-draining
#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/appgw-8/appgw-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
