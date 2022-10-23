$PC_Name = "Win09-DC2"

#remote sessie openen
$s = New-PSSession -ComputerName $PC_Name -Credential "INTRANET\Administrator" 

Invoke-Command -Session $s -ScriptBlock  {
    $Domain = "intranet.howest.be"

    Write-Host "Adding machine to domain $Domain"
    Add-Computer -DomainName $Domain -Restart
}
