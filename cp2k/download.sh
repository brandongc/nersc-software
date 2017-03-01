#!/bin/bash
VN=$(echo $V | tr "." "_")
fname=cp2k-$VN-branch
if ! [ -d "$fname" ]
then
    svn checkout http://svn.code.sf.net/p/cp2k/code/branches/cp2k-4_1-branch
fi
