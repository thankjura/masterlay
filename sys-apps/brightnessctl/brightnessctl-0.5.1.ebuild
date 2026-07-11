# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="A cli tool to control display brightness"
HOMEPAGE="https://github.com/Hummer12007/brightnessctl"
SRC_URI="https://github.com/Hummer12007/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/udev"

src_prepare() {
	eapply_user
	sed -i /-g/d Makefile || die
	sed -i s,VERSION,\"${PV}\", brightnessctl.c || die
}

src_install() {
	dobin brightnessctl
	udev_dorules 90-brightnessctl.rules
	doman brightnessctl.1
}

src_postinst() {
	udev_reload
}
