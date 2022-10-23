$PC_Name = "Win09-MS"

#remote sessie op DC2
$s = New-PSSession -ComputerName $PC_Name -Credential "INTRANET\Administrator" 

Invoke-Command -Session $s -ScriptBlock{
    $Domain = "intranet.howest.be"
    Add-Computer -DomainName $Domain -Restart
}
