$csv = "C:\Users\Mijn_School\Mijn_School\GroupMembers.csv"
$Path = Test-Path $csv -PathType Leaf

if ($Path -like "False") {
    Write-Host "Verkeerd path/ file niet gevonden"
    exit 1
}

$Group = Import-csv $csv -Delimiter ";"
foreach($user in $Group)
{
    $member =$user.Member
    $identity = $user.Identity

    Add-ADGroupMember -Members $member -Identity $identity
}