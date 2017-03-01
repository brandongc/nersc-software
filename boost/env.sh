#!/bin/bash
export V=1.63.0
export NAME='boost'

source ../common.sh

module unload darshan
module load python

module list
echo 'NAME:      '$NAME
echo 'V:         '$V
echo 'TAG:       '$TAG
echo 'PREFIX:    '$PREFIX
echo 'PKGROOT:   '$PKGROOT

