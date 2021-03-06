#!/bin/bash
set -e

source ./env.sh
bash ./download.sh

logfile=$PKGROOT/build.$TAG-$V.txt
{
    BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.XXXXXXX)
    echo "build dir: "$BUILDDIR && cd $BUILDDIR

    tar zxf $PKGROOT/libxc-$V.tar.gz    
    cd libxc-$V
    ./configure --prefix=$PREFIX/$NAME/$V-$TAG
    make -j $NJOB
    make install    

} 2>&1 | tee $logfile

