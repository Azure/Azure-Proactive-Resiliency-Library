+++
title = "AKS"
description = "Best practices and resiliency recommendations for AKS and associated resources."
date = "7/16/23"
author = "dcint"
msAuthor = "dacintro"
draft = false
+++

The presented resiliency recommendations in this guidance include Aks and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                | Impact |  State  | ARG Query Available |
| :-------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :-----------------: |
| [AKS-1 - Deploy AKS cluster across availability zones](#aks-1---deploy-aks-cluster-across-availability-zones)                                 |  High  | Preview |         Yes         |
| [AKS-2 - Isolate system pods](#aks-2---isolate-system-pods)                                                                                   |  High  | Preview |         Yes         |
| [AKS-3 - Enable AKS-managed Azure AD integration](#aks-3---enable-aks-managed-azure-ad-integration)                                           |  High  | Preview |         Yes         |
| [AKS-4 - Configure Azure CNI networking for dynamic allocation of IPs](#aks-4---configure-azure-cni-networking-for-dynamic-allocation-of-ips) | Medium | Preview |         Yes         |
| [AKS-5 - Enable the cluster autoscaler on an existing cluster](#aks-5---enable-the-cluster-autoscaler-on-an-existing-cluster)                 |  High  | Preview |         Yes         |
| [AKS-6 - Plan for multiregion deployment](#aks-6---plan-for-multiregion-deployment)                                                           |  High  | Preview |         No          |
| [AKS-7 - Back up Azure Kubernetes Service](#aks-7---back-up-azure-kubernetes-service)                                                         |  Low   | Preview |         No          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AKS-1 - Deploy AKS cluster across availability zones

#### Impact: High

#### Recommendation/Guidance

Azure Availability Zones are a high-availability offering that protects applications and data from datacenter-level failures. Availability Zones are unique physical locations within an Azure region that are equipped with independent power, cooling, and networking. Each Availability Zone is made up of one or more datacenters and is designed to be highly available and fault tolerant.

By deploying resources such as aks clusters, virtual machines, storage, and databases across multiple Availability Zones in the same region, you can protect your applications and data from datacenter-level failures. If one Availability Zone goes down, the other Availability Zones in the region can continue to provide service.



##### Resources

- [AKS Availability Zones](https://learn.microsoft.com/en-us/azure/aks/availability-zones)
- [Zone Balancing](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-use-availability-zones#zone-balancing)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-1/aks-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-2 - Isolate system pods

#### Impact: High

#### Recommendation/Guidance

AKS automatically assigns the label kubernetes.azure.com/mode: system to nodes in a system node pool. This label signals to AKS that system pods should be scheduled on nodes in this pool. However, you can still schedule application pods on these nodes if you choose to do so.

To prevent misconfigured or rogue application pods from accidentally killing system pods, it is recommended that you isolate critical system pods from your application pods. This can be achieved by scheduling system pods on dedicated node pools or by using node selectors to ensure that system pods are only scheduled on nodes with the kubernetes.azure.com/mode: system label.

##### Resources

- [System and user node pools](https://learn.microsoft.com/en-us/azure/aks/use-system-pools?tabs=azure-cli#system-and-user-node-pools)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-2/aks-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-3 - Enable AKS-managed Azure AD integration

#### Impact: High

#### Recommendation/Guidance

Enabling Azure AD integration on an AKS cluster provides several benefits for managing access to the cluster. By using Azure AD, you can centralize user and group management, enforce multi-factor authentication, and enable role-based access control (RBAC) for fine-grained access control to cluster resources. Additionally, Azure AD provides a secure and scalable authentication mechanism that can be integrated with other Azure services and third-party identity providers.


##### Resources

- [Azure AD integration](https://learn.microsoft.com/en-us/azure/aks/concepts-identity#azure-ad-integration)
- [Use Azure role-based access control for AKS](https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac?source=recommendations)
- [Manage AKS local accounts](https://learn.microsoft.com/en-us/azure/aks/manage-local-accounts-managed-azure-ad?source=recommendations)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-3/aks-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### AKS-4 - Configure Azure CNI networking for dynamic allocation of IPs

#### Impact: Medium

#### Recommendation/Guidance

The Azure CNI networking solution for AKS provides several benefits for managing IP addresses and network connectivity for cluster Pods. By dynamically allocating IPs to Pods from the Pod subnet, the solution leads to better utilization of IPs in the cluster compared to traditional CNI solutions that do static allocation of IPs for every node. The solution is scalable and flexible, allowing node and pod subnets to be scaled independently and shared across multiple node pools or AKS clusters. The solution also provides high performance, with direct connectivity between Pods and resources in the VNet. Additionally, the solution enables separate VNet policies for Pods, which can be configured differently from node policies. Finally, the solution supports Kubernetes network policies, including both Azure Network Policies and Calico. Overall, the Azure CNI networking solution provides a powerful and flexible networking solution for AKS clusters.

##### Resources

- [Configure Azure CNI networking](https://learn.microsoft.com/en-us/azure/aks/configure-azure-cni-dynamic-ip-allocation)
- [Configure Azure CNI Overlay networking](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-4/aks-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### AKS-5 - Enable the cluster autoscaler on an existing cluster

#### Impact: High

#### Recommendation/Guidance

AKS provides several options for scaling your cluster to meet changing demands. You can scale the number of nodes in a node pool manually or automatically based on metrics such as CPU utilization or custom metrics. You can also use virtual node scaling to add additional capacity to your cluster using Azure Container Instances. AKS also supports horizontal pod autoscaling, which automatically scales the number of pods in a deployment based on CPU utilization or custom metrics. Finally, AKS provides cluster autoscaling, which automatically scales the number of nodes in a node pool based on pod resource requests and the available capacity in the cluster. With these scaling options, you can ensure that your AKS cluster can handle varying workloads and optimize resource utilization.

##### Resources

- [Best practices for advanced scheduler features](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-advanced-scheduler)
- [Node pool scaling considerations and best practices](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-run-at-scale#node-pool-scaling-considerations-and-best-practices)
- [Best practices for basic scheduler features](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-scheduler)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-5/aks-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### AKS-6 - Plan for multiregion deployment

#### Impact: High

#### Recommendation/Guidance

An AKS cluster is deployed into a single region. To protect your system from region failure, deploy your application into multiple AKS clusters across different regions. When deploying multiple Kubernetes clusters in highly available and geographically distributed configurations, it's essential to consider the sum of each Kubernetes cluster as a coupled unit. You might want to develop code-driven strategies for automated deployment and configuration to ensure that each Kubernetes instance is as identical as possible.

##### Resources

- [Plan for multiregion deployment](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-multi-region#plan-for-multiregion-deployment)
- [Cluster deployment and bootstrapping](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-multi-region/aks-multi-cluster#cluster-deployment-and-bootstrapping)
- [AKS baseline for multiregion clusters](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-multi-region/aks-multi-cluster)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-6/aks-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### AKS-7 - Back up Azure Kubernetes Service

#### Impact: Low

#### Recommendation/Guidance

AKS is increasingly being used for stateful applications that require a backup strategy. Azure Backup now allows you to back up AKS clusters (cluster resources and persistent volumes attached to the cluster) using a backup extension, which must be installed in the cluster. Backup vault communicates with the cluster via this Backup Extension to perform backup and restore operations."

##### Resources

- [AKS Backups](https://learn.microsoft.com/en-us/azure/backup/azure-kubernetes-service-cluster-backup)
- [Best Practices for AKS Backups](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-storage)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-7/aks-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
