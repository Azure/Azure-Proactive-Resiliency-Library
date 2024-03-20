+++
title = "Azure VMware Solution"
description = "Best practices and resiliency recommendations for Azure VMware Solution and associated resources and settings."
date = "03/30/2024"
author = "michielvanschaik"
msAuthor = "mivansch"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure VMware Solution and associated resources and settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
|  Recommendation                                   |      Category         |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :------:          |
|[AVS-1 Configure Azure Service Health notifications and alerts for AVS](#avs-1---configure-azure-service-health-notifications-and-alerts-for-avs) | Monitoring | High | Verified | Yes |
|[AVS-2 Configure Syslog in Diagnostic Settings for AVS](#avs-2---configure-syslog-in-diagnostic-settings-for-avs) | Monitoring | Medium | Verified | Yes |
|[AVS-3 Configure Azure Monitor Alert warning thresholds for vSAN datastore utilization](#avs-3---configure-azure-monitor-alert-warning-thresholds-for-vsan-datastore-utilization) | Monitoring | High | Verified | No |
|[AVS-4 Enable Stretched Clusters for Multi-AZ Availability of the vSAN Datastore](#avs-4---enable-stretched-clusters-for-multi-az-availability-of-the-vsan-datastore) | Availability | Low | Verified | Yes |
|[AVS-5 Monitor CPU Utilization to ensure sufficient resources for workloads](#avs-5---monitor-cpu-utilization-to-ensure-sufficient-resources-for-workloads) | Monitoring | Medium | Verified | Yes |
|[AVS-6 Monitor Memory Utilization to ensure sufficient resources for workloads](#avs-6---monitor-memory-utilization-to-ensure-sufficient-resources-for-workloads) | Monitoring | Medium | Verified | Yes |
|[AVS-7 Monitor when Azure VMware Solution Cluster Size is approaching the host limit](#avs-7---monitor-when-azure-vmware-solution-cluster-size-is-approaching-the-host-limit) | Monitoring | Medium | Verified | No |
|[AVS-8 Monitor when Azure VMware Solution Private Cloud is reaching the capacity limit](#avs-8---monitor-when-azure-vmware-solution-private-cloud-is-reaching-the-capacity-limit) | Monitoring | Medium | Verified | No |
|[AVS-9 Apply Resource delete lock on the resource group hosting the private cloud](#avs-9---apply-resource-delete-lock-on-the-resource-group-hosting-the-private-cloud) | Governance | High | Verified | No |
|[AVS-10 Align ExpressRoute configuration with best practices for circuit resilience](#avs-10---align-expressroute-configuration-with-best-practices-for-circuit-resilience) | Networking | High | Preview | No |
|[AVS-11 Deploy two or more circuits in different peering locations when using stretched clusters](#avs-11---deploy-two-or-more-circuits-in-different-peering-locations-when-using-stretched-clusters) | Networking | High | Preview | No |
|[AVS-12 Deploy two Azure VMware Solution private clouds in different regions for geographical disaster recovery](#avs-12---deploy-two-azure-vmware-solution-private-clouds-in-different-regions-for-geographical-disaster-recovery) | Disaster Recovery | High | Preview | No |
|[AVS-13 Use the Interconnect feature to connect private clouds in different availability zones](#avs-13---use-the-interconnect-feature-to-connect-private-clouds-in-different-availability-zones) | Storage | High | Preview | No |
|[AVS-14 Use key autorotation for vSAN datastore customer-managed keys](#avs-14---use-key-autorotation-for-vsan-datastore-customer-managed-keys) | Storage | High | Preview | No |
|[AVS-15 Configure LDAPS Identity integration with two sources for NSX-T and vCenter management consoles](#avs-15---configure-ldaps-identity-integration-with-two-sources-for-nsx-t-and-vcenter-management-consoles) | Storage | High | Preview | No |
|[AVS-16 Use Network Extension High Availability](#avs-16---use-network-extension-high-availability) | Availability | High | Preview | No |
|[AVS-17 HCX Network Extension](#avs-17---hcx-network-extension) | Configuration | High | Preview | No |
|[AVS-18 Use multiple DNS servers per private FQDN zone](#avs-18---use-multiple-dns-servers-per-private-fqdn-zone) | Configuration | High | Preview | No |
|[AVS-19 Verify vSAN FTT configuration aligns with the cluster size](#avs-19---verify-vsan-ftt-configuration-aligns-with-the-cluster-size) | Applications | High | Preview | No |


{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### AVS-1 - Configure Azure Service Health notifications and alerts for AVS

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure Azure Service Health notifications and alerts are configured for the Azure VMware Solution(AVS) service in the subscriptions and regions where AVS is deployed.

Azure Service Health is the mechanism used to inform customers of any service or security issues affecting their private cloud deployment.  Additionally, Azure Service Health is used to inform customers of maintenance activities in their AVS environments including host replacements, upgrades, and any service updates which could potentially impact customer operations. Proper configuration of Azure Service Health notifications and alerts ensures that customers receive relevant notifications and can reduce service request submissions due to AVS maintenance.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-management-and-monitoring#design-recommendations)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-1/avs-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-2 - Configure Syslog in Diagnostic Settings for AVS

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure Diagnostic Settings are configured for each private cloud to send the syslogs to one or more external sources for analysis and/or archiving.

Azure VMware Solution Syslogs have useful data for troubleshooting and performance that can help with quicker issue resolution and can also enable early detection of some kinds of issues. Configure Diagnostic Settings on the private cloud to send the Syslogs to one or more external sources for querying and/or archiving in case of an audit.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#manage-logs-and-archives)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="powershell" file="code/avs-2/avs-2.ps1" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-3 - Configure Azure Monitor Alert warning thresholds for vSAN datastore utilization

**Category: Monitoring**

**Impact: High**

**Recommendation/Guidance**

Ensure storage utilization is monitored and alerts are configured so that VMware vSAN datastore slack space is maintained at the level the service-level agreement (SLA) mandates.

For service-level agreement (SLA) purposes, Azure VMware Solution requires 25% slack space available on vSAN. vSAN storage utilization should be regularly monitored, and alerts should be configured at 70% utilization (30% slack space available on vSAN) and 75% utilization (25% slack space available on vSAN) to provide enough time for capacity planning.

To expand the vSAN datastore, additional hosts can be added, up to the maximum supported cluster size (16 hosts). Note, you may need to request host quota. In addition, external storage can be added (e.g. Azure Elastic SAN, Azure NetApp Files, Pure Cloud Block Storage) if the CPU and RAM requirements are being met by the Azure VMware Solution cluster.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-alerts-for-azure-vmware-solution#supported-metrics-and-activities)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-3/avs-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-4 - Enable Stretched Clusters for Multi-AZ Availability of the vSAN Datastore

**Category: Availability**

**Impact: Low**

**Recommendation/Guidance**

If a Multi-AZ deployment of Azure VMware Solution is required, needs a financially backed SLA of 99.99%, or needs synchronous storage replication between AZs (RPO=0), then Azure VMware Solution Stretched Clusters should be considered. If you are in a region that supports stretched clusters, consider enabling this feature to spread the VMware vSAN datastore across two availability zones. Note: Configuring an Azure VMware Solution private cloud as a stretched cluster can only be done during initial implementation and requires twice the quota. This is due to a stretched cluster extending the cluster to the second availability zone.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/infrastructure#implement-high-availability)
- [Stretched Clusters](https://learn.microsoft.com/en-us/azure/azure-vmware/deploy-vsan-stretched-clusters)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-4/avs-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-5 - Monitor CPU Utilization to ensure sufficient resources for workloads

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure there are enough compute resources to avoid host resource exhaustion. Azure VMware Solution uses vSphere DRS and vSphere HA to manage workload resources dynamically. However, sustained host CPU utilization of over 95% can contribute to high CPU Ready times, which will impact running workloads.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-5/avs-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-6 - Monitor Memory Utilization to ensure sufficient resources for workloads

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Ensure there are enough memory resources to avoid host resource exhaustion. Azure VMware Solution uses vSphere DRS and vSphere HA to manage workload resources dynamically. However, sustained host memory utilization of over 95% can contribute to host memory swapping to disk, which will impact running workloads.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-6/avs-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-7 - Monitor when Azure VMware Solution Cluster Size is approaching the host limit

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Alert when the cluster size of 14 hosts is reached. Additionally, periodic alerts should be set up to indicate when growth, especially driven by storage requirements, necessitates planning for a new cluster or the addition of extra datastores. Furthermore, beyond the threshold of 14 hosts, alerts should be triggered each time a new host is added to the cluster, allowing proactive monitoring and management of resource utilization.

**Resources**

- [Learn More](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-7/avs-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-8 - Monitor when Azure VMware Solution Private Cloud is reaching the capacity limit

**Category: Monitoring**

**Impact: Medium**

**Recommendation/Guidance**

Alert when the total node count is greater than or equal to 90 hosts so that it's clear when to start planning for a new private cloud.

**Resources**

- [Configure and streamline alerts](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/monitoring#configure-and-streamline-alerts)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-8/avs-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-9 - Apply Resource delete lock on the resource group hosting the private cloud

**Category: Governance**

**Impact: High**

**Recommendation/Guidance**

Anyone with contributor access to the resource group hosting Azure VMware Solution Private Cloud can delete it. Applying a resource delete lock to the Azure VMware Solution Private Cloud resource group to prevent deletion of the Azure VMware Solution Private Cloud.

**Resources**

- [Lock your resources to protect your infrastructure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-9/avs-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-10 - Align ExpressRoute configuration with best practices for circuit resilience

**Category: Networking**

**Impact: High**

**Recommendation/Guidance**

For critical workloads, Microsoft recommends deploying two (or more) ExpressRoute circuits in different ExpressRoute peering locations. Use Global Reach to connect multiple ExpressRoute circuits and your Azure VMware Solutions private clouds. Please review the APRL recommendations for ExpressRoute circuits in the Resources section below.

**Resources**

- [APRL guidance for ExpressRoute circuits](https://azure.github.io/Azure-Proactive-Resiliency-Library/services/networking/expressroute-circuits)
- [Create a new ExpressRoute circuit](https://learn.microsoft.com/azure/expressroute/expressroute-howto-circuit-portal-resource-manager?pivots=expressroute-preview#create-a-new-expressroute-circuit-preview)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-10/avs-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### AVS-11 - Deploy two or more circuits in different peering locations when using stretched clusters

**Category: Networking**

**Impact: High**

**Recommendation/Guidance**

Azure VMware Solution vSAN stretched clusters span two Availability Zones (AZs) in the region where they are deployed (plus a third AZ for the witness node). When using ExpressRoute to connect to the vSAN stretched clusters from  on-premises, align the ExpressRoute implementation's resilience to the clusters’ resilience by deploying two circuits in different peering locations (i.e., different sites/DC facilities). When using Global Reach, implement a  mesh topology by connecting the on-premises circuits to the managed circuits provided by the Azure VMware Solution private cloud.

**Resources**

- [Deploy vSAN streched cluster](https://learn.microsoft.com/en-us/azure/azure-vmware/deploy-vsan-stretched-clusters#deploy-a-stretched-cluster-private-cloud)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-11/avs-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### AVS-12 - Deploy two Azure VMware Solution private clouds in different regions for geographical disaster recovery

**Category: Disaster Recovery**

**Impact: High**

**Recommendation/Guidance**

Two Azure VMware Solution private clouds can be deployed in different regions for business continuity. Implement a  mesh network topology based on ExpressRoute Gateway Connections and Global Reach Connections.

**Resources**

- [Private Clouds in two regions](https://learn.microsoft.com/en-us/azure/azure-vmware/move-azure-vmware-solution-across-regions)
- [Dual Region Network Topology](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-dual-region-network-topology)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-12/avs-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
### AVS-13 - Use the Interconnect feature to connect private clouds in different availability zones

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Use the Interconnect feature for direct communication between private clouds in different availability zones, enabling connectivity between the private clouds management and workload networks. The IP address for each private cloud should be unique to avoid overlap, as the Interconnect does not check for this.

**Resources**

- [Connect Private Clouds in the same region](https://learn.microsoft.com/en-us/azure/azure-vmware/connect-multiple-private-clouds-same-region)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-13/avs-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-14 - Use key autorotation for vSAN datastore customer-managed keys

**Category: Storage**

**Impact: High**

**Recommendation/Guidance**

When using customer-managed keys to encrypt the vSAN datastore(s), use Azure Key Vault for centralized management and access them using a managed identity mapped to the private cloud. Key expiration can result in the vSAN datastore and its workloads becoming unavailable. Configure key autorotation to avoid unplanned outages due to key rotation not occurring before expiration.

**Resources**

- [Configure Customer Managed Keys](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-customer-managed-keys?tabs=azure-portal)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-14/avs-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-15 - Configure LDAPS Identity integration with two sources for NSX-T and vCenter management consoles

**Category: Access and Security**

**Impact: High**

**Recommendation/Guidance**

Ensure that two external identity sources are configured for NSX-T and vCenter. The VMware vCenter and NSX-T Manager use identity sources to enable authentication using external identities. These sources can be temporarily unavailable during maintenance times. Having two sources ensures that administrators can continue to log in to the control surfaces when one source becomes unavailable.

**Resources**

- [Set an external identity source for vCenter](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-identity-source-vcenter)
- [Set an external identity for NSX-T](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-external-identity-source-nsx-t)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-15/avs-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-16 - Use Network Extension High Availability

**Category: Availability**

**Impact: High**

**Recommendation/Guidance**

Enable Network Extension High Availability to provide appliance failure tolerance to the HCX Network Extension service. When Network Extension High Availability is enabled for a selected appliance, HCX will pair it with an eligible appliance and enable an Active Standby resiliency configuration. This enables highly available configurations that can remain in-service in the event of an unplanned appliance level failure. When either of the HA Actives fail, both standby appliances take over. The Network Extension High Availability is designed to recover within a few seconds after a single appliance has failed.

**Resources**

- [HCX Network extension high availability](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-hcx-network-extension-high-availability)
- [Understanding Network Extension High Availability](https://docs.vmware.com/en/VMware-HCX/4.8/hcx-user-guide/GUID-E1353511-697A-44B0-82A0-852DB55F97D7.html)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-16/avs-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-17 - HCX Network Extension

**Category: Networking**

**Impact: High**

**Recommendation/Guidance**

Do not extend the network on which the HCX Management devices are deployed.

**Resources**

- [Requirements for Network Extension](https://docs.vmware.com/en/VMware-HCX/4.8/hcx-user-guide/GUID-0C746416-850E-46F7-85DD-4D4326A23785.html)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-17/avs-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-18 - Use multiple DNS servers per private FQDN zone

**Category: Networking**

**Impact: High**

**Recommendation/Guidance**

AVS SDDC can support upto 3 DNS servers for a single FQDN. Using a single DNS server for DNS resolution becomes single point of failure. Ensure that multiple DNS servers are used for any on-premises FQDN resolution from AVS SDDC.

**Resources**

- [Configure DNS forwarder](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-dns-azure-vmware-solution#configure-dns-forwarder)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-18/avs-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### AVS-19 - Verify vSAN FTT configuration aligns with the cluster size

**Category: Application Resilience**

**Impact: High**

**Recommendation/Guidance**

AVS service SLA also depends on the vSAN storage policies configured, which vary depending on the cluster size. In clusters with more than 6 hosts, the vSAN storage policy should be configured with a FTT-2 policy (RAID-1, or RAID-6). FTT atands for failures to tolerate, which in this case refers to how many hosts in a cluster can fail, beofre there is potential data or VM impact.

The default storage policy is set to RAID-1 FTT-1, with Object Space Reservation set to Thin provisioning. Unless you adjust the storage policy or apply a new policy, the cluster grows with this configuration. Please note that the storage policy is not automatically updated based on cluster size. Similarly, changing the default does not automatically update the running VM policies.

**Resources**

- [Use fault domains](https://learn.microsoft.com/en-us/azure/well-architected/azure-vmware/application-platform#use-fault-domains)
- [Configure storage policy](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-storage-policy)

**Resource Graph Query/Scripts**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/avs-19/avs-19.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
