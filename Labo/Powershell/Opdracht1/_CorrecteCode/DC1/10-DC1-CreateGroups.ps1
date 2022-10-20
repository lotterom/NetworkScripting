$csv="C:\"
$Path = Test-Path -Path $csvFile -PathType Leaf

Write-Host $Path

if ($Path -like "False") {
    Write-Host "Stopping the script - File not Found"
    exit 1
}

$Groups = Import-csv $csv -Delimeter ";"

foreach($Group in $Groups)
{
    $path = $Group.Path
    $name = $Group.Name
    $display_name = $Group.DisplayName
    $desc = $Group.Description
    $category = $Group.GroupCategory
    $scope = $Group.GroupScope

    New-ADGroup `
    -Path $path `
    -Name $name `
    -DisplayName $display_name `
    -Description $desc `
    -GroupCategory $category `
    -GroupScope $scope
}