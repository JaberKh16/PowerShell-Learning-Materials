
# create a folder
New-Item -Path "C:/NewFolder" -ItemType Directory

# remove a folder
Remove-Item -Path "C:/NewFolder"  # if the folder is empty 
Remove-Item -Path "C:/NewFolder"  -Recurse -Force # if containing files/directories
Remove-Item -Path "C:/NewFolder" -Recurse -Force -Confirm # remove with prompt yes/no


# create a subfolder
New-Item -Path "C:/NewFolder/SubFolder" -ItemType Directory
