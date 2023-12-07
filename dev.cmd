
@REM NOTE: this is a script for personal use. --MG

@REM  1) runs build (msvc, usually)
@REM  2) copies the ouput as both "lyte.exe" and "l.exe" in a path for manual testing elsewhere

cmd /c local_build.cmd
copy out\lyte.exe \bin\lyte.exe
copy out\lyte.exe \bin\l.exe
