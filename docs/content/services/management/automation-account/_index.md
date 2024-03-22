+++
title = "Automation Account"
description = "Best practices and resiliency recommendations for Azure Automation account and associated resources."
date = "10/18/23"
author = "poven"
msAuthor = "poven"
draft = false
+++

The presented resiliency recommendations in this guidance include Automation account and its associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Impact  |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :------: | :-----------------: |
| [AA-1 - Set up disaster recovery of Automation accounts and its dependent resources](#aa-1---set-up-disaster-recovery-of-automation-accounts-and-its-dependent-resources) | High | Preview  |         No         |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AA-1 - Set up disaster recovery of Automation accounts and its dependent resources

**Category: Availability**

**Impact: High**

**Guidance**

 Set up disaster recovery of Automation accounts, and its dependent resources such as Modules, Connections, Credentials, Certificates, Variables and Schedules to handle a region-wide service outage or zone-wide failure. For disaster recovery, the replica Automation account must be already deployed and ready in the secondary region to failover if the Automation account in the primary region becomes unavailable. Ensure that your disaster recovery strategy considers your Automation account and the dependent resources.

 You can use the [PowerShell script](https://learn.microsoft.com/en-us/azure/automation/automation-disaster-recovery?tabs=win-hrw%2Cps-script%2Coption-one#script-to-migrate-automation-account-assets-from-one-region-to-another) to migrate assets of the Automation account from one region to another, or if you are using [ARM templates](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview) to define and deploy Automation runbooks, you can use these templates to deploy the same runbooks in any other Azure region where you create the replica Automation account.

**Resources**

- [Disaster recovery for Automation accounts](https://learn.microsoft.com/en-us/azure/automation/automation-disaster-recovery?tabs=win-hrw%2Cps-script%2Coption-one)
- [Disaster recovery scenarios for cloud and hybrid jobs](https://learn.microsoft.com/en-us/azure/automation/automation-disaster-recovery?tabs=win-hrw%2Cps-script%2Coption-one#scenarios-for-cloud-and-hybrid-jobs)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/aa-1/aa-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
