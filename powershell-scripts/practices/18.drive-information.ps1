# Description: This script retrieves and displays information about the drives on the system.
if($isLinux){
    Get-PSDrive # to get the drivers information
    Get-PSDrive -Name / # to get the root folder information
    Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="Used(GB)"; Expression={[math]::Round($_.Used / 1GB, 2)}}, @{Name="Free(GB)"; Expression={[math]::Round($_.Free / 1GB, 2)}},
    @{Name="Total(GB)"; Expression={[math]::Round($_.Used / 1GB + $_.Free / 1GB, 2)}}
    | Format-Table -AutoSize
}
