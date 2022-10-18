$first_site_name = "Kortrijk"
$second_site_name ="Gent"

$subnet_first_site_name = "192.168.1.0/24"
$subnet_second_site_name = "192.168.2.0/24"

# Site Kortrijk
Get-ADReplicationSite "Default-First-Site-Name" | Rename-AddObject -NewName $fist_site_name
Get-ADReplicationSite $first_site_name | Set_ADReplicationSite -Description $first_site_name
New-ADReplixationSubnet -Name $subnet_first_site_name -Site $first_site_nae -desctiption $first_site_name -location $first_site_name

# Site Gent
New-ADReplicationSite $second_site_name
Get-ADReplicationsite $second_site_name | SetADReplicationSite -Description $second_site_name
New-ADReplicationSubnet -Namr $subnet_second_site_name -Description $second_site_name -location *second_site_name

# Bron:
# https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adreplicationsubnet?view=windowsserver2022-ps