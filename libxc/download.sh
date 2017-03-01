#!/bin/bash
fname=libxc-$V.tar.gz
if ! [ -e "$fname" ]
then
    wget http://www.tddft.org/programs/octopus/down.php?file=libxc/$fname -O $fname
fi
