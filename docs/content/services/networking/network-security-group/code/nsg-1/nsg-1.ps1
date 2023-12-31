# Azure PowerShell Script
# Find all Network Security Groups without diagnostic settings configured.
Get-AzNetworkSecurityGroup |
    Where-Object -FilterScript {
        (Get-AzDiagnosticSetting -ResourceId $_.Id) -eq $null
    } |
    ForEach-Object -Process {
        $nsg = $_
        [PSCustomObject] @{
            recommendationId = 'nsg-1'
            name             = $nsg.Name
            id               = $nsg.Id
            tags             = if ($nsg.Tag) { ($nsg.Tag.GetEnumerator() |% { "{""$($_.Key)"":""$($_.Value)""}" }) -join ',' } else { '' }
            param1           = 'DiagnosticSetting: Disabled'
        }
    }
