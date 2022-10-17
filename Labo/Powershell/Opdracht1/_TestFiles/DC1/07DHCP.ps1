Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools -Restart

$dnsArray = "192.168.1.2", "192.168.1.3"
$macPrinter = "b8-e9-37-3e-55-86"
Add-DhcpServerInDC -DnsName "DC1.intranet.mijnschool.be" -EndRange 192.168.1.254 -SubnetMask 255.255.255.0
Add-DhcpServerV4Scope -Name "Kortrijk" -StartRange 192.168.1.1 -Force
Set-DhcpserverV4OptionValue -SnqServer $dnsArray -Router 192.168.1.1 -EndRange 192.168.1.10
Add-DhcpserveV4Reservetion -ScopeId 192.168.1.0 IPAddress 192.168.1.11 -ClientId $macPrinter -Desctiption "reservation for printer"

Set-ItemPropery registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigutationState -Value 2