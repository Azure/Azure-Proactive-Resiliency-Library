# Powershell
# Verifies if DeleteRetentionPolicy is enabled on a storage account
# Set the Subscription ID for the variable $subid
login-azaccount
$subid = ""
select-AzSubscription -Subscription $subid
$stgs = Get-AzStorageAccount
foreach ($st in $stgs){
    $ResourceGroupName = $st.ResourceGroupName
    $StorageAccountNameName = $st.StorageAccountName
    $DeleteRetentionPolicy = (Get-AzStorageBlobServiceProperty -ResourceGroupName $st.ResourceGroupName -StorageAccountName $st.StorageAccountName).DeleteRetentionPolicy.Enabled
    if ($DeleteRetentionPolicy -eq $false -or $DeleteRetentionPolicy -eq $null){
        Write-Output "---------------------------------------------------------"
        Write-Output ("st-7;" + $StorageAccountNameName + ";" +  $st.id + ";DeleteRetentionPolicy: False")
    }
}
