# Azure PowerShell Script
# Find all Network Security Groups without resource locks configured.
$resourceLockScopes = Get-AzResourceLock |
    Where-Object {
        ($_.ResourceType -eq 'Microsoft.Network/networkSecurityGroups') -or  # Lock for Network Security Group
        ($_.ResourceType -eq 'Microsoft.Authorization/locks')                # Lock for Resource Group
    } |
    Select-Object -ExpandProperty 'ResourceId' |
    ForEach-Object -Process {
        $_.Remove($_.LastIndexOf('/providers/Microsoft.Authorization/locks'))
    }

Get-AzNetworkSecurityGroup | ForEach-Object -Process {
    $nsg = $_
    $nsgHasLock = $false
    foreach ($scope in $resourceLockScopes) {
        $nsgHasLock = ($nsg.Id -eq $scope) -or $nsg.Id.StartsWith($scope)
        if ($nsgHasLock) { break }
    }
    if (-not $nsgHasLock) {
        [PSCustomObject] @{
            recommendationId = 'nsg-3'
            name             = $nsg.Name
            id               = $nsg.Id
            tags             = if ($nsg.Tag) { ($nsg.Tag.GetEnumerator() | ForEach-Object -Process { "{""$($_.Key)"":""$($_.Value)""}" }) -join ',' } else { '' }
        }
    }
}
