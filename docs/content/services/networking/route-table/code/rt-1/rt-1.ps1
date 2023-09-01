#Pulls a list of all Route Tables without an alert configured for modifications.
$NeedsActivityAlerts = @()
$subscriptions = Get-azsubscription

foreach ($subscription in $subscriptions){
    set-azcontext $subscription | Out-Null
    $RouteTables= Get-AzRouteTable
    $ActivityLogAlerts = Get-AzActivityLogAlert | where {$_.scope-match "routeTables"}
    $AlertsEnabled = @()
    foreach ($resource in $RouteTables){
        foreach($Alert in $ActivityLogAlerts){
          if($Alert.scope -match $resource.name){$AlertsEnabled+=$resource}
        }
    }
    foreach ($RT in $RouteTables){
      if($AlertsEnabled.name -notcontains $rt.name){$NeedsActivityAlerts+=$RT}
    }
}

$NeedsActivityAlerts | select Name, ResourceType, ResourceGroupName, Location, ID | format-table
