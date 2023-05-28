VERSION=${shell cat version.txt}

default:
	cat Makefile
	echo "VERSION ${VERSION}"

## Note: Every target is "PHONY" in this Makefile


## Code generators (local development use)

codegen-bootzip:
	rm -f out/boot.zip
	cd lyte_boot && zip -9 -u -r ../out/boot.zip . -x *.tl && cd ..
	cd out && xxd -i boot.zip ../lyte_boot/include/_boot_zip_generated.c && cd ../..
	rm -f out/boot.zip

codegen-apidefs:
	make -C lyte_api/defs all

## Local / Dev builds

local-config-msvc-minsizerel:
	echo "---> CONFIG: Local (msvc console, minsizerel)"
	cmake  -DCMAKE_BUILD_TYPE=MinSizeRel  -S ./lyte -B ./out/builds/msvc_minsizerel -G "Visual Studio 16"

local-build-msvc-minsizerel:
	echo "---> BUILD: Local (msvc console, minsizerel)"
	cmake --build ./out/builds/msvc_minsizerel  --config MinSizeRel
	cp -f ./out/builds/msvc_minsizerel/MinSizeRel/* ./out/

local-config-msvc-debug:
	echo "---> CONFIG: Local (msvc console, debug)"
	cmake  -DCMAKE_BUILD_TYPE=Debug  -S ./lyte -B ./out/builds/msvc_debug -G "Visual Studio 16"

local-build-msvc-debug:
	echo "---> BUILD: Local (msvc console, debug)"
	cmake --build ./out/builds/msvc_debug  --config Debug
	cp -f ./out/builds/msvc_debug/Debug/* ./out/

local-config-gcc-minsizerel:
	echo "---> CONFIG: Local (gcc console, minsizerel)"
	cmake  -DCMAKE_BUILD_TYPE=MinSizeRel  -S ./lyte -B ./out/builds/gcc_minsizerel

local-build-gcc-minsizerel:
	echo "---> BUILD: Local (gcc console, minsizerel)"
	cmake --build ./out/builds/gcc_minsizerel
	cp -f ./out/builds/gcc_minsizerel ./out/

local-config-gcc-debug:
	echo "---> CONFIG: Local (gcc console, debug)"
	cmake  -DCMAKE_BUILD_TYPE=Debug  -S ./lyte -B ./out/builds/gcc_debug

local-build-gcc-debug:
	echo "---> BUILD: Local (gcc console, debug)"
	cmake --build ./out/builds/gcc_debug
	cp -f ./out/builds/gcc_debug ./out/


## Build the official build image locally
## Can be used for either testing lyte2d changes

docker-image-build:
	docker build -t more/builder:0.1 -f ./build_scripts/Dockerfile .
	docker tag more/builder:0.1 more/builder:latest

official-build:
	./build_scripts/official_build.sh

## Personal use/concenience (MG)

DOCKER_RUN_INTERACTIVE=docker run -it --rm --name=builder \
    	--mount type=bind,source=${PWD},target=/src \
		--workdir /src \
    	-t more/builder:latest

# Shell on the builder image for debugging build issues
docker-bash:
	${DOCKER_RUN_INTERACTIVE} bash


clean-docker:
	rm -rf /src/out/rel
	rm -rf /src/out/docker

clean-out-bins:
	rm -rf ./out/lyte*.*

copy-rel-out: clean-out-bins
	cp ./out/rel/bin/* ./out/
	ls -al ./out/

pongout:
	rm -rf ./out/pongout
	mkdir ./out/pongout
	games/pongout/build.sh ./out/rel/bin ./out/pongout

website:
	rm -rf out/website
	mkdir -p out/website
	# copy lyte wasm files to the website folder
	cp ./out/docker/wasm/lyte.html ./out/website
	cp ./out/docker/wasm/lyte.js ./out/website
	cp ./out/docker/wasm/lyte.wasm ./out/website
	# make examples.zip inside the website folder
	cd ./examples && zip -9 -u -r ../out/website/examples.zip * && cd ..
	# make the website
	make -C website_src

## To host web pages locally for testing:
##   with python: python -m http.server
##   with node: http-server (install with npm install -g http-server)

host-pongout:
	cd out/pongout/web && http-server . && cd ../../..

host-website:
	cd out/website && http-server . && cd ..


## codegen things
gen: codegen-bootzip codegen-apidefs

## currently used build target
## should be one of the local-config-* or local-build-* (the star part)
# LOCAL_TARGET=msvc-debug
LOCAL_TARGET=msvc-minsizerel

cfg: local-config-${LOCAL_TARGET}

bld: local-build-${LOCAL_TARGET}
	ls -al ./out/

## for testing the build more generally
dev: bld
	rm \lua\l.exe
	cp out/lyte.exe \lua/lyte.exe
	ln -s \lua/lyte.exe \lua/l.exe

po:
	make dev && cp out\lyte.exe out\rel\bin\ && make pongout && out\pongout\bin\pongout_win.exe