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
| [AKS-6 - Plan for multi-region deployment](#aks-6---plan-for-multi-region-deployment)                                                         |  High  | Preview |         No          |
| [AKS-7 - Back up Azure Kubernetes Service](#aks-7---back-up-azure-kubernetes-service)                                                         |  Low   | Preview |         No          |
| [AKS-8 - Control traffic flow with network policies](#aks-8---control-traffic-flow-with-network-policies)                                                         |  Low   | Preview |         No          |
| [AKS-9 - Plan an AKS version upgrade](#aks-9---plan-an-aks-version-upgrade)                                                         |  High   | Preview |         No          |
| [AKS-10 - Remediate AKS non-compliant Azure Policies](#aks-10---remediate-aks-non-compliant-azure-policies)                                                         |  Low   | Preview |         No          |
| [AKS-11 - Deploy AKS across availability zones](#aks-11---deploy-aks-across-availability-zones)                                                         |  High   | Preview |         No          |
| [AKS-12 - Ensure that Persistent Volumes in storage account are redundant for Pods with stateful applications](#aks-12---ensure-that-persistent-volumes-in-storage-account-are-redundant-for-pods-with-stateful-applications)                                                         |  Low   | Preview |         No          |
| [AKS-13 - Disable Local Account Access to AKS](#aks-13---disable-local-account-access-to-aks)                                                         |  High   | Preview |         No          |
| [AKS-14 - Remediate Azure Advisor recommendations](#aks-14---remediate-azure-advisor-recommendations)                                                         |  High   | Preview |         No          |
| [AKS-15 - Deploy a private AKS cluster if public access is not required](#aks-15---deploy-a-private-aks-cluster-if-public-access-is-not-required)                                                         |  Low   | Preview |         No          |
| [AKS-16 - Keep a consistent configuration between regions with the API Server Authorized IP Addresses](#aks-16---keep-a-consistent-configuration-between-regions-with-the-api-server-authorized-ip-addresses)                                                         |  High   | Preview |         No          |
| [AKS-17 - Upgrade Persistent Volumes with deprecated version to Azure CSI drivers](#aks-17---upgrade-persistent-volumes-with-deprecated-version-to-azure-csi-drivers)                                                         |  High   | Preview |         No          |
| [AKS-18 - Implement Resource Quota to ensure that Kubernetes resources do not exceed hard resource limits.](#aks-18---implement-resource-quota-to-ensure-that-kubernetes-resources-do-not-exceed-hard-resource-limits)                                                         |  Low   | Preview |         No          |
| [AKS-19 - Attach Virtual Nodes (ACI) to the AKS cluster](#aks-19---attach-virtual-nodes-aci-to-the-aks-cluster)                                                         |  Low   | Preview |         No          |
| [AKS-20 - Isolate application (User) pods](#aks-20---isolate-application-user-pods)                                                         |  Medium   | Preview |         No          |
| [AKS-21 - Enable AKS Monitor alerts](#aks-21---enable-aks-monitor-alerts)                                                         |  High   | Preview |         No          |
| [AKS-22 - Update AKS tier to Standard](#aks-22---update-aks-tier-to-standard)                                                         |  High   | Preview |         No          |
| [AKS-23 - Configure the API server Public IP access for public clusters](#aks-23---configure-the-api-server-public-ip-access-for-public-clusters)                                                         |  High   | Preview |         No          |
| [AKS-24 - Enable AKS Monitoring](#aks-24---enable-aks-monitoring)                                                         |  High   | Preview |         No          |
| [AKS-25 - Use Ephemeral Disks on AKS clusters](#aks-25---use-ephemeral-disks-on-aks-clusters)                                                         |  Medium   | Preview |         No          |
| [AKS-26 - Enable Azure Policies configured for AKS](#aks-26---enable-azure-policies-configured-for-aks)                                                         |  Low   | Preview |         No          |
| [AKS-27 - Enable GitOps when using DevOps frameworks](#aks-27---enable-gitops-when-using-devops-frameworks)                                                         |  Low   | Preview |         No          |
| [AKS-28 - Use the Azure KeyVault provider for Secrets Store CSI Driver](#aks-28---use-the-azure-keyvault-provider-for-secrets-store-csi-driver)                                                         |  High   | Preview |         No          |
| [AKS-29 - Configure affinity or anti-affinity rules based on application requirements](#aks-29---configure-affinity-or-anti-affinity-rules-based-on-application-requirements)                                                         |  High   | Preview |         No          |
| [AKS-30 - Configures Pods Liveness, Readiness, and Startup Probes](#aks-30---configures-pods-liveness-readiness-and-startup-probes)                                                         |  High   | Preview |         No          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AKS-1 - Deploy AKS cluster across availability zones

**Category: Availability**

**Impact: High**

**Guidance**

Azure Availability Zones are a high-availability offering that protects applications and data from datacenter-level failures. Availability Zones are unique physical locations within an Azure region that are equipped with independent power, cooling, and networking. Each Availability Zone is made up of one or more datacenters and is designed to be highly available and fault tolerant.

By deploying resources such as aks clusters, virtual machines, storage, and databases across multiple Availability Zones in the same region, you can protect your applications and data from datacenter-level failures. If one Availability Zone goes down, the other Availability Zones in the region can continue to provide service.

**Resources**

- [AKS Availability Zones](https://learn.microsoft.com/en-us/azure/aks/availability-zones)
- [Zone Balancing](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-use-availability-zones#zone-balancing)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-1/aks-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-2 - Isolate system pods

**Category: Governance**

**Impact: High**

**Guidance**

AKS automatically assigns the label kubernetes.azure.com/mode: system to nodes in a system node pool. This label signals to AKS that system pods should be scheduled on nodes in this pool. However, you can still schedule application pods on these nodes if you choose to do so.

To prevent misconfigured or rogue application pods from accidentally killing system pods, it is recommended that you isolate critical system pods from your application pods. This can be achieved by scheduling system pods on dedicated node pools or by using node selectors to ensure that system pods are only scheduled on nodes with the kubernetes.azure.com/mode: system label.

**Resources**

- [System and user node pools](https://learn.microsoft.com/en-us/azure/aks/use-system-pools?tabs=azure-cli#system-and-user-node-pools)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-2/aks-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-3 - Enable AKS-managed Azure AD integration

**Category: Access & Security**

**Impact: High**

**Guidance**

Enabling Azure AD integration on an AKS cluster provides several benefits for managing access to the cluster. By using Azure AD, you can centralize user and group management, enforce multi-factor authentication, and enable role-based access control (RBAC) for fine-grained access control to cluster resources. Additionally, Azure AD provides a secure and scalable authentication mechanism that can be integrated with other Azure services and third-party identity providers.

**Resources**

- [Azure AD integration](https://learn.microsoft.com/en-us/azure/aks/concepts-identity#azure-ad-integration)
- [Use Azure role-based access control for AKS](https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac?source=recommendations)
- [Manage AKS local accounts](https://learn.microsoft.com/en-us/azure/aks/manage-local-accounts-managed-azure-ad?source=recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-3/aks-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-4 - Configure Azure CNI networking for dynamic allocation of IPs

**Category: Networking**

**Impact: Medium**

**Guidance**

The Azure CNI networking solution for AKS provides several benefits for managing IP addresses and network connectivity for cluster Pods. By dynamically allocating IPs to Pods from the Pod subnet, the solution leads to better utilization of IPs in the cluster compared to traditional CNI solutions that do static allocation of IPs for every node. The solution is scalable and flexible, allowing node and pod subnets to be scaled independently and shared across multiple node pools or AKS clusters. The solution also provides high performance, with direct connectivity between Pods and resources in the VNet. Additionally, the solution enables separate VNet policies for Pods, which can be configured differently from node policies. Finally, the solution supports Kubernetes network policies, including both Azure Network Policies and Calico. Overall, the Azure CNI networking solution provides a powerful and flexible networking solution for AKS clusters.

**Resources**

- [Configure Azure CNI networking](https://learn.microsoft.com/en-us/azure/aks/configure-azure-cni-dynamic-ip-allocation)
- [Configure Azure CNI Overlay networking](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-4/aks-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-5 - Enable the cluster autoscaler on an existing cluster

**Category: System Efficiency**

**Impact: High**

**Guidance**

AKS provides several options for scaling your cluster to meet changing demands. You can scale the number of nodes in a node pool manually or automatically based on metrics such as CPU utilization or custom metrics. You can also use virtual node scaling to add additional capacity to your cluster using Azure Container Instances. AKS also supports horizontal pod autoscaling, which automatically scales the number of pods in a deployment based on CPU utilization or custom metrics. Finally, AKS provides cluster autoscaling, which automatically scales the number of nodes in a node pool based on pod resource requests and the available capacity in the cluster. With these scaling options, you can ensure that your AKS cluster can handle varying workloads and optimize resource utilization.

**Resources**

- [Best practices for advanced scheduler features](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-advanced-scheduler)
- [Node pool scaling considerations and best practices](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-run-at-scale#node-pool-scaling-considerations-and-best-practices)
- [Best practices for basic scheduler features](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-scheduler)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-5/aks-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-6 - Plan for multi-region deployment

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

An AKS cluster is deployed into a single region. To protect your system from region failure, deploy your application into multiple AKS clusters across different regions. When deploying multiple Kubernetes clusters in highly available and geographically distributed configurations, it's essential to consider the sum of each Kubernetes cluster as a coupled unit. You might want to develop code-driven strategies for automated deployment and configuration to ensure that each Kubernetes instance is as identical as possible.

**Resources**

- [Plan for multiregion deployment](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-multi-region#plan-for-multiregion-deployment)
- [Cluster deployment and bootstrapping](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-multi-region/aks-multi-cluster#cluster-deployment-and-bootstrapping)
- [AKS baseline for multiregion clusters](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-multi-region/aks-multi-cluster)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-6/aks-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-7 - Back up Azure Kubernetes Service

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

AKS is increasingly being used for stateful applications that require a backup strategy. Azure Backup now allows you to back up AKS clusters (cluster resources and persistent volumes attached to the cluster) using a backup extension, which must be installed in the cluster. Backup vault communicates with the cluster via this Backup Extension to perform backup and restore operations."

**Resources**

- [AKS Backups](https://learn.microsoft.com/en-us/azure/backup/azure-kubernetes-service-cluster-backup)
- [Best Practices for AKS Backups](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-storage)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-7/aks-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-8 - Control traffic flow with network policies

**Category: Access & Security**

**Impact: Low**

**Guidance**

Use network policies to allow or deny traffic to pods. By default, all traffic is allowed between pods within a cluster. For improved security, define rules that limit pod communication. Network policies allow or deny traffic to the pod based on settings such as assigned labels, namespace, or traffic port. Network policies are a cloud-native way to control the flow of traffic for pods. As pods are dynamically created in an AKS cluster, required network policies can be automatically applied. To use network policy, enable the feature when you create a new AKS cluster. You can't enable network policy on an existing AKS cluster. Plan ahead to enable network policy on the necessary clusters.

**Resources**

- [Control traffic with network policies](https://learn.microsoft.com/azure/aks/operator-best-practices-network#control-traffic-flow-with-network-policies)
- [Using network policies](https://learn.microsoft.com/azure/aks/use-network-policies)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-8/aks-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-9 - Plan an AKS version upgrade

**Category: Compliance**

**Impact: High**

**Guidance**

Minor version releases include new features and improvements. Patch releases are more frequent (sometimes weekly) and are intended for critical bug fixes within a minor version. Patch releases include fixes for security vulnerabilities or major bugs.
If you're running an unsupported Kubernetes version, you'll be asked to upgrade when requesting support for the cluster. Clusters running unsupported Kubernetes releases aren't covered by the AKS support policies.

**Resources**

- [Updating to the latest AKS version](https://learn.microsoft.com/azure/aks/operator-best-practices-cluster-security?tabs=azure-cli#regularly-update-to-the-latest-version-of-kubernetes)
- [Upgrade cluster](https://learn.microsoft.com/azure/aks/upgrade-cluster?tabs=azure-cli)
- [Auto-upgrading cluster](https://learn.microsoft.com/azure/aks/auto-upgrade-cluster)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-9/aks-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-10 - Remediate AKS non-compliant Azure Policies

**Category: Compliance**

**Impact: Low**

**Guidance**

It’s important to keep your AKS secure for the applications that you run. Azure Policy makes it possible to manage and report on the compliance state of your Kubernetes clusters from one place, enforces organizational standards, built-in security policies and assess compliance at-scale.

**Resources**

- [Policy for Kubernetes](https://learn.microsoft.com/azure/governance/policy/concepts/policy-for-kubernetes)
- [Governance with Azure Policy](https://learn.microsoft.com/azure/aks/use-azure-policy?toc=%2Fazure%2Fgovernance%2Fpolicy%2Ftoc.json&bc=%2Fazure%2Fgovernance%2Fpolicy%2Fbreadcrumb%2Ftoc.json)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-10/aks-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-11 - Deploy AKS across availability zones

**Category: High Availability**

**Impact: High**

**Guidance**

When you create your VMs, use availability zones to protect your applications and data against unlikely data center failure.

**Resources**

- [Availability Zones](https://learn.microsoft.com/azure/aks/availability-zones)
- [Best Practices for multi-region AKS](https://learn.microsoft.com/azure/aks/operator-best-practices-multi-region?source=recommendations)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-11/aks-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-12 - Ensure that Persistent Volumes in storage account are redundant for Pods with stateful applications


**Category: High Availability**

**Impact: Low**

**Guidance**

Data in an Azure Storage account is always replicated three times in the primary region. Azure Storage for Persistent Volumes offers other options for how your data is replicated in the primary or paired region:
- LRS synchronously replicates data 3 times in single physical location. It is least expensive replication but not recommended for apps with high availability and durability. LRS provides eleven 9 durability.
- ZRS copies data synchronously across 3 availability zone in primary region. ZRS is recommended for apps requiring high availability across zones. ZRS provides twelve 9s durability.

In AKS Premium_ZRS and StandardSSD_ZRS disk types are supported. ZRS disk could be scheduled on the zone or non-zone node, without the restriction that disk volume should be co-located in the same zone as a given node.

**Resources**

- [Azure Disk CSI Driver](https://learn.microsoft.com/azure/aks/azure-disk-csi#azure-disk-csi-driver-features)
- [Virtual Machine Disk Redundancy](https://learn.microsoft.com/azure/virtual-machines/disks-redundancy)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-12/aks-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-13 - Disable Local Account Access to AKS


**Category: Identity**

**Impact: High**

**Guidance**

Local accounts provide a legacy non auditable means of accessing an AKS cluster and are not recommended for use.

**Resources**

- [Manage Local Accounts with Azure AD](https://learn.microsoft.com/azure/aks/manage-local-accounts-managed-azure-ad)
- [Managed Azure AD with AKS](https://learn.microsoft.com/azure/aks/managed-azure-ad)


**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-13/aks-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-14 - Remediate Azure Advisor recommendations


**Category: Monitoring**

**Impact: High**

**Guidance**

Azure Advisor can recommend solutions that will help improve the performance, high availability, and security of your AKS cluster by analyzing your AKS configuration and usage telemetry

**Resources**

- [Getting Started with Azure Advisor](https://learn.microsoft.com/en-us/azure/advisor/advisor-get-started)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-13/aks-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-15 - Deploy a private AKS cluster if public access is not required


**Category: Security**

**Impact: Low**

**Guidance**

As you manage clusters in Azure Kubernetes Service (AKS), workload and data security is a key consideration. When you run multi-tenant clusters using logical isolation, you especially need to secure resource and workload access. Minimize the risk of attack by isolating the AKS cluster from public access.
One of the most important ways to secure your cluster is to secure access to the Kubernetes API server.  To secure and audit access to the API server, limit access and provide the lowest possible permission levels.


**Resources**

- [Operator Best Practices in Cluster Security](https://learn.microsoft.com/azure/aks/operator-best-practices-cluster-security?tabs=azure-cli)
- [Private Clusters](https://learn.microsoft.com/azure/aks/private-clusters?tabs=azure-portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-15/aks-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-16 - Keep a consistent configuration between regions with the API Server Authorized IP Addresses


**Category: Security**

**Impact: High**

**Guidance**

The Kubernetes API server is the core of the Kubernetes control plane and is the central way to interact with and manage your clusters. To improve the security of your clusters and minimize the risk of attacks, we recommend limiting the IP address ranges that can access the API server. To do this, you can use the API server authorized IP ranges feature.

It is important to keep a consistent configuration between clusters to avoid security and governance problems.

**Resources**

- [API Server Authorized IP Ranges](https://learn.microsoft.com/en-us/azure/aks/api-server-authorized-ip-ranges)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-16/aks-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-17 - Upgrade Persistent Volumes with deprecated version to Azure CSI drivers


**Category: Storage**

**Impact: High**

**Guidance**

Starting with Kubernetes version 1.26, in-tree persistent volume types kubernetes.io/azure-disk and kubernetes.io/azure-file are deprecated and will no longer be supported. Removing these drivers following their deprecation is not planned, however you should migrate to the corresponding CSI drivers disks.csi.azure.com and file.csi.azure.com.

**Resources**

- [CSI Storage Drivers](https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers)
- [CSI Migrate in Tree Volumes](https://learn.microsoft.com/azure/aks/csi-migrate-in-tree-volumes)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-17/aks-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-18 - Implement Resource Quota to ensure that Kubernetes resources do not exceed hard resource limits.


**Category: System Efficiency**

**Impact: Low**

**Guidance**

A resource quota, defined by a ResourceQuota object, provides constraints that limit aggregate resource consumption per namespace. It can limit the quantity of objects that can be created in a namespace by type, as well as the total amount of compute resources that may be consumed by resources in that namespace.

**Resources**

- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-18/aks-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-19 - Attach Virtual Nodes (ACI) to the AKS cluster


**Category: Scalability**

**Impact: Low**

**Guidance**

To rapidly scale application workloads in an AKS cluster, you can use virtual nodes. With virtual nodes, you have quick provisioning of pods. No need to wait for Kubernetes cluster auto-scaler to deploy VM compute nodes to run more pods, avoid a transaction lost during AKS default escalation method.

**Resources**

- [Virtual Nodes](https://learn.microsoft.com/azure/aks/virtual-nodes)
- [Azure Container Instances](https://learn.microsoft.com/azure/container-instances/container-instances-overview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-19/aks-19.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-20 - Isolate application (User) pods


**Category: Governance**

**Impact: Medium**

**Guidance**

Isolate critical system pods from your application pods to prevent misconfigured or rogue application pods from accidentally killing system pods.


**Resources**

- [System and User nodepools](https://learn.microsoft.com/azure/aks/virtual-nodes)
- [Using System nodepools](https://learn.microsoft.com/azure/aks/use-system-pools?tabs=azure-cli)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-20/aks-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-21 - Enable AKS Monitor alerts

**Category: Monitoring**

**Impact: High**

**Guidance**

Alerts help you detect and address issues before users notice them by proactively notifying you when Azure Monitor data indicates there might be a problem with your infrastructure or application. Set up monitoring and alerts for AKS health based on various metrics available.

**Resources**

- [AKS Monitor - AKS Alerts](https://learn.microsoft.com/azure/aks/monitor-aks#alerts)
- [How to create a new alert rule](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-create-new-alert-rule?tabs=metric)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-21/aks-21.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-22 - Update AKS tier to Standard

**Category: Resiliency**

**Impact: High**

**Guidance**

Production AKS clusters should be configured with the Standard tier. The AKS free service doesn't offer a financially backed SLA and nodes scalability is limited. To obtain that SLA, Standard tier must be selected.

**Resources**

- [Pricing Tiers](https://learn.microsoft.com/en-us/azure/aks/free-standard-pricing-tiers)
- [AKS Baseline Architecture](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks?toc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Faks%2Ftoc.json&bc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json#kubernetes-api-server-sla)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-22/aks-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-23 - Configure the API server Public IP access for public clusters

**Category: Security**

**Impact: High**

**Guidance**

The Kubernetes API server is the core of the Kubernetes control plane and is the central way to interact with and manage your clusters. To improve the security of your clusters and minimize the risk of attacks, we recommend limiting the IP address ranges that can access the API server.

**Resources**

- [API Server Authorized IP Ranges](https://learn.microsoft.com/azure/aks/api-server-authorized-ip-ranges)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-23/aks-23.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-24 - Enable AKS Monitoring

**Category: Monitoring**

**Impact: High**

**Guidance**

Azure Monitor collects events, captures container logs, collects CPU/Memory information from Metrics API and allows the visualization of the data, to validate the near real time health and performance of AKS environments. The visualization tool can be Azure Monitor Container Insights, Prometheus, Grafana or others.

**Resources**

- [Monitor AKS](https://learn.microsoft.com/azure/aks/monitor-aks)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-24/aks-24.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-25 - Use Ephemeral Disks on AKS clusters

**Category: Performance**

**Impact: Medium**

**Guidance**

Ephemeral OS disks provide lower read/write latency on the OS disk of AKS agent nodes since the disk is locally attached, and it is not replicated as managed disks. You will also get faster cluster operations like scale or upgrade thanks to faster re-imaging and boot times.

**Resources**

- [AKS Ephemeral OS Disk](https://learn.microsoft.com/samples/azure-samples/aks-ephemeral-os-disk/aks-ephemeral-os-disk/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-25/aks-25.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-26 - Enable Azure Policies configured for AKS

**Category: Governance**

**Impact: Low**

**Guidance**
Azure Policies allow companies to enforce governance best practices in the AKS cluster around security, authentication, provisioning, networking and others.


**Resources**

- [AKS Baseline - Policy Management](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks?toc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Faks%2Ftoc.json&bc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json#policy-management)
- [Built-in Policy Definitions for AKS](https://learn.microsoft.com/en-us/azure/aks/policy-reference)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-26/aks-26.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-27 - Enable GitOps when using DevOps frameworks

**Category: Automation**

**Impact: Low**

**Guidance**

GitOps is an operating model for cloud-native applications that stores application and declarative infrastructure code in Git to be used as the source of truth for automated continuous delivery. With GitOps, you describe the desired state of your entire system in a git repository, and a GitOps operator deploys it to your environment, which is often a Kubernetes cluster. This solution can be used in conjunction with Azure DevOps.


**Resources**

- [GitOps with AKS](https://learn.microsoft.com/en-us/azure/architecture/guide/aks/aks-cicd-github-actions-and-gitops)
- [GitOps for AKS - Reference Architecture](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/gitops-aks/gitops-blueprint-aks)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-27/aks-27.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-28 - Use the Azure KeyVault provider for Secrets Store CSI Driver

**Category: Security**

**Impact: High**

**Guidance**

The Azure Key Vault provider for Secrets Store CSI Driver allows for the integration of an Azure Key Vault as a secret store with an Azure Kubernetes Service (AKS) cluster via a CSI volume to allow secure access to secrets and HTTPS/TLS certificates.


**Resources**

- [CSI Secrets Store Driver](https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)
- [GitOps for AKS - Reference Architecture](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/gitops-aks/gitops-blueprint-aks)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-28/aks-28.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-29 - Configure affinity or anti-affinity rules based on application requirements

**Category: High Availability**

**Impact: High**

**Guidance**

Configure Topology Spread Constraints to control how Pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains. This can help to achieve high availability as well as efficient resource utilization.

**Resources**

- [Topology Spread Constraints](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/)
- [Assign Pod Node](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-29/aks-29.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-30 - Configures Pods Liveness, Readiness, and Startup Probes

**Category: High Availability**

**Impact: High**

**Guidance**

AKS kubelet controller uses liveness probes to validate containers and applications health. Based on containers health, kubelet will know when to restart a container.

**Resources**

- [Configure probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Assign Pod Node](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-30/aks-30.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
