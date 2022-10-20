$csv = "C:\"
$Path = Test-Path $csv -PathType Leaf

Write-Host $Path

if ($Path -like "False") {
    Write-Host "Verkeerd path/ file niet gevonden"
    exit 1
}

$Group = Import-csv $csv -Delimeter ";"
foreach($user in $Group)
{
    $member =$user.Member
    $identity = $user.Identity

    Add-ADGroupMember`
    -Memners $member`
    -Identity $identity
}


