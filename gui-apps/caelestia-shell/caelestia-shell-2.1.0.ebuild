# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

M3SHAPES_REV="bdc327b29f95394a732baf3c9b19658ba23755b6"

DESCRIPTION="The desktop shell for the Caelestia dotfiles"
HOMEPAGE="https://github.com/caelestia-dots/shell"
SRC_URI="
	https://github.com/caelestia-dots/shell/releases/download/v${PV}/${PN}-v${PV}.tar.gz
	https://github.com/soramanew/m3shapes/archive/${M3SHAPES_REV}.zip
"

LICENSE="GPL-3.0-only"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	gui-apps/caelestia-cli
	gui-apps/quickshell
	app-misc/ddcutil
	sys-apps/brightnessctl
	media-libs/libcava
	net-misc/networkmanager
	sys-apps/lm-sensors
	media-libs/aubio
	media-video/pipewire
	media-fonts/material-symbols-variable
	sys-power/power-profiles-daemon
	media-fonts/rubik
	media-fonts/cascadia-code
	gui-apps/swappy
	sci-libs/libqalculate
	dev-qt/qtbase:6
	dev-qt/qtdeclarative:6
	dev-qt/qtimageformats:6
"
DEPEND="${DEPEND}"
PATCHES="
	${FILESDIR}/fix-qt6.patch
"
S=${WORKDIR}/release

src_unpack() {
	default
	mkdir -p "${WORKDIR}/release_build/_deps" || die
	mv "${WORKDIR}/m3shapes-${M3SHAPES_REV}" "${WORKDIR}/release_build/_deps/m3shapes-${M3SHAPES_REV}" || die
}

src_configure() {
	local mycmakeargs=(
		-DVERSION=${PV}
		-DGIT_REVISION="$(cat REVISION)"
		-DDISTRIBUTOR="Gentoo"
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DCMAKE_INSTALL_PREFIX=/
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake_src_configure
}
