#!/bin/bash

#Default directory
DEFDIR=~/Pictures/4chan

URL=$(echo ${@: -1})
DIR=$DEFDIR/$(echo $URL | awk -F/ '{ print $4"-"$6 }' | awk -F# '{ print $1 }')

while getopts dP:a:h OPT; do
    case "$OPT" in
        h)
            echo "Usage: 4get [-dh] [-P <path>] <thread link>"
            echo "default path: $DEFDIR/"
            echo "-d)        empty default path"
            echo "-a <arg>)  add to .update file"
            echo "-u)        update all pages in .update"
            echo "-h)        display this help"
            echo "-P <arg>)  enter required path"
            exit 0
            ;;
        d)
            rm -rf $DEFDIR/*
            exit 0
            ;;
        P)
            DIR=$OPTARG
            ;;
        a)
            echo $OPTARG\@$DIR >> $DEFDIR/.update
            ;;
        \?)
            echo "-h for help"
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

echo $URL

if [ ! -d $DIR ]; then
    mkdir $DIR
fi

for i in $(curl -s $URL | sed s/href/\\n/g | grep -o "i.4cdn.org.*\"" | awk -F\" '{ print $1 }' | uniq); do
    if [ ! -e $DIR/$(echo $i | awk -F/ '{print $3}') ]; then
        echo $(echo $i | awk -F/ '{print $3}')
	wget -qP $DIR $i
    fi
done
