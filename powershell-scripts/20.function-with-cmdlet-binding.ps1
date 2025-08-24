# function to get the current date and time
function Get-CurrentDateTime {
    [CmdletBinding()]
    param ()
    return (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

# function to run ping with proper parameter binding
function Invoke-PingTest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Target = "google.com",
        [int]$Count = 4
    )

    # If Count is not provided, ask interactively
    if (-not $PSBoundParameters.ContainsKey("Count")) {
        $inputCount = Read-Host "Ping Attemspts (default 4): "
        if ($inputCount) {
            $Count = [int]$inputCount
        }
    }

    Write-Host "Pinging $Target $Count times..."

    if ($IsWindows) {
        ping $Target -n $Count
    }
    elseif ($IsLinux -or $IsMacOS) {
        ping -c $Count $Target
    }
    else {
        Write-Error "Unsupported platform."
    }
}

# --- Example usage ---
$currentDateTime = Get-CurrentDateTime
Write-Host "`n[$currentDateTime] Running ping test..."

Invoke-PingTest -Target "google.com" -Count 3   # with parameters
Invoke-PingTest -Target "8.8.8.8"               # interactive count if not given
