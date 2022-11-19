#!/bin/bash

#variables
DHCP="dhcp"
STATIC="static"

#script moet als root runnen, ander werkt het niet
#volgende lijnen code is om te checken of script als root runt
if ["$(id -u)" -ne 0]; then
    printf "Dit script moet u runnen als root!"
    printf "Stopping script..."
    exit 1
fi

#functie voor dhcp
toggle_dhcp (){
    printf "iface lo inet loopback\nauto lo\n\nauto ens192\niface ens192 inet dhcp\n" > /etc/network/interfaces
    printf "ip is set to dhcp"
    
    sleep 2
    
    eval "systemctl restart networking.service"
    printf ""
    eval "ip a"
}

#functie voor static
toggle_static (){
    INTERFACE="ens192"
    IPADDRESS="192.168.1.125"
    IPSUBNET="255.255.255.0"
    IPGATEWAY="192.168.1.1"

    echo "iface lo inet loopback\nauto lo\n\nauto $INTERFACE\nallow-hotplug $INTERFACE\niface $INTERFACE inet static\naddress $IPADDRESS\nnetmask $IPSUBNET\ngateway $IPGATEWAY\n" > /etc/network/interfaces

    print "ip set to static"

    sleep 2

    eval "systemctl restart networking.service"
    printf ""
    eval "ip a"
}

#user kiest voor en statisch op of dhcp
read -p "Kies 'STATIC' of 'DHCP': " KEUZE
 
if [ "$KEUZE" = "STATIC"]
then
    echo "Je koos voor 'STATIC'"
    toggle_static

elif [ "$KEUZE" = "DHCP"]
then
    echo "Je koos voor 'DHCP'"
    toggle_dhcp
else
    printf "Parameter $KEUZE moet 'DHCP' of 'STATIC' zijn. (spelling en hoofdletters)\n\n"
    printf "Stopping script...\n"
    exit 2
fi