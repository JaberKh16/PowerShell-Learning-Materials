# function to get the current date and time
function Get-CurrentDateTime {
    return (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

# Function to get system information
function Get-SystemInformation {
    param (
        [string]$reportFile = "./system-info-report.txt"
    )
    # Initialize variable
    $reportData = ""
    $reportData += "`n--- System Information Report ---`n"
    $reportData += "Report generated on: $(Get-CurrentDateTime)`n"
    $reportData += "----------------------------------`n"
    $reportData += "`n--- CPU Information ---`n"
    $reportData += (Get-CimInstance -ClassName Win32_Processor | Out-String)
    $reportData += "`n--- Memory Information ---`n"
    $totalMemory = [System::Math]::Round((Get-CimInstance -ClassName Win32_OperatingSystem).TotalVisibleMemorySize / 1MB, 2)
    $freeMemory  = [System::Math]::Round((Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
    $usedMemoryPercentage = [math]::Round(100 - (($freeMemory / $totalMemory) * 100), 2)
    $freeMemoryPercentage = [math]::Round(($freeMemory / $totalMemory) * 100, 2)
    $reportData += "`nUsed Memory in %  : $usedMemoryPercentage"
    $reportData += "`nFree Memory in %  : $freeMemoryPercentage"
    $reportData += "`n--- Disk Information ---`n"
    $reportData += (Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="Used(GB)"; Expression={[math]::Round($_.Used / 1GB, 2)}}, @{Name="Free(GB)"; Expression={[math]

}

# call the function
Get-SystemInformation -reportFile "./system-info-report.txt"
