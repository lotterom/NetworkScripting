#===========================
#===== DC promo dc1 ========
#===========================
$dnsdomain="intranet.howest.be"
$netbiosdomain="mijnschool"

#install active directory

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

#create DC
Install-ADDSForest
-CreateDnsDelegation:$false
-DatabasePath "c:\windows\NTDS"
-DomainName $dnsdomain
-Installdns:$true
