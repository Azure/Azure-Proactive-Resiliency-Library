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
| Recommendation                                                                                                                                                                                                              |     Category      | Impact  |  State  | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:-------:|:-------:|:-------------------:|
| [AKS-1 - Deploy AKS cluster across availability zones](#aks-1---deploy-aks-cluster-across-availability-zones)                                                                                                               |   Availability    |  High   | Preview |         Yes         |
| [AKS-2 - Isolate system and application pods](#aks-2---isolate-system-and-application-pods)                                                                                                                                 |    Governance     |  High   | Preview |         Yes         |
| [AKS-3 - Disable local accounts](#aks-3---disable-local-accounts)                                                                                                                         | Access & Security |  High   | Preview |         Yes         |
| [AKS-4 - Configure Azure CNI networking for dynamic allocation of IPs](#aks-4---configure-azure-cni-networking-for-dynamic-allocation-of-ips)                                                                               |    Networking    | Medium  | Preview |         Yes         |
| [AKS-5 - Enable the cluster auto-scaler on an existing cluster](#aks-5---enable-the-cluster-auto-scaler-on-an-existing-cluster)                                                                                             | System Efficiency |  High   | Preview |         Yes         |
| [AKS-6 - Back up Azure Kubernetes Service](#aks-6---back-up-azure-kubernetes-service)                                                                                                                                       | Disaster Recovery |   Low   | Preview |         No          |
| [AKS-7 - Plan an AKS version upgrade](#aks-7---plan-an-aks-version-upgrade)                                                                                                                                                 |    Compliance     |  High   | Preview |         No          |
| [AKS-8 - Ensure that Persistent Volumes in storage account are redundant for Pods with stateful applications](#aks-8---ensure-that-persistent-volumes-in-storage-account-are-redundant-for-pods-with-stateful-applications) |   Availability    |   Low   | Preview |         No          |
| [AKS-9 - Upgrade Persistent Volumes with deprecated version to Azure CSI drivers](#aks-9---upgrade-persistent-volumes-with-deprecated-version-to-azure-csi-drivers)                                                         |   Storage  | High   | Preview |   No    |
| [AKS-10 - Implement Resource Quota to ensure that Kubernetes resources do not exceed hard resource limits.](#aks-10---implement-resource-quota-to-ensure-that-kubernetes-resources-do-not-exceed-hard-resource-limits)      | System Efficiency |   Low   | Preview |         No          |
| [AKS-11 - Attach Virtual Nodes (ACI) to the AKS cluster](#aks-11---attach-virtual-nodes-aci-to-the-aks-cluster)                                                                                                             | System Efficiency |   Low   | Preview |         No          |
| [AKS-12 - Update AKS tier to Standard](#aks-12---update-aks-tier-to-standard)                                                                                                                                               |   Availability   |  High   | Preview |         Yes         |
| [AKS-13 - Enable AKS Monitoring](#aks-13---enable-aks-monitoring)                                                                                                                                                           |    Monitoring     |  High   | Preview |         Yes         |
| [AKS-14 - Use Ephemeral Disks on AKS clusters](#aks-14---use-ephemeral-disks-on-aks-clusters)                                                                                                                               | System Efficiency | Medium  | Preview |         No          |
| [AKS-15 - Enable and remediate Azure Policies configured for AKS](#aks-15---enable-and-remediate-azure-policies-configured-for-aks)                                                                                         |    Governance     |   Low   | Preview |         No          |
| [AKS-16 - Enable GitOps when using DevOps frameworks](#aks-16---enable-gitops-when-using-devops-frameworks)                                                                                                                 |    Automation     |   Low   | Preview |         Yes         |
| [AKS-17 - Configure affinity or anti-affinity rules based on application requirements](#aks-17---configure-affinity-or-anti-affinity-rules-based-on-application-requirements)                                               |   Availability    |  High   | Preview |         No          |
| [AKS-18 - Configures Pods Liveness, Readiness, and Startup Probes](#aks-18---configures-pods-liveness-readiness-and-startup-probes)                                                                                         |   Availability    |  High   | Preview |         No          |
| [AKS-19 - Configure Pod replica sets in production applications to guarantee availability](#aks-19---configure-pod-replica-sets-in-production-applications-to-guarantee-availability)                                         |   Availability    |  High   | Preview |         No          |
| [AKS-20 - Configure system nodepool count](#aks-20---configure-system-nodepool-count)                                         |   Availability    |  High   | Preview |         Yes          |
| [AKS-21 - Configure user nodepool count](#aks-21---configure-user-nodepool-count)                                         |   Availability    |  High   | Preview |         Yes          |
| [AKS-22 - Configure pod disruption budgets (PDBs)](#aks-22---configure-pod-disruption-budgets-pdbs)                                         |   Availability    |  Medium   | Preview |         No          |
| [AKS-23 - Nodepool subnet size needs to accommodate maximum auto-scale settings](#aks-23---nodepool-subnet-size-needs-to-accommodate-maximum-auto-scale-settings)                                         |   Availability    |  High   | Preview |         Yes          |
| [AKS-24 - Enforce resource quotas at the namespace level](#aks-24---enforce-resource-quotas-at-the-namespace-level)                                         |   Availability    |  High   | Preview |         No          |

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

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-1/aks-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-2 - Isolate system and application pods

**Category: Governance**

**Impact: High**

**Guidance**

AKS automatically assigns the label kubernetes.azure.com/mode: system to nodes in a system node pool. This label signals to AKS that system pods should be scheduled on nodes in this pool. However, you can still schedule application pods on these nodes if you choose to do so.

To prevent misconfigured or rogue application pods from accidentally killing system pods, it is recommended that you isolate critical system pods from your application pods. This can be achieved by scheduling system pods on dedicated node pools or by using node selectors to ensure that system pods are only scheduled on nodes with the kubernetes.azure.com/mode: system label.

**Resources**

- [System and user node pools](https://learn.microsoft.com/en-us/azure/aks/use-system-pools?tabs=azure-cli#system-and-user-node-pools)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-2/aks-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-3 - Disable local accounts

**Category: Access & Security**

**Impact: High**

**Guidance**

Local Kubernetes accounts provide a legacy non-auditable means of accessing an AKS cluster and are not recommended for use. Enabling Microsoft Entra integration on an AKS cluster provides several benefits for managing access to the cluster. By using Microsoft Entra, you can centralize user and group management, enforce multi-factor authentication, and enable role-based access control (RBAC) for fine-grained access control to cluster resources. Additionally, Microsoft Entra provides a secure and scalable authentication mechanism that can be integrated with other Azure services and third-party identity providers.

**Resources**

- [Entra integration](https://learn.microsoft.com/en-us/azure/aks/concepts-identity#azure-ad-integration)
- [Use Azure role-based access control for AKS](https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac?source=recommendations)
- [Manage AKS local accounts](https://learn.microsoft.com/en-us/azure/aks/manage-local-accounts-managed-azure-ad?source=recommendations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-3/aks-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-4 - Configure Azure CNI networking for dynamic allocation of IPs

**Category: Networking**

**Impact: Medium**

**Guidance**

The Azure CNI networking solution provides several benefits for managing IP addresses and network connectivity for cluster pods including dynamic allocation of IPs to pods, allowing node and pod subnets to scale independently, direct network connectivity between pods and resources in the VNET and allowing different network policies for pods and nodes. It also supports different networking policies including Azure Network Policies and Calico.

**Resources**

- [Configure Azure CNI networking](https://learn.microsoft.com/en-us/azure/aks/configure-azure-cni-dynamic-ip-allocation)
- [Configure Azure CNI Overlay networking](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-4/aks-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-5 - Enable the cluster auto-scaler on an existing cluster

**Category: System Efficiency**

**Impact: High**

**Guidance**

The cluster auto-scaler automatically scales the number of nodes in a node pool based on pod resource requests and the available capacity in the cluster. It helps ensure that the cluster can scale according to demand and prevent outages.

If the cluster has availability zones enabled, the following configuration changes need to be verified or established:

- Persistent Volumes - If the cluster is using persistent volumes backed by Azure Storage, ensure you have one nodepool per availability zone. Persistent volumes do not work across AZs and the auto-scaler could fail to create new pods if the nodepool cannot access the persistent volume.
- Multiple Nodepools per Zone - If the cluster has multiple nodepools per AZ, enable the `--balance-similar-node-groups` property through the auto-scaler profile. This feature detects similar nodepools and balances the number of nodes across them.


**Resources**

- [Use the Cluster Autoscaler on AKS](https://learn.microsoft.com/azure/aks/cluster-autoscaler?tabs=azure-cli)
- [Best practices for advanced scheduler features](https://learn.microsoft.com/azure/aks/operator-best-practices-advanced-scheduler)
- [Node pool scaling considerations and best practices](https://learn.microsoft.com/azure/aks/best-practices-performance-scale-large#node-pool-scaling)
- [Best practices for basic scheduler features](https://learn.microsoft.com/azure/aks/operator-best-practices-scheduler)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-5/aks-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-6 - Back up Azure Kubernetes Service

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

AKS is increasingly being used for stateful applications that require a backup strategy. Azure Backup now allows you to back up AKS clusters (cluster resources and persistent volumes attached to the cluster) using a backup extension, which must be installed in the cluster. Backup vault communicates with the cluster via this Backup Extension to perform backup and restore operations."

**Resources**

- [AKS Backups](https://learn.microsoft.com/en-us/azure/backup/azure-kubernetes-service-cluster-backup)
- [Best Practices for AKS Backups](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-storage)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-6/aks-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-7 - Plan an AKS version upgrade

**Category: Compliance**

**Impact: High**

**Guidance**

Minor version releases include new features and improvements. Patch releases are more frequent (sometimes weekly) and are intended for critical bug fixes within a minor version. Patch releases include fixes for security vulnerabilities or major bugs.
If you're running an unsupported Kubernetes version, you'll be asked to upgrade when requesting support for the cluster. Clusters running unsupported Kubernetes releases aren't covered by the AKS support policies.

**Resources**

- [Updating to the latest AKS version](https://learn.microsoft.com/azure/aks/operator-best-practices-cluster-security?tabs=azure-cli#regularly-update-to-the-latest-version-of-kubernetes)
- [Upgrade cluster](https://learn.microsoft.com/azure/aks/upgrade-cluster?tabs=azure-cli)
- [Auto-upgrading cluster](https://learn.microsoft.com/azure/aks/auto-upgrade-cluster)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-7/aks-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-8 - Ensure that Persistent Volumes in storage account are redundant for Pods with stateful applications

**Category: Availability**

**Impact: Low**

**Guidance**

Data in an Azure Storage account is always replicated three times in the primary region. Azure Storage for Persistent Volumes offers other options for how your data is replicated in the primary or paired region:

- LRS synchronously replicates data 3 times in single physical location. It is least expensive replication but not recommended for apps with high availability and durability. LRS provides eleven 9 durability.
- ZRS copies data synchronously across 3 availability zone in primary region. ZRS is recommended for apps requiring high availability across zones. ZRS provides twelve 9s durability.

In AKS Premium_ZRS and StandardSSD_ZRS disk types are supported. ZRS disk could be scheduled on the zone or non-zone node, without the restriction that disk volume should be co-located in the same zone as a given node.

**Resources**

- [Azure Disk CSI Driver](https://learn.microsoft.com/azure/aks/azure-disk-csi#azure-disk-csi-driver-features)
- [Virtual Machine Disk Redundancy](https://learn.microsoft.com/azure/virtual-machines/disks-redundancy)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-8/aks-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-9 - Upgrade Persistent Volumes with deprecated version to Azure CSI drivers

**Category: Storage**

**Impact: High**

**Guidance**

Starting with Kubernetes version 1.26, in-tree persistent volume types kubernetes.io/azure-disk and kubernetes.io/azure-file are deprecated and will no longer be supported. Removing these drivers following their deprecation is not planned, however you should migrate to the corresponding CSI drivers disks.csi.azure.com and file.csi.azure.com.

**Resources**

- [CSI Storage Drivers](https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers)
- [CSI Migrate in Tree Volumes](https://learn.microsoft.com/azure/aks/csi-migrate-in-tree-volumes)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-9/aks-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-10 - Implement Resource Quota to ensure that Kubernetes resources do not exceed hard resource limits

**Category: System Efficiency**

**Impact: Low**

**Guidance**

A resource quota, defined by a ResourceQuota object, provides constraints that limit aggregate resource consumption per namespace. It can limit the quantity of objects that can be created in a namespace by type, as well as the total amount of compute resources that may be consumed by resources in that namespace.

**Resources**

- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-10/aks-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-11 - Attach Virtual Nodes (ACI) to the AKS cluster

**Category: System Efficiency**

**Impact: Low**

**Guidance**

To rapidly scale application workloads in an AKS cluster, you can use virtual nodes. With virtual nodes, pods provision much faster than through the Kubernetes cluster auto-scaler.

If the cluster has availability zones enabled, the following configuration changes need to be verified or established:

- Persistent Volumes - If the cluster is using persistent volumes backed by Azure Storage, ensure you have one nodepool per availability zone. Persistent volumes do not work across AZs and the auto-scaler could fail to create new pods if the nodepool cannot access the persistent volume.

**Resources**

- [Virtual Nodes](https://learn.microsoft.com/azure/aks/virtual-nodes)
- [Azure Container Instances](https://learn.microsoft.com/azure/container-instances/container-instances-overview)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-11/aks-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-12 - Update AKS tier to Standard

**Category: Availability**

**Impact: High**

**Guidance**

Production AKS clusters should be configured with the Standard tier. The AKS free service doesn't offer a financially backed SLA and node scalability is limited. To obtain that SLA, Standard tier must be selected.

**Resources**

- [Pricing Tiers](https://learn.microsoft.com/en-us/azure/aks/free-standard-pricing-tiers)
- [AKS Baseline Architecture](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks?toc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Faks%2Ftoc.json&bc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json#kubernetes-api-server-sla)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-12/aks-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-13 - Enable AKS Monitoring

**Category: Monitoring**

**Impact: High**

**Guidance**

Azure Monitor collects events, captures container logs, collects CPU/Memory information from the Metrics API and allows the visualization of the data, to validate the near real time health and performance of AKS environments. The visualization tool can be Azure Monitor Container Insights, Prometheus, Grafana or others.

**Resources**

- [Monitor AKS](https://learn.microsoft.com/azure/aks/monitor-aks)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-13/aks-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-14 - Use Ephemeral Disks on AKS clusters

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Ephemeral OS disks provide lower read/write latency on the OS disk of AKS agent nodes since the disk is locally attached, and it is not replicated as managed disks. You will also get faster cluster operations like scale or upgrade thanks to faster re-imaging and boot times.

**Resources**

- [AKS Ephemeral OS Disk](https://learn.microsoft.com/samples/azure-samples/aks-ephemeral-os-disk/aks-ephemeral-os-disk/)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-14/aks-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-15 - Enable and remediate Azure Policies configured for AKS

**Category: Governance**

**Impact: Low**

**Guidance**
Azure Policies allow companies to enforce governance best practices in the AKS cluster around security, authentication, provisioning, networking and others.

**Resources**

- [AKS Baseline - Policy Management](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks?toc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Faks%2Ftoc.json&bc=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json#policy-management)
- [Built-in Policy Definitions for AKS](https://learn.microsoft.com/en-us/azure/aks/policy-reference)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-15/aks-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-16 - Enable GitOps when using DevOps frameworks

**Category: Automation**

**Impact: Low**

**Guidance**

GitOps is an operating model for cloud-native applications that stores application and declarative infrastructure code in Git to be used as the source of truth for automated continuous delivery. With GitOps, you describe the desired state of your entire system in a git repository, and a GitOps operator deploys it to your environment, which is often a Kubernetes cluster. To prevent potential outages or unsuccessful failover scenarios, GitOps helps maintain the configuration of all AKS clusters to the intended configuration.

**Resources**

- [GitOps with AKS](https://learn.microsoft.com/en-us/azure/architecture/guide/aks/aks-cicd-github-actions-and-gitops)
- [GitOps for AKS - Reference Architecture](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/gitops-aks/gitops-blueprint-aks)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-16/aks-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-17 - Configure affinity or anti-affinity rules based on application requirements

**Category: Availability**

**Impact: High**

**Guidance**

Configure Topology Spread Constraints to control how Pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains. This can help to achieve high availability as well as efficient resource utilization.

**Resources**

- [Topology Spread Constraints](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/)
- [Assign Pod Node](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-17/aks-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-18 - Configures Pods Liveness, Readiness, and Startup Probes

**Category: Availability**

**Impact: High**

**Guidance**

AKS kubelet controller uses liveness probes to validate containers and applications health. Based on containers health, kubelet will know when to restart a container.

**Resources**

- [Configure probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Assign Pod Node](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-18/aks-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-19 - Configure pod replica sets in production applications to guarantee availability

**Category: Availability**

**Impact: High**

**Guidance**

Configure ReplicaSets in the Pod or Deployment manifests to maintain a stable set of replica Pods running at any given time. This feature will guarantee the availability of a specified number of identical Pods.

**Resources**

- [Replica Sets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-19/aks-19.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-20 - Configure system nodepool count

**Category: Availability**

**Impact: High**

**Guidance**

The system node pool should be configured with a minimum node count of two to ensure critical system pods are resilient to node outages.

**Resources**

- [System nodepools](https://learn.microsoft.com/azure/aks/use-system-pools?tabs=azure-cli)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-20/aks-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-21 - Configure user nodepool count

**Category: Availability**

**Impact: High**

**Guidance**

The user node pool should be configured with a minimum node count of two if the application requires high availability.

**Resources**

- [Azure Well-Architected Framework review for Azure Kubernetes Service (AKS)](https://learn.microsoft.com/azure/well-architected/service-guides/azure-kubernetes-service#design-checklist)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-21/aks-21.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-22 - Configure pod disruption budgets (PDBs)

**Category: Availability**

**Impact: Medium**

**Guidance**

A Pod Disruption Budget (PDB) is a Kubernetes resource that allows you to configure the minimum number or percentage of pods that should remain available during voluntary disruptions, such as maintenance or scaling events. To maintain the availability of applications, define Pod Disruption Budgets (PDBs) to make sure that a minimum number of pods are available in the cluster.

**Resources**

- [Configure PDBs](https://kubernetes.io/docs/tasks/run-application/configure-pdb/)
- [Plan availability using PDBs](https://learn.microsoft.com/azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-22/aks-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-23 - Nodepool subnet size needs to accommodate maximum auto-scale settings

**Category: Availability**

**Impact: High**

**Guidance**

Nodepool subnets should be sized to accommodate maximum auto-scale settings. By properly sizing the subnet, AKS can efficiently scale out nodes to meet increased demand, reducing the risk of resource constraints and potential service disruptions.

**Resources**

- [AKS Networking](https://learn.microsoft.com/azure/aks/concepts-network)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-23/aks-23.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-24 - Enforce resource quotas at the namespace level

**Category: Availability**

**Impact: High**

**Guidance**

Enforcing namespace-level resource quotas is crucial for ensuring reliability by preventing resource exhaustion and maintaining cluster stability. This helps prevent individual applications or users from monopolizing resources, which can lead to degraded performance or outages for other applications in the cluster.

**Resources**

- [Resource quotas](https://learn.microsoft.com/azure/aks/operator-best-practices-scheduler#enforce-resource-quotas)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aks-24/aks-24.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
