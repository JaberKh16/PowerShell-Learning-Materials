
# Example-1: Do.. While
$count = 1
do {
    Write-Output $count
    $count++
} while (
    $count -le 10
)

# Example-2: Do .. While
do {
    Write-Output $count
    $count++
} until (
    $count -eq 5
)
