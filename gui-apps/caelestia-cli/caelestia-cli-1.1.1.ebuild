# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="The main cli for the Caelestia dotfiles"
HOMEPAGE="https://github.com/caelestia-dots/cli"
SRC_URI="https://github.com/caelestia-dots/cli/releases/download/v${PV}/caelestia-${PV}.tar.gz"

LICENSE="GPL-3.0-only"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/materialyoucolor[${PYTHON_USEDEP}]
	')
	x11-libs/libnotify
	gui-apps/swappy
	gui-apps/grim
	dev-util/dart-sass
	gui-apps/wl-clipboard
	gui-apps/slurp
	gnome-base/dconf
	app-misc/cliphist
	gui-apps/fuzzel

"
RDEPEND="${DEPEND}"

S=${WORKDIR}/caelestia-${PV}
