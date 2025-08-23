function Get-UserInfo {
    [CmdletBinding()]
    param ()

    $logFile = "./userinfo.log"
    $currentDateTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

    try {
        if ($IsWindows) {
            # Windows user info
            $userName   = $env:USERNAME
            $domain     = $env:USERDOMAIN
            $fullName   = (Get-CimInstance Win32_UserAccount -Filter "Name='$userName'" -ErrorAction SilentlyContinue).FullName
            $groups     = (whoami /groups) -join "`n"

            $msg = @"
[$currentDateTime] [Windows User Info]
Username : $userName
Domain   : $domain
FullName : $fullName
Groups   :
$groups
"@
        }
        elseif ($IsLinux -or $IsMacOS) {
            # Linux/macOS user info
            $userName = (whoami)
            $groups   = (id -Gn $userName) -join ", "
            $uid      = (id -u $userName)
            $gid      = (id -g $userName)
            $shell    = (getent passwd $userName | cut -d: -f7)

            $msg = @"
[$currentDateTime] [Linux/macOS User Info]
Username : $userName
UID      : $uid
GID      : $gid
Groups   : $groups
Shell    : $shell
"@
        }
        else {
            $msg = "Unsupported platform."
        }

        Write-Host $msg
        Add-Content -Path $logFile -Value $msg
    }
    catch {
        $errMsg = "[Error] Unable to get user info. $_"
        Write-Host $errMsg -ForegroundColor Red
        Add-Content -Path $logFile -Value $errMsg
    }
}

# Example usage
Get-UserInfo
