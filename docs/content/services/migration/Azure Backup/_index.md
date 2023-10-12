+++
title = "Azure Backup"
description = "Best practices and resiliency recommendations for Azure Backup and associated resources."
date = "10/11/23"
author = "poven"
msAuthor = "poven"
draft = false
+++

The presented resiliency recommendations in this guidance include Backup and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Impact  |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :------: | :-----------------: |
| [BK-1 - Migrate from classic alerts to built-in Azure Monitor alerts for Recovery services vaults](#bk-1---migrate-from-classic-alerts-to-built-in-azure-monitor-alerts-for-recovery-services-vaults) | Medium | Preview  |         Yes         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### BK-1 - Migrate from classic alerts to built-in Azure Monitor alerts for Recovery services vaults

**Category: Availability**

**Impact: Medium**

**Guidance**

On 31 March 2026, classic alerts for Recovery Services vaults in Azure Backup will be retired and no longer supported. Before that date, transition to built-in Azure monitor alerting solution.
Using Azure Monitor Alerts you can:

- Configure notifications to a wide range of notification channels.
- Enable notifications for selective scenarios.
- Monitor alerts at-scale via Backup center.
- Manage alerts and notifications programmatically.
- Consistent alert management for multiple Azure services, including backup.

**Resources**

- [Move to Azure monitor Alerts](https://learn.microsoft.com/en-us/azure/backup/move-to-azure-monitor-alerts)
- [Classic alerts retirement announcement](https://azure.microsoft.com/en-us/updates/transition-to-builtin-azure-monitor-alerts-for-recovery-services-vaults-in-azure-backup-by-31-march-2026/)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/bk-1/bk-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
