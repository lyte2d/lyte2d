# ubuntu 18:04 is chosen as base due to the glibc version (old enough)
FROM ubuntu:18.04
LABEL Description="Lyte2D Build Environment"

ENV HOME /root

SHELL ["/bin/bash", "-c"]

# basics
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
            ca-certificates \
            gnupg  \
            less \
            wget \
            curl \
            zip \
            git \
            npm \
            nodejs \
            python3-pip \
            python3 \
            xxd \
            lua5.1 \
    && update-ca-certificates

# cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.19.8/cmake-3.19.8-Linux-x86_64.sh -q -O /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir /opt/cmake-3.19.8 \
    && /tmp/cmake-install.sh --skip-license --prefix=/opt/cmake-3.19.8 \
    && rm /tmp/cmake-install.sh \
    && ln -s /opt/cmake-3.19.8/bin/* /usr/local/bin

# dev envs & dependencies
RUN apt-get -y --no-install-recommends install \
            build-essential \
            gdb \
            clang \
            mingw-w64 \
            libx11-dev \
            libxrandr-dev \
            libxinerama-dev \
            libxcursor-dev \
            libxi-dev \
            libglu1-mesa-dev

# wasm/emscripten
RUN git clone https://github.com/emscripten-core/emsdk.git \
    && cd emsdk \
    && git pull \
    && ./emsdk install latest \
    && ./emsdk activate latest \
    && cd ..
