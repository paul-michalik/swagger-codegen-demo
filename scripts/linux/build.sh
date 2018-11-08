#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
PROJECT_DIR=$(realpath ${SCRIPT_DIR}/../..)
GEN_TARGET='cpp-restsdk'
BUILD_TARGET='install'

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


. ${SCRIPT_DIR}/configure.sh
${SCRIPT_DIR}/detail/generate-map.ingest.api.sh ${GEN_TARGET}

CORES=$(( $(nproc) - 1 ))
if [ "$cores" = "0" ]; then
  CORES=1
fi

cmake --build ${BUILD_DIR} \
	#--target ${BUILD_TARGET} \
	-- -j${CORES}
