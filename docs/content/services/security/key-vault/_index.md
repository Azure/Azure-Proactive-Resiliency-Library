+++
title = "Key Vault"
description = "Best practices and resiliency recommendations for Key Vault and associated resources."
date = "5/29/23"
author = "maheshbenke"
msAuthor = "maheshbenke"
draft = false
+++

The presented resiliency recommendations in this guidance include Key Vault and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                    |     Category      | Impact |  State  | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:-------:|:-------------------:|
| [KV-1 - Key vaults should have soft delete enabled](#kv-1---key-vaults-should-have-soft-delete-enabled)                           | Disaster Recovery |  High  | Preview |         Yes         |
| [KV-2 - Key vaults should have purge protection enabled](#kv-2---key-vaults-should-have-purge-protection-enabled)                 | Disaster Recovery |  High  | Preview |         Yes         |
| [KV-3 - Enable Azure Private Link Service for Key vault](#kv-3---enable-azure-private-link-service-for-key-vault)                 |    Networking     |  High  | Preview |         No          |
| [KV-4 - Use separate key vaults per application per environment](#kv-4---use-separate-key-vaults-per-application-per-environment) |    Governance     |  High  | Preview |         No          |
| [KV-5 - Diagnostic logs in Key Vault should be enabled](#kv-5---diagnostic-logs-in-key-vault-should-be-enabled)                   |    Monitoring     |  Low   | Preview |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### KV-1 - Key vaults should have soft delete enabled

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Key Vault's soft-delete feature allows recovery of the deleted vaults and deleted key vault objects (for example, keys, secrets, certificates), known as soft-delete.When soft-delete is enabled, resources marked as deleted resources are retained for a specified period (90 days by default). The service further provides a mechanism for recovering the deleted object, essentially undoing the deletion

**Resources**

- [Azure Key Vault soft-delete overview](https://learn.microsoft.com/azure/key-vault/general/soft-delete-overview)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/kv-1/kv-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### KV-2 - Key vaults should have purge protection enabled

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Malicious deletion of a key vault can lead to permanent data loss. A malicious insider in your organization can potentially delete and purge key vaults. Purge protection protects you from insider attacks by enforcing a mandatory retention period for soft deleted key vaults. No one inside your organization or Microsoft will be able to purge your key vaults during the soft delete retention period.

**Resources**

- [Azure Key Vault purge-protection overview](https://learn.microsoft.com/azure/key-vault/general/soft-delete-overview#purge-protection)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/kv-2/kv-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### KV-3 - Enable Azure Private Link Service for Key vault

**Category: Networking**

**Impact: High**

**Guidance**

Azure Private Link Service enables you to access Azure Key Vault and Azure hosted customer/partner services over a Private Endpoint in your virtual network. An Azure Private Endpoint is a network interface that connects you privately and securely to a service powered by Azure Private Link. The private endpoint uses a private IP address from your VNet, effectively bringing the service into your VNet. All traffic to the service can be routed through the private endpoint, so no gateways, NAT devices, ExpressRoute or VPN connections, or public IP addresses are needed. Traffic between your virtual network and the service traverses over the Microsoft backbone network, eliminating exposure from the public Internet. You can connect to an instance of an Azure resource, giving you the highest level of granularity in access control.

**Resources**

- [Azure Key Vault Private Link Service overview](https://learn.microsoft.com/azure/key-vault/general/security-features#network-security)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/kv-3/kv-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### KV-4 - Use separate key vaults per application per environment

**Category: Governance**

**Impact: High**

**Guidance**

Key vaults define security boundaries for stored secrets. Grouping secrets into the same vault increases the blast radius of a security event because attacks might be able to access secrets across concerns. To mitigate access across concerns, consider what secrets a specific application should have access to, and then separate your key vaults based on this delineation. Separating key vaults by application is the most common boundary. Security boundaries, however, can be more granular for large applications, for example, per group of related services.

**Resources**

- [Azure Key Vault best practices overview](https://learn.microsoft.com/azure/key-vault/general/best-practices#why-we-recommend-separate-key-vaults)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/kv-4/kv-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### KV-5 - Diagnostic logs in Key Vault should be enabled

**Category: Monitoring**

**Impact: Low**

**Guidance**

Enable logs , set up alerts and retain them as per the retention requirement. This enables you to monitor how and when your key vaults are accessed, and by whom.

**Resources**

- [Azure Key Vault logging overview](https://learn.microsoft.com/azure/key-vault/general/logging?tabs=Vault)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/kv-5/kv-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
