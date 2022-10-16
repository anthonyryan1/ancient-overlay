# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Another (FUSE based) union filesystem"
HOMEPAGE="https://github.com/trapexit/mergerfs"
SRC_URI="https://github.com/trapexit/mergerfs/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xattr"

CDEPEND="sys-fs/fuse"

BDEPEND="virtual/pkgconfig"

DEPEND="${CDEPEND}
	xattr? ( sys-apps/attr )"

RDEPEND="${CDEPEND}"
