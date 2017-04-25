#!/bin/bash
set -e

source ./env.sh
bash ./download.sh


function build_namd() {
    
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

    BUILD=$1
    ./config $BUILD --with-fftw3 --fftw-prefix $FFTW_DIR --charm-arch gni-crayxc-persistent
    cd $BUILD
    gmake -j $NJOBS
    
    # fails due to ldd on static binary
    set +e
    make release     
    set -e

    echo "installing release to:"$PREFIX/$NAME/$V-$TAG/$TG
    mkdir -p $PREFIX/$NAME/$V-$TAG/$TG
    mv NAMD_"$V"_* $PREFIX/$NAME/$V-$TAG/$TG

    rm -fr $BUILDDIR

}



logfile=$PKGROOT/build.$TAG.$V.log
{

    build_namd CRAY-XC-intel

    set_pe intel mic-knl

    build_namd CRAY-XC-KNL-intel

} 2>&1 | tee $logfile
