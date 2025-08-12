# get the process and filter value greater than 20 which than sorted by Id
get-process | where-object {$_.CPU -gt 20} | Sort {$_.Id}
