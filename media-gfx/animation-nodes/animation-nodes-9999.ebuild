# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 git-r3

DESCRIPTION="is a node based visual scripting system designed for motion graphics in Blender"
HOMEPAGE="https://github.com/JacquesLucke/animation_nodes"
EGIT_REPO_URI="https://github.com/JacquesLucke/animation_nodes.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	media-gfx/blender:=
	$(python_gen_cond_dep '
		dev-python/numpy[${PYTHON_USEDEP}]
	')
"

DEPEND="${RDEPEND}"

python_configure() {
	local blender_ver = $(best_version media-gfx/blender)
	blender_ver=$(ver_cut 1-2 "${blender_ver#media-gfx/blender-}")
	echo "{\"Copy Target\" : \"${D}/usr/share/blender/${blender_ver}/scripts/addons_core\"}" > conf.json
	#mkdir -p ${D%/}/usr/share/blender/${blender_ver}/scripts/addons_core
	esetup.py build --noversioncheck
}

#src_install() {
#	local blender_ver = $(best_version media-gfx/blender)
#	blender_ver=$(ver_cut 1-2 "${blender_ver#media-gfx/blender-}")
#	echo "{\"Copy Target\" : \"${D}/usr/share/blender/${blender_ver}/scripts/addons_core\"}" > conf.json
#	mkdir -p ${D%/}/usr/share/blender/${blender_ver}/scripts/addons_core
#	esetup.py build --copy --noversioncheck
#	python_optimize "${D%/}/usr/share/blender/${blender_ver}/scripts/addons/animation_nodes"
#}
