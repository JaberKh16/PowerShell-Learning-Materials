# define list of objects
$employees = @(
    [PSCustomObject]@{
        Name = "A"
        ID = 121
    }
    [PSCustomObject]@{
        Name = "B"
        ID = 112
    }
)

# print
$employees

# iterate
foreach($i in $employees)
{
    # $i.Name # single thing
    "$($i.Name), $($i.ID)"
}
