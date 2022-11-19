#!/bin/bash
#mak een script dat de map /home met alle onderliggende mappen backupped
#path /home/user/scripts/dirlotte

#check of script runt
if ["$(id -u)" -ne 0]; then
    printf "Dit script moet u runnen als root!"
    printf "Stopping script..."
    exit 1
fi


#variabalen
PATH="/home/user/scripts/dirlotte"

#runt script op specifiek tijdsstip bron: https://askubuntu.com/questions/335904/how-to-execute-bash-script-automatically-at-specific-interval
crontab -e
0 17 * * 7 PATH

#check of het path bestaat
betaat_path (){
    echo "Zoken naar map..."
    if[-d $PATH]
    then
        echo "$PATH bestaat"
        backupmap_aanmaken
    else
        echo "Map voor backup is aangemaakt"
    fi
}

#Maak de backup map aan
backupmap_aanmaken (){
    echo "Map voor backup aanmaken..."
    if[-d "/backup"]
    then
        echo "Bestaat al"
    else
        mkdir /backup
        echo "Map voor backup is aangemaakt"
    fi
}

#backup maken
echo "Bezig met backup maken..."
echo "Maak backup van $PATH"
bestaat_path
NOW=$(date+"%d_%m_%Y")
BACKUPFILE="/backup/bacup-${NOW}.tar.gz"
echo"Plaats van de backupfile $BACKUPFILE"
tar -cvf $BACKUPFILE $PATH
echo "BAKCUP IS KLAAR!"