# switch case statement
$trafficLight = "red"
switch ($trafficLight) {
    "red" { Write-Output "Stop" }
    "yellow" { Write-Output "Caution!"}
    "green" { Write-Output "Go!" }
    Default { Write-Output "Unknown" }
}
