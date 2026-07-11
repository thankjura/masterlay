# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..14} )

inherit distutils-r1

DESCRIPTION="Material You color algorithms for python"
HOMEPAGE="https://github.com/T-Dynamos/materialyoucolor-python"

LICENSE="MIT"
SLOT="0"

DISTUTILS_IN_SOURCE_BUILD=

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/T-Dynamos/materialyoucolor-python.git"
	EGIT_BRANCH="main"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/T-Dynamos/materialyoucolor-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-python-${PV}"
	KEYWORDS="~amd64 ~arm64"
fi
