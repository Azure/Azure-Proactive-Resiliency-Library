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
|
Recommendation | Category | Impact | State | ARG Query Available |
:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|--------|:--------:|:-------------------:|
| [BK-1 - Migrate from classic alerts to built-in Azure Monitor alerts for Azure Recovery Services Vaults](#bk-1---migrate-from-classic-alerts-to-built-in-azure-monitor-alerts-for-azure-recovery-services-vaults) | Monitoring | Medium | Verified | Yes |
| [BK-2 - Opt-in to Cross Region Restore for all Geo-Redundant Storage (GRS) Azure Recovery Services vaults](#bk-2---opt-in-to-cross-region-restore-for-all-geo-redundant-storage-grs-azure-recovery-services-vaults) | Disaster Recovery | Medium | Verified | Yes |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### BK-1 - Migrate from classic alerts to built-in Azure Monitor alerts for Azure Recovery Services Vaults

**Category: Monitoring**

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

- [Move to Azure monitor Alerts](https://learn.microsoft.com/azure/backup/move-to-azure-monitor-alerts)
- [Classic alerts retirement announcement](https://azure.microsoft.com/updates/transition-to-builtin-azure-monitor-alerts-for-recovery-services-vaults-in-azure-backup-by-31-march-2026/)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/bk-1/bk-1.kql" >}} {{< /code >}}

{{< /collapse >}}

### BK-2 - Opt-in to Cross Region Restore for all Geo-Redundant Storage (GRS) Azure Recovery Services vaults

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Cross Region Restore allows you to restore Azure VMs in a secondary region, which is an Azure paired region. This option allows you to conduct drills to meet audit or compliance requirements, and to restore the VM or its disk if there's a disaster in the primary region. CRR is an opt-in feature for any GRS vault only.

**Resources**

- [Set Cross Region Restore](https://learn.microsoft.com/azure/backup/backup-create-recovery-services-vault#set-cross-region-restore)
- [Azure Backup Best Practices](https://learn.microsoft.com/azure/backup/guidance-best-practices)
- [Minimum Role Requirements for Cross Region Restore](https://learn.microsoft.com/azure/backup/backup-rbac-rs-vault#minimum-role-requirements-for-azure-vm-backup)
- [Recovery Services Vault](https://learn.microsoft.com/azure/backup/backup-azure-arm-vms-prepare)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/bk-2/bk-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
