#!/bin/bash
export V=8.2.1
export NAME='abinit'

source ../common.sh

set_pe gnu haswell
module load fftw
module load cray-netcdf
module unload darshan

module list
echo 'NAME:      '$NAME
echo 'V:         '$V
echo 'TAG:       '$TAG
echo 'PREFIX:    '$PREFIX
echo 'PKGROOT:   '$PKGROOT
