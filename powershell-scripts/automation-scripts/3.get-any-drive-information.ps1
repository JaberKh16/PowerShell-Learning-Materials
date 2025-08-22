# Description: Get any drive information
function Get-DriveInfo {
    param (
        [Parameter(Mandatory=$false)] # this ensures the parameter is optional
        [string]$drive,
        [string]$logFile = "./driveinfo.log"   # Default value if not passed
    )

    # If user didn't pass a drive, ask interactively
    if (-not $drive) {
        $drive = Read-Host "Enter drive name (e.g. C on Windows or / on Linux)"
    }

    try {
        if ($IsLinux) {
            # Linux volumes (PowerShell cross-platform)
            $volume = Get-PSDrive -Name $drive -ErrorAction SilentlyContinue
            if ($volume) {
                $used  = [math]::Round($volume.Used / 1GB, 2)   # Used in GB
                $free  = [math]::Round($volume.Free / 1GB, 2)   # Free in GB
                $total = [math]::Round(($volume.Used + $volume.Free) / 1GB, 2)

                $msg = @"
[Linux] Drive: $($volume.Name)
Used : $used GB
Free : $free GB
Total: $total GB
"@

                Write-Host $msg
                Add-Content -Path $logFile -Value $msg
            }
            else {
                $msg = "Drive $drive not found."
                Write-Host $msg
                Add-Content -Path $logFile -Value $msg
            }
        }
        elseif ($IsWindows) {
            # Windows volumes
            $volume = Get-Volume -ErrorAction SilentlyContinue | Where-Object { $_.DriveLetter -eq $drive }
            if ($volume) {
                $used  = [math]::Round(($volume.Size - $volume.SizeRemaining) / 1GB, 2)
                $free  = [math]::Round($volume.SizeRemaining / 1GB, 2)
                $total = [math]::Round($volume.Size / 1GB, 2)

                # Using a hashtable structured
                $0msg = @{
                    Drive = $volume.DriveLetter
                    Used  = "$used GB"
                    Free  = "$free GB"
                    Total = "$total GB"
                }

                # Display formatted
                Write-Host "Drive: $($msg.Drive), Used: $($msg.Used), Free: $($msg.Free), Total: $($msg.Total)"

                # Append JSON to log (so it’s structured)
                $msg | ConvertTo-Json | Add-Content -Path $logFile

            }
            else {
                $msg = "Drive $drive not found."
                Write-Host $msg
                Add-Content -Path $logFile -Value $msg
            }
        }
        else {
            $msg = "Unsupported platform."
            Write-Host $msg
            Add-Content -Path $logFile -Value $msg
        }
    }
    catch {
        $errMsg = "[Error] Unable to retrieve volume information. $_"
        Write-Host $errMsg -ForegroundColor Red
        Add-Content -Path $logFile -Value $errMsg
    }
}

# Example usage:
Get-DriveInfo -drive "C"                    # Windows, logs to ./driveinfo.log
Get-DriveInfo -drive "/"                    # Linux, logs to ./driveinfo.log
Get-DriveInfo -drive "D" -logFile "D:\mylog.txt"  # Custom log file
Get-DriveInfo -logFile "/tmp/mystorage.log"       # Interactive + custom log
