#!/bin/bash
fname=abinit-$V.tar.gz
if ! [ -e "$fname" ]; then
    wget http://ftp.abinit.org/$fname
fi
