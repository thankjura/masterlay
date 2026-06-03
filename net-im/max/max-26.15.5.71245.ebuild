# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg desktop

DESCRIPTION="IM client"
HOMEPAGE="https://max.ru"
# https://download.max.ru/linux/deb/dists/stable/main/binary-amd64/Packages.gz
SRC_URI="https://download.max.ru/linux/deb/pool/main/m/max/MAX-${PV}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtserialport
	x11-libs/libnotify
	dev-libs/nss
"
RDEPEND="${DEPEND}"
BDEPEND=dev-util/patchelf

QA_PREBUILT="*"

src_unpack() {
	default
	mkdir -p "${S}"
	tar xf data.tar.xz -C "${S}"
}

src_prepare() {
	default
	local lib_dir="usr/share/max/bin/max-service/lib64"
	local files=(
		"libnetwork.so"
		"libcalls_types_converter.so"
		"liblogger.so"
		"libstorage.so"
		"libbase64_utils.so"
		"libdesktop_utils.so"
		"libdynamic_library.so"
		"libcalls.so"
		"libfile.so"
		"libconfig.so"
		"libcall-service.so"
		"liburl_parser.so"
		"libtext_utils.so"
	)

	# TODO: remove system libs
	# rm -rf ${S}/usr/share/max/lib64/libQt6*

	for f in "${files[@]}"; do
		patchelf --set-rpath '$ORIGIN' ${lib_dir}/${f}
	done
}

src_install() {
	insinto /
	doins -r .
	fperms 0755 /usr/share/max/bin/max
	dosym /usr/share/max/bin/max /usr/bin/max
	mv "${ED}/usr/share/applications/max.desktop" "${ED}/usr/share/applications/ru.max.desktop" || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

