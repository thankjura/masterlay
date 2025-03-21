# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Free digital painting application. Digital Painting, Creative Freedom!"
HOMEPAGE="https://krita.org/"
RESTRICT="strip"

SRC_URI="http://download.kde.org/stable/krita/${PV/b/}/krita-${PV}-x86_64.appimage"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	!media-gfx/krita
"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/krita-${PV}-x86_64.appimage krita.appimage || die "Can't copy source file"
	chmod a+x krita.appimage || die "Can't chmod archive file"
	./krita.appimage --appimage-extract "org.kde.krita.desktop" || die "Failed to extract .desktop from appimage"
	./krita.appimage --appimage-extract "usr/share/icons" || die "Failed to extract hicolor icons from app image"
	#krita-${PV}-x86_64.appimage --appimage-extract "krita.png" || die "Failed to extract hicolor icons from app image"
}

src_install() {
	newbin krita.appimage krita
	insinto /usr/share/applications
	doins "squashfs-root/org.kde.krita.desktop"
	insinto /usr/share/icons
	doins -r squashfs-root/usr/share/icons/hicolor
}
