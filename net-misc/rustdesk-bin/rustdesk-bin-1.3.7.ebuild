# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

_PN=${PN/-bin/}
inherit pam xdg desktop

DESCRIPTION="Yet another remote desktop software, written in Rust."
HOMEPAGE="https://rustdesk.com/"
SRC_URI="
	amd64? ( https://github.com/${_PN}/${_PN}/releases/download/${PV}/${_PN}-${PV}-x86_64.deb )
	arm64? ( https://github.com/${_PN}/${_PN}/releases/download/${PV}/${_PN}-${PV}-aarch64.deb )
"

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror"

IUSE="X wayland"

## TODO: add all needed DEPS(!) - still WiP
RDEPEND="
	app-accessibility/at-spi2-core
	app-arch/brotli
	dev-libs/fribidi
	>=dev-libs/glib-2.76.4
	dev-libs/libffi
	dev-libs/libpcre2
	dev-libs/wayland
	media-gfx/graphite2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	>=media-libs/libjpeg-turbo-3.0.0
	media-libs/libpng:0/16
	sys-apps/dbus
	sys-apps/systemd
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/pango
	x11-libs/pixman
	x11-misc/xdotool
"
DEPEND="${RDEPEND}"

QA_PRESTRIPPED="
	/usr/lib/${_PN}/${_PN}
	/usr/lib/${_PN}/lib/lib${_PN}.so
	/usr/lib/${_PN}/lib/libapp.so
	/usr/lib/${_PN}/lib/libdesktop_drop_plugin.so
	/usr/lib/${_PN}/lib/libdesktop_multi_window_plugin.so
	/usr/lib/${_PN}/lib/libflutter_custom_cursor_plugin.so
	/usr/lib/${_PN}/lib/libflutter_linux_gtk.so
	/usr/lib/${_PN}/lib/libscreen_retriever_plugin.so
	/usr/lib/${_PN}/lib/libtexture_rgba_renderer_plugin.so
	/usr/lib/${_PN}/lib/liburl_launcher_linux_plugin.so
	/usr/lib/${_PN}/lib/libwindow_manager_plugin.so
	/usr/lib/${_PN}/lib/libwindow_size_plugin.so
"

src_unpack() {
	default
	mkdir -p "${S}"
	tar xf data.tar.xz -C "${S}"
}

src_install() {
	insinto /
	doins -r .

	# bin
	chmod +x "${D}"/usr/share/rustdesk/files/polkit
	chmod +x "${D}"/usr/share/rustdesk/rustdesk
	dosym /usr/share/${_PN}/${_PN} /usr/bin/${_PN}

	# pam
	dopamd etc/pam.d/rustdesk
	# desktop
	domenu usr/share/applications/${_PN}.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
