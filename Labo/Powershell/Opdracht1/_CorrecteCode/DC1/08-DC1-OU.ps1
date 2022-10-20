# importeren van csv file
Import-Module activedirectory

# path csv
$csv = " c:/"

$TestPath = Test-Path -Path $csv  -PathType Leaf
Write-Host $TestPath

if ($TestPath -like "False")
{
    Write-Host "--Script stopped -- File niet gevonden"
    exit 1
}

#variable met csv data
$ADOU = Import-Csv $csv -Delimiter ";"

foreach ($ou in $ADOU)
{
    $name =$ou.Name
    $path = $ou.Path
    $description = $ou.Description
    $displayname = $ou.DisplayName 

    New-ADOrganizationalUnit -Name $name -Path $Path -Description $description -DisplayName $displayname
}
