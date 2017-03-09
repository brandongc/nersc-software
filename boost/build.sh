#!/bin/bash
set -e

create_custom_jam () {
    if [[ -f "$HOME/user-config.jam" ]]; then
	echo "$HOME/user-config.jam exists - please stash this somewhere safe, as it is about to be overwritten"
	exit 1
    fi
    
    cat << END > $HOME/user-config.jam
using mpi : :
  <include>$MPICH_DIR/include
  <library-path>$MPICH_DIR/lib
END

    cat << END > test.cxx
int main() {
  return 0;
}
END

    mpich_libs=$(CC -v test.cxx 2>&1 \
	| tr -s ' ' '\n' \
	| grep ^-lmpich \
	| sed 's/^-l//')
    for lib in $mpich_libs; do
	echo "  <find-shared-library>$lib " >> $HOME/user-config.jam
    done
    echo "  ;" >> $HOME/user-config.jam
    rm -f test.cxx a.out

    echo "note: wrote custom mpi config to $HOME/user-config.jam"
    custom_jam=$HOME/user-config.jam
}

tools () {
    PE=$1
    case "$PE" in
	gnu)
	    toolset=gcc
	    ;;
	cray)
	    toolset=cray
	    ;;
	intel)
	    toolset=intel-linux
	    ;;
	*)
	    echo "unknown toolset for ${PE}"
	    exit 1
    esac
    echo $toolset
}

build_boost () {
    PE=$1
    TG=$2

    logfile=$PKGROOT/boost.$V.$TAG.$PE.$TG.txt
    {
	BUILDDIR=$(mktemp -d --tmpdir $NAME.$V.$PE.$TG.XXXXXXX)
	echo "build dir: "$BUILDDIR && cd $BUILDDIR
	set_pe $PE $TG
	create_custom_jam
	VN=$(echo "$V" | tr "." "_")
	fname='boost_'$VN'.tar.bz2'
	tar jxf $PKGROOT/$fname
	cd boost_${VN}
	./bootstrap.sh --prefix=$PREFIX/$NAME/$V-$TAG/$PE/$TG --with-libraries=all
	./b2 install --toolset=$(tools $PE) -j $NJOBS
	[[ -n "$custom_jam" ]] && rm $custom_jam
	rm -r $BUILDDIR	
    } 2>&1 | tee $logfile
}

source ./env.sh
bash ./download.sh

for pe in gnu intel cray; do
    case "$NERSC_HOST" in
	cori)
	    for tg in mic-knl haswell; do
		build_boost $pe $tg	
	    done
	    ;;
	edison)
	    build_boost $pe ivybridge
	    ;;
	*)
	    echo "Unknown NERSC_HOST "$NERSC_HOST
	    exit 1
    esac
done
