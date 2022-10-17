$IP 		= "192.168.1.4"
$MaskBits	= 24 			#subnetmaks =255.255.255.0
$Gateway 	= "192.168.1.1"
$Dns1 		= "172.20.0.2"
$Dns2 		= "172.20.0.3"
$IpType 	= "IPv4"

$adapter = Get-NetAdapter -Physical | Where-object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}

#verwijder bestaande ip adressen op adapter
if (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress){
	$adapter | Remove-NetIpAddress -AddressFamily $IPType -Confirm:$false
}

If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway){
	$adapter |Remove-NetRoute -AddressFamily $IPType -Cofirm:$false
}

#ip adres en default gateway instellen adhv de bovenstaande parameters
#vergeet de backticks niet
$adapter | New-NetIPAddress `
	-AddressFamily $IPType `
	-IPAddress $IP `
	-PrefixLength $MaskBits `
	-DefaultGateway $Gateway `

$adapter | Set-DnsClientServerAddress -ServerAddresses ($Dns1, $Dns2)

# Bron:
# https://www.ntweekly.com/2020/08/15/how-to-set-a-static-ip-address-with-powershell/
# https://learn.microsoft.com/en-us/powershell/module/netadapter/get-netadapter?view=windowsserver2022-ps