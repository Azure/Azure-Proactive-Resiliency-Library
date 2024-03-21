+++
title = "Azure Virtual Desktop"
description = "Best practices and resiliency recommendations for Azure Virtual Desktop and associated resources and settings."
date = "1/9/24"
author = "yshafner"
msAuthor = "yonahshafner"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Virtual Desktop and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation | Category | Impact | State | ARG Query Available |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------:|:--------:|:-------:|:-------------------:|
| [AVD-1 Use Private link when connecting to File Share or Key Vault](#avd-1---use-private-link-when-connecting-to-file-share-or-key-vault) | Access & Security | Medium | Verified | Yes |
| [AVD-2 Monitor Service Health and Resource Health of AVD](#avd-2---monitor-service-health-and-resource-health-of-avd) | Monitoring | High | Verified | No |
| [AVD-3 Deploy Session Hosts in an Availability Zone](#avd-3---deploy-session-hosts-in-an-availability-zone) | Availability | High | Verified | No |
| [AVD-4 Deploy Domain Controllers and DNS Servers in Azure Virtual Network Across Availability Zones](#avd-4---deploy-domain-controllers-and-dns-servers-in-azure-virtual-network-across-availability-zones) | Availability | Medium | Verified | No |
| [AVD-5 Implement RDP Shortpath for Public or Managed Networks](#avd-5---implement-rdp-shortpath-for-public-or-managed-networks) | Networking | Medium | Verified | No |
| [AVD-6 Implement a Multi-Region BCDR Plan](#avd-6---implement-a-multi-region-bcdr-plan) | Disaster Recovery | Medium | Verified | No |
| [AVD-7 Store Golden Image Redundantly for Disaster Recovery](#avd-7---store-golden-image-redundantly-for-disaster-recovery) | Disaster Recovery | Low | Verified | No |
| [AVD-8 Capacity Planning for AVD Resources](#avd-8---capacity-planning-for-avd-resources) | Disaster Recovery | Low | Verified | No |
| [AVD-9 Ensure that FSLogix Storage Account is Redundant](#avd-9---ensure-that-fslogix-storage-account-is-redundant) | Availability | High | Verified | No |
| [AVD-10 Enable Azure Backup for FSLogix Storage Account](#avd-10---enable-azure-backup-for-fslogix-storage-account) | Disaster Recovery | Medium | Verified | No |
| [AVD-11 Scaling plans should be created per region and not scaled across regions](#avd-11---scaling-plans-should-be-created-per-region-and-not-scaled-across-regions) | Disaster Recovery | Medium | Verified | No |
| [AVD-12 Keep detailed documentation of all AVD and shared services based on BCDR strategy detailing failover scenarios covered based on agreements](#avd-12---keep-detailed-documentation-of-all-avd-and-shared-services-based-on-bcdr-strategy-detailing-failover-scenarios-covered-based-on-agreements) | Disaster Recovery | Low | Verified | No |
| [AVD-13 Validate that the AVD session hosts can communicate with the AVD control plane and UDP ports are open if UDP is in use](#avd-13---validate-that-the-avd-session-hosts-can-communicate-with-the-avd-control-plane-and-udp-ports-are-open-if-udp-is-in-use) | User Connection | Medium | Verified | No |
| [AVD-14 Ensure Secondary Entra ID connect synchronization server](#avd-14---ensure-secondary-entra-id-connect-synchronization-server) | Identity/Directory | Low | Verified | No |
| [AVD-15 Deploy paired Domain Controllers in the same region as AVD session hosts](#avd-15---deploy-paired-domain-controllers-in-the-same-region-as-avd-session-hosts) | Disaster Recovery | High | Verified | No |
| [AVD-16 Ensure DNS regions are replicated to avoid single point of failure](#avd-16---ensure-dns-regions-are-replicated-to-avoid-single-point-of-failure) | DNS | Medium | Verified | No |
| [AVD-17 Capacity Planning for AVD Resources](#avd-17---capacity-planning-for-avd-resources) | Disaster Recovery | Low | Verified | No |
| [AVD-18 Create new version of updated image and replace session hosts rather than update host directly](#avd-18---create-new-version-of-updated-image-and-replace-session-hosts-rather-than-update-host-directly) | Pooled Session Host VMs | Low | Verified | No |
| [AVD-19 Pooled Create a validation pool for testing of planned updates](#avd-19---pooled-create-a-validation-pool-for-testing-of-planned-updates) | Pooled Session Host VMs | Medium | Verified | No |
| [AVD-20 Pooled Configure scheduled agent updates](#avd-20---pooled-configure-scheduled-agent-updates) | Pooled Session Host VMs | Medium | Verified | No |
| [AVD-21 Personal Create a validation pool for testing of planned updates](#avd-21---personal-create-a-validation-pool-for-testing-of-planned-updates) | Personal Session Host VMs | Low | Verified | No |
| [AVD-22 Use Azure Site Recovery or Backups on VMs supporting personal desktops](#avd-22---use-azure-site-recovery-or-backups-on-vms-supporting-personal-desktops) | Personal Session Host VMs | Medium | Verified | No |
| [AVD-23 Ensure a unique OU when deploying VMs to Domain](#avd-23---ensure-a-unique-ou-when-deploying-vms-to-domain) | GPO | Medium | Verified | No |
| [AVD-24 Ensure the standard FSLogix configuration is deployed](#avd-24---ensure-the-standard-fslogix-configuration-is-deployed) | FSLogix Profiles | Medium | Verified | No |
| [AVD-25 Ensure user permissions are set correctly on SMB shares](#avd-25---ensure-user-permissions-are-set-correctly-on-smb-shares) | FSLogix Profiles | Medium | Verified | No |
| [AVD-26 Configure Diagnostic Settings for FSLogix logs and enable review for accounts](#avd-26---configure-diagnostic-settings-for-fslogix-logs-and-enable-review-for-accounts) | FSLogix Profiles | Medium | Verified | No |
| [AVD-27 Manually update new FSLogix image when available](#avd-27---manually-update-new-fslogix-image-when-available) | FSLogix Profiles | Low | Verified | No |
| [AVD-28 Turn on Continuous Availability for ANF if using App Attach](#avd-28---turn-on-continuous-availability-for-anf-if-using-app-attach) | App Attach Storage | Medium | Verified | No |
| [AVD-29 App attach should be placed in separate file share; Disaster recovery plan should include App attach storage.](#avd-29---app-attach-should-be-placed-in-separate-file-share-and-disaster-recovery-plan-should-include-app-attach-storage)
| [AVD-30 Ensure virtual networks have route tables/route server configured for all regions](#avd-30---ensure-virtual-networks-have-route-tablesroute-server-configured-for-all-regions) | Networking/Connectivity | Medium | Verified | No |
| [AVD-31 Ensure virtual networks isolation with separate IP space and NSGs for Prod and DR](#avd-31---ensure-virtual-networks-isolation-with-separate-ip-space-and-nsgs-for-prod-and-dr) | Networking/Connectivity | Medium | Verified | No |
| [AVD-32 Ensure the network is resilient](#avd-32---ensure-the-network-is-resilient) | Networking/Connectivity | Medium | Verified | No |
| [AVD-33 Ensure route tables accommodate failover](#avd-33---ensure-route-tables-accommodate-failover) | FSLogix Profiles | Medium | Verified | No |
| [AVD-34 Ensure Resilient Deployment of Keyvault for AVD Host Pools](#avd-34---ensure-resilient-deployment-of-keyvault-for-avd-host-pools) | Keyvault | High | Verified | No |
| [AVD-35 Ensure all apps/data/(DC) accessed from session hosts have DR strategy/failover mechanisms and have been tested](#avd-35---ensure-all-appsdatadc-accessed-from-session-hosts-have-dr-strategyfailover-mechanisms-and-have-been-tested) | Non-AVD LOB Dependencies | High | Verified | No |
| [AVD-36 Configure AVD insights Workbook](#avd-36---configure-avd-insights-workbook) | Observability | High | Verified | No |
| [AVD-37 Ensure separate log analytics workspaces for Prod and DR](#avd-37---ensure-separate-log-analytics-workspaces-for-prod-and-dr) | Observability | Low | Verified | No |
| [AVD-38 Organize AVD resources using the AVD Scale unit model described by the AVD Landing Zone Methodology](#avd-38---organize-avd-resources-using-the-avd-scale-unit-model-described-by-the-avd-landing-zone-methodology) | Subscriptions | Low | Verified | No |
| [IT-2 - Replicate your Image Templates to a secondary region](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/compute/image-templates/#it-2---replicate-your-image-templates-to-a-secondary-region) | Disaster Recovery | Low | Verified | Yes |
| [CG-2 - Zone redundant storage should be used for image versions](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/compute/compute-gallery/#cg-2---zone-redundant-storage-should-be-used-for-image-versions) | Availability | Medium | Verified | Yes |
| [VM-2 - Deploy VMs across Availability Zones](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/compute/virtual-machines/#vm-2---deploy-vms-across-availability-zones) | Availability | High | Verified | Yes |
| [VM-7 - Enable Backups on your VMs](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/compute/virtual-machines/#vm-7---backup-vms-with-azure-backup-service) | Disaster Recovery | Medium | Verified | Yes |
| [VM-8 - Production VMs should be using SSD disks](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/compute/virtual-machines/#vm-8---production-vms-should-be-using-ssd-disks) | System Efficiency | High | Verified | Yes |
| [ERC-1 - Connect your on-premises network to critical workloads in Azure through two or more ExpressRoute circuits in different peering locations](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-circuits/#erc-1---connect-your-on-premises-network-to-critical-workloads-in-azure-through-two-or-more-expressroute-circuits-in-different-peering-locations) | Availability | High | Verified | No |
| [ERC-2 - Ensure the two physical links of your ExpressRoute circuit are connected to two distinct edge devices in your network](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-circuits/#erc-2---ensure-the-two-physical-links-of-your-expressroute-circuit-are-connected-to-two-distinct-edge-devices-in-your-network) | Availability | High | Verified | No |
| [VPNG-1 - Choose a Zone-redundant gateway](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/vpn-gateway/#vpng-1---choose-a-zone-redundant-gateway) | Availability | High | Verified | Yes |
| [VPNG-3 - Plan for Site-to-Site VPN and Azure ExpressRoute coexisting connection](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/vpn-gateway/#vpng-3---plan-for-site-to-site-vpn-and-azure-expressroute-coexisting-connection) | Disaster Recovery | High | Verified | No |
| [NSG-4 - Configure NSG Flow Logs](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/network-security-group/#nsg-4---configure-nsg-flow-logs) | Monitoring | Medium | Verified | Yes |
| [VM-21 - Configure diagnostic settings for all Azure Virtual Machines](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/compute/virtual-machines/#vm-21---configure-diagnostic-settings-for-all-azure-virtual-machines) | Monitoring | Low | Verified | Yes |
| [VM-25 - Do not create more than 2000 Citrix VDA servers per subscription](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/compute/virtual-machines/#vm-25---do-not-create-more-than-2000-citrix-vda-servers-per-subscription) | Application Resiliency | High | Verified | Yes |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AVD-1 - Use Private link when connecting to File Share or Key Vault

**Category: Access & Security**

**Impact: Medium**

**Guidance**

Private Link is available for other Azure services that work in conjunction with Azure Virtual Desktop, such as Azure Files and Key Vault. From a resiliency standpoint, we recommending implementing private endpoints for these services to reduce exposure to potential internet-related issues such as latency, packet loss, and/or downtime. This can lead to more reliable communication between AVD and dependent services.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/networking#private-endpoints-private-link)
- [Private link](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/networking#private-endpoints-private-link)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-1/avd-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-2 - Monitor Service Health and Resource Health of AVD

**Category: Monitoring**

**Impact: Medium**

**Guidance**

Use Service Health to stay informed about the health of the Azure services and regions that you use to insure their availability.
Set up Service Health alerts so that you stay aware of service issues, planned maintenance, or other changes that might affect your Azure Virtual Desktop resources.
Use Resource Health to monitor your VMs and storage solutions.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/monitoring#resource-health)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-2/avd-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-3 - Deploy Session Hosts in an Availability Zone

**Category: Availability**

**Impact: High**

**Guidance**

Deploy session hosts in an availability zone or an availability set helps protect the environment from outages.

Enhances reliability by minimizing latency and impacts reliability helping keep the data synchronized and protecting from outages. If one zone experiences an outage, then regional services, capacity, and high availability are supported by the remaining zones.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/application-delivery#session-host-settings)
- [Availability Zones](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/application-delivery#session-host-settings)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-3/avd-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-4 - Deploy Domain Controllers and DNS Servers in Azure Virtual Network Across Availability Zones

**Category: Availability**

**Impact: Medium**

**Guidance**

When using an AD DS identity solution with AVD, it is recommended to deploy domain controllers and DNS servers on Azure virtual machines across availability zones. This improves the environment’s reliability by removing a dependency on an on-premises service and improves performance by creating a shorter path for user authentication.

This recommendation is not relevant when you are utilizing Microsoft Entra as the identity provider.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/identity/adds-extend-domain#reliability)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-4/avd-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-5 - Implement RDP Shortpath for Public or Managed Networks

**Category: Networking**

**Impact: Medium**

**Guidance**

It is recommended to enable RDP Shortpath for AVD. RDP Shortpath is a feature of Azure Virtual Desktop that establishes a direct UDP-based transport between a supported Windows Remote Desktop client and session host. By default, Remote Desktop Protocol (RDP) tries to establish connection using UDP and uses a TCP-based reverse connect transport as a fallback connection mechanism. TCP-based reverse connect transport provides the best compatibility with various networking configurations and has a high success rate for establishing RDP connections. UDP-based transport offers better connection reliability and more consistent latency.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/rdp-shortpath?tabs=managed-networks)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-5/avd-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-6 - Implement a Multi-Region BCDR Plan

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

It is recommended to adopt a multi-region deployment (active-active) for AVD. Each region should contain at least identity, name resolution, AVD management resources, and session hosts in case of a primary region outage.

**Resources**

- [Multi-region BCDR](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/wvd/azure-virtual-desktop-multi-region-bcdr)
- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/business-continuity#active-active-scenarios)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-6/avd-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-7 - Store Golden Image Redundantly for Disaster Recovery

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

If a full BCDR strategy is not in place, consider using zone-redundant storage to store golden images across availability zones. Having the image available will allow for faster recovery in case of zonal or regional outage.

**Resources**

- [Golden Image](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/business-continuity#golden-images)
- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/application-delivery#fault-tolerance)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-7/avd-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-8 - Capacity Planning for AVD Resources

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

Monitor and plan for subscription limits and API throttling limits. Closely monitor your Azure Virtual Desktop deployments, and keep track of resource usage within your subscription. By proactively monitoring capacity, you can identify potential challenges early on, and you can take suitable actions to avoid reaching limits.
Consider scaling across multiple subscriptions if further scaling is required, or work with Azure support to adjust limits based on your business requirements.
To handle a large number of users, consider scaling horizontally by creating multiple host pools.

**Resources**

- [Capacity Planning](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/business-continuity#capacity-planning)
- [Learn More](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/wvd/windows-virtual-desktop#azure-virtual-desktop-limitations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-8/avd-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-9 - Ensure that FSLogix Storage Account is Redundant

**Category: Availability**

**Impact: Medium**

**Guidance**

It is important to ensure the redundancy of our user profiles when using FSLogix. When using FSLogix with AVD, it is deployed on a file share in a storage account. Data in an Azure Storage account is always replicated three times in the primary region. Below are the options for how your data is replicated in the primary or paired region:
LRS for least expensive replication (not recommended for apps with high availability and durability).

- LRS provides eleven 9s durability and replicates three time in a single physical location.
- ZRS is recommended for apps requiring high availability across zones. ZRS provides twelve 9s durability. Replicated across three availability zones
- GRS replicates an additional three copies to secondary region and provides sixteen 9s durability.
- GZRS provides both high availability and redundancy across geo replication. It provides sixteen 9s durability over a given year.

Generally, it is recommended to store your data as secure and redundant as possible.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-virtual-desktop/storage#user-profiles)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-9/avd-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-10 - Enable Azure Backup for FSLogix Storage Account

**Category: Backup/Storage**

**Impact: Medium**

**Guidance**

It is recommended to enable backup on the FSLogix Storage Account. Ensuring the user profiles are resilient will allow user data and experience to be consistent through outages.

**Resources**

- [FSLogix](https://learn.microsoft.com/en-us/fslogix/overview-what-is-fslogix)
- [Backup Storage Account](https://learn.microsoft.com/en-us/azure/backup/blob-backup-configure-manage?tabs=operational-backup)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-10/avd-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-11 - Scaling plans should be created per region and not scaled across regions

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance:**
Scaling plans exist per region assigned to host pools within the region and can become inaccessible in case of regional failure. A secondary scaling plan should be created with a secondary region to protect from this.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/autoscale-scaling-plan?tabs=portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-11/avd-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-12 - Keep detailed documentation of all AVD and shared services based on BCDR strategy detailing failover scenarios covered based on agreements

**Category: Disaster Recovery**

**Impact: Low**

**Guidance:**
It's essential for all stakeholders to have access to the latest documented business continuity and disaster recovery considerations aligned to the AVD workloads you deploy.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/network-connectivity)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-12/avd-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-13 - Validate that the AVD session hosts can communicate with the AVD control plane and UDP ports are open if UDP is in use

**Category: User Connection**

**Impact: Medium**

**Guidance:**
Connectivity for validating the VMs connectivity to AVD Control Plane and UDP TURN ports open.
Global URLs confirmed whitelisted. UDP/TURN ports open and accessible.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/troubleshoot-rdp-shortpath)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-13/avd-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-14 - Ensure Secondary Entra ID connect synchronization server

**Category: Identity/Directory**

**Impact: Low**

**Guidance:**
Hybrid - Entra ID Connect best to run in Azure but can be hosted on-prem. Secondary or more VMs should be setup in staging mode in event of failover.
Set up secondary server in staging mode for Entra Connect for syncing to Entra in case of primary server outage.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/how-to-connect-install-multiple-domains)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-14/avd-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-15 - Deploy paired Domain Controllers in the same region as AVD session hosts

**Category: Disaster Recovery**

**Impact: High**

**Guidance:**
Ensure each Region with session host has multiple domain controllers in the same region to support adjustments based on your business requirements. To handle a large number of users, consider scaling horizontally by creating multiple host pools.
Hybrid - Each Azure region with AVD hosts should have ADDS DCs (IaaS VMs) in Azure and use Availability Sets or Zones for resiliency across single Datacenter or Region. Mitigates dependency on ER/VPN/Inter-Azure dependencies.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop-multi-region-bcdr)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-15/avd-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-16 - Ensure DNS regions are replicated to avoid single point of failure

**Category: DNS**

**Impact: Medium**

**Guidance:**
ADDS Integrated DNS/other should target Secondary/Tertiary customer DNS across multi-region zones. If using custom DNS, ensure there are redundant DNS servers to avoid a single point of failure.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/azure-virtual-desktop/azure-virtual-desktop-multi-region-bcdr)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-16/avd-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-17 - Capacity Planning for AVD Resources

**Category: Disaster Recovery**

**Impact: Low**

**Guidance:**
Monitor and plan for subscription limits and API throttling limits. Closely monitor your Azure Virtual Desktop deployments and keep track of resource usage within your subscription. By proactively monitoring capacity, you can identify potential challenges early on, and you can take suitable actions to avoid reaching limits. Consider scaling across multiple subscriptions if further scaling is required, or work with Azure support to adjust limits based on your business requirements. To handle a large number of users, consider scaling horizontally by creating multiple host pools.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/wvd/windows-virtual-desktop#azure-virtual-desktop-limitations)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-17/avd-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-18 - Create new version of updated image and replace session hosts rather than update host directly

**Category: Pooled Session Host VMs**

**Impact: Low**

**Guidance:**
Automated patching and updating requiring minimal maintenance windows and ability to quickly roll back to prior image immediately.
Updating session hosts should be done through the update of a golden image and creation of new session hosts and destruction of old session hosts. This process guarantees that all hosts are identical and not affected by configuration drift. This also provides flexibility in rolling back of images if issues arise with an updated image.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/training/modules/create-manage-session-host-image/)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-18/avd-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-19 - [Pooled] Create a validation pool for testing of planned updates

**Category: Pooled Session Host VMs**

**Impact: Medium**

**Guidance:**
At least one Validation Pool to have early warning if a planned update to AVD causes an issue. support to adjust limits based on your business requirements. To handle a large number of users, consider scaling horizontally by creating multiple host pools.
Also check that the host pool has been used regularly to test planned updates.
Host pools are a collection of one or more identical virtual machines within Azure Virtual Desktop environment. We highly recommend you create a validation host pool where service updates are applied first. Validation host pools let you monitor service updates before the service applies them to your standard or non-validation environment. Without a validation host pool, you may not discover changes that introduce errors, which could result in downtime for users in your standard environment.
To ensure your apps work with the latest updates, the validation host pool should be as similar to host pools in your non-validation environment as possible. Users should connect as frequently to the validation host pool as they do to the standard host pool. If you have automated testing on your host pool, you should include automated testing on the validation host pool.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/configure-validation-environment?tabs=azure-portal)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-19/avd-19.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-20 - [Pooled] Configure scheduled agent updates

**Category: Pooled Session Host VMs**

**Impact: Medium**

**Guidance:**
Check if schedules have been created to provide maintenance windows.
Scheduled AVD agent updates on the host pool.
The Scheduled Agent Updates feature lets you create up to two maintenance windows for the Azure Virtual Desktop agent, side-by-side stack, and Geneva Monitoring agent to get updated so that updates don't happen during peak business hours.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/scheduled-agent-updates)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-20/avd-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-21 - [Personal] Create a validation pool for testing of planned updates

**Category: Personal Session Host VMs**

**Impact: Low**

**Guidance:**
At least one Validation Pool to have early warning if a planned update to AVD causes an issue. Also check that the host pool has been used regularly to test planned updates.
Host pools are a collection of one or more identical virtual machines within Azure Virtual Desktop environment. We highly recommend you create a validation host pool where service updates are applied first. Validation host pools let you monitor service updates before the service applies them to your standard or non-validation environment. Without a validation host pool, you may not discover changes that introduce errors, which could result in downtime for users in your standard environment.
To ensure your apps work with the latest updates, the validation host pool should be as similar to host pools in your non-validation environment as possible. Users should connect as frequently to the validation host pool as they do to the standard host pool. If you have automated testing on your host pool, you should include automated testing on the validation host pool.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/configure-validation-environment?tabs=azure-portal)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-21/avd-21.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-22 - Use Azure Site Recovery or Backups on VMs supporting personal desktops

**Category: Personal Session Host VMs**

**Impact: Medium**

**Guidance:**
Ensuring the resiliency and backup/recovery of session hosts.
Assess and determine the impacted personal desktop to either failover using ASR or deploy a new machine will ensure your business can reach the resiliency targets.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/scheduled-agent-updates)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-22/avd-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-23 - Ensure a unique OU when deploying VMs to Domain

**Category: GPO**

**Impact: Medium**

**Guidance:**
Hybrid VMs should be in a unique OU.
When using AD-joined session hosts will benefit from using a unique OU to target specific AVD configurations per hostpool. Examples include Fslogix, time out limits, session controls, and much more. It’s also important to segment your Prod and DR organization units to ensure resources are configured per environment.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/deploy/virtual-dc/adds-on-azure-vm#configure-the-vms-and-install-active-directory-domain-services)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-23/avd-23.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-24 - Ensure the standard FSLogix configuration is deployed

**Category: FSLogix Profiles**

**Impact: Medium**

**Guidance:**
After installing FSLogix, the installer will create a base set of registry keys and values which provides the framework for adding configuration settings. FSLogix doesn't create ANY configuration setting value names as part of the installation.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/fslogix/reference-configuration-settings?tabs=profiles)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-24/avd-24.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-25 - Ensure user permissions are set correctly on SMB shares

**Category: FSLogix Profiles**

**Impact: Medium**

**Guidance:**
Verify RBAC permissions are set using Security Group and that appropriate security permissions are set so that no user has access to another user's profile. Set permissions at the root volume to allow administrators to have access to the full volume. Also consider secondary storage path permissions in case of a DR event.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/fslogix/how-to-configure-storage-permissions)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-25/avd-25.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-26 - Configure Diagnostic Settings for FSLogix logs and enable review for accounts

**Category: FSLogix Profiles**

**Impact: Medium**

**Guidance:**
Regularly review FSLogix logs for errors and issues related to login and mounting the profile. Events can be reviewed by looking locally inside the Session Host and also in Log Analytics when the Azure Monitor Agent is used.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/fslogix/troubleshooting-events-logs-diagnostics)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-26/avd-26.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-27 - Manually update new FSLogix image when available

**Category: FSLogix Profiles**

**Impact: Low**

**Guidance:**
Maintain FSLogix up to date by having a process to regularly check for FSLogix Agent upgrades. We recommend customers upgrade to the latest version of FSLogix as quickly as their deployment process can allow. FSLogix will provide hotfix releases which address current and potential bugs that impact customer deployments. Additionally, it is the first requirement when opening any support case.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/fslogix/how-to-install-fslogix)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-27/avd-27.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-28 - Turn on Continuous Availability for ANF if using App Attach

**Category: App Attach Storage**

**Impact: Medium**

**Guidance**

Turn on Continuous Availability if using Azure Netapp Files.

Verify the number of users connecting to each file share to make sure the SMB path can handle the number of file connections. Currently, Azure Files supports up to 10k handles per root directory.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/app-attach-overview?pivots=msix-app-attach)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-28/avd-28.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-29 - App attach should be placed in separate file share and Disaster recovery plan should include App attach storage

**Category: App Attach**

**Impact: Medium**

**Guidance**

App Attach packages should be on a separate share from profiles. And App Attach files should be backed up.

Best practice is to separate App Attach VHD files in a separate file share away from user profiles, both for performance and scalability purposes. Requirements can vary greatly depending on how many packaged applications are stored in an image, and you need to test your applications to understand your requirements.

Your file share should be in the same Azure region as your session hosts.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/app-attach-overview?pivots=msix-app-attach)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-29/avd-29.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-30 - Ensure virtual networks have route tables/route server configured for all regions

**Category: Networking/Connectivity**

**Impact: Medium**

**Guidance**

Consider backup paths across regions where high availability connections back to on-premises are required. While ExpressRoute is designed for high availability to provide carrier-grade private network connectivity to Microsoft resources, it is reasonable to consider backup paths in case of regional failure.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering#need-for-redundant-connectivity-solution)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-30/avd-30.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-31 - Ensure virtual networks isolation with separate IP space and NSGs for Prod and DR

**Category: Networking/Connectivity**

**Impact: Medium**

**Guidance**

NSG and ASG per AVD persona and IP space per Prod/DR regions.

It's important your organization plans for IP addressing in Azure. Planning ensures the IP address space doesn't overlap across on-premises locations and Azure regions. Overlapping IP address spaces across on-premises and Azure regions create major contention challenges.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-31/avd-31.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-32 - Ensure the network is resilient

**Category: Networking/Connectivity**

**Impact: Medium**

**Guidance**

The use of separate routing in Production and DR is highly encouraged, especially for backup ExR or VPN path for on-premises connections. Be sure to separate routing and security appliances, as well as on-premises physical hardware.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/firewall/features#availability-zones)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-32/avd-32.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-33 - Ensure route tables accommodate failover

**Category: FSLogix Profiles**

**Impact: Medium**

**Guidance**

Ensure Route Tables that force tunnel traffic to FW/NVA have failover considerations evaluated and won't fail or trigger next-gen FW protections.

AVD workload teams should collaborate with centralized teams that manage the shared infrastructure, like networking, to ensure that both Production and DR workloads have the appropriate route tables in place for failover of routing to perform as expected.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-business-continuity-disaster-recovery)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-33/avd-33.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-34 - Ensure Resilient Deployment of Keyvault for AVD Host Pools

**Category: Keyvault**

**Impact: High**

**Guidance:**
AVD host pools or any unit of scale operation utilizing Keyvault should be deployed resiliently to ensure availability and disaster recovery preparedness. Depending on your region and requirements, consider deploying your Keyvault using Geo-Redundant Storage (GRS) or deploy two Keyvaults using Zone-redundant Storage (ZRS) and write to both production and disaster recovery Keyvaults simultaneously. This ensures that critical secrets and cryptographic keys are protected and accessible even in the event of a regional outage.

**Resources:**

- [Learn More](https://learn.microsoft.com/en-us/azure/key-vault/general/disaster-recovery-guidance)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-34/avd-34.kql" >}} {{< /code >}}

{{< /collapse >}}

### AVD-35 - Ensure all apps/data/(DC) accessed from session hosts have DR strategy/failover mechanisms and have been tested

**Category: Non-AVD LOB Dependencies**

**Impact: High**

**Guidance**

It is critical that AVD workload teams, centralized teams, and any other App dependency team collaborates to ensure that DR environments and apps mirror Production environments configuration to ensure the DR workloads will function and meet performance targets.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/disaster-recovery#disaster-recovery-testing)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-35/avd-35.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-36 - Configure AVD Insights Workbook

**Category: Observability**

**Impact: High**

**Guidance**

AVD Insights is an Azure Workbook template provided by the AVD product team. It is highly recommended in order to monitor and troubleshoot AVD workloads across metrics, logs, events, and more. Both Production and DR workloads should be enabled with AVD Insights.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/virtual-desktop/insights?tabs=monitor)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-36/avd-36.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-37 - Ensure separate log analytics workspaces for Prod and DR

**Category: Observability**

**Impact: Low**

**Guidance**

Having separate Log Analytics ensures that your DR environment is fully operational for visibility of the metrics, performance, and other auditing tools your workload teams will rely on in the event of an incident.

**Resources**

- [Learn More](https://learn.microsoft.com/en-US/azure/virtual-desktop/set-up-service-alerts)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-37/avd-37.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVD-38 - Organize AVD resources using the AVD Scale unit model described by the AVD Landing Zone Methodology

**Category: Subscriptions**

**Impact: Low**

**Guidance**

Follow AVD Landing Zone best practices using multiple resource groups based on resource type and associated shared resources for AVD workloads.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/azure-virtual-desktop/enterprise-scale-landing-zone)

**Resource Graph Query/Scripts:**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avd-38/avd-38.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
