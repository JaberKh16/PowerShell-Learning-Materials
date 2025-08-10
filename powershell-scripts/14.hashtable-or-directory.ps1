# HashTable/Dictionary In Powershell

$settings = @{
    "AppName" = "Microsoft VS Code"
    "Version" = "15.3.2"
    "ReleaseYear" = 2019
}

$settings

# get specific value
$settings["AppName"]
$settings["version"] # not case-senstive
$settins["version", "ReleaseYear"] # two keys value together


# assign new value
$settings["comment"] = "IDE For Coding"


# looping
Foreach($i in $settings)
{
    $i # to print key-value
    # $i.Keys # only keys
    # $i.Values # only keys
}

# method => ContainsKey(key)
$settins.ContainsKey("version")
$settings.Count # to get the length

