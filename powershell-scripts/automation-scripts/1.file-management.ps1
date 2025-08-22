# check if the system is unix or windows
# and set the directory path
if($PSVersionTable.Platform -eq 'Unix'){
    $directoryPath = '/test'
} else {
    $directoryPath = 'C:\Documents\test'
}

$filePath = "$directoryPath\test.log"

# verify if the directory exists
try {
    if(-not(Test-Path -path $filePath -ErrorAction Stop)){
        # create a directory
        New-Item -Path $directoryPath Directory -ErrorAction Stop | Out-Null   # with Out-Null bypass console verbose text
        # create a file
        New-Item -Path $filePath -Path File -ErrorAction Stop | Out-Null
    }
`   # add content
    Add-Content -Path $filePath -Value "[INFO] Running $PSCommandPath"

} catch {
    throw
}



