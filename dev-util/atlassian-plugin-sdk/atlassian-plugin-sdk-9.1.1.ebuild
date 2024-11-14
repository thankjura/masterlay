# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Development kit to build Atlassian plugins"
HOMEPAGE="http://developer.atlassian.com"
SRC_URI="https://maven.artifacts.atlassian.com/com/atlassian/amps/atlassian-plugin-sdk/${PV}/atlassian-plugin-sdk-${PV}.tar.gz"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/jdk
"
RDEPEND="${DEPEND}"

src_install(){
	local TARGET_DIR=/opt/${PN}/${PV}
	local MAVEN_VER=$(find . -name 'apache-maven-*'|awk -F/ '{print $NF}')
	MAVEN_VER=$(awk -F- '{print $3}' <<<"$MAVEN_VER")
	cp ${FILESDIR}/activate .
	sed -e 's/%MAVEN_VER%/'"${MAVEN_VER}"'/g' -i activate || die
	sed -e 's/%ATLAS_VER%/'"${PV}"'/g' -i activate || die
	insinto ${TARGET_DIR}
	doins -r repository || die
	doins -r apache-maven-* || die
	exeinto ${TARGET_DIR}/bin
	doexe activate
	find bin/ -exec doexe '{}' +
	fperms +x ${TARGET_DIR}/apache-maven-${MAVEN_VER}/bin/{mvnyjp,mvnDebug,mvn.orig,mvn}
}
