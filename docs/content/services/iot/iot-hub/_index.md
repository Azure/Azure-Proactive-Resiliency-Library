+++
title = "IoT Hub"
description = "Best practices and resiliency recommendations for IoT Hub and associated resources and settings."
date = "10/25/23"
author = "ReneHezser"
msAuthor = "rehezser"
draft = false
+++

The presented resiliency recommendations in this guidance include IoT Hub and associated resources and settings. General guidance are available in the Well-Architected Framework for IoT [Reliability in your IoT workload](https://learn.microsoft.com/en-us/azure/well-architected/iot/iot-reliability).

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Category                                                               |  Impact         |  State            | ARG Query Available |
| :------------------------------------------------ | :---------------------------------------------------------------------: | :------:        | :------:          | :-----------------: |
| [IOTH-1 - Device Identities are exported to a secondary region](#ioth-1---device-identities-are-exported-to-a-secondary-region) | Disaster Recovery | High | Preview  |         No         |
| [IOTH-2 - Do not use free tier](#ioth-2---do-not-use-free-tier) | Availability | High | Preview  |         Yes          |
| [IOTH-3 - Use Availability Zones](#ioth-3---use-availability-zones) | Availability | High | Preview  |         No          |
| [IOTH-4 - Use Device Provisioning Service](#ioth-4---use-device-provisioning-service) | System Efficiency | High | Preview  |         Yes          |
| [IOTH-5 - Define Failover Guidelines](#ioth-5---define-failover-guidelines) | Availability | High | Preview  |         No          |
| [IOTH-6 - Disabled Fallback Route](#ioth-6---disabled-fallback-route) | Monitoring | Low | Preview  |         Yes          |

{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### IOTH-1 - Device Identities are exported to a secondary region

**Category: Disaster Recovery**

**Impact: High**

**Recommendation**

Device Identities should be copied to the failover region IoT-Hub for all IoT devices to be able to connect in case of a failover to another IoT Hub.

Manual Failover of IoT Hub to another region is faster (RTO) and can be used for mission critical workload.

**Resources**

- [Import and export IoT Hub device identities in bulk](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-bulk-identity-mgmt)
- [IoT Hub high availability and disaster recovery](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-ha-dr#manual-failover)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ioth-1/ioth-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### IOTH-2 - Do not use free tier

**Category: Availability**

**Impact: High**

**Recommendation**

In a production scenario the IoT Hub tier should not be Free, as the Free tier does not offer the necessary SLA.

**Resources**

- [Choose the right IoT Hub tier and size for your solution](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-scaling)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ioth-2/ioth-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### IOTH-3 - Use Availability Zones

**Category: Availability**

**Impact: High**

**Recommendation**

In a region that supports Availability Zones for IoT Hub, these Zones should be used to increase availability. Availability Zones are automatically activated for new IoT Hubs in the supported regions.

**Resources**

- [Azure IoT Hub high availability and disaster recovery](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-ha-dr#availability-zones)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ioth-3/ioth-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### IOTH-4 - Use Device Provisioning Service

**Category: System Efficiency**

**Impact: High**

**Recommendation**

Device Provisioning Service (DPS) can redistribute IoT devices easily for scaling and availability. Devices will not be bound to specific IoT Hub instances, but can be reassigned with rules.

Even IoT Hubs that are associated to a Device Provisioning Service need to be checked if their devices use it.

**Resources**

- [IoT Hub Device Provisioning Service (DPS) terminology](https://learn.microsoft.com/en-us/azure/iot-dps/concepts-service)
- [Best practices for large-scale IoT device deployments](https://learn.microsoft.com/en-us/azure/iot-dps/concepts-deploy-at-scale)
- [IoT Hub Device Provisioning Service high availability and disaster recovery](https://learn.microsoft.com/en-us/azure/iot-dps/iot-dps-ha-dr)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ioth-4/ioth-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### IOTH-5 - Define Failover Guidelines

**Category: Availability**

**Impact: High**

**Recommendation**

In case of a regional failure, an IoT Hub can failover to a second region. This failover can be initiated automatically or manually. In both cases certain requirements are necessary for you application to continue working. Review the guidance for a failover

- check if the RTO is matched in case of an automatic failover
- no IP addresses are used by devices to connect to an IoT Hub

**Resources**

- [IoT Hub high availability and disaster recovery](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-ha-dr)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ioth-5/ioth-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### IOTH-6 - Disabled Fallback Route

**Category: Monitoring**

**Impact: Low**

**Recommendation**

If message routing is used to route messages to custom endpoints, it can happen that messages are not delivered to the custom routes, if the conditions are not meat. A default route will always receive all messages. Disabling it could potentially leave messages undelivered.

**Resources**

- [Use message routing - Fallback route](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-devguide-messages-d2c#fallback-route)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/ioth-6/ioth-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
