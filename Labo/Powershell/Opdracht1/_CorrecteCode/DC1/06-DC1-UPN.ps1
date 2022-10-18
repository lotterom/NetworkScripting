$Suffix = "mijnschool.be"

Get-ADForest | Set-ADForest -UPNSuffixes @{add=$Suffix}
# toont de suffix
Get-ADForest | Format-List UPNSuffixes

$LocalUsers = Get-ADUser -Filter {UserPrincipalName -like '*intranet.mijnschool.be'} -Properties UserPrincipalName -ResultSize $null
# users die al suffix hebben verandert de suffix naar de nieuwe
$LocalUsers | foreach {$newUpn = $._UserPrinvipalName.Replace("intranet.mijnschool.be", $Suffix); $_ | Set-ADUser -UserPrincipalName $newUpn}