#!/bin/bash

#Default directory
DEFDIR=~/Pictures/4chan

function download {
    for i in $(curl -s $1 | sed s/href/\\n/g | grep -o "i.4cdn.org.*\"" | awk -F\" '{ print $1 }' | uniq); do
        if [ ! -e $2/$(echo $i | awk -F/ '{print $3}') ]; then
            echo $(echo $i | awk -F/ '{print $3}')
	        wget -qP $2 $i
        fi
    done
}

URL=$(echo ${@: -1})
DIR=$DEFDIR/$(echo $URL | awk -F/ '{ print $4"-"$6 }' | awk -F# '{ print $1 }')

while getopts dP:a:uch OPT; do
    case "$OPT" in
        h)
            echo "Usage: 4get [-dh] [-P <path>] <thread link>"
            echo "default path: $DEFDIR/"
            echo "-d)        empty default path"
            echo "-a <arg>)  add to .update file"
            echo "-u)        update all pages in .update"
            echo "-c)        clears update file"
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
            if [ ! -d $DEFDIR ]; then
    	        mkdir $DEFDIR
	        fi
            if [ ! -e $DEFDIR/.update ]; then
                touch $DEFDIR/.update
            fi
            echo $OPTARG\@$DIR >> $DEFDIR/.update
            ;;
        u)
			if [ ! -e $DEFDIR/.update ]; then
                exit 0
            fi
            UPDATES=$(wc -l $DEFDIR/.update | awk -F" " '{ print $1 }')
	        for j in $(seq 1 $UPDATES); do
	            URL=$(awk -F@ '{ print $1 }' $DEFDIR/.update | sed -n "$j"p)
	            DIR=$(awk -F@ '{ print $2 }' $DEFDIR/.update | sed -n "$j"p)
	            echo $URL
				download $URL $DIR
	        done
	        exit 0
	        ;;
	c)
	    if [ ! -e $DEFDIR/.update ]; then
                exit 0
            fi
	    rm $DEFDIR/.update
	    exit 0
	    ;;
        \?)
            echo "-h for help"
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

download $URL $DIR
