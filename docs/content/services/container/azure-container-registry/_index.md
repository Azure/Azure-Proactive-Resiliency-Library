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
| [CR-4 - Maximize pull performance](#cr-4---maximize-pull-performance)                                                                                                                                                              |  High  | Preview |         No          |
| [CR-5 - Use Repository namespaces](#cr-5---use-repository-namespaces)                                                                                                                                                              |  Low   | Preview |         No          |
| [CR-6 - Move Container Registry to a dedicated resource group](#cr-6---move-container-registry-to-a-dedicated-resource-group)                                                                                                      |  Low   | Preview |         Yes         |
| [CR-7 - Manage registry size](#cr-7---manage-registry-size)                                                                                                                                                                        | Medium | Preview |         Yes         |
| [CR-8 - Disable anonymous pull access](#cr-8---disable-anonymous-pull-access)                                                                                                                                                      | Medium | Preview |         Yes         |
| [CR-9 - Use an Azure managed identity to authenticate to an Azure container registry](#cr-9---use-an-azure-managed-identity-to-authenticate-to-an-azure-container-registry)                                                        | Medium | Preview |         Yes         |
| [CR-10 - Configure Diagnostic Settings for all Azure Resources](#cr-10---configure-diagnostic-settings-for-all-azure-resources)                                                                                                    | Medium | Preview |         No         |
| [CR-11 - Monitor Azure Container Registry with Azure Monitor](#cr-11---monitor-azure-container-registry-with-azure-monitor)                                                                                                        | Medium | Preview |         No          |
| [CR-12 - Enable soft delete policy](#cr-12---enable-soft-delete-policy)                                                                                                                                                            | Medium | Preview |         Yes
{{< /table >}}
{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### CR-1 - Use Premium tier for critical production workloads

**Category: System Efficiency**

**Impact: High**

**Guidance**

Choose a service tier of Azure Container Registry that meets your performance needs. The Premium tier provides the greatest bandwidth and highest rate of concurrent read and write operations when you have high-volume deployments. Use Basic for getting started, Standard for most production applications, and Premium for hyper-scale performance and geo-replication.

**Resources**

- [Container Registry Best Practices](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-1/cr-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-2 - Enable zone redundancy

**Category: Availability**

**Impact: High**

**Guidance**

Azure Container Registry supports optional zone redundancy. Zone redundancy provides resiliency and high availability to a registry or replication resource (replica) in a specific region.

**Resources**

- [Registry best practices - Enable zone redundancy](https://review.learn.microsoft.com/en-us/azure/container-registry/zone-redundancy?toc=%2Fazure%2Freliability%2Ftoc.json&bc=%2Fazure%2Freliability%2Fbreadcrumb%2Ftoc.json&branch=main)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-2/cr-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-3 - Enable geo-replication

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

Use Azure Container Registry's geo-replication feature if you're deploying containers to multiple regions. Whether you're serving global customers from local data centers or your development team is in different locations, you can simplify registry management and minimize latency by geo-replicating your registry. You can also configure regional webhooks to notify you of events in specific replicas such as when images are pushed.

Geo-replication is available with Premium registries.

**Resources**

- [Registry best practices - Enable geo-replication](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices#geo-replicate-multi-region-deployments)
- [Geo-Replicate Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-geo-replication)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-3/cr-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-4 - Maximize pull performance

**Category: System Efficiency**

**Impact: High**

**Guidance**

Some characteristics of your images themselves can impact pull performance:

- Image size - Minimize the sizes of your images by removing unnecessary layers or reducing the size of layers. One way to reduce image size is to use the multi-stage Docker build approach to include only the necessary runtime components. Also check whether your image can include a lighter base OS image. And if you use a deployment environment such as Azure Container Instances that caches certain base images, check whether you can swap an image layer for one of the cached images.

- Number of layers - Balance the number of layers used. If you have too few, you don’t benefit from layer reuse and caching on the host. Too many, and your deployment environment spends more time pulling and decompressing. Five to 10 layers is optimal.

**Resources**

- [Registry authentication options - Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli#admin-account)

<br><br>

### CR-5 - Use Repository namespaces

**Category: Access & Security**

**Impact: Low**

**Guidance**

By using repository namespaces, you can allow sharing a single registry across multiple groups within your organization. Registries can be shared across deployments and teams. Azure Container Registry supports nested namespaces, enabling group isolation. However, the registry manages all repositories independently, not as a hierarchy.

**Resources**

- [Registry best practices - use repository namespaces](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices#repository-namespaces)

<br><br>

### CR-6 - Move Container Registry to a dedicated resource group

**Category: Governance**

**Impact: Low**

**Guidance**

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

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

The storage constraints of each container registry service tier are intended to align with a typical scenario: Basic for getting started, Standard for most production applications, and Premium for hyper-scale performance and geo-replication. Throughout the life of your registry, you should manage its size by periodically deleting unused content. Consider also enabling a retention policy to automatically delete untagged image manifests to free up storage space.

**Resources**

- [Registry best practices - Manage registry size](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-best-practices#manage-registry-size)
- [Retention Policy](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-retention-policy#about-the-retention-policy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-7/cr-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-8 - Disable anonymous pull access

**Category: Access & Security**

**Impact: Medium**

**Guidance**

By default, access to pull or push content from an Azure container registry is only available to authenticated users. Enabling anonymous (unauthenticated) pull access makes all registry content publicly available for read (pull) actions. Warning: Anonymous pull access currently applies to all repositories in the registry. If you manage repository access using repository-scoped tokens, all users may pull from those repositories in a registry enabled for anonymous pull. We recommend deleting tokens when anonymous pull access is enabled.

**Resources**

- [Enable anonymous pull access](https://learn.microsoft.com/en-us/azure/container-registry/anonymous-pull-access#about-anonymous-pull-access)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-8/cr-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-9 - Use an Azure managed identity to authenticate to an Azure container registry

**Category: Access & Security**

**Impact: Medium**

**Guidance**

Each container registry includes an admin user account, which is disabled by default. The admin account is designed for a single user to access the registry, mainly for testing purposes. We do not recommend sharing the admin account credentials among multiple users. All users authenticating with the admin account appear as a single user with push and pull access to the registry. Changing or disabling this account disables registry access for all users who use its credentials.

Use a managed identity for Azure resources to authenticate to an Azure container registry from another Azure resource, without needing to provide or manage registry credentials.

**Resources**

- [Registry authentication options - Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli#admin-account)
- [Authenticate with managed identity - Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-authentication-managed-identity?tabs=azure-cli)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-9/cr-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CR-10 - Configure Diagnostic Settings for all Azure Resources

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Resource Logs are not collected and stored until you create a diagnostic setting and route them to one or more locations.

**Resources**

- [Monitoring Azure Container Registry data reference - Resource Logs](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service-reference#resource-logs)
- [Monitor Azure Container Registry - Enable diagnostic logs](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service#collection-and-routing)

<br><br>

### CR-11 - Monitor Azure Container Registry with Azure Monitor

**Category: Monitoring**

**Impact: Medium**

**Guidance**

When you have critical applications and business processes relying on Azure resources, you want to monitor those resources for their availability, performance, and operation. Azure Container Registry creates monitoring data using Azure Monitor, which is a full stack monitoring service in Azure that provides a complete set of features to monitor your Azure resources in addition to resources in other clouds and on-premises.

**Resources**

- [Monitoring Azure Container Registry data reference](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service-reference#metrics)
- [Monitor Azure Container Registry](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service)
<br><br>

### CR-12 - Enable soft delete policy

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Once you enable the soft delete policy, ACR manages the deleted artifacts as the soft deleted artifacts with a set retention period. Thereby you have ability to list, filter, and restore the soft deleted artifacts. Once the retention period is complete, all the soft deleted artifacts are auto-purged.

**Resources**

- [Enable soft delete policy](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-soft-delete-policy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cr-12/cr-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
