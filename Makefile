VERSION=0.3

LYTE_WIN=lyte.exe
LYTE_LINUX=lyte

ZIP_WIN=lyte.v${VERSION}.win_x64.zip
ZIP_LINUX=lyte.v${VERSION}.linux_x64.zip
ZIP_WASM=lyte.v${VERSION}.wasm.zip

PONGOUT_SRC_ZIP=pongout_src.zip
PONGOUT_WIN_ZIP=pongout_win64.zip
PONGOUT_LINUX_ZIP=pongout_linux64.zip
PONGOUT_HTML_ZIP=pongout_html.zip

default:
	cat Makefile

clean-dev:
	rm -rf builds/dev/CMakeCache.txt
	rm -f builds/dev/lyte.exe

clean-win:
	rm -rf builds/win/CMakeCache.txt
	rm -f builds/win/lyte.exe

clean-linux:
	rm -rf builds/linux/CMakeCache.txt
	rm -f builds/linux/lyte

clean-wasm:
	rm -rf builds/wasm/CMakeCache.txt
	rm -f builds/wasm/lyte.*

config-dev:
	cmake -S ./lyte -B ./builds/dev -G "Visual Studio 16"

config-win:
	cmake -S ./lyte -B ./builds/win -G "Visual Studio 16"

config-linux:
	cmake  -DCMAKE_BUILD_TYPE=MinSizeRel  -S ./lyte -B ./builds/linux

config-wasm:
	emcmake cmake  -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" -S ./lyte -B ./builds/wasm

pack-win: win
	rm -f out/${ZIP_WIN}
	cd out && zip -9 -u -r ${ZIP_WIN} readme.md lyte.exe && cd ..

pack-linux: # dev.... make sure linux build is ready
	rm -f out/${ZIP_LINUX}
	cd out && zip -9 -u -r ${ZIP_LINUX} readme.md lyte && cd ..

pack-wasm: wasm
	rm -f out/${ZIP_WASM}
	cd out && zip -9 -u -r ${ZIP_WASM} readme.md index.html lyte.js lyte.wasm

dev:
	rm -f out/lyte.exe
	cmake --build builds/dev --config Debug
	cp -r builds/dev/Debug/lyte.exe out/lyte.exe
	ls -al out

win:
	rm -f out/lyte.exe
	cmake --build builds/win --config MinSizeRel
	cp -r builds/win/MinSizeRel/lyte.exe out/lyte.exe
	ls -al out

linux:
	rm -f out/lyte
	cmake --build builds/linux --config MinSizeRel
	cp -r builds/linux/lyte out/lyte
	ls -al out

wasm:
	rm -f out/lyte.html
	rm -f out/lyte.js
	rm -f out/lyte.wasm
	cmake --build builds/wasm
	cp -r builds/wasm/lyte* out
	cp out/lyte.html out/index.html
	ls -al out

bootzip:
	rm -f out/boot.zip
	cd lyte/boot && zip -9 -u -r ../../out/boot.zip . -x *.tl && cd ../..
	cd out && xxd -i boot.zip ../lyte/src/_boot_zip.h && cd ..

exampleszip:
	rm -f out/examples.zip
	cd examples && zip -9 -u -r ../out/examples.zip . && cd ..

webpage:
	rm -rf website/**
	make -C webgen
	cp -r out/lyte.html website
	cp -r out/lyte.js website
	cp -r out/lyte.wasm website
	cp -r out/examples.zip website

pongout:
	rm -f out/${PONGOUT_SRC_ZIP}
	cd games/pongout && zip -9 -u -r ../../out/${PONGOUT_SRC_ZIP} . -i app.cfg app.lua  boot/\* game/\* assets/\* -x ".*" *.tl  && cd ../..
	cat out/${LYTE_WIN} out/${PONGOUT_SRC_ZIP} > out/pongout_win.exe
	cat out/${LYTE_LINUX} out/${PONGOUT_SRC_ZIP} > out/pongout_linux
	cd out && zip -9 -u -r ${PONGOUT_WIN_ZIP} pongout_win.exe && cd ..
	cd out && zip -9 -u -r ${PONGOUT_LINUX_ZIP} pongout_linux && cd ..
	cd out && cp ${PONGOUT_SRC_ZIP} app.zip && zip -9 -u -r ${PONGOUT_HTML_ZIP} app.zip index.html lyte.js lyte.wasm && rm app.zip && cd ..
	ls -al out

# Make sure to have linux binary ready
build-rel: bootzip win pack-win wasm pack-wasm pack-linux

build-website: wasm pongout exampleszip webpage

build-all: build-rel build-website

host-out:
	# with python: python -m http.server
	# with node: http-server (install with npm install -g http-server)
	cd out && http-server && cd ..

host-website:
	# with python: python -m http.server
	# with node: http-server (install with npm install -g http-server)
	cd website && http-server ./ && cd ..

# personal use
L:
	cp out/lyte.exe \lua/lyte.exe
	# cp -r out/index.html ./scratch
	# cp -r out/lyte.js ./scratch
	# cp -r out/lyte.wasm ./scratch
S:
	l dir=scratch
