# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Use version control tags to discover version numbers"
HOMEPAGE="https://github.com/habnabit/vcversioner https://pypi.python.org/pypi/vcversioner"
SRC_URI="mirror://pypi/v/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
	"

# not included
RESTRICT=test

python_test() {
	py.test || die
}