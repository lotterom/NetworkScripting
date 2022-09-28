$Suffix = "mijnschool.be"
Get-ADForest | Set-ADForest -UPNSuffix @{add=$Suffix}

Get-ADForest | Format-List UPNSuffixes

$Suffix = "mijnschool.be"
$LocationUsers = Get-ADUsers -Filter {UserPrincipalName -like '*intranet.mijnschool.be'} -Properties User=====principalName -ResultSetSize $nul
$LocalUsers = Get-ADUder -Filter {UserPrincipalName.Replace("intranet.mijnschool.be",$Suffix); $_ | Set-ADUser -UserPrincipalName $newUpn}
