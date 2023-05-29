#!/bin/bash

cd ~
mkdir catkin_carto
cd catkin_carto

https://github.com/BAICIRS/cartographer.git

sudo apt-get install \
    clang \
    cmake \
    g++ \
    git \
    google-mock \
    libboost-all-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libeigen3-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblua5.2-dev \
    libsuitesparse-dev \
    lsb-release \
    ninja-build \
    stow \
	libatlas-base-dev


# Build and install abseil-cpp
set -o errexit
set -o verbose

cd ~/catkin_carto/abseil-cpp
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_INSTALL_PREFIX=/usr/local/stow/absl \
  ..
ninja
sudo ninja install
cd /usr/local/stow
sudo stow absl


# Build and install Ceres.
cd ~/catkin_carto/ceres 
mkdir build
cd build
cmake .. -G Ninja -DCXX11=ON
ninja
#CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install


# Build and install proto3.
cd ~/catkin_carto/protobuf 
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -Dprotobuf_BUILD_TESTS=OFF \
  ../cmake
ninja
sudo ninja install

#ros install cartographer
cd ~/catkin_carto

catkin_make_isolated --install --use-ninja
#catkin_make_isolated --install --use-ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=Yes

source install_isolated/setup.bash
