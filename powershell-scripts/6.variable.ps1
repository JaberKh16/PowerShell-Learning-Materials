# powershell variables can be written in 3 formats: 
# camel-case => someVariable
# pascal-case =>SomeVariable
# snake-case => some_variable
# syntax: $var=''

# Available Variable Types:
# 1. String  => $var = '' or $var = ""
# 2. Integer => $var = 2 
# 3. Boolean => $var = $true or $false

# Available Properties and Methods On String
# String.Length => to get the length
# String.GetType() => to get the variable type

# Example-1: String
$message = 'Welcome to powershell'
$message

# Exmaple-2: Integer
$number = 2
$number

 
# Example-3: Get The Length]
$message.Length

# Example-4: Get the type
$message.GetType()
