#!/bin/bash

#Default directory (change if you will)
DEFDIR=~/Pictures/4chan

function download {
    COUNT=$(curl -s $1 | sed s/href/\\n/g | grep -o "i.4cdn.org.*\"" | awk -F\" '{ print $1 }' | uniq | wc -l)
    for i in $(curl -s $1 | sed s/href/\\n/g | grep -o "i.4cdn.org.*\"" | awk -F\" '{ print $1 }' | uniq); do
        NUM=$(expr $NUM + 1)
        PER=$(echo $COUNT $NUM | awk '{ div = $2 * 100; per = div / $1; printf"%0.0f\n", per }')
        if [ ! -e $2/$(echo $i | awk -F/ '{print $3}') ]; then
            echo -e "$PER% \t $(echo $i | awk -F/ '{print $3}')"
	        wget -qP $2 $i
        fi
    done
}

URL=$(echo ${@: -1})
DIR=$DEFDIR/$(echo $URL | awk -F/ '{ print $4"-"$6 }' | awk -F# '{ print $1 }')
NUM=0

while getopts dP:a:uchlg OPT; do
    case "$OPT" in
        h)
            echo "4get user manual"
            echo ""
            echo "Usage: 4get [option] [thread url]"
            echo "default path: $DEFDIR/"
            echo ""
            echo "-d)        empty default path"
            echo "-a [url])  add to .update file"
            echo "-u)        update all pages in your update list"
            echo "-l)        show update list"
            echo "-c)        clears update list"
            echo "-h)        display this help"
            echo "-P [dir])  enter required path"
            echo "-g)        start GUI interface"
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
            touch ~/.4get
            echo $OPTARG:$DIR >> ~/.4get
            ;;
        u)
	        if [ ! -e ~/.4get ]; then
                exit 0
            fi
            UPDATES=$(wc -l ~/.4get | awk -F" " '{ print $1 }')
	        for j in $(seq 1 $UPDATES); do
	            URL=$(awk -F: '{ print $1 }' ~/.4get | sed -n "$j"p)
                DIR=$(awk -F: '{ print $2 }' ~/.4get | sed -n "$j"p)
                echo $URL
		        download $URL $DIR
	        done
	        exit 0
	        ;;
	    c)
	        if [ ! -e ~/.4get ]; then
                exit 0
            fi
	        rm ~/.4get
	        exit 0
	        ;;
	    l)
            if [ ! -e ~/.4get ]; then
                echo "no updates listed"
		        exit 0
            fi
            awk -F:'{ print $1 " in " $2 }' ~/.4get
            exit 0
            ;;
        g)
            4gui
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
