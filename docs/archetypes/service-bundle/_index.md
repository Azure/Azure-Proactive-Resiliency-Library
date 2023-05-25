+++
title = "{{ replace .Name "-" " " | title }}"
description = "Best practices and resiliency recommendations for {{ replace .Name "-" " " | title }} and associated resources."
date = "{{ .Date | time.Format ":date_short" }}"
author = "CHANGE ME TO YOUR GITHUB USERNAME"
msAuthor = "CHANGE ME TO YOUR MICROSOFT ALIAS"
draft = false
+++

The presented resiliency recommendations in this guidance include {{ replace .Name "-" " " | title }} and associated settings.

## Summary of Recommendations

{{< table style="table-striped" >}}
| Recommendation                                    |  Impact  |  State   | ARG Query Available |
| :------------------------------------------------ | :------: | :------: | :-----------------: |
| [CM-1 - CHANGE ME title](#cm-1---change-me-title) | High/Medium/Low | Preview  |         Yes         |
| [CM-2 - CHANGE ME title](#cm-2---change-me-title) | High/Medium/Low | Verified |         No          |
{{< /table >}}

{{< alert style="info" >}}

Definitions of states can be found [here]({{< ref "../../../_index.md#definitions-of-terms-used-in-aprl">}})

{{< /alert >}}

## Recommendations Details

### CM-1 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-1/cm-1.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>

### CM-2 - CHANGE ME title

#### Impact: CHANGE ME

#### Recommendation/Guidance

FILL ME IN...

##### Resources

- [CHANGE ME LINK](https://aka.ms)
- [CHANGE ME LINK](https://aka.ms)

#### Queries/Scripts

##### Azure Resource Graph

{{< collapse title="Show/Hide Query/Script" >}}

{{< code lang="sql" file="code/cm-2/cm-2.kql" >}} {{< /code >}}

{{< /collapse >}}

<br><br>
