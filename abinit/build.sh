#!/bin/bash
set -e

source ./env.sh
bash ./download.sh

logfile=$PKGROOT/log/build.$TAG.$V.log
{
    BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.XXXXXXX)
    echo "build dir: "$BUILDDIR && cd $BUILDDIR
    tar zxf $PKGROOT/abinit-$V.tar.gz
    cd abinit-$V
    ./configure --prefix=$PREFIX/$NAME/$V-$TAG FC=ftn CC=cc CXX=CC --with-fft-flavor=fftw3 --with-linalg-flavor=custom --enable-netcdf=yes --with-trio-flavor=netcdf  --enable-zdot-bugfix
    make -j $NJOBS
    make install    
    rm -r $BUILDDIR

} > $logfile 2>&1
