#!/bin/bash
VN=$( echo $V | tr "." "-" )
fname=release-$VN.zip
if ! [ -e "$fname" ]; then
    wget https://github.com/evaleev/libint/archive/$fname
fi
    
