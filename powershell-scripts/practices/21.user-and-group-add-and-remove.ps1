# Description: This script sets and retrieves user properties in Active Directory.
Set-AdUser -Identity "jaber" -City "New York" -Department "IT" -Title "Senior Developer"
Get-AdUser -Identity "jaber" -Properties * | Select-Object Name, City, Department, Title

# add user to a group
Add-ADGroupMember -Identity "IT Team" -Members "jaber"
# remove user from a group
Remove-ADGroupMember -Identity "IT Team" -Members "jaber" -Confirm

# create a new user
New-ADUser -Name "Alice Johnson" -GivenName "Alice" -Surname "Johnson" -SamAccountName "alice.j"
-UserPrincipalName "alice.j@yourdomain.com" -Path "OU=Users,DC=yourdomain,DC=com"
-AccountPassword (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) -Enabled $true

# create a new group
New-ADGroup -Name "HR Team" -GroupScope Global -Path "OU=Groups,DC=yourdomain,DC=com" -Description "Human Resources Team"

# remove a user
Remove-ADUser -Identity "alice.j" -Confirm:$false
# remove a group
Remove-ADGroup -Identity "HR Team" -Confirm:$false
