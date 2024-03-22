# Azure PowerShell script
# Lists Service Health Alerts, if not all event types have been configured
$subscription = (Get-AzContext).Subscription
$alertConfiguration = [PSCustomObject]@{
  ServiceIssueConfigured       = $false
  ServiceAdvisoryConfigured    = $false
  PlannedMaintenanceConfigured = $false
  HealthAdvisoryConfigured     = $false
  FullyConfigured              = $false
  SubscriptionId               = $subscription.Id
  SubscriptionName             = $subscription.Name
  AlertNames                   = @()
}

Get-AzActivityLogAlert | Where-Object { $_.Enabled -eq $true } | ForEach-Object {
  $first = $_.ConditionAllOf[0]
  # filter for Service Health Alerts
  if ($first.Field -eq 'category' -and $first.Equal -eq 'ServiceHealth') {
    $alertConfiguration.AlertNames += $_.Name
    if ($_.ConditionAllOf.Length -eq 1) {
      # if no specific Service Health Alert type is configured, then the alert is fully configured
      $alertConfiguration.FullyConfigured = $true
    }
    else {
      # check for specific Service Health Alert types
      foreach ($allOf in $_.ConditionAllOf) {
        foreach ($anyOf in $allOf.AnyOf) {
          if ($anyOf.Field -eq 'properties.incidentType') {
            if ($anyOf.Equal -eq 'Incident') {
              $alertConfiguration.ServiceIssueConfigured = $true
            }
            elseif ($anyOf.Equal -eq 'ActionRequired') {
              $alertConfiguration.HealthAdvisoryConfigured = $true
            }
            elseif ($anyOf.Equal -eq 'Maintenance') {
              $alertConfiguration.PlannedMaintenanceConfigured = $true
            }
            elseif ($anyOf.Equal -eq 'Security') {
              $alertConfiguration.ServiceAdvisoryConfigured = $true
            }
          }
        }
      }
    }

    if ($alertConfiguration.ServiceIssueConfigured -eq $true -and
      $alertConfiguration.ServiceAdvisoryConfigured -eq $true -and
      $alertConfiguration.PlannedMaintenanceConfigured -eq $true -and
      $alertConfiguration.HealthAdvisoryConfigured -eq $true) {
      # all alerts are configured
      $alertConfiguration.FullyConfigured = $true
    }
  }
}

if ($alertConfiguration.FullyConfigured -eq $false) {
  [PSCustomObject] @{
    recommendationId = 'ala-1'
    name             = $subscription.Name
    id               = $subscription.Id
    tags             = if ($subscription.Tags) { [PSCustomObject] ([Hashtable] $subscription.Tags) } else { $null }
    param1           = 'AllServiceHealthAlertsConfigured: false'
    param2           = 'ConfiguredServiceHealthAlerts: ' + ($alertConfiguration.AlertNames -join ', ')
  }
}
