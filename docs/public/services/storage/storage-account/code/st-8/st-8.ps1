# Powershell
# Verifies if DiagnosticSettings is enabled on a storage account
# Set the Subscription ID for the variable $subid
login-azaccount
$subid = ""
select-AzSubscription -Subscription $subid
$stgs = Get-AzStorageAccount
foreach ($st in $stgs){
    $ResourceGroupName = $st.ResourceGroupName
    $StorageAccountNameName = $st.StorageAccountName
    $diag = (Get-AzDiagnosticSetting -ResourceId  "/subscriptions/$subid/resourceGroups/$ResourceGroupName/providers/Microsoft.Storage/storageAccounts/$StorageAccountNameName").Id
    if ($diag -eq $null){
        Write-Output "---------------------------------------------------------"
        Write-Output ("st-9;" + $StorageAccountNameName + ";" +  $st.id + ";DiagnosticSettings: Null")
    }
}
