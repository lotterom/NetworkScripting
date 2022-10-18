$dnsdomain="intranet.howest.be"

#install active directory

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

#create DC
Install-ADDSForest
-CreateDnsDelegation:$false
-DatabasePath "c:\windows\NTDS"
-DomainName $dnsdomain
-Installdns:$true

# Bron:
# https://learn.microsoft.com/en-us/powershell/module/addsdeployment/install-addsdomaincontroller?view=windowsserver2022-ps