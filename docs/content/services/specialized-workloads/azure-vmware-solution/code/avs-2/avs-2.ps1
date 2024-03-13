# Azure PowerShell script
# Provides a list of private clouds that don't have a diagnostic setting configured to export the logs
$output = @()
$privateClouds = get-AzVMwarePrivateCloud
foreach ($privateCloud in $privateClouds) {
    $ds = Get-AzDiagnosticSetting -ResourceId $privateCloud.id

    if (!$ds) {
        $output += [PSCustomObject] @{ #no diagnostic settings values
            recommendationId = 'aks-2'
            name             = $privateCloud.Name
            id               = $privateCloud.Id
            tags             = if ($privateCloud.tag) { $privateCloud.tag } else { $null }
            param1           = 'exportSyslogWithDiagnosticSetting:false'
        }
    }

    if ($ds) {
        $fixFlag = $false
        foreach ($log in $ds.log) { #diagnostic settings exist but not for logs
            if (($log.CategoryGroup -eq "allLogs") -and ($log.Enabled -eq $false)){ $fixFlag = $true}
            if (($log.Category -eq "vmwaresyslog") -and ($log.Enabled -eq $false)){ $fixFlag = $true}
        }
        if ($fixFlag){
            $output += [PSCustomObject] @{
                recommendationId = 'aks-2'
                name             = $privateCloud.Name
                id               = $privateCloud.Id
                tags             = if ($privateCloud.tag) { $privateCloud.tag } else { $null }
                param1           = 'exportSyslogWithDiagnosticSetting:false'
            }
        }
    }
}

$output
