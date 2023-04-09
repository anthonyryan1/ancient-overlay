# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=MIYAGAWA

inherit perl-module

DESCRIPTION=" HTTP::Tiny compatible wrappers for LWP, curl, wget "

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Dependencies from
# https://github.com/miyagawa/HTTP-Tinyish/blob/master/META.json

# $.prereqs.configure.requires
DEPEND="
	virtual/perl-ExtUtils-MakeMaker
"

# $.prereqs.runtime.requires
RDEPEND="
    dev-perl/File-Which
    virtual/perl-HTTP-Tiny
    dev-perl/IPC-Run3
	virtual/perl-parent
"
SRC_TEST="do"
