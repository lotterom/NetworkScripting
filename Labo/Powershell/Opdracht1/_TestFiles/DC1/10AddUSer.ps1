Import-Module ActiveDirectory
$AddGroups  = Import-Csv -Path "C:\....." -Delimeter ";"

ForEach($Group in $AddGroups)
{
	$Name = $Group.Name
	$DisplayName = $Group.DisaplayName
	$Path = $Group.Path
	$GroupSource = $Group.GroupSource
	$Description = $Group.Description

	Write-Host "Creating Group $Name" -GoregroundColor Green

	$CreateGroup = New-ADGroup
		-Name $Name`
		-DisplayName $DisplayName`
		-GroupScope $GroupScope`
		-Path $Path
		-GroupCategory $GroupCategory
		-Description $Discription

}