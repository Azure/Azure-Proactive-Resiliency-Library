+++
title = "Container Registry"
description = "Best practices and resiliency recommendations for Container Registries and associated resources."
date = "8/21/23"
author = "oZakari"
msAuthor = "ztrocinski"
draft = false
+++

The presented resiliency recommendations in this guidance include Container Registries and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                     | Impact |  State  | ARG Query Available |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :-----------------: |
| [CR-1 - Use Premium tier for critical production workloads](#cr-1---use-premium-tier-for-critical-production-workloads)                                                                                                            |  High  | Preview |         Yes         |
| [CR-2 - Enable zone redundancy](#cr-2---enable-zone-redundancy)                                                                                                                                                                    |  High  | Preview |         Yes         |
| [CR-3 - Enable geo-replication](#cr-3---enable-geo-replication)                                                                                                                                                                    |  High  | Preview |         Yes         |
| [CR-4 - Maximize pull performance](#cr-4---maximize-pull-performance)                                                                                                                                                              |  High  | Preview |         Yes         |
| [CR-5 - Use Repository namespaces](#cr-5---use-repository-namespaces)                                                                                                                                                              |  Low   | Preview |         Yes         |
| [CR-6 - Move Container Registry to a dedicated resource group](#cr-6---move-container-registry-to-a-dedicated-resource-group)                                                                                                      |  Low   | Preview |         Yes         |
| [CR-7 - Manage registry size](#cr-7---manage-registry-size)                                                                                                                                                                        | Medium | Preview |         Yes         |
| [CR-8 - Disable anonymous pull access](#cr-8---disable-anonymous-pull-access)                                                                                                                                                      | Medium | Preview |         Yes         |
| [CR-9 - Use an Azure managed identity to authenticate to an Azure container registry](#cr-9---use-an-azure-managed-identity-to-authenticate-to-an-azure-container-registry)                                                        | Medium | Preview |         Yes         |
| [CR-10 - Configure Diagnostic Settings for all Azure Resources](#cr-10---configure-diagnostic-settings-for-all-azure-resources)                                                                                                    | Medium | Preview |         Yes         |
| [CR-11 - Monitor Azure Container Registry with Azure Monitor](#cr-11---monitor-azure-container-registry-with-azure-monitor)                                                                                                        | Medium | Preview |         Yes         |
{{< /table >}}
{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### CR-1 - Use Premium tier for critical production workloads

**Impact: High**

**Recommendation/Guidance**

Choose a service tier of Azure Container Registry that meets your performance needs. The Premium tier provides the greatest bandwidth and highest rate of concurrent read and write operations when you have high-volume deployments. Use Basic for getting started, Standard for most production applications, and Premium for hyper-scale performance and geo-replication.

**Resources**

- [Container Registry Best Practices](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-1/cr-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-2 - Enable zone redundancy

**Impact: High**

**Recommendation/Guidance**

Azure Container Registry supports optional zone redundancy. Zone redundancy provides resiliency and high availability to a registry or replication resource (replica) in a specific region.

**Resources**

- [Registry best practices - Enable zone redundancy](https://review.learn.microsoft.com/en-us/azure/container-registry/zone-redundancy?toc=%2Fazure%2Freliability%2Ftoc.json&bc=%2Fazure%2Freliability%2Fbreadcrumb%2Ftoc.json&branch=main)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-2/cr-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-3 - Enable geo-replication

**Impact: High**

**Recommendation/Guidance**

Use Azure Container Registry's geo-replication feature if you're deploying containers to multiple regions. Whether you're serving global customers from local data centers or your development team is in different locations, you can simplify registry management and minimize latency by geo-replicating your registry. You can also configure regional webhooks to notify you of events in specific replicas such as when images are pushed.

Geo-replication is available with Premium registries.

**Resources**

- [Registry best practices - Enable geo-replication](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices#geo-replicate-multi-region-deployments)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-3/cr-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-4 - Maximize pull performance

**Impact: High**

**Recommendation/Guidance**

Each container registry includes an admin user account, which is disabled by default. The admin account is designed for a single user to access the registry, mainly for testing purposes. We do not recommend sharing the admin account credentials among multiple users. All users authenticating with the admin account appear as a single user with push and pull access to the registry. Changing or disabling this account disables registry access for all users who use its credentials.

Use a managed identity for Azure resources to authenticate to an Azure container registry from another Azure resource, without needing to provide or manage registry credentials.

**Resources**

- [Registry authentication options - Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli#admin-account)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-4/cr-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-5 - Use Repository namespaces

**Impact: Low**

**Recommendation/Guidance**

By using repository namespaces, you can allow sharing a single registry across multiple groups within your organization. Registries can be shared across deployments and teams. Azure Container Registry supports nested namespaces, enabling group isolation. However, the registry manages all repositories independently, not as a hierarchy.

**Resources**

- [Registry best practices - use repository namespaces](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices#repository-namespaces)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-5/cr-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-6 - Move Container Registry to a dedicated resource group

**Impact: Low**

**Recommendation/Guidance**

Because container registries are resources that are used across multiple container hosts, a registry should reside in its own resource group.

Although you might experiment with a specific host type, such as Azure Container Instances, you'll likely want to delete the container instance when you're done. However, you might also want to keep the collection of images you pushed to Azure Container Registry. By placing your registry in its own resource group, you minimize the risk of accidentally deleting the collection of images in the registry when you delete the container instance resource group.

**Resources**

- [Registry best practices - Use dedicated resource group](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices#dedicated-resource-group)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-6/cr-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-7 - Manage registry size

**Impact: Medium**

**Recommendation/Guidance**

The storage constraints of each container registry service tier are intended to align with a typical scenario: Basic for getting started, Standard for most production applications, and Premium for hyper-scale performance and geo-replication. Throughout the life of your registry, you should manage its size by periodically deleting unused content.
**Resources**

- [Registry best practices - Manage registry size](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices#manage-registry-size)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-7/cr-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-8 - Disable anonymous pull access

**Impact: Medium**

**Recommendation/Guidance**

By default, access to pull or push content from an Azure container registry is only available to authenticated users. Enabling anonymous (unauthenticated) pull access makes all registry content publicly available for read (pull) actions. Warning: Anonymous pull access currently applies to all repositories in the registry. If you manage repository access using repository-scoped tokens, all users may pull from those repositories in a registry enabled for anonymous pull. We recommend deleting tokens when anonymous pull access is enabled.

**Resources**

- [Enable anonymous pull access](https://learn.microsoft.com/en-us/azure/container-registry/anonymous-pull-access#about-anonymous-pull-access)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-8/cr-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-9 - Use an Azure managed identity to authenticate to an Azure container registry

**Impact: Medium**

**Recommendation/Guidance**

Each container registry includes an admin user account, which is disabled by default. The admin account is designed for a single user to access the registry, mainly for testing purposes. We do not recommend sharing the admin account credentials among multiple users. All users authenticating with the admin account appear as a single user with push and pull access to the registry. Changing or disabling this account disables registry access for all users who use its credentials.

Use a managed identity for Azure resources to authenticate to an Azure container registry from another Azure resource, without needing to provide or manage registry credentials.

**Resources**

- [Registry authentication options - Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli#admin-account)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-9/cr-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-10 - Configure Diagnostic Settings for all Azure Resources

**Impact: Medium**

**Recommendation/Guidance**

Resource Logs are not collected and stored until you create a diagnostic setting and route them to one or more locations.

**Resources**

- [Monitoring Azure Container Registry data reference - Resource Logs](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service-reference#resource-logs)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-10/cr-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-11 - Monitor Azure Container Registry with Azure Monitor

**Impact: Medium**

**Recommendation/Guidance**

When you have critical applications and business processes relying on Azure resources, you want to monitor those resources for their availability, performance, and operation. Azure Container Registry creates monitoring data using Azure Monitor, which is a full stack monitoring service in Azure that provides a complete set of features to monitor your Azure resources in addition to resources in other clouds and on-premises.

**Resources**

- [Monitoring Azure Container Registry data reference](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service-reference#metrics)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/CR-11/CR-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>