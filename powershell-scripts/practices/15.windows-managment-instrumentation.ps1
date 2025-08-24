# Windows Management Instrumentation(WMI)
# Drive, Network Devices
# Powershel 7+ => Doesn't support $PSVersionTable.Platform
# Detecting Platform Use: $IsWindows, $IsLinux, $IsMacOS

# Detect Platform
$platform = $PSVersionTable.Platform # or [System.Environment]::OSVersion.Platform
if ($IsWindows) {
    Write-Host "Running on Windows, using WMI/CIM..."

    # Processor
    Get-CimInstance -ClassName Win32_Processor | Select-Object Name, NumberOfCores, LoadPercentage

    # Disk Drives
    Get-CimInstance -ClassName Win32_DiskDrive | Select-Object Model, Size, SerialNumber

    # Network Adapters
    Get-CimInstance -ClassName Win32_NetworkAdapter | Select-Object Name, MACAddress, NetEnabled

    # Physical Memory
    Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, Speed

    # BIOS
    Get-CimInstance -ClassName Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion, SerialNumber

    # User Accounts
    Get-CimInstance -ClassName Win32_UserAccount | Select-Object Name, Disabled, LocalAccount
}
elseif ($IsLinux) {
    Write-Host "Running on Linux, using system tools..."

    # Processor
    lscpu

    # Disk Drives
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINT

    # Network Devices
    ip link show

    # Physical Memory
    free -h

    # BIOS (if dmidecode available)
    sudo dmidecode -t bios

    # User Accounts
    cat /etc/passwd | cut -d: -f1
}
elseif ($IsMacOS) {
    Write-Host "Running on macOS, using system tools..."

    # Processor
    sysctl -n machdep.cpu.brand_string

    # Disk Drives
    diskutil list

    # Network Devices
    ifconfig -a

    # Physical Memory
    vm_stat

    # BIOS equivalent
    system_profiler SPHardwareDataType

    # User Accounts
    dscl . list /Users
}
else {
    Write-Host "Unsupported platform."
}
