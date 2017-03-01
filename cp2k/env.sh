#!/bin/bash
export V=4.1
export NAME='cp2k'

source ../common.sh

module rm fftw cray-libsci darshan


export LIBINT=$PREFIX/libint/1.1.4
export LIBXC=$PREFIX/libxc/3.0.0
export PLUMED=$PREFIX/plumed/2.2.3

module list
echo 'NAME:      '$NAME
echo 'V:         '$V
echo 'TAG:       '$TAG
echo 'PREFIX:    '$PREFIX
echo 'PKGROOT:   '$PKGROOT
