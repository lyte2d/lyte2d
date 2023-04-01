#!/bin/sh

CURRDIR=$(pwd)

BUILDDIR=$CURRDIR/out/docker

echo
echo "@@@ BUILD SCRIPT"
echo "  datetime: " $(date)
echo
echo "  currentdir: " $CURRDIR
echo "  builddir: " $BUILDDIR
echo



echo "---> BUILD: WIN (GUI)"
cmake --build $BUILDDIR/wingui
echo "---> DONE: WIN (GUI)"
echo

echo "---> BUILD: WASM"
cmake --build $BUILDDIR/wasm
echo "---> DONE: WASM"
echo

echo "---> BUILD: LINUX"
cmake --build $BUILDDIR/linux
echo "---> DONE: LINUX"
echo

echo "---> BUILD: WIN (console)"
cmake --build $BUILDDIR/win
echo "---> DONE: WIN (console)"


echo "@@@ DONE: BUILD SCRIPT"
echo "  datetime: " $(date)
echo