# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker xdg

MY_PV=${PV/_beta/~beta.}
MY_PN=${PN}
DESCRIPTION="The MongoDB GUI"
HOMEPAGE="https://www.mongodb.com/products/compass"

BETA_POSTFIX=""

if [[ "${PV}" == *beta* ]]; then
	MY_PN=${PN}-beta
	SRC_URI="https://downloads.mongodb.com/compass/beta/${MY_PN}_${MY_PV}_amd64.deb"
else
	SRC_URI="https://downloads.mongodb.com/compass/${PN}_${PV}_amd64.deb"
fi

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

S="${WORKDIR}"

src_install() {
	default
	insinto /usr/lib/mongodb-compass
	doins -r usr/lib/mongodb-compass/.

	domenu usr/share/applications/mongodb-compass.desktop
	doicon usr/share/pixmaps/mongodb-compass.png

	fperms +x "/usr/lib/mongodb-compass/MongoDB Compass"
	fperms 4755 /usr/lib/mongodb-compass/chrome-sandbox
	fperms 4755 /usr/lib/mongodb-compass/chrome_crashpad_handler


	# Included binary doesn't work, make a symlink instead
	rm usr/bin/mongodb-compass || die
	dosym "../lib/mongodb-compass/MongoDB Compass" "usr/bin/mongodb-compass"
}
