+++
title = "Specialized Workloads"
description = "Specialized Workloads Services"
date = 2023-03-21T10:12:16Z
draft = false
+++

This page lists all of the Azure Services under the Specialized Workloads category for which the APRL has guidance, recommendations and queries for.

## Services List

{{< alert style="info" >}}

The below list of services is automatically populated based on the child folders and files in this directory within the source code in the repo.

{{< /alert >}}

{{< childpages >}}



Well Architected Reliability Assessment for SAP is a combination of [WARA v3](https://eng.ms/docs/microsoft-customer-partner-solutions-mcaps-core/customer-experience-and-support/customer-success/azure-core/resource-center/waf/reliability/wara_v3/0_engagement_overview) checks, [SAP ACSS](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/overview) checks & SAP Checklist. 

[SAP ACSS](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/overview) runs quality checks for all Virtual Instances for SAP solutions (VIS). The Quality Insights Azure workbook in Azure Center for SAP solutions offers insights on SAP system resources through over 100 quality checks on VIS, ensuring adherence to Azure and SAP best practices for reliability and performance monitoring. If a VIS is not configured as per the different best practices, you will see a corresponding recommendation in Azure Advisor.

 - Encourage the customer team to implement ACSS (Azure Center for SAP Solutions) before the workshop. 
   If ACSS (Azure Center for SAP Solutions) is available in the given Azure region and implemented, use the integrated [ACSS Quality Insights](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights). 

 - Otherwise, use the standalone [SAP QualityCheck](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) tool from GitHub directly. This is the original and open-source version of SAP Quality Insights,
   and can be used if the customer hasn't implemented ACSS. 

 - Work with the customer/partner to complete the [SAP Checklist](https://microsoft.sharepoint.com/teams/ASDIPRelease/IP%20Release/Forms/AllItems.aspx?id=%2Fteams%2FASDIPRelease%2FIP%20Release%2FSecure%20Infrastructure%2FVBD%2FMigration%20and%20modernizing%20to%20S4HANA%20via%20RISE%20with%20SAP%20or%20Azure%20native%2FGoLive). Anything that's either non implemented or only partially implemented should be flagged with commentary.

For more detailed Steps – please refer to [Well Architected Review and Remediate for SAP VBD](https://eng.ms/docs/microsoft-customer-partner-solutions-mcaps-core/customer-experience-and-support/customer-success/azure-core/resource-center/vbd/sap/warr_sap/overview)
