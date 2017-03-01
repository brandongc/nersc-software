#!/bin/bash
export V=2.2.3
export NAME='plumed'

source ../common.sh

module list
echo 'NAME:      '$NAME
echo 'V:         '$V
echo 'TAG:       '$TAG
echo 'PREFIX:    '$PREFIX
echo 'PKGROOT:   '$PKGROOT
