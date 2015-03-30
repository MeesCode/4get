#!/bin/bash

DIR="default"
UPDATE=""

URL=$(zenity --entry --title "4get" --text "URL")
zenity --question --title "4get" --text "Default directory?"

if [ $? -eq 1 ]; then
	DIR=$(zenity --file-selection --directory --title "4get") 
fi

zenity --question --title "4get" --text "Add to update list?"

if [ $? -eq 0 ]; then
	UPDATE="-a" 
fi

if [ $DIR = "default" ]; then
	4get $UPDATE $URL 
else
	4get -P $DIR $UPDATE $URL
fi