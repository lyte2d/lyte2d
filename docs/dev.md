## Lyte2D Dev Notes

## CMake build
- You may already know what you need to have on your machine/env :)
- `cmake -B ./build -S .` (and with all your optional specific configuration you'd like to pass)
- `cmake --build ./build`

### Docker based FULL build (emulates official CI build)
- Install docker
- Build the docker image with `./etc/docker_make_buildimage.sh` (or the mac version in the same dir)
- Run `./etc/official_docker_run_fullbuild.sh`
- With this build option, you don't need anything but Docker on the host system

### Windows shortcut scripts
- On Windows you'll need a Windows 10/11 SDK And a VS 2022 SDK cmdline (full VS installation is not needed)
- `./etc/local_config.cmd`
- `./etc/local_build.cmd`
- Alternatively you can use MinGW (like the official build, but this is not recommended.)

### Linux or MacOS shortcut scripts
- For Linux `etc/Dockerfile`` contains all the requirements documented in executable form. Install those locally.
- For MacOS you'll need the regular dev tools, XCode cmd line tools etc.
- `./etc/local_config.sh`
- `./etc/local_build.sh`

### WASM/HTML5 shortcut scritps
- Emscripten SDK needs to be installed and activated. (See `Dockerfile`` for how)
- Pretty straightforward, just like other emscripten cmake builds

### CI info
- Github based CI config is provided. It uses Docker to build Windows, Linux and Wasm builds serially. So it takes about 6-7 minutes.
- No official MacOS build yet, mainly because I'm not sure how signing would work. Mac devs should build locally.
- iOS/Android should work, but not tested. All components are compatible
- Top level version.txt file is used for filenames and tags
- Windows builds are less than ideal. They're build with mingw. Ideally they should be build with MSVC on the CI for smaller/faster binaries.

### API definitions & code/bindings generation
- `./lyte/api_defs/` folder contains Lyte2D API definitions in a DSL implemented in Lua
- From this, C bindings, documents and the typing files are generated
- It's a bit janky, but it works!
- Can be used to add other APIs (imagine adding a lyte_network top level, and defining the APIs for that in this folder)
- NOTE: YOU CAN OPT OUT OF THIS.  This folder can be safely removed if the desire is to manually edit/add new APIs going forward.

### Website
- Website is a separate repo, but uses data from this repo (like samples, typings, etc.)

### Notes
- This is written in a mixture of C89/C99 and Lua.
- GLFW, OpenGL, Sokol, Sokol_GP, Raudio, Freetype etc.
- No AI/LLM was used in building this framework. I'm not against LLM use (I use it elsewhere), but I haven't used it at all for this one.
- It's quite performant. I'm especially proud of font rendering and the completely dynamic (string) GLSL3x shaders that work everywhere.
- It's close to beta quality with the current release (as we removed the jankier parts)
- It works on Mac/Linux either with their respective binaries or directly running the Windows binaries with Wine.
- Ditto for SteamDeck! It just works!
- Should work on iOS and anroid with relatively small work
-

### Possible future avenues
- LuaJIT on desktop, or Lua 5.4.x everywhere
- Networking, Physics, GUIs
- Code/binding gen system (api_defs) can be ripped out, either to be replaced with some alternative or manual work
- Error handling can be done better
- luasteam integration. Should be very straightforward!
- Web based editor. Should be strightforward
- VSCode editor that incorporates the WASM build. Immediately display the game inside vscode