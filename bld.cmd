echo "building"

cmake --build ./out/builds/msvc_minsizerel  --config MinSizeRel
copy out\builds\msvc_minsizerel\MinSizeRel\* out
