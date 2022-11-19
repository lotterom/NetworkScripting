#!/bin/bash

#zoek alle certificaten (.crt) ouder dan 2 weken
CERTS = find / -type f -name '*.crt' -mtime +14

#schrijf certificaten weg naar file
FILE = /home/user/NetwScripting/certs/certificaten.txt
CERTS >> FILE

#overloop alle certificaten in bestand certificaten.txt en bekijke hun datum
REGELS=$(cat $FILE)

#for R in $REGELS
#do
#haal de datum uit de regels (https://www.cyberciti.biz/faq/find-check-tls-ssl-certificate-expiry-date-from-linux-unix/)
    #DATUM=$(openssl x509 -enddate -noout -in $R)

    #MAAND="$(echo "$DATUM" +%b)"
    #DAG="$(echo "$DATUM" +%d)"
    #JAAR="$(echo "$DATUM" +%Y)"

