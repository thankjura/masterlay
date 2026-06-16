# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

DESCRIPTION="A cross-platform IDE for Databases and SQL by JetBrains"
HOMEPAGE="https://www.jetbrains.com/datagrip/"

SRC_URI="https://download.jetbrains.com/${PN}/${P}.tar.gz"
S="${WORKDIR}/DataGrip-${PV}"

LICENSE="|| ( JetBrains-business JetBrains-classroom JetBrains-educational JetBrains-individual ) Apache-2.0 BSD BSD-2 CC0-1.0 CC-BY-2.5 CC-BY-3.0 CC-BY-4.0 CPL-1.0 CDDL CDDL-1.1 EPL-1.0 EPL-2.0 GPL-2 GPL-2-with-classpath-exception ISC JDOM LGPL-2.1 LGPL-3 MIT MPL-1.1 MPL-2.0 OFL-1.1 PYTHON Unicode-DFS-2016 Unlicense UPL-1.0 ZLIB"

SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"
RESTRICT="bindist mirror splitdebug"
QA_PREBUILT="opt/${PN}/*"
RDEPEND="
	sys-process/audit
	dev-libs/libdbusmenu
	llvm-core/lldb
	media-libs/mesa[X(+)]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
"
BDEPEND="dev-util/patchelf"

src_prepare() {
	default

	declare -a remove_arches=(\
		arm64 \
		aarch64 \
		macos \
		windows- \
		win- \
	)

	# Remove all unsupported ARCH
	for arch in "${remove_arches[@]}"
	do
		echo "Removing files for $arch"
		find . -name "*$arch*" -exec rm -rf {} \; || true
	done

	if use wayland; then
		echo "-Dawt.toolkit.name=WLToolkit" >> bin/datagrip64.vmoptions

		elog "Experimental wayland support has been enabled via USE flags"
		elog "You may need to update your JBR runtime to the latest version"
		elog "https://github.com/JetBrains/JetBrainsRuntime/releases"
	fi


}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{"${PN}",remote-dev-server,fsnotifier,restarter}
	fperms 755 "${dir}"/bin/{"${PN}",format,inspect,ltedit,remote-dev-server}.sh
	fperms 755 "${dir}"/bin/fsnotifier

	fperms 755 "${dir}"/jbr/bin/{java,javac,javadoc,jcmd,jdb,jfr,jhsdb,jinfo,jmap,jps,jrunscript,jstack,jstat,keytool,rmiregistry,serialver}
	fperms 755 "${dir}"/jbr/lib/{chrome-sandbox,jcef_helper,jexec,jspawnhelper}

	patchelf --set-rpath '$ORIGIN' "${ED}/opt/datagrip/jbr/lib/jcef_helper"
	patchelf --set-rpath '$ORIGIN' "${ED}/opt/datagrip/jbr/lib/libjcef.so"

	make_wrapper "${PN}" "${dir}"/bin/"${PN}"
	doicon -s scalable bin/"${PN}".svg
	make_desktop_entry "${PN}" "DataGrip" "${PN}" "Development;IDE;"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	dodir /usr/lib/sysctl.d/
	echo "fs.inotify.max_user_watches = 524288" > "${D}/usr/lib/sysctl.d/30-${PN}-inotify-watches.conf" || die
}
