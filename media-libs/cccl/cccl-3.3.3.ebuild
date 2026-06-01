# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="CUDA Core Compute Libraries"
HOMEPAGE="https://github.com/NVIDIA/cccl"
SRC_URI="https://github.com/NVIDIA/cccl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

PATCHES="${FILESDIR}/8842.patch"

src_configure() {
	local mycmakeargs=(
		#-B build
	    #-S ${P}
		-W no-dev
	    -DCMAKE_BUILD_TYPE=None
		-DCMAKE_INSTALL_PREFIX=/usr
	    -DCMAKE_INSTALL_INCLUDEDIR=include/${PN}
		-DCCCL_ENABLE_EXAMPLES=OFF
	    -DCCCL_ENABLE_TESTING=OFF
		-DTHRUST_ENABLE_EXAMPLES=OFF
	    -DTHRUST_ENABLE_HEADER_TESTING=OFF
		-DTHRUST_ENABLE_TESTING=OFF
	    -DCUB_ENABLE_EXAMPLES=OFF
	    -DCUB_ENABLE_HEADER_TESTING=OFF
	    -DCUB_ENABLE_TESTING=OFF
	    -DLIBCUDACXX_ENABLE_LIBCUDACXX_TESTS=OFF
	    # controls only enable_language(CUDA) in CMake, but we don't build anything
		-DLIBCUDACXX_ENABLE_CUDA=OFF
	)

	cmake_src_configure
}
