$NetworkID 		= "192.168.1.0/24" #huidige netwerk
$ZoneFile 		= "1.168.192.in-addr.arpa.dns"
$IP 			= "192.168.1.2"
$MaskBits 		= 24
$Gateway 		= "192.168.1.1"
$Dns1 			= "172.20.0.2"
$Dns2 			= "172.20.0.3"
$IPType 		= "IPv4"

$adapter = Get-NetAdapter -Physical | where-Object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}
#bestaande ip's verwijderen
If(($adapter | Get-NetIpConfiguration).IPv4Address.ipAddress){
	$adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}

If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
	$adapter | Remove-NetRoute -AddressFamily $IPType -Confirm=$false
}

$adapter | New-NetIPAddress`
	-AddressFamily $IPType`
	-IPAddress $IP`
	-PrefixLength *MaskBits `
	-DefaultGateway $Gateway
$adapter | Set-DnsClientServerAddress -ServerAddresses ($Dns1, $Dns2)

Add-DnsServerPrimaryZone -NetworkId 192.168.1.0/24 -ReplivationScope Domain 
Register-DnsClient