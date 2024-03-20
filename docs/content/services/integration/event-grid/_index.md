+++
title = "Event Grid"
description = "Best practices and resiliency recommendations for Event Grid and associated resources and settings."
date = "8/30/23"
author = "beheath"
msAuthor = "benheath"
draft = false
+++

The presented resiliency recommendations in this guidance include Event Grid and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State   | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------: | :-----------------: |
| [EVG-1 - Configure Diagnostic Settings for all Azure Event Grid resources](#evg-1---configure-diagnostic-settings-for-all-azure-event-grid-resources) | Monitoring | Low | Preview  |         No        |
| [EVG-2 - Configure Dead-letter to save events that cannot be delivered](#evg-2---configure-dead-letter-to-save-events-that-cannot-be-delivered) | Automation          | Low | Preview |         No          |
| [EVG-3 - Configure Private Endpoints](#evg-3---configure-private-endpoints) | Access & Security          | Low | Preview |         Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### EVG-1 - Configure Diagnostic Settings for all Azure Event Grid resources

**Category: Monitoring**

**Impact: Low**

**Guidance**

Enabling diagnostic settings allow you to capture and view diagnostic information so that you can troubleshoot any failures. The following table shows the settings available for different types of Event Grid resources - custom topics, system topics, and domains.

**Resources**

- [Azure Event Grid - Enable diagnostic logs for Event Grid resources](https://learn.microsoft.com/en-us/azure/event-grid/enable-diagnostic-logs-topic)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/evg-1/evg-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### EVG-2 - Configure Dead-letter to save events that cannot be delivered

**Category: Automation**

**Impact: Low**

**Guidance**

When Event Grid can't deliver an event within a certain time period or after trying to deliver the event a certain number of times, it can send the undelivered event to a storage account. This process is known as dead-lettering. By default, Event Grid doesn't turn on dead-lettering. To enable it, you must specify a storage account to hold undelivered events when creating the event subscription. You pull events from this storage account to resolve deliveries.

**Resources**

- [Azure Event Grid delivery and retry](https://learn.microsoft.com/en-us/azure/event-grid/delivery-and-retry#dead-letter-events)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/evg-2/evg-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### EVG-3 - Configure Private Endpoints

**Category: Access & Security**

**Impact: Low**

**Guidance**

You can use private endpoints to allow ingress of events directly from your virtual network to your custom topics and domains securely over a private link without going through the public internet. The private endpoint uses an IP address from the VNet address space for your custom topic or domain.

**Resources**

- [Configure private endpoints for Azure Event Grid topics or domains](https://learn.microsoft.com/en-us/azure/event-grid/configure-private-endpoints)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/evg-3/evg-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
