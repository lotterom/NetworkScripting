$csv = "C:\"
$Path = Test-Path -Path $csv -PathType Leaf

Write-Host $Path

if ($Path -like "False")
{
    Write-Host "--Bestand niet gevonden--"
}

$FileName = "logon.bat"
$FilePath = "\\"

if (Test-Path $FilePath) {
    Write-Host "Wordt uitgevoerd."
}
else {
    New-Item -Path "" -Name $FileName

    "@echo off" | Out-File -FilePath $FilePath
    "net user H: \\win09-MS\Home" | Out-File -FilePath $FilePath -Append

}

$ADUser = Import-csv $csv -Delimiter ";"

foreach ($user in $ADUser)
{
    $name = $user.Name
    $acc_name = $user.SamAccountName
    $given_name = $user.GivenName
    $sur_name = $user.Surname
    $display_name = $user.DisplayName
    $passwd = $user.AccountPassword
    $home_drive = $user.HomeDrive
    $home_directory = $user.HomeDirectory
    $script_path = $user.ScriptPath
    $path = $user.Path

    New-ADUser `
    -Name $name `
    -SamAccountName $acc_name `
    -GivenName $given_name `
    -Surname $sur_name `
    -DisplayName $display_name `
    -AccountPassword (convertto-securestring "$passwd" -asplaintext -force)  `
    -HomeDrive $home_drive `
    -HomeDirectory $home_directory `
    -ScriptPath $script_path `
    -Path $path
}

