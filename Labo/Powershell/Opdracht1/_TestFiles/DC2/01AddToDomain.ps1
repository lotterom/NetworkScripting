$session= New-PSSession -ComputerName "DC2" -Creadential(Get-Credential)

Invoke-Command -Session $Session -ScriptBlock {
	Zdd-Computer -DomainName intranet.mijnschool.be	-Credential Administration -Restart
}