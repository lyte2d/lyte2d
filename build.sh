#!//bin/sh
cmake --build ./out/builds/gcc_minsizerel
cp out/builds/gcc_minsizerel/lyte/lyte out
