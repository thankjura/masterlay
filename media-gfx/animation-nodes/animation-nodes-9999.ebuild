# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{9..14} )

inherit python-single-r1 git-r3

DESCRIPTION="is a node based visual scripting system designed for motion graphics in Blender"
HOMEPAGE="https://github.com/JacquesLucke/animation_nodes"
EGIT_REPO_URI="https://github.com/JacquesLucke/animation_nodes.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="
	$(python_gen_cond_dep 'dev-python/cython[${PYTHON_USEDEP}]')
"
RDEPEND="
	${PYTHON_DEPS}
	media-gfx/blender:=
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i -e '/if not os.path.samefile(currentDirectory, os.getcwd()):/,/sys.exit()/d' setup.py || die
}

src_compile() {
	einfo "Compiling Animation Nodes for ${EPYTHON}..."
	${EPYTHON} setup.py build --noversioncheck || die "Compilation failed"
}

src_install() {
	local blender_ver=$(best_version media-gfx/blender)
	blender_ver=$(ver_cut 1-2 "${blender_ver#media-gfx/blender-}")
	local target_dir="${D}/usr/share/blender/${blender_ver}/scripts/addons_core"
	mkdir -p "${target_dir}" || die
	echo "{\"Copy Target\" : \"${target_dir}\"}" > conf.json
	echo ${target_dir}
	${EPYTHON} setup.py build --noversioncheck --copy || die "Instalation failed"
	einfo "Animation Nodes successfully compiled and installed into Blender addons core."
}
