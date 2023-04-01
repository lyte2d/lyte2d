#!//bin/sh

VERSION=$1

CURRDIR=$(pwd)
RELDIR=$CURRDIR/out/rel
DOCDIR=$CURRDIR/docs

BINDIR=$RELDIR/bin
TMPDIR=$RELDIR/tmp
ZIPDIR=$RELDIR/zip

ZIPCMD='zip -9 -u -r'

echo
echo "@@@ PACK SCRIPT"
echo "  datetime: " $(date)
echo

echo "  currentdir: " $CURRDIR
echo "  version: " $VERSION
echo "  docdir: " $DOCDIR
echo "  reldir: " $RELDIR
echo "  tmpdir: " $TMPDIR
echo "  zipdir: " $ZIPDIR
echo

rm -rf $ZIPDIR
mkdir -p $ZIPDIR
mkdir -p $TMPDIR

cp -r $DOCDIR/licenses.txt $TMPDIR/
cp -r $DOCDIR/readme.txt $TMPDIR/
cp -r $BINDIR/* $TMPDIR/

cd $TMPDIR

echo "--- to be packed: listing ---"
pwd
ls -al
echo "------"

$ZIPCMD $ZIPDIR/lyte2d.windows-gui.x64.v$VERSION.zip  licenses.txt readme.txt   lyte_gui.exe
$ZIPCMD $ZIPDIR/lyte2d.wasm.v$VERSION.zip             licenses.txt readme.txt   lyte.html lyte.js lyte.wasm
$ZIPCMD $ZIPDIR/lyte2d.linux.x64.v$VERSION.zip        licenses.txt readme.txt   lyte
$ZIPCMD $ZIPDIR/lyte2d.windows.x64.v$VERSION.zip      licenses.txt readme.txt   lyte.exe
$ZIPCMD $ZIPDIR/lyte2d.EVERYTHING.x64.v$VERSION.zip   licenses.txt readme.txt   lyte* lyte*.*

cd ..
rm -rf $TMPDIR

echo
echo "@@@ DONE: PACK SCRIPT"
echo "  datetime: " $(date)
echo
