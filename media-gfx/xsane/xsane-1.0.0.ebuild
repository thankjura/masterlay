# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop strip-linguas toolchain-funcs

DESCRIPTION="Graphical scanning frontend"
HOMEPAGE="http://www.xsane.org/"
COMMIT="2eee8154575587d67f46faef71275bc4d986b4c4"
SRC_URI="
	https://gitlab.com/sane-project/frontend/xsane/-/archive/${COMMIT}/xsane-${COMMIT}.tar.bz2 -> ${P}.tar.bz2
	https://dev.gentoo.org/~soap/distfiles/${PN}-0.998-patches-3.tar.xz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="nls jpeg png tiff gimp lcms"

DEPEND="
	dev-libs/glib:2
	media-gfx/sane-backends
	sys-libs/zlib
	x11-libs/gtk+:3
	x11-misc/xdg-utils
	jpeg? ( media-libs/libjpeg-turbo:= )
	png? ( media-libs/libpng:= )
	tiff? ( media-libs/tiff:= )
	gimp? ( media-gfx/gimp:0/2 )
	lcms? ( media-libs/lcms:2 )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	# Apply multiple fixes from different distributions
	"${FILESDIR}"/patches
)

S=${WORKDIR}/${PN}-${COMMIT}

src_prepare() {
	default

	# bug #609672
	strip-linguas -i po/

	# Fix compability with libpng15 (bug #377363)
	sed -i -e 's:png_ptr->jmpbuf:png_jmpbuf(png_ptr):' src/xsane-save.c || die

	# Fix AR calling directly (bug #442606)
	sed -i -e 's:ar r:$(AR) r:' lib/Makefile.am || die

	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	tc-export AR

	econf \
		$(use_enable nls) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable tiff) \
		$(use_enable gimp) \
		$(use_enable lcms)
}

src_install() {
	default

	dodoc xsane.*

	# link xsane so it is seen as a plugin in gimp
	if use gimp; then
		local plugindir gimptool=( "${ESYSROOT}"/usr/bin/gimptool* )
		if [[ ${#gimptool[@]} -gt 0 ]]; then
			plugindir="$("${gimptool[0]}" --gimpplugindir)/plug-ins"
		else
			die "Can't find GIMP plugin directory."
		fi
		dosym -r /usr/bin/xsane "${plugindir}"/xsane
	fi

	newicon "${FILESDIR}/${PN}-icon.png" "${PN}".png
}
