#!/bin/bash

script_dir=$(realpath $(dirname $0))
project_dir=$(realpath ${script_dir}/../..)
cores=$(nproc)

# ----------------------------------------------------------------------------------

# Quit with given exit code and message
function quit()
{
	echo "ERROR: " $2
	exit $1
}

# ----------------------------------------------------------------------------------

# Exit if a simple command exits with a non-zero status
# See http://mywiki.wooledge.org/BashFAQ/105
trap 'quit 1 "ERROR: script failed in line $LINENO"' ERR

# Determine platform, tool set and build type
platform=`uname -m`
toolset=gcc.`gcc -dumpversion`
build_type=Release

if [[ ! -z "$1" ]]; then
    platform="$1"
fi
if [[ ! -z "$2" ]]; then
    toolset="$2"
fi
if [[ ! -z "$3" ]]; then
    build_type="$3"
fi

# Determine build directory
build_dir="${project_dir}/products/cmake.make.linux.${platform}.${toolset}.${build_type}"
echo ${build_dir}

cd ${project_dir}
mkdir -p ${build_dir}

cmake \
    ${project_dir} \
    -B${build_dir} \
    -DCMAKE_BUILD_TYPE=${build_type} \
    -DBUILD_ALL_EXAMPLES=ON \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_EXPERIMENTS=ON \
    -DBUILD_TOOLS=ON \
    -DBUILD_TESTING=ON \
    -DWARNINGS=OFF \
    -DPRINT_CMAKE_VARIABLES=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr/local

cmake \
    --build ${build_dir} \
    --config ${build_type} \
    --target install \
    -- -j${cores}
