# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Console-based Audio Visualizer for Alsa"
HOMEPAGE="https://github.com/LukashonakV/cava"
SRC_URI="https://github.com/LukashonakV/cava/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa jack +ncurses pipewire portaudio pulseaudio sdl sndio"

RDEPEND="
	>=dev-libs/iniparser-4.2:=
	sci-libs/fftw:3.0=
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	ncurses? ( sys-libs/ncurses:= )
	pipewire? ( media-video/pipewire:= )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	sdl? (
		media-libs/libglvnd
		media-libs/libsdl2[opengl,video]
	)
	sndio? ( media-sound/sndio:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"
S="${WORKDIR}/cava-${PV}"
src_configure() {
	local emesonargs=(
		# cairo is not required with nanosvg
		-Dcava_font=false
	)
	meson_src_configure
}
