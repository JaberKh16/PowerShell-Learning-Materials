# get public ip for windows and linux
function Get-PublicIP {
    param (
        [string]$ServiceName
    )

    # Default services list
    $services = @{
        "ipify"    = "https://api.ipify.org?format=json"
        "ipinfo"   = "https://ipinfo.io/json"
        "ifconfig" = "https://ifconfig.me/all.json"
    }

    # Ask user if not provided
    if (-not $ServiceName) {
        Write-Host "Available services: $($services.Keys -join ', ')"
        $ServiceName = Read-Host "Enter service name"
    }

    # Check if service exists
    if (-not $services.ContainsKey($ServiceName)) {
        Write-Host "Unknown service: $ServiceName. Falling back to ipify."
        $ServiceName = "ipify"
    }

    $url = $services[$ServiceName]

    try {
        $response = Invoke-RestMethod -Uri $url -UseBasicParsing

        if ($ServiceName -eq "ipify") {
            $ip = $response.ip
        } elseif ($ServiceName -eq "ipinfo") {
            $ip = $response.ip
        } elseif ($ServiceName -eq "ifconfig") {
            $ip = $response.ip_addr
        }

        if ($ip) {
            $msg = @"
[$ServiceName] Public IP: $ip
Platform: $(if ($IsWindows) { "Windows" } elseif ($IsLinux) { "Linux" } else { "Unknown" })
Timestamp: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
"@

            Write-Host $msg -ForegroundColor Green
            Add-Content -Path "./publicip.log" -Value $msg

            return $ip
        } else {
            Write-Error "Could not extract IP address from $ServiceName response."
        }
    }
    catch {
        $errMsg = "[Error] Failed to fetch public IP from $ServiceName. $_"
        Write-Host $errMsg -ForegroundColor Red
        Add-Content -Path "./publicip.log" -Value $errMsg
    }
}

# Example calls:
Get-PublicIP                # Interactive (asks user)
Get-PublicIP -ServiceName "ipify"
Get-PublicIP -ServiceName "ipinfo"
Get-PublicIP -ServiceName "ifconfig"
