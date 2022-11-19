#!/bin/bash

#zoek alle certificaten (.crt)
CERTS = find / -type f -name '*.crt'

#schrijf certificaten weg naar file
FILE = /home/user/NetwScripting/certs/certificaten.txt
CERTS >> FILE


