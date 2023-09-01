#Pulls a list of all Route Tables without a resource lock configured.
$NeedsResourceLock = @()
$subscriptions = Get-azsubscription

foreach ($subscription in $subscriptions){
    set-azcontext $subscription | Out-Null

    $RouteTables= Get-AzRouteTable
    $ResourceLocks = Get-AzResourceLock
    $RouteTableLocks = $ResourceLocks | where{$_.resourcetype -eq "Microsoft.Network/routeTables"}
    $ResourceGroupLocks = $ResourceLocks | where{$_.resourcetype -eq "Microsoft.Authorization/locks"}
    foreach ($resource in $RouteTables){
      If ($routetablelocks.resourcename -notcontains $resource.name -and $ResourceGroupLocks.ResourceGroupName -notcontains $resource.ResourceGroupName){$NeedsResourceLock += $resource}
    }
}

$NeedsResourceLock | select Name, ResourceType, ResourceGroupName, Location, ID | format-table
