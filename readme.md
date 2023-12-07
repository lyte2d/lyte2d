# Lyte2D

## What

Lyte2D is a comfy little Lua framework for game development that is OSS and free. Lyte2D is a work in progress!

- [Lyte2D website](https://lyte2d.com)
- [Github repo](https://github.com/lyte2d/lyte2d)
- [Downloads](https://github.com/lyte2d/lyte2d/releases)

- Manual: [manual](https://github.com/lyte2d/lyte2d/tree/main/manual)
- Example code: [samples](https://github.com/lyte2d/lyte2d/tree/main/samples)
- Typings: [typings](https://github.com/lyte2d/lyte2d/tree/main/typings)

- Community: [Discord](https://discord.gg/BKPfQrCaNU) and [Discussions](https://github.com/lyte2d/lyte2d/discussions)

This readme contains information about _developing_ Lyte2D _itself_. For developing _with_ Lyte2D, check out the links above.

## How to build locally

### Windows
- On Windows you'll need a Windows 10/11 SDK And a VS 2022 SDK cmdline (full VS installation is not needed)
- `local_config.cmd`
- `local_build.cmd`

### Linux or Windows with WSL (Tested only with Ubuntu)
- `Dockerfile`` contains all the requirements documented in executable form. Install those locally.
- `./local_config.sh`
- `./local_build.sh`

## How to build locally (expert mode)

- You may already know what you need to have on your machine/env :)
- `cmake -B ./build -S .` (and with all your optional specific configuration you'd like to pass)
- `cmake --build ./build`

### WASM
- Emscripten SDK needs to be installed and activated. (See `Dockerfile`` for how)
- See `fullinstall.sh` (wasm config/build parts)

## How to test "official" builds locally (or build with Docker)

### Prep
- Install docker
- Build the docker image with `./docker_make_buildimage.sh`

### Run
- `./docker_fullbuild.sh`

## License

- This project is licensed under the terms of the MIT license. See [LICENSE](/LICENSE) file for details.
- Lyte2D depends on other software which have various licenses. See [licenses_all.txt](/licenses_all.txt) file for details.

