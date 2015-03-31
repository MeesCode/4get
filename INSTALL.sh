#!/bin/bash

#Installation directory (change if you will)
INSTALLDIR="/user/local/bin"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cp $DIR/4get.sh $INSTALLDIR/4get
cp $DIR/4gui.sh $INSTALLDIR/4gui

chmod 755 $INSTALLDIR/4get
chmod 755 $INSTALLDIR/4gui