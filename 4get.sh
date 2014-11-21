#!/bin/bash

DIR=~/Pictures/4chan/$(echo $1 | awk -F/ '{ print $4"-"$6 }' | awk -F# '{ print $1 }')

while getopts dP:h OPT; do
    case "$OPT" in
        h)
            echo "Usage: 4get [-dh] [-P <path>] <thread link>"
            echo "default path: ~/Pictures/4chan/"
            echo "-d)        empty default path"
            echo "-h)        display this help"
            echo "-P <arg>)  enter required path"
            exit 0
            ;;
        d)
            rm -rf ~/Pictures/4chan/*
            exit 0
            ;;
        P)
            DIR=$OPTARG
            ;;
        \?)
            echo "-h for help"
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

if [ $# -eq 0 ]; then
    echo "-h for help"
    exit 1
fi

if [ ! -d $DIR ]; then
  mkdir $DIR
fi

for i in $(curl -s $1 | sed s/href/\\n/g | grep -o "i.4cdn.org.*\"" | awk -F\" '{print $1}' | uniq); do
  if [ ! -e $DIR/$(echo $i | awk -F/ '{print $3}') ]; then
    wget -qP $DIR $i
  fi
done
