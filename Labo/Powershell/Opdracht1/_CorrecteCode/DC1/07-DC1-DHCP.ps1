# DHCP instellen
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools

Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange 192.168.1.10 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0

Set-DhcpServerV4OptionValue -DnsServer 192.168.1.2 -Router 192.168.1.0

Set-DhcpServerv4Scope -ScopeId 192.168.1.1 -LeaseDuration 1.00:00:00

# DHCP reservation

Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.5 -ClientId "00-50-56-9C-56-2B" --Diescription "Reservation"

Restart-service dhcpserver