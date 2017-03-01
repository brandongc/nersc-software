#!/bin/bash
export V=3.0.0
export NAME='libxc'

source ../common.sh

module list
echo 'NAME:      '$NAME
echo 'V:         '$V
echo 'TAG:       '$TAG
echo 'PREFIX:    '$PREFIX
echo 'PKGROOT:   '$PKGROOT
