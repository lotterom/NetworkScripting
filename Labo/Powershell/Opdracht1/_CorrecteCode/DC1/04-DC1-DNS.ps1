$IP         = "192.168.1.2"   # IP win09-DC1
$MaskBits   = 24
$Gateway    = "192.168.1.1"
$Dns1       = "172.20.0.2"
$Dns2       = "172.20.0.3"
$IPType     = "IPv4"
$NetworkId  = "192.168.1.0/24"

$adapter = Get-NetAdapter -Physical | Where-Object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}

If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}

If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}

$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway

$adapter | Set-DnsClientServerAddress -ServerAddresses ($Dns1, $Dns2)

Add-DnsServerPrimaryZone -NetworkId $NetworkId  -ReplicationScope Domain    # Creating DNS reverse lookup zone
Register-DnsClient                                                          # Registering the zone

# Bron:
# https://learn.microsoft.com/en-us/powershell/module/dnsserver/add-dnsserverprimaryzone?view=windowsserver2022-ps