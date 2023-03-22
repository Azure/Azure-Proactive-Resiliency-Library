+++
title = "{{ replace .Name "-" " " | title }}"
description = "{{ replace .Name "-" " " | title }} Services"
date = "{{ .Date | time.Format ":date_short" }}"
author = "CHANGE ME TO YOUR GITHUB USERNAME"
msAuthor = "CHANGE ME TO YOUR MICROSOFT ALIAS"
draft = false
+++

This page lists all of the Azure Services under the {{ replace .Name "-" " " | title }} category for which the APRL has guidance, recommendations and queries for.

## Services List

{{< alert style="info" >}}

The below list of services is automatically populated based on the child folders and files in this directory within the source code in the repo.

{{< /alert >}}

{{< childpages >}}
