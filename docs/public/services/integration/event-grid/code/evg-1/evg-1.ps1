#Pulls a list of all event grid resources without diagnostic settings configured.
$NeedsDiagnosticSetting = @()
$subscriptions = Get-azsubscription

foreach ($subscription in $subscriptions){
    set-azcontext $subscription | Out-Null

    $EventGridResources = @()
    $EventGridResources += get-azresource -Resourcetype "microsoft.eventgrid/systemtopics"
    $EventGridResources += get-azresource -Resourcetype "microsoft.eventgrid/topics"
    $EventGridResources += get-azresource -Resourcetype "microsoft.eventgrid/domains"

    foreach ($resource in $EventGridResources){
        $result = Get-AzDiagnosticSetting -resourceid $resource.resourceid
        If ($result -eq $null) {$NeedsDiagnosticSetting += $resource}
    }
}

$NeedsDiagnosticSetting | select Name, ResourceType, ResourceGroupName, Location, ResourceID | format-table
