EAPI=7

inherit cmake-utils

DESCRIPTION="Free and Open Source PS4 Remote Play Client"
HOMEPAGE="https://github.com/thestr4ng3r/chiaki"
# SRC_URI="https://github.com/thestr4ng3r/chiaki/archive/v${PV}.tar.gz -> ${P}.tar.gz"

inherit git-r3
EGIT_REPO_URI="https://github.com/thestr4ng3r/chiaki.git"
EGIT_REPO_BRANCH="v${PV}"
EGIT_SUBMODULES=('*')

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="
	dev-qt/qtmultimedia
	dev-qt/qtsvg
	media-video/ffmpeg
	media-libs/opus
	>=dev-libs/openssl-1.1
	dev-libs/protobuf-c
"
DEPEND="${RDEPEND}
	dev-python/protobuf-python
"

DOCS=(README.md)

