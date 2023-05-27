LYTEBINDIR=$1
OUTDIR=$2


OUT=../../$OUTDIR

cd games/pongout
zip -9 -u -r $OUT/pongout_src.zip ** -x *.sh
cd ../..

rm -rf $OUTDIR/bin
mkdir -p $OUTDIR/bin

cat $LYTEBINDIR/lyte_gui.exe $OUTDIR/pongout_src.zip > $OUTDIR/bin/pongout_win_gui.exe
cat $LYTEBINDIR/lyte.exe $OUTDIR/pongout_src.zip > $OUTDIR/bin/pongout_win.exe
cat $LYTEBINDIR/lyte $OUTDIR/pongout_src.zip > $OUTDIR/bin/pongout_linux

rm -rf $OUTDIR/web
mkdir -p $OUTDIR/web

cp $OUTDIR/pongout_src.zip  $OUTDIR/web/app.zip
cp $LYTEBINDIR/lyte.html $OUTDIR/web/index.html
cp $LYTEBINDIR/lyte.js $OUTDIR/web/
cp $LYTEBINDIR/lyte.wasm $OUTDIR/web/

pushd $OUTDIR/web
zip -9 -u -r ../pongout_html.zip **
popd

pushd $OUTDIR/bin
zip -9 -u -r ../pongout_win64.zip pongout_win.exe
zip -9 -u -r ../pongout_linux64.zip pongout_linux
popd


ls -al ./${OUTDIR}
ls -al ./${OUTDIR}/bin
ls -al ./${OUTDIR}/web
