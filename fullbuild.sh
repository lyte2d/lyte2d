#!//bin/sh

####  LYTE2D OFFICIAL BUILD
####
####  - Runs with github CI to produce Lyte2D release artifacts
####  - The 'Dockerfile' in the same location can be used to match all the requirements


#############
# VARS
#############

VERSION=$(cat version.txt)
CURRDIR=$(pwd)
# relative source locations
SOURCEDIR=$CURRDIR
DOCDIR=$CURRDIR/documents
# relative build & release locations
BUILDDIR=$CURRDIR/out/docker
RELDIR=$CURRDIR/out/rel
# copy & pack location
BINDIR=$RELDIR/bin
TMPDIR=$RELDIR/tmp
ZIPDIR=$RELDIR/zip
ZIPCMD='zip -9 -u -r'

#############
# BEGIN
#############

echo "@@@ BEGIN: $(date)"
echo "lyte2d version: ${VERSION} sourcedir: ${SOURCEDIR} outdir: ${BUILDDIR}"

#############
# Configure
#############

echo "@@@ CONFIGURE: $(date)"

echo " @@ cfg: wingui"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DWIN_GUI=1 -DCMAKE_TOOLCHAIN_FILE=$SOURCEDIR/mingw.cmake -S $SOURCEDIR/lyte -B $BUILDDIR/wingui

echo " @@ cfg: wasm"
source /emsdk/emsdk_env.sh
emcmake cmake  -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" -S $SOURCEDIR/lyte -B $BUILDDIR/wasm

echo " @@ cfg: linux"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -S $SOURCEDIR/lyte -B $BUILDDIR/linux

echo " @@ cfg: win"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_TOOLCHAIN_FILE=$SOURCEDIR/mingw.cmake -S $SOURCEDIR/lyte -B $BUILDDIR/win


#############
# Build
#############

echo "@@@ BUILD: $(date)"

echo " @@ build: wasm"
cmake --build $BUILDDIR/wasm

echo " @@ build: wingui"
cmake --build $BUILDDIR/wingui

echo " @@ build: linux"
cmake --build $BUILDDIR/linux

echo " @@ build: win"
cmake --build $BUILDDIR/win


#############
# Copy
#############

echo "@@@ COPY: $(date)"

mkdir -p $RELDIR
mkdir -p $RELDIR/bin

cp $BUILDDIR/wingui/lyte_gui.exe $RELDIR/bin

cp $BUILDDIR/wasm/lyte.html $RELDIR/bin
cp $BUILDDIR/wasm/lyte.wasm $RELDIR/bin
cp $BUILDDIR/wasm/lyte.js $RELDIR/bin

cp $BUILDDIR/linux/lyte $RELDIR/bin

cp $BUILDDIR/win/lyte.exe $RELDIR/bin

#############
# Pack
#############
echo "@@@ PACK: $(date)"

rm -rf $ZIPDIR
mkdir -p $ZIPDIR
mkdir -p $TMPDIR

cp -r $DOCDIR/licenses.txt $TMPDIR/
cp -r $DOCDIR/readme.md $TMPDIR/
# cp -r $DOCDIR/guide.md $TMPDIR/
cp -r $BINDIR/* $TMPDIR/

cd $TMPDIR
echo " @@ to be packed: ls -al:"
pwd
ls -al
echo " @@"
$ZIPCMD $ZIPDIR/lyte2d.windows-gui.x64.v$VERSION.zip  licenses.txt readme.md   lyte_gui.exe
$ZIPCMD $ZIPDIR/lyte2d.wasm.v$VERSION.zip             licenses.txt readme.md   lyte.html lyte.js lyte.wasm
$ZIPCMD $ZIPDIR/lyte2d.linux.x64.v$VERSION.zip        licenses.txt readme.md   lyte
$ZIPCMD $ZIPDIR/lyte2d.windows.x64.v$VERSION.zip      licenses.txt readme.md   lyte.exe
# $ZIPCMD $ZIPDIR/lyte2d.EVERYTHING.x64.v$VERSION.zip   licenses.txt readme.md   lyte* lyte*.*
cd ..

rm -rf $TMPDIR

#############
# END
#############
echo "@@@ END: $(date)"

