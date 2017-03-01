#!/bin/bash
set -e

source ./env.sh
bash ./download.sh

logfile=$PKGROOT/log/build.$TAG.$V.log
{
    BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.XXXXXXX)
    echo "build dir: "$BUILDDIR && cd $BUILDDIR
    
    tar zxf $PKGROOT/NAMD_$V'_Source.tar.gz'
    cd NAMD_$V'_Source'

    tar xf charm-*.tar
    cd charm-*
    ./build charm++ gni-crayxc persistent --with-production -j$NJOBS
    cd ..

    tar xzf $PKGROOT/tcl8.5.9-linux-x86_64.tar.gz
    tar xzf $PKGROOT/tcl8.5.9-linux-x86_64-threaded.tar.gz
    mv tcl8.5.9-linux-x86_64 tcl
    mv tcl8.5.9-linux-x86_64-threaded tcl-threaded

    BUILD=CRAY-XC-intel
    ./config $BUILD --with-fftw3 --fftw-prefix $FFTW_DIR --charm-arch gni-crayxc-persistent
    cd $BUILD
    gmake -j $NJOBS
    
    # fails due to ldd on static binary
    set +e
    make release     
    set -e

    mkdir -p $PREFIX/$NAME/$V-$TAG
    mv NAMD_"$V"_CRAY-XC-ugni $PREFIX/$NAME/$V-$TAG/

    rm -fr $BUILDDIR
} > $logfile 2>&1
