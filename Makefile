VERSION=${shell cat version.txt}

default:
	cat Makefile
	echo "VERSION ${VERSION}"

## Note: Every target is "PHONY" in this Makefile

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


clean-docker:
	rm -rf /src/out/rel
	rm -rf /src/out/docker

clean-out-bins:
	rm -rf ./out/lyte*.*

copy-rel-out: clean-out-bins
	cp ./out/rel/bin/* ./out/
	ls -al ./out/



## Code generators (local development use)

codegen-bootzip:
	rm -f out/boot.zip
	cd lyte_boot/boot && zip -9 -u -r ../../out/boot.zip . -x *.tl && cd ../..
	cd out && xxd -i boot.zip ../lyte_boot/include/_boot_zip_generated.c && cd ../..
	mv out/boot.zip out/boot_old.zip
	rm -f out/boot.zip

codegen-apidefs:
	make -C lyte_api/defs all

## codegen things
gen: codegen-bootzip codegen-apidefs

