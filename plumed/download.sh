#!/bin/bash
fname=v$V.zip
if ! [ -e "$fname" ]; then
    wget https://github.com/plumed/plumed2/archive/$fname
fi
    
