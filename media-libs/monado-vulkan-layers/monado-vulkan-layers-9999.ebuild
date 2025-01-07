# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="Optional Vulkan Layers for Monado"
HOMEPAGE="https://gitlab.freedesktop.org/monado/utilities/vulkan-layers"
EGIT_REPO_URI="https://gitlab.freedesktop.org/monado/utilities/vulkan-layers"

LICENSE="Other"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-util/vulkan-headers
"
RDEPEND="${DEPEND}"
