# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit gnome2-utils

MY_PN="vertical-overview"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Bringing back vertically stacked workspaces"
HOMEPAGE="https://github.com/RensAlthuis/vertical-overview"
SRC_URI="https://github.com/RensAlthuis/vertical-overview/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-eselect/eselect-gnome-shell-extensions
	>=gnome-base/gnome-shell-40
"
DEPEND=""

S="${WORKDIR}/${MY_P}"
extension_uuid="vertical-overview@RensAlthuis.github.com"

src_install() {
	einstalldocs
	dodoc README.md

	insinto /usr/share/glib-2.0/schemas
	doins schemas/*.xml

	rm -rf schemas/ LICENSE Makefile README.md || die
	insinto /usr/share/gnome-shell/extensions/"${extension_uuid}"
	doins -r *
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
}

pkg_postrm() {
	gnome2_schemas_update
}
