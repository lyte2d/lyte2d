#!/usr/bin/bash

CURRDIR=$(pwd)

RELDIR=$CURRDIR/out/rel
BUILDDIR=$CURRDIR/out/docker

echo
echo "@@@ COPY SCRIPT"
echo "  datetime: " $(date)
echo
echo "  currentdir: " $CURRDIR
echo "  reldir: " $RELDIR
echo "  builddir: " $BUILDDIR
echo

mkdir -p $RELDIR
mkdir -p $RELDIR/bin

cp $BUILDDIR/wingui/lyte_gui.exe $RELDIR/bin

cp $BUILDDIR/wasm/lyte.html $RELDIR/bin
cp $BUILDDIR/wasm/lyte.wasm $RELDIR/bin
cp $BUILDDIR/wasm/lyte.js $RELDIR/bin

cp $BUILDDIR/linux/lyte $RELDIR/bin

cp $BUILDDIR/win/lyte.exe $RELDIR/bin


echo "@@@ DONE: COPY SCRIPT"
echo "  datetime: " $(date)
echo