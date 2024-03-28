# Powershell
# Verifies if versioning is enabled on a storage account
# Set the Subscription ID for the variable $subid
login-azaccount
$subid = ""
select-AzSubscription -Subscription $subid
$stgs = Get-AzStorageAccount
foreach ($st in $stgs){
    $ResourceGroupName = $st.ResourceGroupName
    $StorageAccountNameName = $st.StorageAccountName
    $IsVersioningEnabled = (Get-AzStorageBlobServiceProperty -ResourceGroupName $st.ResourceGroupName -AccountName $st.StorageAccountName).IsVersioningEnabled
    if ($IsVersioningEnabled -eq $null){
        Write-Output "---------------------------------------------------------"
        Write-Output ("st-6;" + $StorageAccountNameName + ";" +  $st.id + ";IsVersioningEnabled: Null")
    }
}
