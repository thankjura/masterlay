# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Orca Slicer is a free 3D printing slicer created by SoftFever."

HOMEPAGE="https://orca-slicer.com/"
MY_PV=${PV/_/-}

SRC_URI="https://github.com/SoftFever/OrcaSlicer/releases/download/v${MY_PV}/OrcaSlicer_Linux_AppImage_Ubuntu2404_V${MY_PV}.AppImage"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="GPL-3"

SLOT="0"

IUSE=""

RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

DEPEND="
	!media-gfx/orcaslicer
"

S="${WORKDIR}"

QA_PREBUILT="*"

src_unpack() {
	cp ${DISTDIR}/OrcaSlicer_Linux_AppImage_Ubuntu2404_V${MY_PV}.AppImage orcaslicer.appimage || die "Can't copy source file"
	chmod a+x orcaslicer.appimage ||  die "Can't chmod archive file"
	./orcaslicer.appimage --appimage-extract "usr/share/icons" || die "Failed to extract hicolor icons from app image"
	./orcaslicer.appimage --appimage-extract "OrcaSlicer.desktop" || die "Failed to extract .desktop from appimage"
}

src_install() {
	sed -i "s/Exec=AppRun/Exec=orca-slicer/g" squashfs-root/OrcaSlicer.desktop
	newbin orcaslicer.appimage orca-slicer
	insinto /usr/share/applications
	doins "squashfs-root/OrcaSlicer.desktop"
	insinto /usr/share/icons
	doins -r squashfs-root/usr/share/icons
}
