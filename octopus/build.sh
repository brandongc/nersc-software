#!/bin/bash
set -e

source ./env.sh
bash ./download.sh

logfile=$PKGROOT/log/build.$TAG.$V.log
{
    export TMPDIR=$SCRATCH
    BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.XXXXXXX)
    echo "build dir: "$BUILDDIR && cd $BUILDDIR
    tar zxf $PKGROOT/octopus-$V.tar.gz
    cd octopus-$V

    LIBXC=/usr/common/software/libxc/3.0.0
    case "$NERSC_HOST" in
	edison)
	    ./configure --prefix=$PREFIX/$NAME/$V-$TAG --with-libxc-prefix=$LIBXC --enable-mpi --enable-openmp \
		CC=cc FC=ftn FCFLAGS="-fast -no-ipo" CFLAGS="-fast -no-ipo" \
		FCCPP="/lib/cpp -ffreestanding" --with-fftw-prefix=$FFTW_DIR/.. \
		--with-arpack="$ARPACK" --with-parpack=no \
		--with-metis-prefix=/usr/common/usg/metis/5.1.0/intel \
		--with-parmetis-prefix=/usr/common/usg/parmetis/4.0.3/intel
	    ;;
	cori)
	    ./configure --prefix=$PREFIX/$NAME/$V-$TAG --with-libxc-prefix=$LIBXC --enable-mpi --enable-openmp \
		CC=cc FC=ftn FCFLAGS="-fast -no-ipo" CFLAGS="-fast -no-ipo" \
		--with-arpack="$ARPACK" --with-parpack=no --with-berkeleygw-prefix=/usr/common/software/berkeleygw/1.2-beta-2 \
		FCCPP="/lib/cpp -ffreestanding" --with-fftw-prefix=$FFTW_DIR/..
	    ;;
	*)
	    echo "unsupport NERSC_HOST"
	    exit 1
    esac
	    
    make -j $NJOBS
    make install
    
    rm -r $BUILDDIR
} > $logfile 2>&1
