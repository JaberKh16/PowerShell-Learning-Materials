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
    return $pingCount
}

# call the functions
$currentDateTime = Get-CurrentDateTime
$pingCount = Get-PingCount
