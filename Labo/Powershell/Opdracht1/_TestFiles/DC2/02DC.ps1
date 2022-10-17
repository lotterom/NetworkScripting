$session = New-PSSession -ComputerName "DC2" -Credential(Get-Credential)

Invoke-Command -Session $session -ScriptBlock {
	$Domain = "intranet.mijnschool.be"
	$Site = "Kortrijk"
	$Login = "intranet\administrator"
	Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
	Install-ADDSDomainController -CreateDnsDelegation:$flase -DatabasePath 'C:\....' -DomainName $Domain -InstallDns:$true -LogPath 'C:\...' -NoGlobalCatalog: Restart-Computer


$session = New-PSSession -ComputerName "DC2" -Credential(Get-Credential)

	$NetworkID = "192.168.1.0/24"
	$IP = "192.168.1.3"
	$MaskBits = 24
	$IPType = "IPv4"

	$dns1 = "192.168.1.3"
	$dns2 = "192.168.1.2"

	$adapter = Get-NetAdapter | where-object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}
	
	If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
     		$adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
    	}

	If(($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway){
		$adapeter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
	}

	$adapter | New-NetIPAddress`
	-AddressFamily $IPType`
	-IPAddress $IP`
	-PrefixLength $MaskBits`
	-DefaultGateway $Gateway
	
	$adapter | set-DnsClientServerAddress -ServerAddresses ($dns2, $dns2)

}