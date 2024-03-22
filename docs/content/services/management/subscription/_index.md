+++
title = "Subscription"
description = "Best practices and resiliency recommendations for Subscription and associated resources and settings."
date = "3/20/24"
author = "davenewman777"
msAuthor = "davenew"
draft = false
+++

The presented resiliency recommendations in this guidance include Subscription and associated resources and settings. This is for items where the resource being assessed is not a specific object but a subscription or collection of subscriptions.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |                                Category                                 |     Impact      |      State       | ARG Query Available |
|:--------------------------------------------------|:-----------------------------------------------------------------------:|:---------------:|:----------------:|:-------------------:|
| [MS-1 - Do not create more than 2000 Citrix VDA servers per subscription](#ms-1---do-not-create-more-than-2000-citrix-vda-servers-per-subscription) | Application Resiliency | High | Preview |         Yes         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### MS-1 - Do not create more than 2000 Citrix VDA servers per subscription

**Category: Application Resilience**

**Impact: High**

**Guidance**

A Citrix Managed Azure subscription supports the number of machines indicated in Limits. (In this context, machines refers to VMs that have a Citrix VDA installed. These machines deliver apps and desktops to users. It does not include other machines in a resource location, such as Cloud Connectors.)

If your Citrix Managed Azure subscription is likely to reach its limit soon, and you have enough Citrix licenses, you can request another Citrix Managed Azure subscription. The dashboard contains a notification when you’re close to the limit.

You can’t create a catalog (or add machines to a catalog) if the total number of machines for all catalogs that use that Citrix Managed Azure subscription would exceed the value indicated in Limits.

This recommendation checks for 80% of the Citrix limit so that attention can be paid to this before hitting the published Citrix limit of 2500.

**Resources**

- [Citrix Limits](https://docs.citrix.com/en-us/citrix-daas-azure/limits)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ms-1/ms-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
