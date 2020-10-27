# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1

DESCRIPTION="Sans-I/O wrapper of Google Music API calls."
HOMEPAGE="https://github.com/thebigmunch/google-music-proto"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/marshmallow[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
        dev-python/audio-metadata[${PYTHON_USEDEP}]
        dev-python/pendulum[${PYTHON_USEDEP}]
"
