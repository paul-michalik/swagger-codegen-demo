#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
PROJECT_DIR=$(realpath ${SCRIPT_DIR}/../..)
VCPKG_DIR=${HOME}/.vcpkg

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
trap 'quit 1 "ERROR: script failed in line ${LINENO}"' ERR

# Determine platform, tool set and build type
PLATFORM=`uname -m`
TOOLSET=gcc.`gcc -dumpversion`
BUILD_TYPE=Release

if [[ ! -z "$1" ]]; then
	PLATFORM="$1"
fi
if [[ ! -z "$2" ]]; then
	TOOLSET="$2"
fi
if [[ ! -z "$3" ]]; then
	BUILD_TYPE="$3"
fi

# Determine build directory
BUILD_DIR="${PROJECT_DIR}/products/cmake.make.linux.${PLATFORM}.${TOOLSET}.${BUILD_TYPE}"
INSTALL_DIR="${PROJECT_DIR}/install/cmake.make.linux.${PLATFORM}.${TOOLSET}"

mkdir -p ${BUILD_DIR}
cmake \
	${PROJECT_DIR} \
	-B${BUILD_DIR} \
	-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
	-DCMAKE_TOOLCHAIN_FILE=${VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake \
	-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}

