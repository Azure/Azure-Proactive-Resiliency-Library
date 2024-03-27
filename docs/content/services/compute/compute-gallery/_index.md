+++
title = "Compute Gallery"
description = "Best practices and resiliency recommendations for Compute gallery and associated resources."
date = "10/12/23"
author = "poven"
msAuthor = "poven"
draft = false
+++

The presented resiliency recommendations in this guidance include Compute Gallery and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                      |   Category   | Impact |  State   | ARG Query Available |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------:|:------:|:--------:|:-------------------:|
| [CG-1 - A minimum of three replicas should be kept for production image versions](#cg-1---a-minimum-of-three-replicas-should-be-kept-for-production-image-versions) | Availability | Medium | Verified |         Yes         |
| [CG-2 - Zone redundant storage should be used for image versions](#cg-2---zone-redundant-storage-should-be-used-for-image-versions)                                 | Availability | Medium | Verified |         Yes         |
| [CG-3 - Consider creating TrustedLaunchSupported images where possible](#cg-3---consider-creating-trustedlaunchsupported-images-where-possible)        | Availability |  Low   | Verified |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### CG-1 - A minimum of three replicas should be kept for production image versions

**Category: Availability**

**Impact: Medium**

**Guidance**

Keep a minimum of 3 replicas for production images.  In multi-VM deployment scenarios the VM deployments can be spread to different replicas reducing the chance of instance creation processing being throttled due to overloading of a single replica. For every 20 VMs that you create concurrently, we recommend you keep one replica. For example, if you create 1000 VMs concurrently, you should keep 50 replicas (you can have a maximum of 50 replicas per region). To update the replica count, please go to the gallery -> Image Definition -> Image Version -> Update replication.

**Resources**

- [Compute Gallery best practices](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery#best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cg-1/cg-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CG-2 - Zone redundant storage should be used for image versions

**Category: Availability**

**Impact: Medium**

**Guidance**

Use ZRS wherever available for high availability. You can configure ZRS in the replication tab when you create a version of the image or VM application. Azure Zone Redundant Storage (ZRS) provides resilience against an Availability Zone failure in the region. With the general availability of Azure Compute Gallery, you can choose to store your images in ZRS accounts in [regions with Availability Zones](https://learn.microsoft.com/en-us/azure/availability-zones/az-overview#azure-regions-with-availability-zones).
You can also choose the account type for each of the target regions. The default storage account type is Standard_LRS, but it is recommended to select Standard_ZRS for regions with Availability Zones.

**Resources**

- [Compute Gallery best practices](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery#best-practices)
- [Zone-redundant storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy#zone-redundant-storage)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cg-2/cg-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CG-3 - Consider creating TrustedLaunchSupported images where possible

**Category: Access & Security**

**Impact: Low**

**Guidance**

We recommend that you create a Trusted Launch Supported Images to take advantage of features like Secure Boot, vTPM, trusted launch VMs, large boot volume. Trusted Launch Supported Images are Gen 2 Images by default. You can’t change a virtual machine’s generation after you’ve created it. So it is recommended to review the [considerations](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v#which-guest-operating-systems-are-supported) first.

**Resources**

- [Compute Gallery best practices](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery#best-practices)
- [Generation 1 vs Generation 2 in Hyper-V](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v)
- [Images in Compute gallery](https://learn.microsoft.com/en-us/azure/virtual-machines/shared-image-galleries?tabs=azure-cli)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cg-3/cg-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
