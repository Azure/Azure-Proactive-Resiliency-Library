+++
title = "Aks"
description = "Best practices and resiliency recommendations for Aks and associated resources."
date = "7/16/23"
author = "dcint"
msAuthor = "dacintro"
draft = false
+++

The presented resiliency recommendations in this guidance include Aks and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                      |     Impact      |  State   | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------ | :-------------: | :------: | :-----------------: |
| [AKS-1 - Create an AKS cluster across availability zones](#aks-1---create-an-aks-cluster-across-availability-zones) | High/Medium/Low | Preview  |         Yes         |
| [AKS-2 - Isolate system pods](#aks-2---isolate-system-pods)                                                         | High/Medium/Low | Verified |         No          |
| [AKS-3 - Enable AKS-managed Azure AD integration](#aks-3---enable-aks-managed-azure-ad-integration)                 | High/Medium/Low | Verified |         No          |
| [CM-2 - CHANGE ME title](#cm-2---change-me-title)                                                                   | High/Medium/Low | Verified |         No          |
| [CM-2 - CHANGE ME title](#cm-2---change-me-title)                                                                   | High/Medium/Low | Verified |         No          |
| [CM-2 - CHANGE ME title](#cm-2---change-me-title)                                                                   | High/Medium/Low | Verified |         No          |
| [CM-2 - CHANGE ME title](#cm-2---change-me-title)                                                                   | High/Medium/Low | Verified |         No          |
| [CM-2 - CHANGE ME title](#cm-2---change-me-title)                                                                   | High/Medium/Low | Verified |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AKS-1 - Create an AKS cluster across availability zones

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

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AKS-2 - Isolate system pods

#### Impact: Medium

#### Recommendation/Guidance

AKS automatically assigns the label kubernetes.azure.com/mode: system to nodes in a system node pool. This label signals to AKS that system pods should be scheduled on nodes in this pool. However, you can still schedule application pods on these nodes if you choose to do so.

To prevent misconfigured or rogue application pods from accidentally killing system pods, it is recommended that you isolate critical system pods from your application pods. This can be achieved by scheduling system pods on dedicated node pools or by using node selectors to ensure that system pods are only scheduled on nodes with the kubernetes.azure.com/mode: system label.

##### Resources

- [System and user node pools](https://learn.microsoft.com/en-us/azure/aks/use-system-pools?tabs=azure-cli#system-and-user-node-pools)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

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

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>


### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

