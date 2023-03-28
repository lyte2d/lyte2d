#!/usr/bin/bash

CURRDIR=$(pwd)

SOURCEDIR=$CURRDIR
BUILDDIR=$CURRDIR/out/docker

echo
echo "@@@ CONFIG SCRIPT"
echo "  datetime: " $(date)
echo

echo "  currentdir: " $CURRDIR
echo "  sourcedir: " $SOURCEDIR
echo "  builddir: " $BUILDDIR
echo

echo "---> CONFIG: WIN (GUI)"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DWIN_GUI=1 -DCMAKE_TOOLCHAIN_FILE=$SOURCEDIR/build_scripts/mingw.cmake -S $SOURCEDIR/lyte -B $BUILDDIR/wingui
echo "---> DONE: WIN (GUI)"

echo "---> CONFIG: WASM"
source /emsdk/emsdk_env.sh
emcmake cmake  -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" -S $SOURCEDIR/lyte -B $BUILDDIR/wasm
echo "---> DONE: WASM"

echo "---> CONFIG: LINUX"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -S $SOURCEDIR/lyte -B $BUILDDIR/linux
echo "---> DONE: LINUX"

echo "---> CONFIG: WIN (console)"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_TOOLCHAIN_FILE=$SOURCEDIR/build_scripts/mingw.cmake -S $SOURCEDIR/lyte -B $BUILDDIR/win
echo "---> DONE: WIN (console)"
echo "@@@ CONFIG SCRIPT"

echo
echo "@@@ DONE: CONFIG SCRIPT"
echo "  datetime: " $(date)
echo