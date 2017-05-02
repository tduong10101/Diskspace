$Freespace = 
@{
  Expression = {[int]($_.Freespace/1GB)}
  Name = 'Free Space (GB)'
}

$PercentFree = 
@{
  Expression = {[int]($_.Freespace*100/$_.Size)}
  Name = 'Free (%)'
}
$Servers = Read-Host -Prompt "Please input server name. Use `";`" to seperate between servers"
$Servers = $Servers -split ";"|% {$_.trim()}
$output = $null
foreach ($s in $servers){
    $output += Get-WmiObject –ComputerName $s -Class Win32_LogicalDisk | Select-Object -Property DeviceID, VolumeName, $Freespace, $PercentFree
    foreach ($o in $output){
        if (![bool]($o.PSobject.Properties.name -match "Server")){
            Add-Member -inputobject $o -NotePropertyName "Server" $s.toupper()  
        }
    }
<<<<<<< HEAD
}
Write-Host "Test"
$output | Export-Csv "C:\Temp\DiskSpaceReport.csv"
=======
 }

$output | select -property Server,@{N="Disk ID";E={$_.DeviceID}},VolumeName,"Free Space (GB)","Free (%)" | Export-Csv "C:\Temp\DiskSpaceReport.csv" -NoTypeInformation
>>>>>>> refs/heads/init
