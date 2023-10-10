##Update-AzConfig -DisplayBreakingChangeWarning $false
$servers = Get-AzSqlServer
##Loop through all servers
foreach($server in $servers) {
    $databases= Get-AzSqlDatabase -ServerName $server.ServerName -ResourceGroupName $server.ResourceGroupName
    foreach($db in $databases) {
        if ($db.CurrentBackupStorageRedundancy -eq 'Local' -or $db.CurrentBackupStorageRedundancy -eq 'Zone') {
            Write-Output( "recommendationId=SQLDB-1;SQLServerName=" +$server.ServerName +";databasename=" +$db.DatabaseName + ";Redundancy=" + $db.CurrentBackupStorageRedundancy)
        }
    }
}
