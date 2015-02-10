#!/bin/bash

#Default directory
DEFDIR=~/Pictures/4chan

URL=$(echo ${@: -1})
DIR=$DEFDIR/$(echo $URL | awk -F/ '{ print $4"-"$6 }' | awk -F# '{ print $1 }')

while getopts dP:a:uh OPT; do
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
            if [ ! -e $DEFDIR/.update ]; then
                touch $DEFDIR/.update
            fi
            echo $OPTARG\@$DIR >> $DEFDIR/.update
            ;;
        u)
	    for j in $(seq 1 $(wc -l $DEFDIR/.update | awk -F" " '{ print $1 }')); do
	        echo $(awk -F@ '{ print $1 }' $DEFDIR/.update | sed -n "$j"p)
	            for i in $(curl -s $(awk -F@ '{ print $1 }' $DEFDIR/.update | sed -n "$j"p) | sed s/href/\\n/g | grep -o "i.4cdn.org.*\"" | awk -F\" '{ print $1 }' | uniq); do
 		        if [ ! -e $(awk -F@ '{ print $2 }' $DEFDIR/.update | sed -n "$j"p)/$(echo $i | awk -F/ '{print $3}') ]; then
			    echo $(echo $i | awk -F/ '{print $3}')
			        wget -qP $(awk -F@ '{ print $2 }' $DEFDIR/.update | sed -n "$j"p) $i
			fi
		    done
	    done
	    exit 0
	    ;;
        \?)
            echo "-h for help"
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

if [ ! -d $DEFDIR ]; then
    mkdir $DEFDIR
fi

for i in $(curl -s $URL | sed s/href/\\n/g | grep -o "i.4cdn.org.*\"" | awk -F\" '{ print $1 }' | uniq); do
    if [ ! -e $DIR/$(echo $i | awk -F/ '{print $3}') ]; then
        echo $(echo $i | awk -F/ '{print $3}')
	wget -qP $DIR $i
    fi
done
