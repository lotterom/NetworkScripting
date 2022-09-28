Import-Module ActiveDirectory
$GroupMembers = Import-Csv C:\.... -Delimeter ";"

ForEach($Mebmber in $GroupMembers)
{
	$Member = $Mebmer.Member
	$Identity = $Mebmer.Identity

	Write-Host "Adding $Member to $Identity -ForegroundColor Green"

	$CreateGroup = Add-ADGroupMember`
		-Identity $Identity
		-Members $Member

}