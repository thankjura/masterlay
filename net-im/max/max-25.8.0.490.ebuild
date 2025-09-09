# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg desktop

DESCRIPTION="IM client"
HOMEPAGE="https://max.ru"
SRC_URI="https://download.max.ru/electron/MAX.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXtst
	app-accessibility/at-spi2-core
	app-crypt/libsecret
"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PRESTRIPPED="
	/opt/MAX/libEGL.so
	/opt/MAX/chrome-sandbox
	/opt/MAX/chrome_crashpad_handler
	/opt/MAX/libffmpeg.so
	/opt/MAX/libvulkan.so.1
	/opt/MAX/libGLESv2.so
	/opt/MAX/libvk_swiftshader.so
	/opt/MAX/MAX
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
	chmod +x "${D}"/opt/MAX/MAX
	dosym /opt/MAX/MAX /usr/bin/MAX

	domenu usr/share/applications/MAX.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

