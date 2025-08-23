# Script to get the public IP address of the machine
# This script works on both Windows and Linux platforms.
function Get-MyIP {
    param (
        [string]$Service = "https://api.ipify.org?format=json"
    )

    try {
        if ($IsLinux) {
            Write-Host "[Linux] Fetching Public IP..."
        }
        elseif ($IsWindows) {
            Write-Host "[Windows] Fetching Public IP..."
        }
        else {
            Write-Host "[Other Platform] Fetching Public IP..."
        }

        $response = Invoke-RestMethod -Uri $Service -ErrorAction Stop
        if ($response.ip) {
            $ip = $response.ip
        }
        elseif ($response) {
            # some services return plain text
            $ip = $response
        }
        else {
            throw "Could not parse response from $Service"
        }

        Write-Host "🌍 Your Public IP is: $ip"
        return $ip
    }
    catch {
        Write-Error "❌ Error retrieving public IP: $_"
    }
}

# Example usage:
Get-MyIP                       # default (api.ipify.org)
Get-MyIP -Service "https://ifconfig.me/all.json"
Get-MyIP -Service "https://ipinfo.io/json"
