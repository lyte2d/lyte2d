# Dev docs

## How to build locally

- You may already know what you need to have on your machine/env :)
- `cmake -B ./build -S .` (and with all your optional specific configuration you'd like to pass)
- `cmake --build ./build`

### Windows shortcut scripts
- On Windows you'll need a Windows 10/11 SDK And a VS 2022 SDK cmdline (full VS installation is not needed)
- `etc/local_config.cmd`
- `etc/local_build.cmd`

### Linux or MacOS shortcut scripts
- `etc/Dockerfile`` contains all the requirements documented in executable form. Install those locally.
- `./etc/local_config.sh`
- `./etc/local_build.sh`

### WASM
- Emscripten SDK needs to be installed and activated. (See `Dockerfile`` for how)

## How to test "official" builds locally (or build with Docker)

### Prep
- Install docker
- Build the docker image with `./docker_make_buildimage.sh`

### Run
- `./etc/official_docker_run_fullbuild.sh`


### API definitions

- `./lyte/api_defs` folder contains Lyte2D API definitions in a DSL implemented in Lua
- From this, C bindings, documents and the typing files are generated
- Can be used to add other APIs (imagine adding a lyte_network top level, and defining the APIs for that in this folder)
- NOTE: YOU CAN OPT OUT OF THIS.  This folder can be safely removed if the desire is to manually edit/add new APIs going forward.

- API defs / impls are separated in the current design. This means, the impl file can be changed, for example to use SDL, to serve the same API
