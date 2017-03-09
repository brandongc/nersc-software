#!/bin/bash
set -e

source ./env.sh
bash ./download.sh

logfile=$PKGROOT/build.$TAG-$V.txt
{
    BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.XXXXXXX)
    echo "build dir: "$BUILDDIR && cd $BUILDDIR

    VN=$(echo "$V" | tr "." "-")
    fname=release-$VN.zip
    unzip $PKGROOT/$fname
    cd libint-release-$VN
    aclocal -I lib/autoconf
    autoconf
    ./configure --prefix=$PREFIX/$NAME/$V-$TAG
    make -j $NJOB
    make install

} 2>&1 | tee $logfile

