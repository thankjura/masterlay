# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for caelestia"
HOMEPAGE="https://github.com/caelestia-dots/shell"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	gui-apps/caelestia-cli
	gui-apps/caelestia-shell
	gui-libs/xdg-desktop-portal-hyprland
	gui-wm/hyprland
	hyprland-plugin/hyprexpo
	media-sound/playerctl
"
