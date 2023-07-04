echo "configuring"

cmake  -DCMAKE_BUILD_TYPE=MinSizeRel  -S ./lyte -B ./out/builds/msvc_minsizerel -G "Visual Studio 16"
