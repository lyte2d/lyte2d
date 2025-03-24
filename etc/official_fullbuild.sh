#!//bin/sh

####  LYTE2D OFFICIAL BUILD


#############
# VARS
#############

VERSION=$(cat version.txt)
CURRDIR=$(pwd)

# relative source locations
SOURCEDIR=$CURRDIR

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
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DWIN_GUI=1 -DCMAKE_TOOLCHAIN_FILE=$SOURCEDIR/etc/mingw.cmake -S $SOURCEDIR -B $BUILDDIR/wingui

echo " @@ cfg: wasm"
source /emsdk/emsdk_env.sh
emcmake cmake  -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" -S $SOURCEDIR -B $BUILDDIR/wasm

echo " @@ cfg: linux"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -S $SOURCEDIR -B $BUILDDIR/linux

echo " @@ cfg: win"
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_TOOLCHAIN_FILE=$SOURCEDIR/etc/mingw.cmake -S $SOURCEDIR -B $BUILDDIR/win


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


cp $BUILDDIR/wingui/lyte/lyte_gui.exe $RELDIR/bin

cp $BUILDDIR/wasm/lyte/lyte.html $RELDIR/bin
# cp $BUILDDIR/wasm/lyte/lyte.wasm $RELDIR/bin
# cp $BUILDDIR/wasm/lyte/lyte.js $RELDIR/bin

cp $BUILDDIR/linux/lyte/lyte $RELDIR/bin

cp $BUILDDIR/win/lyte/lyte.exe $RELDIR/bin


#############
# Pack
#############

echo "@@@ PACK: $(date)"

rm -rf $ZIPDIR
mkdir -p $ZIPDIR
mkdir -p $TMPDIR

mkdir -p $TMPDIR/docs

cp -r $SOURCEDIR/LICENSE $TMPDIR/docs
cp -r $SOURCEDIR/deps/deps_licenses.txt $TMPDIR/docs
cp -r $SOURCEDIR/typings/* $TMPDIR/docs
cp -r $SOURCEDIR/docs/guide.md $TMPDIR/docs


cp -r $BINDIR/* $TMPDIR/


cd $TMPDIR
echo " @@ to be packed: ls -al:"
pwd
ls -al
echo " @@"
$ZIPCMD $ZIPDIR/lyte2d.windows.x64.v$VERSION.zip   docs/*   lyte.exe   lyte_gui.exe
$ZIPCMD $ZIPDIR/lyte2d.wasm.v$VERSION.zip          docs/*   lyte.html  # lyte.js lyte.wasm
$ZIPCMD $ZIPDIR/lyte2d.linux.x64.v$VERSION.zip     docs/*   lyte
cd ..

rm -rf $TMPDIR


#############
# END
#############

echo "@@@ END: $(date)"

