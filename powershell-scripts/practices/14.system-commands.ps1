# services commands
get-service -Name "wsupdate"
stop-service -Name "wsupdate"
start-service -Name "wsupdate"


# process commands
get-process -Name "NotePad"
stop-prcess -Name "Notepad"
start-process -FilePath "Notepad.exe" # to start the process need to use -FilePath


# managing event logs
get-eventlog -List    # to list all events log in the system
get-eventlog -LogName Application # to list all events log Application related logs
get-eventlog -LogName Application -Newest 20   # to list 20 Application related event logs
get-eventlog -LogName Application -Security -Newest 20 # to list security related event logs
get-eventlog -LogName Application -Source "Chrome"  # to list Chrome related event logs


# latest application installed
get-eventlog -LogName Application -Source "MsiInstaller" -Newest 20 | Select-Object Timegenerated, Message
