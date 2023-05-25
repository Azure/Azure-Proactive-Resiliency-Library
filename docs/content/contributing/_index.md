+++
title = "Contributing"
description = "Contribution Guide for the Azure Proactive Resiliency Library (APRL)"
weight = 2
+++
{{< panel title="Contributions Notice" style="warning" >}} Currently we can only accept contributions from Microsoft FTEs. In the future we will look to change this. {{< /panel >}}

Looking to contribute to the Azure Proactive Resiliency Library (APRL), well you have made it to the right place/page 👍

Follow the below instructions, especially the pre-requisites, to get started contributing to the library.

## Context/Background

Before jumping into the pre-requisites and specific section contribution guidance, please familiarize yourself with this context/background on how this library is built to help you contribute going forward.

This [site](https://aka.ms/aprl) is built using [Hugo](https://gohugo.io/), a static site generator, that's source code is stored in the [APRL GitHub repo](https://aka.ms/aprl/repo) (link in header of this site too) and is hosted on [GitHub Pages](https://pages.github.com), via the repo.

The reason for the combination of Hugo & GitHub pages is to allow us to present an easy to navigate and consume library, rather than using a native GitHub repo, which is not easy to consume when there are lots of pages and folders. Also Hugo generates the site in such a way that it is also friendly for mobile consumers.

### But I don't have any skills in Hugo?

That's okay and you really don't need them. Hugo just needs you to be able to author markdown (`.md`) files and it does the rest when it generates the site 👍

## Pre-Requisites

Read and follow the below sections to leave you in a "ready state" to contribute to APRL.

A "ready state" means you have a forked copy of the [`Azure/Azure-Proactive-Resiliency-Library` repo](https://aka.ms/aprl/repo) cloned to your local machine and open in VS Code.

## Run and Access a Local Copy of APRL During Development

When in VS Code you should be able to open a terminal and run the below commands to access a copy of the APRL website from a local web server, provided by Hugo, using the following address [`http://localhost:1313/Azure-Proactive-Resiliency-Library/`](http://localhost:1313/Azure-Proactive-Resiliency-Library/):

{{< code lang="text" >}}cd docs
hugo server -D
{{< /code >}}

### Software/Applications

To contribute to this project/repo/library you will need the following installed:

{{< alert style="success" >}}
You can use `winget` to install all the pre-requisites easily for you. See the [below section](#winget-install-commands)
{{< /alert >}}

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Visual Studio Code (VS Code)](https://code.visualstudio.com/Download)
  - Extensions:
    - `editorconfig.editorconfig`, `streetsidesoftware.code-spell-checker`, `ms-vsliveshare.vsliveshare`, `medo64.render-crlf`, `vscode-icons-team.vscode-icons`
    - VS Code will recommend automatically to install these when you open this repo, or a fork of it, in VS Code.
- [Hugo Extended](https://gohugo.io/installation/)

### winget Install Commands

To install `winget` follow the [install instructions here.](https://learn.microsoft.com/windows/package-manager/winget/#install-winget)

{{< code lang="text" >}}winget install --id 'Git.Git'
winget install --id 'Microsoft.VisualStudioCode'
winget install --id 'Hugo.Hugo.Extended'
{{< /code >}}

### Other requirements

- [A GitHub profile/account](https://github.com/join)
- A fork of the [`Azure/Azure-Proactive-Resiliency-Library` repo](https://aka.ms/aprl/repo) into your GitHub org/account and cloned locally to your machine
  - Instructions on forking a repo and then cloning it can be found [here](https://docs.github.com/get-started/quickstart/fork-a-repo)

## Useful Resources

Below are links to a number of useful resources to have when contributing to APRL:

- [Ace Documentation Theme (that we use) - Docs](https://docs.vantage-design.com/ace/)
  - [Shortcodes - e.g. Code](https://docs.vantage-design.com/ace/shortcodes/)
- [Ace Documentation Theme (that we use) - Repo](https://github.com/vantagedesign/ace-documentation)
  - [The Example Site, which is the first link above, source code](https://github.com/vantagedesign/ace-documentation/tree/master/exampleSite)
- [Hugo Quick Start](https://gohugo.io/getting-started/quick-start/)
- [Hugo Docs](https://gohugo.io/documentation/)
- [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)

## Steps to do before contributing anything (after pre-requisites)

Run the following commands in your terminal of choice from the directory where you fork of the repo is located:

{{< code lang="text" >}}git checkout main
git pull
git fetch -p
git fetch -p upstream
git pull upstream main
git push
{{< /code >}}

Doing this will ensure you have the latest changes from the upstream repo and you are ready to now create a new branch from `main` by running the below commands:

{{< code lang="text" >}}git checkout main
git checkout -b <YOUR-DESIRED-BRANCH-NAME-HERE>
{{< /code >}}

## Creating a Service's Recommendation Page

{{< panel title="Important" style="danger" >}}
Make sure you have followed the the [Steps to do before contributing anything (after pre-requisites)](#steps-to-do-before-contributing-anything-after-pre-requisites) before following this section.
{{< /panel >}}

The is a common task that is likely to be done is adding a new service to which you want to provide recommendations and supporting queries etc. for example Virtual Machines.

For this task we use [Hugo's archetype](https://gohugo.io/content-management/archetypes/) features which enables you to create a whole directory for a new service with a lot of templated content ready for you to change and use. This can be called by using the following command `hugo new --kind service-bundle services/<category>/<service-name`

You can see source code of the directory archetype called `service-bundle` [here in the repo.](https://github.com/Azure/Azure-Proactive-Resiliency-Library/tree/main/docs/archetypes/service-bundle)

{{< alert style="info" >}}
For the steps below we will use the Virtual Machine service as an example. Please change this to the service you are wanting to create.
{{< /alert >}}

Steps to follow:

1. In your terminal of choice run the following:
{{< code lang="text" >}}cd docs/
hugo new --kind service-bundle services/compute/virtual-machines
{{< /code >}}
2. You will now see a new folder in `content/services/compute` called `virtual-machines`
{{< code lang="text" >}}├───content
│   ├───contributing
│   └───services
│       ├───ai-ml
│       ├───compute
│       │   └───virtual-machines
│       │       └───code
│       │           ├───cm-1
│       │           └───cm-2
{{< /code >}}
3. Inside the `virtual-machines` folder you will see the following files pre-staged
{{< code lang="text" >}}│       │   └───virtual-machines
│       │       │   _index.md
│       │       │
│       │       └───code
│       │           ├───cm-1
│       │           │       cm-1.azcli
│       │           │       cm-1.kql
│       │           │       cm-1.ps1
│       │           │
│       │           └───cm-2
│       │                   cm-2.azcli
│       │                   cm-2.kql
│       │                   cm-2.ps1
{{< /code >}}
4. Open `_index.md` in VS Code and make relevant changes
    - You can copy the recommendations labelled `CM-1` or `CM-2` multiple times to create more recommendations
5. Update the ARG, PowerShell, AZCLI scripts in the `code` folder within `virtual-machines`
    - You will see there is a folder, e.g. `cm-1`, `cm-2`, per recommendation to help with file structure organization
6. Save, commit and push your changes to your branch and repo
7. Create a [create a Pull Request](https://docs.github.com/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) into the `main` branch of the upstream repo
8. Get it merged

{{< alert style="success" >}}
Don't forget you can see your changes live by running a local copy of the APRL website by following the guidance [here.](#run-and-access-a-local-copy-of-aprl-during-development)
{{< /alert >}}

## Updating a Service's Recommendation Page

{{< panel title="Important" style="danger" >}}
Make sure you have followed the the [Steps to do before contributing anything (after pre-requisites)](#steps-to-do-before-contributing-anything-after-pre-requisites) before following this section.
{{< /panel >}}

This is likely the most common task that will be performed.

All you need to do is just make edits directly to the existing markdown (`.md`) files, save your changes, commit, stage and push them to your branch and repo. Then [create a Pull Request](https://docs.github.com/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) into the `main` branch of the upstream repo and you are done 👍

{{< alert style="success" >}}
Don't forget you can see your changes live by running a local copy of the APRL website by following the guidance [here.](#run-and-access-a-local-copy-of-aprl-during-development)
{{< /alert >}}

## Creating a Service Category

{{< panel title="Important" style="danger" >}}
Make sure you have followed the the [Steps to do before contributing anything (after pre-requisites)](#steps-to-do-before-contributing-anything-after-pre-requisites) before following this section.
{{< /panel >}}

For this task we use [Hugo's archetype](https://gohugo.io/content-management/archetypes/) features which enables you to create a whole directory for a new service with a lot of templated content ready for you to change and use. This can be called by using the following command `hugo new --kind category-bundle services/<category>`

You can see source code of the directory archetype called `category-bundle` [here in the repo.](https://github.com/Azure/Azure-Proactive-Resiliency-Library/tree/main/docs/archetypes/category-bundle)

{{< alert style="info" >}}
For the steps below we will use the AAA category as an example. Please change this to the category you are wanting to create.
{{< /alert >}}

Steps to follow:

1. In your terminal of choice run the following:
{{< code lang="text" >}}cd docs/
hugo new --kind category-bundle services/aaa
{{< /code >}}
2. You will now see a new folder in `content/services` called `aaa`
{{< code lang="text" >}}├───content
│   │   _index.md
│   │
│   ├───contributing
│   │       _index.md
│   │
│   └───services
│       │   _index.md
│       │
│       ├───aaa
│       │       _index.md
{{< /code >}}
3. Inside the `aaa` folder you will see the following file `_index.md` pre-staged
{{< code lang="text" >}}├───aaa
│       │       _index.md
{{< /code >}}
4. Open `_index.md` in VS Code and make relevant changes
5. Save, commit and push your changes to your branch and repo
6. Create a [create a Pull Request](https://docs.github.com/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) into the `main` branch of the upstream repo
7. Get it merged

{{< alert style="success" >}}
Don't forget you can see your changes live by running a local copy of the APRL website by following the guidance [here.](#run-and-access-a-local-copy-of-aprl-during-development)
{{< /alert >}}

## Top Tips

1. Sometimes the local version of the website may show some inconsistencies that don't reflect the content you have created.
     - If this happens, simply kill the Hugo local web server by pressing <kbd>CTRL</kbd>+<kbd>C</kbd> and then restart the Hugo web server by running `hugo server -D` from the `docs/` directory

