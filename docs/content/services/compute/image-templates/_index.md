+++
title = "Image Templates"
description = "Best practices and resiliency recommendations for Image Templates and associated resources."
date = "8/28/23"
author = "oZakari"
msAuthor = "ztrocinski"
draft = false
+++

The presented resiliency recommendations in this guidance include Image Templates and dependent resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                              |     Category      | Impact |  State   | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------|:-----------------:|:------:|:--------:|:-------------------:|
| [IT-1 - Use Generation 2 virtual machine source image](#it-1---use-generation-2-virtual-machine-source-image)               |   Availability    |  Low   | Verified |         No          |
| [IT-2 - Replicate your Image Templates to a secondary region](#it-2---replicate-your-image-templates-to-a-secondary-region) | Disaster Recovery |  Low   | Verified |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### IT-1 - Use Generation 2 virtual machine source image

**Category: Availability**

**Impact: Low**

**Guidance**

When building your Image Templates, utilize source images that support generation 2 virtual machines. Generation 2 VMs support key features that aren't supported in generation 1 VMs.These features include increased memory, support for larger >2TB disks, it uses the new UEFI-based boot architecture rather than the BIOS-based architecture used by generation 1 VMs which can improve boot and installation times, Intel Software Guard Extensions (Intel SGX), and virtualized persistent memory (vPMEM).

**Resources**

- [Generation 1 vs generation 2 virtual machines](https://learn.microsoft.com/en-us/azure/virtual-machines/generation-2#features-and-capabilities)

<br><br>

### IT-2 - Replicate your Image Templates to a secondary region

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

The Azure Image Builder service that is used to deploy Image Templates doesn't currently support availability zones. Therefore, when building your Image Templates, replicate them to a secondary region, preferably to your primary region's paired region. This will allow you to quickly recover from a region failure and continue to deploy virtual machines from your Image Templates.

**Resources**

- [Image Template resiliency](https://learn.microsoft.com/en-us/azure/reliability/reliability-image-builder?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json&bc=%2Fazure%2Fvirtual-machines%2Fbreadcrumb%2Ftoc.json#capacity-and-proactive-disaster-recovery-resiliency)
- [Azure Image Builder Supported Regions](https://learn.microsoft.com/en-us/azure/virtual-machines/image-builder-overview?tabs=azure-powershell#regions)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/it-2/it-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
