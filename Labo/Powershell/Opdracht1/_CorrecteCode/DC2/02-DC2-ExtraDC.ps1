$PC_Name = "Win09-DC2"

#remote sessie
$s = New-PSSession -ComputerName $PC_Name -Credential "INTRANET\Administrator" 

Invoke-Command -Session $s -ScriptBlock {
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

    $Domain = "intranet.howest.be"
    $Site = "Kortrijk"
    $Login = "intranet\administrator"
    $NTDS_Path = "C:\Windows\NTDS"
    
    Install-ADDSDomainController `
        -CreateDnsDelegation:$false `
        -DatabasePath $NTDS_Path `
        -DomainName $Domain `
        -InstallDns:$true `
        -LogPath $NTDS_Path `
        -NoGlobalCatalog:$false `
        -SiteName $Site `
        -SysvolPath 'C:\Windows\SYSVOL' `
        -NoRebootOnCompletion:$true `
        -Force:$true `
        -Credential (Get-Credential $Login) `
    
    Restart-Computer
}