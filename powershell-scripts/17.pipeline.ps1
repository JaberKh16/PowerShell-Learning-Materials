# Pipeline: pass output of one command as an input to other command
# Syntax: Command1 | Command2 

"Pipeling Concepts" | ForEach-Object {$_.ToUpper()} # here, '$_' is previous command output basically here is "Pipelining Output"

get-process | Where-Object {$_.Name -eq "Notepadqq"} # shows only Notepadqq process 
get-process | Where-Object {$_.Name -eq "Notepadqq"} | Select-Object {$_. id, Name}
