# APRL Automation Tool (aprl-automate)

This tool runs all of the Azure Proactive Resiliency Library queries based on the Azure resource types present in a given subscription and outputs the results to a file in a CSV (default) or JSON format.

```
aprl-automate> python aprl_automate.py --help
usage: aprl_automate.py [-h] -s ID [-p PATH] [-j] [-e] [-w WORKERS]

This tool runs all of the Azure Proactive Resiliency Library queries based on the Azure resource types present in a given subscription.

options:
  -h, --help            show this help message and exit
  -s ID, --id ID        Subscription ID
  -p PATH, --path PATH  Path to APRL queries
  -j, --json            Output to JSON file instead of CSV
  -e, --exclude-errors  Exclude queries that return errors from output
  -w WORKERS, --workers WORKERS
                        Number of concurrent workers
```

## Installation

### Software Requirements:
- Python     >= 3.11.x
- pip        >= 23.2.x
- Azure CLI  >= 2.52.0

#### Setting up the Python environment:
> **_NOTE:_**  Installation starts with cloning of this repo.  The following commands are run from the 'tooling/aprl-automate' folder.  If you run the script from a different directory, you will need to add the '--path' parameter to point to where files in 'docs/content/services' of this repo are located on your local machine.  Access to the subscription being queried is based on your active Azure CLI credentials.

```
aprl-automate> python -m venv .venv
aprl-automate> ./.venv/Scripts/activate
(.venv) aprl-automate> pip install -r requirements.txt
```

#### Running the aprl-automate command
```
(.venv) aprl-automate> az login
(.venv) aprl-automate> python aprl_automate.py --id 00000000-0000-0000-0000-000000000000 --exclude-errors
``````
## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft
trademarks or logos is subject to and must follow
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
