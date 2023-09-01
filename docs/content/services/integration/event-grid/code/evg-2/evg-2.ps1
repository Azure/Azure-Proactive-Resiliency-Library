#Pulls a list of all event grid subscriptions without dead letter configured.
$NeedsDeadLetter = @()
$subscriptions = Get-azsubscription

foreach ($subscription in $subscriptions){
    set-azcontext $subscription | Out-Null

    $EventGridSub = (Get-AzEventGridSubscription).PsEventSubscriptionsList

    foreach ($resource in $EventGridSub){
        $result = $resource.DeadLetterEndpoint
        If ($result -eq $null) {$NeedsDeadLetter += $resource}
    }
}

$NeedsDeadLetter | select EventSubscriptionName, Type, ID | format-table
