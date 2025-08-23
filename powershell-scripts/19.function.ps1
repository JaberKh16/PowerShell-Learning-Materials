# function to get the current date and time
function Get-CurrentDateTime {
    return (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

# Function to get ping count
function Get-PingCount {
    param (
        [string]$Target = "google.com"
    )

    $pingCount = Read-Host "Enter number of ping attempts (default 4)"
    if (-not $pingCount) {
        $pingCount = 4
    }

    Write-Host "Pinging $Target $pingCount times..."
    return $pingCount
}

# Call the functions
$currentDateTime = Get-CurrentDateTime   # without parameters
$pingCount = Get-PingCount -Target "google.com"   # with parameter

Write-Host "`n[$currentDateTime] Running ping test..."
ping google.com -n $pingCount   # Windows
# ping -c $pingCount google.com   # Linux (uncomment if running on Linux PowerShell)
