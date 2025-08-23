# Description: This script automates the backup of MySQL, PostgreSQL, and SQL Server databases.
# It detects the operating system (Linux or Windows) and uses appropriate commands to perform the backup
# It logs the backup status and errors to a log file.
# Usage: Call the function with parameters for database type, name, user, password, and
function Backup-Database {
    param (
        [string]$DbType,        # mysql | postgres | mssql
        [string]$DbName,
        [string]$User,
        [string]$Password,
        [string]$OutputDir = "./db_backups"
    )

    # Ensure backup directory exists
    if (-not (Test-Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir | Out-Null
    }

    # Timestamped backup file
    $timestamp = (Get-Date -Format "yyyyMMdd_HHmmss")
    $backupFile = Join-Path $OutputDir "$DbName-$timestamp.sql"

    try {
        if ($IsLinux) {
            Write-Host "[Linux] Detected. Running backup..."
            switch ($DbType.ToLower()) {
                "mysql" {
                    $env:MYSQL_PWD = $Password
                    & mysqldump -u $User $DbName > $backupFile
                }
                "postgres" {
                    $env:PGPASSWORD = $Password
                    & pg_dump -U $User $DbName > $backupFile
                }
                "mssql" {
                    & sqlcmd -S localhost -U $User -P $Password -Q "BACKUP DATABASE [$DbName] TO DISK='$backupFile.bak'"
                }
                default {
                    throw "Unsupported database type: $DbType"
                }
            }
        }
        elseif ($IsWindows) {
            Write-Host "[Windows] Detected. Running backup..."
            switch ($DbType.ToLower()) {
                "mysql" {
                    $env:MYSQL_PWD = $Password
                    & "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" -u $User $DbName > $backupFile
                }
                "postgres" {
                    $env:PGPASSWORD = $Password
                    & "C:\Program Files\PostgreSQL\15\bin\pg_dump.exe" -U $User $DbName > $backupFile
                }
                "mssql" {
                    & sqlcmd -S localhost -U $User -P $Password -Q "BACKUP DATABASE [$DbName] TO DISK='$backupFile.bak'"
                }
                default {
                    throw "Unsupported database type: $DbType"
                }
            }
        }
        else {
            throw "Unsupported OS."
        }

        Write-Host "✅ Backup completed: $backupFile"
        Add-Content -Path "./db_backup.log" -Value "[$(Get-Date)] Backup completed for $DbName ($DbType) -> $backupFile"
    }
    catch {
        $errMsg = "[ERROR] $(Get-Date): Failed to back up $DbName ($DbType). $_"
        Write-Host $errMsg -ForegroundColor Red
        Add-Content -Path "./db_backup.log" -Value $errMsg
    }
}

# Example usage:
# For MySQL on Linux
# Backup-Database -DbType mysql -DbName mydb -User root -Password mypass

# For PostgreSQL on Windows
# Backup-Database -DbType postgres -DbName mydb -User postgres -Password mypass

# For SQL Server on Windows/Linux
# Backup-Database -DbType mssql -DbName MyDatabase -User sa -Password StrongPass123
