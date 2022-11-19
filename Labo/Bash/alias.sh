#!/bin/bash

#script moet als root runnen, ander werkt het niet
#volgende lijnen code is om te checken of script als root runt
if ["$(id -u)" -ne 0]; then
    printf "Dit script moet u runnen als root!"
    printf "Stopping script..."
    exit 1
fi

#updating system
echo "Updating system"
apt get update && apt dist-upgrade -y && apt upgrade -Y

#installing apache
echo "apache installeren"
apt install apache2 bind9 bind9utils wget -y

wget --user-ftp --password=ftp ftp://ftp.rs.internic.net/domain/db.cache -O /etc/bind/db.root

# Adjusting /etc/default/bind9
echo "OPTIONS=\"-4 -u bind\"" >> /etc/default/bind9

# Adjusting /etc/bind/named.conf.local
printf "zone \" mctinternal.be\" {\n type master;\nfile \"/etc/bind/zones/nmctinternal.be\";\n};\n\n" >> /etc/bind/named.conf.local

printf "zone \"1.168.192.in-addr.arpa\" {\ntype master;\n file \"/etc/bind/zones/reverse/1.168.192.in-addr.arpa\";\n};" >> /etc/bind/named.conf.local
# Creating directories
echo "Creating directories that are needed for bind9 reverse zones"
mkdir -p /etc/bind/zones/reverse

# Adjusting nmctinternal.be
touch /etc/bind/zones/nmctinternal.be
echo "Adjusting nmctinternal.be"
echo ";" >> /etc/bind/zones/nmctinternal.be
echo "; BIND data for mctinternal.be" >> /etc/bind/zones/nmctinternal.be
echo ";" >> /etc/bind/zones/nmctinternal.be
printf "\$TTL 3h\n" >> /etc/bind/zones/nmctinternal.be
echo "@       IN      SOA     ns1.mctinternal.be. admin.mctinternal.be. (" >> /etc/bind/zones/nmctinternal.be
echo "                        1       ; serial" >> /etc/bind/zones/nmctinternal.be
echo "                        3h      ; refresh" >> /etc/bind/zones/nmctinternal.be
echo "                        1h      ; retry" >> /etc/bind/zones/nmctinternal.be
echo "                        1w      ; expire" >> /etc/bind/zones/nmctinternal.be
echo "                        1h )    ; minimum" >> /etc/bind/zones/nmctinternal.be
echo ";" >> /etc/bind/zones/nmctinternal.be
echo "@       IN      NS      ns1.mctinternal.be." >> /etc/bind/zones/nmctinternal.be
echo "" >> /etc/bind/zones/nmctinternal.be
echo "www                     IN      CNAME   mctinternal.be." >> /etc/bind/zones/nmctinternal.be

touch /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "Adjusting reverse lookup zone"
echo ";" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "; BIND reverse file for 1.168.192.in-addr.arpa" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo ";" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
printf "\$TTL    604800\n" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "@ IN  SOA   ns1.mctinternal.be. admin.mctinternal.be. (" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "                        1       ; serial" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "                        3h      ; refresh" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "                        1h      ; retry" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "                        1w      ; expire" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "                        1h )    ; minimum" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo ";" >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa
echo "@       IN      NS      ns1.mctinternal.be." >> /etc/bind/zones/reverse/1.168.192.in-addr.arpa

sudo named-checkconf
systemctl restart bind9
systemctl status bind9
echo "Done!"