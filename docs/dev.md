# Dev docs

## How to build locally

### Windows
- On Windows you'll need a Windows 10/11 SDK And a VS 2022 SDK cmdline (full VS installation is not needed)
- `etc/local_config.cmd`
- `etc/local_build.cmd`

### Linux or Windows with WSL (Tested only with Ubuntu)
- `etc/Dockerfile`` contains all the requirements documented in executable form. Install those locally.
- `./etc/local_config.sh`
- `./etc/local_build.sh`

## How to build locally (expert mode)

- You may already know what you need to have on your machine/env :)
- `cmake -B ./build -S .` (and with all your optional specific configuration you'd like to pass)
- `cmake --build ./build`

### WASM
- Emscripten SDK needs to be installed and activated. (See `Dockerfile`` for how)

## How to test "official" builds locally (or build with Docker)

### Prep
- Install docker
- Build the docker image with `./docker_make_buildimage.sh`

### Run
- `./etc/official_docker_run_fullbuild.sh`

## License

- This project is licensed under the terms of the MIT license. See [LICENSE](/LICENSE) file for details.
- Lyte2D depends on other software which have various licenses. See [licenses_all.txt](/licenses_all.txt) file for details.

