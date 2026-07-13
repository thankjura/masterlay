# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LUA_COMPAT=( lua5-4 )

inherit flag-o-matic toolchain-funcs lua-single


COMMIT="0c0fe4fc9cc9eac42d6891b840c349263ce42dba"
DESCRIPTION="A plugin for Hyprland that implements a workspace overview feature"
HOMEPAGE="https://github.com/ImanolBarba/Hyprspace"
SRC_URI="https://github.com/ImanolBarba/Hyprspace/archive/${COMMIT}.zip -> ${PN}-${COMMIT}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	gui-wm/hyprland
	gui-libs/hyprutils
	x11-libs/libdrm
	x11-libs/pango
	x11-libs/cairo
	x11-libs/pixman
	virtual/libudev
	x11-libs/libxkbcommon
	dev-libs/wayland
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/Hyprspace-${COMMIT}

src_compile() {
	append-cxxflags -std=c++2b -shared -fPIC --no-gnu-unique -Wall -DWLR_USE_UNSTABLE $(lua_get_CFLAGS)
	emake CXX="$(tc-getCXX)"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/lib/hyprland-plugins" install
}
