#!/bin/bash
fname=NAMD_$V'_Source.tar.gz'
if ! [ -e "$fname" ]; then
    echo "File not found, download from "
    echo "http://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=NAMD"
fi

for f in tcl8.5.9-linux-x86_64.tar.gz tcl8.5.9-linux-x86_64-threaded.tar.gz; do
    if ! [ -e "$f" ]; then
	wget http://www.ks.uiuc.edu/Research/namd/libraries/$f
    fi
done
