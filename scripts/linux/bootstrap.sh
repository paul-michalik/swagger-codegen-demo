#!/bin/bash

# Setup local variables
gcc_version=7
cmake_version=3.10.1
cmake_dir=${HOME}/.cmake
vcpkg_dir=${HOME}/.vcpkg
vcpkg_modules='cpprestsdk boost-test'

# ----------------------------------------------------------------------------------

# Quit with given exit code and message
function quit()
{
	echo "ERROR: " $2
	exit $1
}

# Install given compilers
function install_compiler()
{
	add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
	apt-get update -y && \
	apt-get install build-essential software-properties-common -y  && \
	apt-get install gcc-snapshot -y && \
	apt-get install gcc-$1 g++-$1 -y
	update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$1 10
	update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-$1 10
	update-alternatives --set gcc /usr/bin/gcc-$1
	update-alternatives --set g++ /usr/bin/g++-$1
}

# Install  given cmake version to given path
function install_cmake()
{
    # sudo apt-get install cmake does not, by itself, ever upgrade cmake to a newer version
	# See https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line
	v_installed="$(cmake --version | grep -Po '\d{1,4}.\d{1,4}.\d{1,4}')" 
	if [[ ${v_installed} != $2 ]]; then
		# Install cmake
		echo "cmake not found, installing version $2 at $1 ..."
		v=( ${2//./ } )
		wget http://www.cmake.org/files/v${v[0]}.${v[1]}/cmake-${v[0]}.${v[1]}.${v[2]}.tar.gz -P $1
		cd $1
		tar -xvzf cmake-${v[0]}.${v[1]}.${v[2]}.tar.gz 
		cd cmake-${v[0]}.${v[1]}.${v[2]}/
		./configure 
		make
		make install
		update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force
	fi
}

# Install git
function install_git
{
	apt-add-repository ppa:git-core/ppa -y && \
	apt-get update -y && \
	apt-get install git -y
}

# Install vcpkg to given path
function install_vcpkg()
{
	if [[ ! -d $1 ]]; then
		# Install vcpkg
		echo "vcpkg not found, installing at $vcpkg_dir ..."
		sudo -u ${SUDO_USER} git clone --recursive https://github.com/Microsoft/vcpkg.git $vcpkg_dir
		cd $1
		sudo -u ${SUDO_USER} ./bootstrap-vcpkg.sh
		sudo -u ${SUDO_USER} ./vcpkg integrate install
	else 
	
		cd	$1
		if [[ $(git fetch --dry-run) ]]; then
			echo "vcpkg changed, updating at $vcpkg_dir ..."
			sudo -u ${SUDO_USER} git pull
			sudo -u ${SUDO_USER} ./bootstrap-vcpkg.sh
			sudo -u ${SUDO_USER} ./vcpkg integrate install
		fi
	fi
}

# Install tools used by build scripts
function install_tools
{
	apt-get install realpath
}

# Install modules using vcpkg
function vcpkg_install()
{
	# Install dependencies using vcpkg
	cd $1
	sudo -u ${SUDO_USER} ./vcpkg update
	sudo -u ${SUDO_USER} ./vcpkg install $2
}


# ----------------------------------------------------------------------------------

# Exit if a simple command exits with a non-zero status
# See http://mywiki.wooledge.org/BashFAQ/105
trap 'quit 1 "ERROR: script failed in line $LINENO"' ERR

# Exit here if Effective User ID is not root ID
if [[ ${EUID} -ne 0 ]]; then
   quit 2 "${0} must be run as root"
fi

#install_compiler $gcc_version
install_cmake $cmake_dir $cmake_version
#install_git
#install_vcpkg $vcpkg_dir
#install_tools

#vcpkg_install $vcpkg_dir $vcpkg_modules
