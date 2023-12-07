# Lyte2D

## What

Lyte2D is a comfy little Lua framework for game development that is OSS and free. Lyte2D is a work in progress!

- [Lyte2D website](https://lyte2d.com)
- [Github repo](https://github.com/lyte2d/lyte2d)
- [Downloads](https://github.com/lyte2d/lyte2d/releases)

- Documentation: [lyte2d/documents/manual](https://github.com/lyte2d/documents/tree/main/manual)
- Example code: [lyte2d/documents/examples](https://github.com/lyte2d/documents/tree/main/examples)
- Typings: [lyte2d/documents/typings](https://github.com/lyte2d/documents/tree/main/typings)

- Community: [Discord](https://discord.gg/BKPfQrCaNU) and [Discussions](https://github.com/lyte2d/lyte2d/discussions)

This readme contains information about _developing_ Lyte2D _itself_. For developing _with_ Lyte2D, check out the links above.

## How to build locally (expert mode)

- You already know what you need to have on your machine/env. (Optinally you already have judged my CMakeLists.txt files :D)
- `cmake -B ./build -S .` (and with all your optional specific configuration you'd like to pass)
- `cmake --build ./build`

## How to build locally (scripts)

### Windows
- On Windows you'll need a Windows 10/11 SDK And a VS 2022 SDK cmdline (full VS installation is not needed)
- `local_config.cmd`
- `local_build.cmd`

### Linux or Windows with WSL (Tested only with Ubuntu)
- Dockerfile contains all the requirements documented in executable form. Install those locally.
- `./local_config.sh`
- `./local_build.sh`

### WASM
- Emscripten SDK needs to be installed and activated. (See Dockerfile for how)
- See `fullinstall.sh` (wasm config/build parts)

## How to test "official" builds (docker)

### Prep
- Install docker
- Build the docker image with `./docker_make_buildimage.sh`

### Run
- `./docker_fullbuild.sh`

## License

- This project is licensed under the terms of the MIT license. See [LICENSE](/LICENSE) file for details.
- Lyte2D depends on other software which have various licenses. See [licenses_all.txt](/licenses_all.txt) file for details.

