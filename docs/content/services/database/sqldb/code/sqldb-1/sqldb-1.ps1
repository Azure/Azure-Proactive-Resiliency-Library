
$servers = Get-AzSqlServer
##Loop through all servers
foreach($server in $servers) {
    $databases= Get-AzSqlDatabase -ServerName $server.ServerName -ResourceGroupName $server.ResourceGroupName
    foreach($db in $databases) {
        if ($db.CurrentBackupStorageRedundancy -eq 'Local' -or $db.CurrentBackupStorageRedundancy -ne 'Zone') {
            Write-Output( "recommendationId=sqldb-1, databasename=" +$db.DatabaseName + ",id=" + $db.DatabaseId)
        }
    }
}
