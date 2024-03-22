+++
title = "Private Endpoints"
description = "Best practices and resiliency recommendations for Private Endpoints and associated resources and settings."
date = "9/19/23"
author = "CHANGE ME TO YOUR GITHUB USERNAME"
msAuthor = "CHANGE ME TO YOUR MICROSOFT ALIAS"
draft = false
+++

The presented resiliency recommendations in this guidance include Private Endpoints and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                      |  Category       |  Impact     |  State    | ARG Query Available |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :-------------: | :------:    | :------:  | :-----------------: |
| [PEP-1 - Resolve issues with Private Endpoints in non Succeeded connection state](#pep-1---resolve-issues-with-private-endpoints-in-non-succeeded-connection-state) | Networking      | Medium      | Preview   |         Yes         |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### PEP-1 - Resolve issues with Private Endpoints in non Succeeded connection state

**Category: Networking**

**Impact: Medium**

**Guidance**

A private endpoint has two custom properties, static IP address and the network interface name. These properties must be set when the private endpoint is created. I the state is not in Succeeded state, there might be a problem with the private endpoint or with the associated resource.

**Resources**

- [Private endpoint connections](https://learn.microsoft.com/azure/private-link/manage-private-endpoint?tabs=manage-private-link-powershell#private-endpoint-connections)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/pep-1/pep-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
