Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Bron:
# https://pureinfotech.com/enable-remote-desktop-powershell-windows-10/ 