# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="The MongoDB GUI"
HOMEPAGE="https://www.mongodb.com/products/compass"

SRC_URI="https://github.com/mongodb-js/compass/releases/download/v${PV}/mongodb-compass-${PV}-linux-x64.tar.gz"

LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPENDS="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXtst
	x11-misc/xdg-utils
	app-accessibility/at-spi2-core:2
	x11-libs/libdrm
	media-libs/mesa
	x11-libs/libxcb
	dev-libs/glib
	gnome-base/gvfs
	app-crypt/libsecret
	gnome-base/gnome-keyring
"

S="${WORKDIR}/MongoDB Compass-linux-x64"

src_install() {
	default
	insinto /opt/mongodb-compass
	doins -r .

	domenu ${FILESDIR}/mongodb-compass.desktop
	doicon ${FILESDIR}/mongodb-compass.png

	fperms +x "/opt/mongodb-compass/MongoDB Compass"
	fperms 4755 /opt/mongodb-compass/chrome-sandbox
	fperms 4755 /opt/mongodb-compass/chrome_crashpad_handler


	dosym "/opt/mongodb-compass/MongoDB Compass" "/usr/bin/mongodb-compass"
}
