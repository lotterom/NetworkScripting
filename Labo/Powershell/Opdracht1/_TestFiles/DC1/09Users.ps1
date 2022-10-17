Import-Module ActiveDirectory
$ADUsers = Import-Csv C:\....

$UPN = "mijnschool.be"

foreach ($User.Name.ToLower().replace('',"") {
$Name = $User.Name
$SamAccountName = $User.SamAccountName = $User.SamAccountName
$GivenName = $User.GivenName
$DisplayName = $User.DisplayName
$AccountPassword = $User.AccountPAssword
$HomeDrive = $User.HomeDrive
$HomeDirectory = "\\ms\homedirs\$Username"
$ScriptPath = $User.ScriptPath
$Path = $User.Path
write-host "User $Name is creting" -ForegroundColor Green

	New-ADUser`
		-UserPrincipalName "$username@$UPN"`
		-Name $Name`
		-SamAccountName $SamAccountName`
		-GivenName $GivenName`
		-Surname $Surname `
            	-DisplayName $DisplayName `
         	-AccountPassword (ConvertTo-secureString $AccountPassword -AsPlainText -Force) `
          	-HomeDrive $HomeDrive `
         	-HomeDirectory $HomeDirectory `
          	-ScriptPath $ScriptPath `
       		-Path $Path `
            	-Enabled $True
		-ChangePAsswordAtLogon $False

Write-Host "Folder creating for $Name" -ForegroundColor Green

#home directory
New-Item -Path $HomeDirectory -type directory -Force
$acl = Get-Acl $HomeDirectory
$alc.SetAccessRuleProtection($False, $True)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($Username, 'Modify', "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
(Get-Item $HomeDirectory).SetAccessControl($acl)

}