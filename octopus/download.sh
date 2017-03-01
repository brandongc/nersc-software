#!/bin/bash
fname=octopus-$V.tar.gz
if ! [ -e "$fname" ]; then
    wget http://www.tddft.org/programs/octopus/down.php?file=6.0/$fname -O $fname
fi
