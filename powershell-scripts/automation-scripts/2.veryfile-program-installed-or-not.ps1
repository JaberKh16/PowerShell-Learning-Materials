# verify notepadqq installed or not
if(-not (Get-Module -Name Notepadqq -ListAvailable)){
    Add-Content -Path "/test/test.log" -Value "[Error] Notepadqq is not installed."
    throw
} else {
    Add-Content -Path "/test/test.log" -Value "[Info] Notepadqq is installed."
}


