#!/bin/bash
export V=6.0
export NAME='octopus'

source ../common.sh

module load fftw gsl cray-netcdf parpack

module list
echo 'NAME:      '$NAME
echo 'V:         '$V
echo 'TAG:       '$TAG
echo 'PREFIX:    '$PREFIX
echo 'PKGROOT:   '$PKGROOT
