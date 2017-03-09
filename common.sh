#!/bin/bash
export PREFIX=$SCRATCH/sw

export TAG=`date "+%F"`
export PKGROOT=`pwd`
export NJOBS=10
export TMPDIR=/tmp

# helper functions for builds
to_lower() {
    echo "$@" | tr '[:upper:]' '[:lower:]'
}

set_pe () {
    PE=$1
    TG=$2
    curr_pe=$(to_lower "$PE_ENV")
    curr_tg=$(to_lower "$CRAY_CPU_TARGET")
    if [[ "$curr_pe" != "$PE" ]]; then
        module swap PrgEnv-$curr_pe PrgEnv-$PE
    fi
    if [[ "$curr_tg" != "$TG" ]]; then
        module swap craype-$curr_tg craype-$TG
    fi
}
