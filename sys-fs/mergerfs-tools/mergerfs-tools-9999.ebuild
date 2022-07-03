# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit python-single-r1

DESCRIPTION="Optional tools to help manage data in a mergerfs pool"
HOMEPAGE="https://github.com/trapexit/mergerfs-tools"

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="https://github.com/trapexit/mergerfs-tools/releases/download/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"

RDEPEND="net-misc/rsync"

src_prepare() {
	rm Makefile
	default
}

src_install() {
	dobin src/mergerfs.*
}
