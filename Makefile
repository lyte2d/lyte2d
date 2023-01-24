VERSION=0.2

LYTE=lyte2d.exe
LYTE_LINUX=lyte2d

ZIP_WIN=lyte2d.v${VERSION}.win_x64.zip
ZIP_LINUX=lyte2d.v${VERSION}.linux_x64.zip
ZIP_WASM=lyte2d.v${VERSION}.wasm.zip

PONGOUT_ZIP=pongout.zip
PONGOUT_WIN_ZIP=pongout_win64.zip
PONGOUT_LINUX_ZIP=pongout_linux64.zip
PONGOUT_HTML_ZIP=pongout_html.zip


default:
	cat Makefile

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
	cmake  -DCMAKE_BUILD_TYPE=MinSizeRel  -S ./lyte2d -B ./builds/build_dev

config-win:
	cmake -S ./lyte2d -B ./builds/build_vs -G "Visual Studio 16"

config-wasm:
	emcmake cmake  -G "Unix Makefiles" -S ./lyte2d -B ./builds/build_ems

pack-linux: # dev.... make sure linux build is ready
	rm -f out/${ZIP_LINUX}
	cd out && zip -9 -u -r ${ZIP_LINUX} readme.md lyte2d && cd ..

pack-win: win
	rm -f out/${ZIP_WIN}
	cd out && zip -9 -u -r ${ZIP_WIN} readme.md lyte2d.exe && cd ..

pack-wasm: wasm
	rm -f out/${ZIP_WASM}
	cd out && zip -9 -u -r ${ZIP_WASM} readme.md index.html lyte2d.js lyte2d.wasm

dev:
	rm -f out/lyte2d_dev.exe
	cmake --build builds/build_dev --config MinSizeRel
	cp -r builds/build_dev/lyte2d out/lyte2d
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
	cp out/lyte2d.html out/index.html
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
	cat out/${LYTE} out/${PONGOUT_ZIP} > out/pongout_linux.exe
	cat out/${LYTE_LINUX} out/${PONGOUT_ZIP} > out/pongout.exe
	cd out && zip -9 -u -r ${PONGOUT_WIN_ZIP} pongout.exe && cd ..
	cd out && zip -9 -u -r ${PONGOUT_LINUX_ZIP} pongout_linux && cd ..
	cd out && cp ${PONGOUT_ZIP} app.zip && zip -9 -u -r ${PONGOUT_HTML_ZIP} app.zip index.html lyte2d.js lyte2d.wasm && rm app.zip && cd ..
	ls -al out

host-out:
	cd out && http-server && cd ..

# Make sure to have linux binary ready
build-rel: bootzip win pack-win wasm pack-wasm pack-linux

build-website: wasm pongout exampleszip
	rm website/*.html
	make -C webgen
	cp -r out/lyte2d.html website
	cp -r out/lyte2d.js website
	cp -r out/lyte2d.wasm website
	cp -r out/pongout.zip website
	cp -r out/examples.zip website

build-all: build-rel build-website

host-website:
	# with python: python -m http.server
	# with node: http-server (install with npm install -g http-server)
	cd website && http-server ./ && cd ..

# testing the static website gen code
# mk-newsite:
	# make -C webgen

# personal use
L:
	cp out/lyte2d.exe \lua/l.exe
	# cp -r out/index.html ./scratch
	# cp -r out/lyte2d.js ./scratch
	# cp -r out/lyte2d.wasm ./scratch
S:
	l dir=scratch
