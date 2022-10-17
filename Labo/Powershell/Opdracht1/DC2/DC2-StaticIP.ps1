#===================================
#====== set static ipv4 ============
#===================================
$IP 		= "192.168.1.3"
$MaskBits	= 24
$Gateway 	= "192.168.1.1"
$Dns1 		= "172.20.0.2"
$Dns2 		= "172.20.0.3"
$IpType 	= "IPv4"



$adapter = Get-NetAdapter -Physical | Where-object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}

if (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress){
	$adapter | Remove-NetIpAddress -AddressFamily $IPType -Confirm:$false
}

If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway){
	$adapter |Remove-NetRoute -AddressFamily $IPType -Cofirm:$false
}

$adapter | New-NetIPAddress `
	-AddressFamily $IPType `
	-IPAddress $IP `
	-PrefixLength $MaskBits `
	-DefaultGateway $Gateway `

$adapter | Set-DnsClientServerAddress -ServerAddresses ($Dns1, $Dns2)