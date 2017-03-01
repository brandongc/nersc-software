#!/bin/bash

VN=$(echo "$V" | tr "." "_")
fname='boost_'$VN'.tar.bz2'
if ! [ -e "$fname" ]; then
    wget https://sourceforge.net/projects/boost/files/boost/$V/$fname
fi

