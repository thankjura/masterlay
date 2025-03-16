# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

DESCRIPTION="A portable, open-source, coherent noise-generating library for C++"
HOMEPAGE="http://libnoise.sourceforge.net"
SRC_URI="https://prdownloads.sourceforge.net/libnoise/libnoisesrc-${PV}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/noise

src_prepare() {
	eapply_user
	cp "${FILESDIR}/CMakeLists.txt" "${S}/CMakeLists.txt"
	cmake_src_prepare
}
