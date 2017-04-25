#!/bin/bash
export V=2.12
export NAME='namd'

source ../common.sh

set_pe intel haswell
module swap intel intel/16.0.3.210
module load craype-hugepages8M
module load fftw

module list
echo 'NAME:      '$NAME
echo 'V:         '$V
echo 'TAG:       '$TAG
echo 'PREFIX:    '$PREFIX
echo 'PKGROOT:   '$PKGROOT
