+++
title = "Network Security Group"
description = "Best practices and resiliency recommendations for Network Security Group and associated resources and settings."
date = "9/19/23"
author = "rodrigosantosms"
msAuthor = "rodrigosantosms"
draft = false
+++

The presented resiliency recommendations in this guidance include Network Security Group and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                |  Category         |  Impact   |  State     | ARG Query Available |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------:  | :------:  | :------:   | :-----------------: |
| [NSG-1 - Configure Diagnostic Settings for all network security groups](#nsg-1---configure-diagnostic-settings-for-all-network-security-groups)                                               | Monitoring        |  Medium   | Preview    |     No          |
| [NSG-2 - Monitor changes in Network Security Groups with Azure Monitor](#nsg-2---monitor-changes-in-network-security-groups-with-azure-monitor)                               | Monitoring        |     Low   | Preview    |     Yes          |
| [NSG-3 - Configure locks for Network Security Groups to avoid accidental changes and/or deletion](#nsg-3---configure-locks-for-network-security-groups-to-avoid-accidental-changes-andor-deletion)      | Governance        |     Low   | Preview    |     No          |
| [NSG-4 - Configure NSG Flow Logs](#nsg-4---configure-nsg-flow-logs)                                                                     | Monitoring        |  Medium   | Preview    |     Yes         |
| [NSG-5 - The NSG only has Default Security Rules, make sure to configure the necessary rules](#nsg-5---the-nsg-only-has-default-security-rules-make-sure-to-configure-the-necessary-rules)          | Access & Security |  Medium   | Preview    |     Yes          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### NSG-1 - Configure Diagnostic Settings for all network security groups

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Resource Logs are not collected and stored until you create a diagnostic setting and route them to one or more locations.

**Resources**

- [Diagnostic settings in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/diagnostic-settings)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-1/nsg-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-2 - Monitor changes in Network Security Groups with Azure Monitor

**Category: Monitoring**

**Impact: Low**

**Guidance**

Create Alerts for administrative operations such as Create or Update Network Security Group rules with Azure Monitor to detect unauthorized/undesired changes to production resources, this alert can help identify undesired changes in the default security, such as attempts to by-pass firewalls or from accessing resources externally.

**Resources**

- [Azure Monitor activity log](https://learn.microsoft.com/azure/azure-monitor/essentials/activity-log?tabs=powershell)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-2/nsg-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-3 - Configure locks for Network Security Groups to avoid accidental changes and/or deletion

**Category: Governance**

**Impact: Low**

**Guidance**

As an administrator, you can lock an Azure subscription, resource group, or resource to protect them from accidental user deletions and modifications. The lock overrides any user permissions.
You can set locks that prevent either deletions or modifications. In the portal, these locks are called Delete and Read-only.

**Resources**

- [Lock your resources to protect your infrastructure](https://learn.microsoft.com/azure/azure-resource-manager/management/lock-resources?toc=%2Fazure%2Fvirtual-network%2Ftoc.json&tabs=json)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-3/nsg-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-4 - Configure NSG Flow Logs

**Category: Monitoring**

**Impact: Medium**

**Guidance**

It's vital to monitor, manage, and know your own network so that you can protect and optimize it. You need to know the current state of the network, who's connecting, and where users are connecting from. You also need to know which ports are open to the internet, what network behavior is expected, what network behavior is irregular, and when sudden rises in traffic happen.

Flow logs are the source of truth for all network activity in your cloud environment. Whether you're in a startup that's trying to optimize resources or a large enterprise that's trying to detect intrusion, flow logs can help. You can use them for optimizing network flows, monitoring throughput, verifying compliance, detecting intrusions, and more.

**Resources**

- [Flow logging for network security groups](https://learn.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-overview)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-4/nsg-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### NSG-5 - The NSG only has Default Security Rules, make sure to configure the necessary rules

**Category: Access & Security**

**Impact: Medium**

**Guidance**

You can use an Azure network security group to filter network traffic between Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.

**Resources**

- [Security rules](https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview#security-rules)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/nsg-5/nsg-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
