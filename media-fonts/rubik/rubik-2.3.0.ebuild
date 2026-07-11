# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A sans serif font family with slightly rounded corners: variable font version"
HOMEPAGE="https://github.com/googlefonts/ribuk"
COMMIT="e337a5f69a9bea30e58d05bd40184d79cc099628"
SRC_URI="
	https://github.com/googlefonts/rubik/blob/${COMMIT}/fonts/variable/Rubik-Italic%5Bwght%5D.ttf
	https://github.com/googlefonts/rubik/blob/${COMMIT}/fonts/variable/Rubik%5Bwght%5D.ttf
	https://github.com/googlefonts/rubik/blob/${COMMIT}/AUTHORS.txt
	https://github.com/googlefonts/rubik/blob/${COMMIT}/CONTRIBUTORS.txt
	https://github.com/googlefonts/rubik/blob/${COMMIT}/OFL.txt
"
S="${WORKDIR}"

LICENSE="OFL"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~loong ~ppc ~ppc64 ~riscv x86 ~x64-macos"
DOCS=( AUTHORS.txt CONTRIBUTORS.txt OFL.txt )
FONT_SUFFIX="ttf"

src_prepare() {
	default
	cp ${DISTDIR}/Rubik-Italic%5Bwght%5D.ttf ${S}
	cp ${DISTDIR}/Rubik%5Bwght%5D.ttf ${S}
	cp ${DISTDIR}/AUTHORS.txt ${S}
	cp ${DISTDIR}/CONTRIBUTORS.txt ${S}
	cp ${DISTDIR}/OFL.txt ${S}
}
