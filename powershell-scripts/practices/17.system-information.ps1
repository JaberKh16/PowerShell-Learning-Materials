# File to store the report
$reportFile = "./temp-file"

# check if the file does not exists then create
$checkFileExists = (Test-Path "./temp-file") # returns true if exits

if(!$checkFileExist){
   New-Item -Path "./temp-file" -ItemType File # create a file
}
# Initialize variable
$reportData = ""

# --- CPU Usage ---
$reportData += "`n--- CPU ---`n"
$reportData += (Get-CimInstance -ClassName Win32_Processor | Out-String) # CimInstance => Common Instance
$reportData += (Get-CimInstance -ClassName Win32_Processor |
                Select-Object Name, LoadPercentage | Out-String)

# --- Memory Usage ---
$reportData += "`n--- MEMORY ---`n"
# $reportData += (Get-CimInstance -ClassName Win32_OperatingSystem |
#                 Select-Object @{Name="TotalMemory(GB)"; Expression={[math]::Round($_.TotalVisibleMemorySize / 1MB, 2)}},
#                               @{Name="FreeMemory(GB)"; Expression={[math]::Round($_.FreePhysicalMemory / 1MB, 2)}} |
#                 Out-String)
#

# Get total and free memory in MB
$totalMemory = [System::Math]::Round((Get-CimInstance -ClassName Win32_OperatingSystem).TotalVisibleMemorySize / 1MB, 2)
$freeMemory  = [System::Math]::Round((Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)

# Calculate percentages
$usedMemoryPercentage = [math]::Round(100 - (($freeMemory / $totalMemory) * 100), 2)
$freeMemoryPercentage = [math]::Round(($freeMemory / $totalMemory) * 100, 2)

# Append to report data
$reportData += "`n--- Memory ---"
$reportData += "`nUsed Memory in %  : $usedMemoryPercentage"
$reportData += "`nFree Memory in %  : $freeMemoryPercentage"




# Save the report to file
$reportData | Set-Content -Path $reportFile

Write-Host "Report saved to $reportFile"
