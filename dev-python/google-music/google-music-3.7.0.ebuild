# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1

DESCRIPTION="A Google Music API wrapper"
HOMEPAGE="https://github.com/thebigmunch/google-music"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
        dev-python/audio-metadata[${PYTHON_USEDEP}]
        dev-python/google-music-proto[${PYTHON_USEDEP}]
        dev-python/requests-oauthlib[${PYTHON_USEDEP}]
        dev-python/tenacity[${PYTHON_USEDEP}]
        dev-python/wrapt[${PYTHON_USEDEP}]
"
