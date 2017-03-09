#!/bin/bash
set -e

source ./env.sh
bash ./download.sh

logfile=$PKGROOT/build.$TAG-$V.txt
{
    BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.$PE.$TG.XXXXXXX)
    echo "build dir: "$BUILDDIR && cd $BUILDDIR

    unzip $PKGROOT/v$V.zip
    cd plumed2-$V
    export CRAYPE_LINK_TYPE=dynamic
    ./configure --prefix=$PREFIX/$NAME/$V-$TAG CC=cc CXX=CC FC=ftn --disable-openmp
    make -j $NJOB
    make install
    unset CRAYPE_LINK_TYPE

    rm -r $BUILDDIR

} 2>&1 | tee $logfile
