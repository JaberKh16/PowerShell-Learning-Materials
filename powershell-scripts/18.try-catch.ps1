
# try .. catch
try {
    get-content -Path "C:\Users\Documents\NewFile.txt" -ErrorAction Stop
    Write-Output "Content readed"
}
catch {
    <#Do this if a terminating exception happens #>
    Write-Output("ErrorL $($_.Exception.Message)")
}

