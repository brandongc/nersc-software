#!/bin/bash
set -e

source ./env.sh
bash ./download.sh
    

logfile=$PKGROOT/build.$TAG-$V.txt
{
    BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.XXXXXXX)
    echo "build dir: "$BUILDDIR && cd $BUILDDIR

    VN=$(echo $V | tr "." "_")
    cp -r $PKGROOT/cp2k-$VN-branch/cp2k cp2k
    cd cp2k
    
    v=popt

    arch=cray-xc40-intel-mkl-hsw
    cp $PKGROOT/$arch.$v arch/
    
    cd makefiles
    make -j $NJOBS ARCH=$arch VERSION=$v
    make ARCH=$arch VERSION=$v clean
    cd ..

    mkdir -p $PREFIX/$NAME/$V-$TAG
    cp -r exe/$arch $PREFIX/$NAME/$V-$TAG/
    
    rm -r $BUILDDIR
    
} 2>&1 | tee $logfile

