# Powershell
# Verifies the current ShareDeleteRetentionPolicy setting for a storage account
# Set variable values to approroriate storage account and resource group
$storageAccount = "StorageAccountName"
$resourceGroupName = "ResourceGroupName"
Get-AzStorageFileServiceProperty -ResourceGroupName $resourceGroupName -AccountName $storageAccount  | Select-Object ShareDeleteRetentionPolicy | Format-Custom
