VERSION=0.1

LYTE=lyte2d.exe

ZIP_WIN=lyte2d.v${VERSION}.win_x64.zip
ZIP_WASM=lyte2d.v${VERSION}.wasm.zip

PONGOUT_ZIP=pongout.zip
PONGOUT_WIN_ZIP=pongout_win64.zip
PONGOUT_HTML_ZIP=pongout_html.zip


default: dev

clean-dev:
	rm -rf builds/build_dev/CMakeCache.txt
	rm -f builds/build_dev/lyte2d.exe

clean-win:
	rm -rf builds/build_vs/CMakeCache.txt
	rm -f builds/build_vs/lyte2d.exe

clean-wasm:
	rm -rf builds/build_ems/CMakeCache.txt
	rm -f builds/build_ems/lyte2d.*

config-dev:
	cmake  -DCMAKE_BUILD_TYPE=Debug  -S ./lyte2d -B ./builds/build_dev

config-win:
	cmake -S ./lyte2d -B ./builds/build_vs -G "Visual Studio 16"

config-wasm:
	emcmake cmake  -G "Unix Makefiles" -S ./lyte2d -B ./builds/build_ems

pack-win: win
	rm -f out/${ZIP_WIN}
	cd out && zip -9 -u -r ${ZIP_WIN} readme.md lyte2d.exe && cd ..

pack-wasm: wasm
	rm -f out/${ZIP_WASM}
	cd out && zip -9 -u -r ${ZIP_WASM} readme.md lyte2d.html lyte2d.js lyte2d.wasm

dev:
	rm -f out/lyte2d_dev.exe
	cmake --build builds/build_dev
	cp -r builds/build_dev/lyte2d.exe out/lyte2d_dev.exe
	ls -al out

win:
	rm -f out/lyte2d.exe
	cmake --build builds/build_vs --config MinSizeRel
	cp -r builds/build_vs/MinSizeRel/lyte2d.exe out/lyte2d.exe
	ls -al out

wasm:
	rm -f out/lyte2d.html
	rm -f out/lyte2d.js
	rm -f out/lyte2d.wasm
	cmake --build builds/build_ems
	cp -r builds/build_ems/lyte* out
	ls -al out

bootzip:
	rm -f out/boot.zip
	cd lyte2d/boot && zip -9 -u -r ../../out/boot.zip . -x *.tl && cd ../..
	cd out && xxd -i boot.zip ../lyte2d/src/_boot_zip.h && cd ..

exampleszip:
	rm -f out/examples.zip
	cd examples && zip -9 -u -r ../out/examples.zip . && cd ..

pongout:
	rm -f out/${PONGOUT_ZIP}
	cd games/pongout && zip -9 -u -r ../../out/${PONGOUT_ZIP} . -i app.cfg app.lua  boot/\* game/\* assets/\* -x ".*" *.tl  && cd ../..
	cat out/${LYTE} out/${PONGOUT_ZIP} > out/pongout.exe
	cd out && zip -9 -u -r ${PONGOUT_WIN_ZIP} pongout.exe && cd ..
	cd out && cp ${PONGOUT_ZIP} app.zip && zip -9 -u -r ${PONGOUT_HTML_ZIP} app.zip lyte2d.html lyte2d.js lyte2d.wasm && rm app.zip && cd ..
	ls -al out

build-rel: bootzip win pack-win wasm pack-wasm

build-website: wasm pongout exampleszip
	cp -r out/lyte2d.html website
	cp -r out/lyte2d.js website
	cp -r out/lyte2d.wasm website
	cp -r out/pongout.zip website
	cp -r out/examples.zip website

host:
	cd website && python -m http.server && cd ..

# personal use
L:
	cp out\lyte2d.exe \lua\l.exe