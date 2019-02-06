# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7} )
inherit distutils-r1

DESCRIPTION="Motor is a full-featured, non-blocking MongoDB driver"
HOMEPAGE="https://github.com/mongodb/motor/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/pymongo-3.6[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""