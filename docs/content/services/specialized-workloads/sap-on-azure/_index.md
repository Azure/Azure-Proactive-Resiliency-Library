+++
title = "Sap on Azure"
description = "Best practices and resiliency recommendations for Sap on Azure and associated resources and settings."
date = "2/5/24"
author = "PMeshramPM"
msAuthor = "pameshra"
draft = false
+++

The presented resiliency recommendations in this guidance include Sap on Azure and associated resources and settings.

For Well Architected Reliability Assessment for SAP, Please leverage [SAP ACSS](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/overview) checks.

[SAP ACSS](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/overview) runs quality checks for all Virtual Instances for SAP solutions (VIS). The Quality Insights Azure workbook in Azure Center for SAP solutions offers insights on SAP system resources through over 100 quality checks on VIS, ensuring adherence to Azure and SAP best practices for reliability and performance monitoring. If a VIS is not configured as per the different best practices, you will see a corresponding recommendation in Azure Advisor.

- Encourage the customer team to implement ACSS (Azure Center for SAP Solutions) before the workshop.
   If ACSS (Azure Center for SAP Solutions) is available in the given Azure region and implemented, use the integrated [ACSS Quality Insights](https://learn.microsoft.com/en-us/azure/sap/center-sap-solutions/get-quality-checks-insights).

- Otherwise, use the standalone [SAP QualityCheck](https://github.com/Azure/SAP-on-Azure-Scripts-and-Utilities/tree/main/QualityCheck) tool from GitHub directly. This is the original and open-source version of SAP Quality Insights,and can be used if the customer hasn't implemented ACSS


