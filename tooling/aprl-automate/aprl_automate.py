import json
import os
import fnmatch
import re
import argparse
import pandas as pd

from datetime import datetime
from concurrent.futures import ThreadPoolExecutor

# Import Azure Resource Graph library
import azure.mgmt.resourcegraph as arg

# Import specific methods and models from other libraries
from azure.identity import AzureCliCredential

# Concurrency for running queries
_max_workers = 5

# Parse command line arguments
def parseArguments():
  parser = argparse.ArgumentParser(description='This tool runs all of the Azure Proactive Resiliency Library queries based on the Azure resource types present in a given subscription.')
  parser.add_argument('-s', '--id', type=str, required=True, help='Subscription ID')
  parser.add_argument('-p', '--path', type=str, required=False, help='Path to APRL queries', default='../../docs/content/services')
  parser.add_argument('-j', '--json', action="store_true", required=False, help='Output to JSON file instead of CSV')
  parser.add_argument('-e', '--exclude-errors', action="store_true", required=False, help='Exclude queries that return errors from output')
  parser.add_argument('-w', '--workers', type=int, required=False, help='Number of concurrent workers', default='5')

  args = parser.parse_args()

  return args

# Query Azure Resource Graph
def queryAzureResourceGraph(query, subscriptionId):
  # Get your credentials from Azure CLI (development only!) and get your subscription list
  credential = AzureCliCredential()

  # Create Azure Resource Graph client and set options
  argClient = arg.ResourceGraphClient(credential)
  argQueryOptions = arg.models.QueryRequestOptions(result_format="objectArray")

  # Create query
  argQuery = arg.models.QueryRequest(subscriptions=[subscriptionId], query=query, options=argQueryOptions)

  # Run query
  argResults = argClient.resources(argQuery)

  # Show Python object
  return argResults

# Get a list of all resource types in subscription list
def getResourceTypes(subscriptionId):
  query = "Resources | summarize by type"
  results = queryAzureResourceGraph(query=query, subscriptionId=subscriptionId)
  return results.data

# Get a list of all APRL queries
def getAprlQueries(path):
  includes = ['*.kql']
  excludes = []
  queries = {}

  for root, dirs, files in os.walk(path, topdown=True):
    # excludes can be done with fnmatch.filter and complementary set,
    # but it's more annoying to read.
    dirs[:] = [d for d in dirs if d not in excludes]
    for pat in includes:
      for file in fnmatch.filter(files, pat):
        with open(os.path.join(root, file), "r") as f:
          content = f.read()

          for x in re.split('\||and', content):
            if x.lower().strip().startswith("where type ="):
              resourceType = x.split("=")[-1].replace('=', '').replace('~', '').replace('\'','').replace('\"','').strip().lower()

              if resourceType not in queries:
                queries[resourceType] = []

              text_part = file.replace('.kql', '').split('-')[0].upper()
              num_part = re.sub(r"\D", '', file).zfill(2)

              query = {
                "id": f"{text_part}-{num_part}",
                "kql": content
              }

              queries[resourceType].append(query)

              # Only need to find the first resource type
              break;
  return queries

def runAprlQuery(query, subscriptionId):
  print(f"Running APRL query: {query['id']}")

  results = []
  error = ""

  try:
    argResults = queryAzureResourceGraph(query['kql'], subscriptionId)
    results = argResults.data
  except Exception as e:
    error = f"Error: {str(e)}"
    #print(error)

  affectedResources = []
  for result in results:
    if 'id' in result:
      affectedResources.append(result['id'])
    elif 'name' in result:
      affectedResources.append(result['name'])

  affectedResources = sorted(list(set(affectedResources)))

  aprlQueryResult = {
    "id": query['id'],
    "count": len(results),
    "affectedResources": affectedResources,
    "results": results,
    "error": error,
  }

  return aprlQueryResult

# Run APRL queries for each resource type found in subscription
def runAprlQueries(resourceTypes, subscriptionId):

  # Get a list of all APRL queries
  aprlQueries = getAprlQueries(pathToServices)

  now = datetime.now()
  dt_string = now.strftime("%m/%d/%Y %H:%M:%S")

  aprlQueryResults = {
    "name": "Azure Proactive Resiliency Library Queries",
    "date": dt_string,
    "subscriptionId": subscriptionId,
    "queries": []
  }

  # Loop through each resource type and run the queries
  for item in resourceTypes:
    resourceType = item['type'].lower()
    if resourceType in aprlQueries:
      with ThreadPoolExecutor(max_workers=_max_workers) as executor:
        futures = [executor.submit(runAprlQuery, query=query, subscriptionId=subscriptionId) for query in aprlQueries[resourceType]]
        for future in futures:
            aprlQueryResult = future.result()
            if args.exclude_errors:
              if aprlQueryResult['error'] != "":
                continue
            aprlQueryResults['queries'].append(aprlQueryResult)

  # Sort the results by query name with padded numberic part to two digits
  aprlQueryResults['queries'] = sorted(aprlQueryResults['queries'], key=lambda x: x['id'])

  return aprlQueryResults

def OutputToJsonFile(filename, data):
  # Write the results to a file
  with open(filename, "w") as f:
      json.dump(data, f, indent=2)

def OutputToCsvFile(filename, data):

  df = pd.DataFrame(data['queries'])

  # convert affectedResources column to a string
  df['affectedResources'] = df['affectedResources'].apply(lambda x: '\n'.join(x)).astype(str)

  # convert error column to a string
  df['results'] = df['results'].astype(str)

  # convert error column to a string
  df['error'] = df['error'].astype(str)

  # Save the DataFrame to a CSV file
  df.to_csv(filename, index=False, header=True)

### Main ###

# Parse the command line arguments
args = parseArguments()

subscriptionId = args.id
pathToServices = args.path
_max_workers = args.workers

# Get a list of all resource types in subscription list
resourceTypes = getResourceTypes(subscriptionId)

# Run APRL queries for each resource type found in subscription
aprlQueriesResults = runAprlQueries(resourceTypes, subscriptionId)

# Output the results to file
if args.json:
  OutputToJsonFile(f"aprlQueryResults_{subscriptionId}.json", aprlQueriesResults)
else:
  OutputToCsvFile(f"aprlQueryResults_{subscriptionId}.csv", aprlQueriesResults)

print("Done!")
