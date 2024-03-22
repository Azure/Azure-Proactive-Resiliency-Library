+++
title = "Azure Databricks"
description = "Best practices and resiliency recommendations for Azure Databricks and associated resources."
date = "10/09/23"
author = "oZakari"
msAuthor = "ztrocinski"
draft = false
+++

The presented resiliency recommendations in this guidance include Azure Databricks and dependent resources and settings.

## Summary of Recommendation
{{< table style="table-striped" >}}
| Recommendation                                                                                                                                                                                                                |        Category        | Impact |  State   | ARG Query Available |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------:|:------:|:--------:|:-------------------:|
| [DBW-1 - Databricks runtime version is not latest and/or is not LTS version](#dbw-1---databricks-runtime-version-is-not-latest-or-is-not-lts-version)                                                                         |       Governance       | Medium | Verified |         No          |
| [DBW-2 - Use Databricks Pools](#dbw-2---use-databricks-pools)                                                                                                                                                                 |   System Efficiency    |  High  | Verified |         No          |
| [DBW-3 - Use SSD backed VMs for Worker VM Type and Driver type](#dbw-3---use-ssd-backed-vms-for-worker-vm-type-and-driver-type)                                                                                               |   System Efficiency    | Medium | Verified |         No          |
| [DBW-4 - Enable autoscaling for batch workloads](#dbw-4---enable-autoscaling-for-batch-workloads)                                                                                                                             |   System Efficiency    |  High  | Verified |         No          |
| [DBW-5 - Enable autoscaling for SQL warehouse](#dbw-5---enable-autoscaling-for-sql-warehouse)                                                                                                                                 |   System Efficiency    |  High  | Verified |         No          |
| [DBW-6 - Use Delta Live Tables enhanced autoscaling](#dbw-6---use-delta-live-tables-enhanced-autoscaling)                                                                                                                     |   System Efficiency    | Medium | Verified |         No          |
| [DBW-7 - Automatic Job Termination is enabled, ensure there are no user-defined local processes](#dbw-7---automatic-job-termination-is-enabled-ensure-there-are-no-user-defined-local-processes)                              |      Availability      | Medium | Verified |         No          |
| [DBW-8 - Enable Logging-Cluster log delivery](#dbw-8---enable-logging-cluster-log-delivery)                                                                                                                                   |       Monitoring       | Medium | Verified |         No          |
| [DBW-9 - Use Delta Lake for higher reliability](#dbw-9---use-delta-lake-for-higher-reliability)                                                                                                                               |      Availability      |  High  | Verified |         No          |
| [DBW-10 - Use Photon Acceleration](#dbw-10---use-photon-acceleration)                                                                                                                                                         |      Availability      |  Low   | Verified |         No          |
| [DBW-11 - Automatically rescue invalid or nonconforming data with Databricks Auto Loader or Delta Live Tables](#dbw-11---automatically-rescue-invalid-or-nonconforming-data-with-databricks-auto-loader-or-delta-live-tables) | Application Resilience |  Low   | Verified |         No          |
| [DBW-12 - Configure jobs for automatic retries and termination](#dbw-12---configure-jobs-for-automatic-retries-and-termination)                                                                                               |      Availability      |  High  | Verified |         No          |
| [DBW-13 - Use a scalable and production-grade model serving infrastructure](#dbw-13---use-a-scalable-and-production-grade-model-serving-infrastructure)                                                                       |   System Efficiency    |  High  | Verified |         No          |
| [DBW-14 - Use a layered storage architecture](#dbw-14---use-a-layered-storage-architecture)                                                                                                                                   | Application Resilience | Medium | Verified |         No          |
| [DBW-15 - Improve data integrity by reducing data redundancy](#dbw-15---improve-data-integrity-by-reducing-data-redundancy)                                                                                                   | Application Resilience |  Low   | Verified |         No          |
| [DBW-16 - Actively manage schemas](#dbw-16---actively-manage-schemas)                                                                                                                                                         |       Governance       | Medium | Verified |         No          |
| [DBW-17 - Use constraints and data expectations](#dbw-17---use-constraints-and-data-expectations)                                                                                                                             | Application Resilience |  Low   | Verified |         No          |
| [DBW-18 - Create regular backups](#dbw-18---create-regular-backups)                                                                                                                                                           |   Disaster Recovery    |  Low   | Verified |         No          |
| [DBW-19 - Recover from Structured Streaming query failures](#dbw-19---recover-from-structured-streaming-query-failures)                                                                                                       |      Availability      |  High  | Verified |         No          |
| [DBW-20 - Recover ETL jobs based on Delta time travel](#dbw-20---recover-etl-jobs-based-on-delta-time-travel)                                                                                                                 |   Disaster Recovery    | Medium | Verified |         No          |
| [DBW-21 - Use Databricks Workflows and built-in recovery](#dbw-21---use-databricks-workflows-and-built-in-recovery)                                                                                                           |   Disaster Recovery    |  Low   | Verified |         No          |
| [DBW-22 - Configure a disaster recovery pattern](#dbw-22---configure-a-disaster-recovery-pattern)                                                                                                                             |   Disaster Recovery    |  High  | Preview  |         No          |
| [DBW-23 - Automate deployments and workloads](#dbw-23---automate-deployments-and-workloads)                                                                                                                                   |       Automation       |  High  | Preview  |         No          |
| [DBW-24 - Set up monitoring, alerting, and logging](#dbw-24---set-up-monitoring-alerting-and-logging)                                                                                                                         |       Monitoring       |  High  | Preview  |         No          |
| [DBW-25 - Deploy workspaces in separate Subscriptions](#dbw-25---deploy-workspaces-in-separate-subscriptions)                                                                                                                 |   System Efficiency    |  High  | Preview  |         No          |
| [DBW-26 - Isolate each workspace in its own Vnet](#dbw-26---isolate-each-workspace-in-its-own-vnet)                                                                                                                           |   System Efficiency    |  High  | Preview  |         No          |
| [DBW-27 - Do not Store any Production Data in Default DBFS Folders](#dbw-27---do-not-store-any-production-data-in-default-dbfs-folders)                                                                                       |      Availability      |  High  | Preview  |         No          |
| [DBW-28 - Do not use Azure Sport VMs for critical Production workloads](#dbw-28---do-not-use-azure-sport-vms-for-critical-production-workloads)                                                                               |      Availability      |  High  | Preview  |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### DBW-1 - Databricks runtime version is not latest or is not LTS version

**Category: Governance**

**Impact: Medium**

**Guidance**

Use 12.2 LTS later. Databricks recommends that you migrate your workloads in the following order:

- If your workloads are currently running on Databricks Runtime 11.3 LTS or above, you can migrate directly to the latest version of Databricks Runtime 12.x, as described later in this article.
- If your workloads are currently running on Databricks Runtime 11.3 LTS or below, do the following:
  - Migrate to Databricks Runtime 11.3 LTS first. See the Databricks Runtime 11.x migration guide.
  - Follow the guidance in this article to migrate from Databricks Runtime 11.3 LTS to the latest version of Databricks Runtime 12.x.

**Resources**

- [Databricks runtime support lifecycles](https://learn.microsoft.com/en-us/azure/databricks/release-notes/runtime/databricks-runtime-ver)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-1/dbw-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-2 - Use Databricks Pools

**Category: System Efficiency**

**Impact: High**

**Guidance**

Databricks pools are a standard feature of the service, pre-provisions VM’s instead of spinning them up on demand will help to vastly reduce risks of “provisioning” errors when starting or scaling clusters.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-2/dbw-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-3 - Use SSD backed VMs for Worker VM Type and Driver type

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

We have identified that you are using standard hard disks with your premium-capable Virtual Machines and we recommend you consider upgrading the standard-hdd disks to standard-ssd or premium disks. For any Single Instance Virtual Machine using premium storage for all Operating System Disks and Data Disks, we guarantee you will have Virtual Machine Connectivity of at least 99.9%. Consider these factors when making your upgrade decision. The first is that upgrading requires a VM reboot and this process takes 3-5 minutes to complete. The second is if the VMs in the list are mission-critical production VMs, evaluate the improved availability against the cost of premium disks.

- Premium SSD disks offer high-performance, low-latency disk support for I/O-intensive applications and production workloads.
- Standard SSD Disks are a cost effective storage option optimized for workloads that need consistent performance at lower IOPS levels.
- Use Standard HDD disks for Dev/Test scenarios and less critical workloads at lowest cost.

Standard SSDs are acceptable for some Production workloads as well.

**Resources**

- [Azure managed disk types](https://learn.microsoft.com/azure/virtual-machines/disks-types#premium-ssd)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-3/dbw-3.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-4 - Enable autoscaling for batch workloads

**Category: System Efficiency**

**Impact: High**

**Guidance**

Autoscaling allows clusters to resize automatically based on workloads. Autoscaling can benefit many use cases and scenarios from both a cost and performance perspective. The documentation provides considerations for determining whether to use Autoscaling and how to get the most benefit.

For streaming workloads, Databricks recommends using Delta Live Tables with autoscaling.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices#enable-autoscaling-for-batch-workloadss)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-4/dbw-4.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-5 - Enable autoscaling for SQL warehouse

**Category: System Efficiency**

**Impact: High**

**Guidance**

The scaling parameter of a SQL warehouse sets the minimum and the maximum number of clusters over which queries sent to the warehouse are distributed. The default is a minimum of one and a maximum of one cluster.

To handle more concurrent users for a given warehouse, increase the cluster count.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices#enable-autoscaling-for-sql-warehouse)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-5/dbw-5.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-6 - Use Delta Live Tables enhanced autoscaling

**Category: System Efficiency**

**Impact: Medium**

**Guidance**

Databricks enhanced autoscaling optimizes cluster utilization by automatically allocating cluster resources based on workload volume, with minimal impact on the data processing latency of your pipelines.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/azure/databricks/lakehouse-architecture/reliability/best-practices)
- [Databricks enhanced autoscaling](https://learn.microsoft.com/azure/databricks/delta-live-tables/settings#use-autoscaling-to-increase-efficiency-and-reduce-resource-usage)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-6/dbw-6.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-7 - Automatic Job Termination is enabled, ensure there are no user-defined local processes

**Category: Availability**

**Impact: Medium**

**Guidance**

To save cluster resources, you can terminate a cluster. The terminated cluster’s configuration is stored so that it can be reused (or, in the case of jobs, autostarted) at a later time. You can manually terminate a cluster or configure the cluster to terminate automatically after a specified period of inactivity. When the number of terminated clusters exceeds 150, the oldest clusters are deleted.
You can also set auto termination for a cluster. During cluster creation, you can specify an inactivity period in minutes after which you want the cluster to terminate.
However, The auto termination feature monitors only Spark jobs, not user-defined local processes. Therefore, if all Spark jobs have completed, a cluster may be terminated, even if local processes are running.

**Resources**

- [Best practices for reliability?](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-7/dbw-7.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-8 - Enable Logging-Cluster log delivery

**Category: Monitoring**

**Impact: Medium**

**Guidance**

When you create a cluster, you can specify a location to deliver the logs for the Spark driver node, worker nodes, and events. Logs are delivered every five minutes and archived hourly in your chosen destination. When a cluster is terminated, Azure Databricks guarantees to deliver all logs generated up until the cluster was terminated.

The destination of the logs depends on the cluster ID. If the specified destination is dbfs:/cluster-log-delivery, cluster logs for 0630-191345-leap375 are delivered to dbfs:/cluster-log-delivery/0630-191345-leap375.

**Resources**

- [Create a cluster](https://learn.microsoft.com/en-us/azure/databricks/clusters/configure#cluster-log-delivery)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-8/dbw-8.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-9 - Use Delta Lake for higher reliability

**Category: Availability**

**Impact: High**

**Guidance**

Delta Lake is an open source storage format that brings reliability to data lakes. Delta Lake provides ACID transactions, schema enforcement, scalable metadata handling, and unifies streaming and batch data processing. Delta Lake runs on top of your existing data lake and is fully compatible with Apache Spark APIs. Delta Lake on Databricks allows you to configure Delta Lake based on your workload patterns.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-9/dbw-9.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-10 - Use Photon Acceleration

**Category: Availability**

**Impact: Low**

**Guidance**

Apache Spark, as the compute engine of the Databricks Lakehouse, is based on resilient distributed data processing. In case of an internal Spark task not returning a result as expected, Apache Spark automatically reschedules the missing tasks and continues with the execution of the entire job. This is helpful for failures outside the code, like a short network issue or a revoked spot VM. Working with both the SQL API and the Spark DataFrame API comes with this resilience built into the engine.

In the Databricks Lakehouse, Photon, a native vectorized engine entirely written in C++, is high performance compute compatible with Apache Spark APIs.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices#use-apache-spark-or-photon-for-distributed-compute)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-10/dbw-10.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-11 - Automatically rescue invalid or nonconforming data with Databricks Auto Loader or Delta Live Tables

**Category: Application Resilience**

**Impact: Low**

**Guidance**

Invalid or nonconforming data can lead to crashes of workloads that rely on an established data format. To increase the end-to-end resilience of the whole process, it is best practice to filter out invalid and nonconforming data at ingestion. Supporting rescued data ensures you never lose or miss out on data during ingest or ETL. The rescued data column contains any data that wasn’t parsed, either because it was missing from the given schema, because there was a type mismatch, or the column casing in the record or file didn’t match that in the schema.

- Databricks Auto Loader: Auto Loader is the ideal tool for streaming the ingestion of files. It supports rescued data for JSON and CSV.
- Delta Live Tables: Another option to build workflows for resilience is using Delta Live Tables with quality constraints.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-11/dbw-11.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-12 - Configure jobs for automatic retries and termination

**Category: Availability**

**Impact: High**

**Guidance**

For batch and streaming inference, use Databricks jobs and MLflow to deploy models as Apache Spark UDFs to leverage job scheduling, retries, autoscaling, and so on.
Model serving provides a scalable and production-grade model real-time serving infrastructure. It processes your machine learning models using MLflow and exposes them as REST API endpoints. This functionality uses serverless compute, which means that the endpoints and associated compute resources are managed and run in the Databricks cloud account.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-12/dbw-12.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-13 - Use a scalable and production-grade model serving infrastructure

**Category: System Efficiency**

**Impact: High**

**Guidance**

For batch and streaming inference, use Databricks jobs and MLflow to deploy models as Apache Spark UDFs to leverage job scheduling, retries, autoscaling, and so on.
Model serving provides a scalable and production-grade model real-time serving infrastructure. It processes your machine learning models using MLflow and exposes them as REST API endpoints. This functionality uses serverless compute, which means that the endpoints and associated compute resources are managed and run in the Databricks cloud account.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-13/dbw-13.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-14 - Use a layered storage architecture

**Category: Application Resilience**

**Impact: Medium**

**Guidance**

Curate data by creating a layered architecture and ensuring data quality increases as data moves through the layers. A common layering approach is:

Raw layer (bronze): Source data gets ingested into the lakehouse into the first layer and should be persisted there. When all downstream data is created from the raw layer, rebuilding the subsequent layers from this layer is possible if needed.

Curated layer (silver): The purpose of the second layer is to hold cleansed, refined, filtered and aggregated data. The goal of this layer is to provide a sound, reliable foundation for analyses and reports across all roles and functions.

Final layer (gold): The third layer is created around business or project needs. It provides a different view as data products to other business units or projects, preparing data around security needs (such as anonymized data) or optimizing for performance (such as with preaggregated views). The data products in this layer are seen as the truth for the business.

The final layer should only contain high-quality data and can be fully trusted from a business point of view.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-14/dbw-14.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-15 - Improve data integrity by reducing data redundancy

**Category: Application Resilience**

**Impact: Low**

**Guidance**

Copying or duplicating data creates data redundancy and will lead to lost integrity, lost data lineage, and often different access permissions. This will decrease the quality of the data in the lakehouse. A temporary or throwaway copy of data is not harmful on its own - it is sometimes necessary for boosting agility, experimentation and innovation. However, if these copies become operational and regularly used for business decisions, they become data silos. These data silos getting out of sync has a significant negative impact on data integrity and quality, raising questions such as “Which data set is the master?” or “Is the data set up to date?”.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-15/dbw-15.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-16 - Actively manage schemas

**Category: Governance**

**Impact: Medium**

**Guidance**

Uncontrolled schema changes can lead to invalid data and failing jobs that use these data sets. Databricks has several methods to validate and enforce the schema:

- Delta Lake supports schema validation and schema enforcement by automatically handling schema variations to prevent the insertion of bad records during ingestion.
- Auto Loader detects the addition of new columns as it processes your data. By default, the addition of a new column causes your streams to stop with an UnknownFieldException. Auto Loader supports several modes for schema evolution.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-16/dbw-16.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-17 - Use constraints and data expectations

**Category: Application Resilience**

**Impact: Low**

**Guidance**

Delta tables support standard SQL constraint management clauses that ensure that the quality and integrity of data added to a table are automatically verified. When a constraint is violated, Delta Lake throws an InvariantViolationException error to signal that the new data can’t be added. See Constraints on Azure Databricks.

To further improve this handling, Delta Live Tables supports Expectations: Expectations define data quality constraints on the contents of a data set. An expectation consists of a description, an invariant, and an action to take when a record fails the invariant. Expectations to queries use Python decorators or SQL constraint clauses. See Manage data quality with Delta Live Tables.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices#use-constraints-and-data-expectations)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-17/dbw-17.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-18 - Create regular backups

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

To recover from a failure, regular backups need to be available. The Databricks Labs project migrate allows workspace admins to create backups by exporting most of the assets of their workspaces (the tool uses the Databricks CLI/API in the background). See Databricks Migration Tool. Backups can be used either for restoring workspaces or for importing into a new workspace in case of a migration.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices#create-regular-backups)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-18/dbw-18.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-19 - Recover from Structured Streaming query failures

**Category: Availability**

**Impact: High**

**Guidance**

Structured Streaming provides fault-tolerance and data consistency for streaming queries. Using Azure Databricks workflows, you can easily configure your Structured Streaming queries to restart on failure automatically. The restarted query continues where the failed one left off.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices#recover-from-structured-streaming-query-failures)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-19/dbw-19.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-20 - Recover ETL jobs based on Delta time travel

**Category: Disaster Recovery**

**Impact: Medium**

**Guidance**

Despite thorough testing, a job in production can fail or produce some unexpected, even invalid, data. Sometimes this can be fixed with an additional job after understanding the source of the issue and fixing the pipeline that led to the issue in the first place. However, often this is not straightforward, and the respective job should be rolled back. Using Delta Time travel allows users to easily roll back changes to an older version or timestamp, repair the pipeline, and restart the fixed pipeline.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices#recover-etl-jobs-based-on-delta-time-travel)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-20/dbw-20.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-21 - Use Databricks Workflows and built-in recovery

**Category: Disaster Recovery**

**Impact: Low**

**Guidance**

Databricks Workflows are built for recovery. When a task in a multi-task job fails (and, as such, all dependent tasks), Azure Databricks Workflows provide a matrix view of the runs, which lets you examine the issue that led to the failure. See View runs for a job. Whether it was a short network issue or a real issue in the data, you can fix it and start a repair run in Azure Databricks Workflows. It runs only the failed and dependent tasks and keep the successful results from the earlier run, saving time and money.

**Resources**

- [Best practices for reliability](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/reliability/best-practices)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-21/dbw-21.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-22 - Configure a disaster recovery pattern

**Category: Disaster Recovery**

**Impact: High**

**Guidance**

A clear disaster recovery pattern is critical for a cloud-native data analytics platform like Azure Databricks. For some companies, it’s critical that your data teams can use the Databricks platform even in the rare case of a regional service-wide cloud-service provider outage, whether caused by a regional disaster like a hurricane or earthquake or another source.

**Resources**

- [Azure Databricks Best Practices](https://github.com/Azure/AzureDatabricksBestPractices/tree/master)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-22/dbw-22.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-23 - Automate deployments and workloads

**Category: Automation**

**Impact: High**

**Guidance**

The Databricks Terraform provider manages Azure Databricks workspaces and the associated cloud infrastructure using a flexible, powerful tool. The goal of the Databricks Terraform provider is to support all Azure Databricks REST APIs, supporting automation of the most complicated aspects of deploying and managing your data platforms. The Databricks Terraform provider is the recommended tool to deploy and manage clusters and jobs reliably, provision Azure Databricks workspaces, and configure data access.

**Resources**

- [Best practices for operational excellence](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/operational-excellence/best-practices#2-automate-deployments-and-workloads)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-23/dbw-23.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-24 - Set up monitoring, alerting, and logging

**Category: Monitoring**

**Impact: High**

**Guidance**

The Databricks Terraform provider manages Azure Databricks workspaces and the associated cloud infrastructure using a flexible, powerful tool. The goal of the Databricks Terraform provider is to support all Azure Databricks REST APIs, supporting automation of the most complicated aspects of deploying and managing your data platforms. The Databricks Terraform provider is the recommended tool to deploy and manage clusters and jobs reliably, provision Azure Databricks workspaces, and configure data access.

**Resources**

- [Best practices for operational excellence](https://learn.microsoft.com/en-us/azure/databricks/lakehouse-architecture/operational-excellence/best-practices#system-monitoring)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-24/dbw-24.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-25 - Deploy workspaces in separate Subscriptions

**Category: System Efficiency**

**Impact: High**

**Guidance**

Customers commonly partition workspaces based on teams or departments and arrive at that division naturally. But it is also important to partition keeping Azure Subscription and ADB Workspace limits in mind.

**Resources**

- [Azure Databricks Best Practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md#deploy-workspaces-in-multiple-subscriptions-to-honor-azure-capacity-limits)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-25/dbw-25.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-26 - Isolate each workspace in its own Vnet

**Category: System Efficiency**

**Impact: High**

**Guidance**

While you can deploy more than one Workspace in a VNet by keeping the associated subnet pairs separate from other workspaces, we recommend that you should only deploy one workspace in any Vnet. Doing this perfectly aligns with the ADB's Workspace level isolation model. Most often organizations consider putting multiple workspaces in the same Vnet so that they all can share some common networking resource, like DNS, also placed in the same Vnet because the private address space in a vnet is shared by all resources. You can easily achieve the same while keeping the Workspaces separate by following the hub and spoke model and using Vnet Peering to extend the private IP space of the workspace Vnet.

**Resources**

- [Azure Databricks Best Practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md#consider-isolating-each-workspace-in-its-own-vnet)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-26/dbw-26.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-27 - Do not Store any Production Data in Default DBFS Folders

**Category: Availability**

**Impact: High**

**Guidance**

This recommendation is driven by security and data availability concerns. Every Workspace comes with a default DBFS, primarily designed to store libraries and other system-level configuration artifacts such as Init scripts. You should not store any production data in it, because:

- The lifecycle of default DBFS is tied to the Workspace. Deleting the workspace will also delete the default DBFS and permanently remove its contents.
- One can't restrict access to this default folder and its contents.

**Resources**

- [Azure Databricks Best Practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md#do-not-store-any-production-data-in-default-dbfs-foldersr)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-27/dbw-27.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### DBW-28 - Do not use Azure Sport VMs for critical Production workloads

**Category: Availability**

**Impact: High**

**Guidance**

Azure Spot VMs are not recommended for critical production workloads that require high availability and reliability. Azure Spot VMs are designed for workloads that are fault-tolerant and can tolerate interruptions. The amount of available capacity can vary based on size, region, time of day, and more. When deploying Azure Spot Virtual Machines, Azure will allocate the VMs if there's capacity available, but there's no SLA for these VMs. An Azure Spot Virtual Machine offers no high availability guarantees. At any point in time when Azure needs the capacity back, the Azure infrastructure will evict Azure Spot Virtual Machines with 30-seconds notice.

**Resources**

- [Use Azure Spot Virtual Machines](https://learn.microsoft.com/en-us/azure/virtual-machines/spot-vms)

**Resource Graph Query**

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/dbw-28/dbw-28.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
