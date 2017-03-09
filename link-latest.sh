#!/bin/bash

source common.sh

for d in `ls -d $PREFIX/*/`; do 
    echo $d
    cd $d
    latest=$( ls | cut -d- -f2-4 | sort | tail -n 1 )
    version=$( ls -d *$latest | cut -d- -f1 )
    rm $version
    echo $version-$latest $version
    ln -s $version-$latest $version
    cd ../
done
