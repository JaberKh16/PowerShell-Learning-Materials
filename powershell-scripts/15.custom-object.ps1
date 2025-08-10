# define custom object
$person = [PSCustomObject]@{
    FirstName = "Jaber"
    LastName = "Khan"
    Age = 30
    Occupation = "Software Developer"
    Salary = 30.000
}

# print object
$person

# access specific
$person.Occupation

# with "" print
"Name : $($person.FirstName) $($person.LastName)"



