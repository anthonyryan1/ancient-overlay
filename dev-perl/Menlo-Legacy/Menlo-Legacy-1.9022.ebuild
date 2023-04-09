# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=MIYAGAWA

inherit perl-module

DESCRIPTION="HTTP::Tinyish - HTTP::Tiny compatible HTTP client wrappers"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Dependencies from
# https://github.com/perl-carton/carton/blob/master/META.json

# $.prereqs.configure.requires
DEPEND="
	virtual/perl-ExtUtils-MakeMaker
"

# $.prereqs.runtime.requires
RDEPEND="
	dev-perl/Menlo
	virtual/perl-version
"
SRC_TEST="do"
