#!/bin/bash

UPDATE=""
DIR=""
DOWN=""

ANS=$(zenity  --list  --title "4get" --text "options" --width 500 --height 500 --checklist \
--column 	"Pick" --column "options" \
			TRUE 			"Download pictures" \
			TRUE 			"Add to update list" \
            TRUE			"Update all pages in your update list" \
			FALSE 			"Change directory" \
			FALSE 			"Empty default directory" \
			FALSE			"Clear update list" \
			FALSE			"Show update list" \
--separator=":")

COUNT=$(echo $ANS | sed s/:/\\n/g | wc -l)

for i in $(seq $COUNT)
do
	TRY=$(echo $ANS | awk -F: -v var="$i" '{ print $var }')
    if [ "$TRY" = "Download pictures" ]; then
    	DOWN="TRUE"
    fi
    if [ "$TRY" = "Add to update list" ]; then
    	UPDATE="-a"
    fi
    if [ "$TRY" = "Update all pages in your update list" ]; then
    	4get -u
    fi
    if [ "$TRY" = "Change directory" ]; then
    	DIR="TRUE"
    fi
	if [ "$TRY" = "Empty default directory" ]; then
    	4get -d
    fi
    if [ "$TRY" = "Clear update list" ]; then
    	4get -c
    fi
	if [ "$TRY" = "Show update list" ]; then
    	zenity --info --title "4get" --text "$(4get -l)"
    fi
done

if [ $DOWN = "TRUE" ]; then
	URL=$(zenity --entry --width 500 --title "4get" --text "URL")
    if [ $? -eq 1 ]; then
        	exit 1
    fi
	if [ $DIR = "TRUE" ]; then
		DIR="-P $(zenity --file-selection --directory --title="Select a Folder")/"
        if [ $? -eq 1 ]; then
        	exit 1
        fi
	fi
fi

4get $DIR $UPDATE $URL
	
