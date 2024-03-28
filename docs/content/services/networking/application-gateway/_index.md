+++
title = "Application Gateway"
description = "Best practices and resiliency recommendations for Application Gateway and Web Application Firewall and associated resources."
date = "5/1/23"
author = "jimays"
msAuthor = "jimays"
draft = false
+++

The presented resiliency recommendations in this guidance include Application Gateway, Web Application Firewall and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                               |     Category      | Impact |  State  | ARG Query Available |
|:---------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [AGW-1 - Set a minimum instance count of 2](#agw-1---set-a-minimum-instance-count-of-2)                                                      | System Efficiency |  High  | Preview |         Yes         |
| [AGW-2 - Secure all incoming connections with SSL](#agw-2---secure-all-incoming-connections-with-ssl)                                        | Access & Security |  High  | Preview |         Yes          |
| [AGW-3 - Enable WAF policies](#agw-3---enable-web-application-firewall-policies)                                                             | Access & Security |  High  | Preview |         Yes         |
| [AGW-4 - Use Application GW V2 instead of V1](#agw-4---use-application-gw-v2-instead-of-v1)                                                  | System Efficiency |  High  | Preview |         Yes         |
| [AGW-5 - Monitor and Log the configurations and traffic](#agw-5---monitor-and-log-the-configurations-and-traffic)                            |    Monitoring     | Medium | Preview |         No          |
| [AGW-6 - Use Health Probes to detect backend availability](#agw-6---use-health-probes-to-detect-backend-availability)                        |    Monitoring     | Medium | Preview |         Yes         |
| [AGW-7 - Deploy Application Gateway in a zone-redundant configuration](#agw-7---deploy-application-gateway-in-a-zone-redundant-configuration)|   Availability    |  High  | Preview |         Yes         |
| [AGW-8 - Plan for backend maintenance by using connection draining](#agw-8---plan-for-backend-maintenance-by-using-connection-draining)      |    Governance     | Medium | Preview |         No          |
| [AGW-9 - Ensure Application Gateway Subnet is using a /24 subnet mask](#agw-9---ensure-application-gateway-subnet-is-using-a-24-subnet-mask) |    Networking     |  High  | Preview |         Yes          |

{{< /table >}}
{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AGW-1 - Set a minimum instance count of 2

**Category: System Efficiency**

**Impact: High**

**Guidance**

Azure Application Gateways v2 are always deployed in a highly available fashion, deployed with multiple instances by default regardless of your autoscaling configuration. However, creating a new instance can take up to six or seven minutes. In order to avoid downtime for various failure modes, it is recommended that you configure a minimum instance count of two, ideally with Availability Zone support. By doing this, you will always have at least two instances in your Azure Application Gateway under normal circumstances. If one of them was to have a problem, there will always be another instance present to handle the traffic while a new instance is being created. Also, continue to leverage auto scaling to dynamically scale out based on the traffic requirements without the need of manual intervention.

**Resources**

- [Application Gateway Autoscaling Zone-Redundant](https://learn.microsoft.com/azure/application-gateway/application-gateway-autoscaling-zone-redundant#autoscaling-and-high-availability)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-1/agw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-2 - Secure all incoming connections with SSL

**Category: Access & Security**

**Impact: High**

**Guidance**

Ensure that all incoming connections are using HTTPs for production services. Using end to end SSL/TLS or SSL/TLS termination to ensure the security of all incoming connections to the Application Gateway allows you and your users to be safe from possible attacks as it ensures that all data passed between the web server and browsers remain private and encrypted.

**Resources**

- [Application Gateway Security](https://learn.microsoft.com/azure/well-architected/services/networking/azure-application-gateway#security)
- [Application Gateway SSL Overview](https://learn.microsoft.com/azure/application-gateway/ssl-overview)
- [Application Gateway SSL Policy Overview](https://learn.microsoft.com/azure/application-gateway/application-gateway-ssl-policy-overview)
- [Application Gateway KeyVault Certs](https://learn.microsoft.com/azure/application-gateway/key-vault-certs)
- [Application Gateway SSL Cert Management](https://learn.microsoft.com/azure/application-gateway/ssl-certificate-management)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-2/agw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-3 - Enable Web Application Firewall policies

**Category: Access & Security**

**Impact: High**

**Guidance**

Use Application Gateway with Web Application Firewall (WAF) within an application virtual network to protect inbound HTTP/S traffic from the Internet. The WAF provides centralized protection from possible exploits by using rules based on the OWASP (Open Web Application Security Project) core rule sets.

**Resources**

- [Well-Architected Framework Application Gateway Overview](https://learn.microsoft.com/azure/well-architected/services/networking/azure-application-gateway)
- [Application Gateway - Web Application Firewall](https://learn.microsoft.com/azure/application-gateway/features#web-application-firewall)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-3/agw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-4 - Use Application GW V2 instead of V1

**Category: System Efficiency**

**Impact: High**

**Guidance**

You should use Application Gateway v2 unless there is a compelling reason for using v1. V2 has many more built in features such as autoscaling, static VIPs, Azure KeyVault integration for certificate management and many more features listed in our comparison charts. Leveraging this updated version allows for better performance and control of how your traffic routed and the ability to make changes to the traffic.

**Resources**

- [Application Gateway Overview V2](https://learn.microsoft.com/azure/application-gateway/overview-v2)
- [Application Gateway Feature Comparison Between V1 and V2](https://learn.microsoft.com/azure/application-gateway/overview-v2#feature-comparison-between-v1-sku-and-v2-sku)
- [Application Gateway V1 Retirement](https://azure.microsoft.com/updates/application-gateway-v1-will-be-retired-on-28-april-2026-transition-to-application-gateway-v2/)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-4/agw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-5 - Monitor and Log the configurations and traffic

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Enable logs that can be stored in storage accounts, Log Analytics, and other monitoring services. If NSGs are applied NSG flow logs can be enabled and stored for traffic audit and to provide insights into the traffic flowing into your Azure Cloud.

**Resources**

- [Application Gateway Metrics](https://learn.microsoft.com/azure/application-gateway/application-gateway-metrics)
- [Application Gateway Diagnostics](https://learn.microsoft.com/azure/application-gateway/application-gateway-diagnostics)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-5/agw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-6 - Use Health Probes to detect backend availability

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Using custom health probes can help with understand the availability of your backends and allows you to monitor the backend services if they are being affected in any way.

**Resources**

- [Application Gateway Probe Overview](https://learn.microsoft.com/azure/application-gateway/application-gateway-probe-overview)
- [Well-Architected Framework Application Gateway Overview](https://learn.microsoft.com/azure/well-architected/services/networking/azure-application-gateway)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-6/agw-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-7 - Deploy Application Gateway in a zone-redundant configuration

**Category: Availability**

**Impact: High**

**Guidance**

Deploying your Application Gateway in a zone-aware configurations ensures that if a specific zone goes down that customers will still have access to the services as the other services located in other zones will still be available.

**Resources**

- [Well-Architected Framework Application Gateway Reliability](https://learn.microsoft.com/azure/well-architected/services/networking/azure-application-gateway#reliability)
- [Application Gateway V2 Overview](https://learn.microsoft.com/azure/application-gateway/overview-v2)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-7/agw-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-8 - Plan for backend maintenance by using connection draining

**Category: Governance**

**Impact: Medium**

**Guidance**

Plan for backend maintenance by using connection draining. Connection draining helps you achieve graceful removal of backend pool members during planned service updates or problems with backend health. This setting is enabled via the Backend Setting and is applied to all backend pool members during rule creation.

**Resources**

- [Application Gateway Connection Draining](https://learn.microsoft.com/azure/application-gateway/features#connection-draining)
- [Application Gateway Connection Draining HTTP Settings](https://learn.microsoft.com/azure/application-gateway/configuration-http-settings#connection-draining)

**Resource Graph Query**
{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/agw-8/agw-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AGW-9 - Ensure Application Gateway Subnet is using a /24 subnet mask

**Category: Networking**

**Impact: High**

**Recommendation/Guidance**

Application Gateway (Standard_v2 or WAF_v2 SKU) can support up to 125 instances. Although a /24 subnet isn't required per Application Gateway v2 SKU deployment, it is highly recommended. This is to ensure that Application Gateway v2 has sufficient space for autoscaling expansion and maintenance upgrades.

**Resources**

- [Azure Application Gateway infrastructure configuration | Microsoft Learn](https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure#size-of-the-subnet)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}
{{< code lang="sql" file="code/agw-9/agw-9.kql" >}} {{< /code >}}
{{< /collapse >}}
<br><br>
