# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=MIYAGAWA
DIST_VERSION="v${PV}"

inherit perl-module

DESCRIPTION="Perl Carton - Perl module dependency manager (aka Bundler for Perl)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Dependencies from
# https://metacpan.org/release/MIYAGAWA/Menlo-Legacy-1.9022/source/META.json

# $.prereques.configure.requires
DEPEND="
	virtual/perl-ExtUtils-MakeMaker
"

# $.prereqs.configure.suggests
DEPEND="${DEPEND}
	dev-perl/JSON
"

# $.prereqs.runtime.suggests
RDEPEND="
	dev-perl/App-FatPacker
	dev-perl/File-pushd
"

# $.prereqs.runtime.requires
RDEPEND="${RDEPEND}
	virtual/perl-CPAN-Meta
	virtual/perl-CPAN-Meta-Requirements
	dev-perl/Class-Tiny
	virtual/perl-Getopt-Long
	virtual/perl-JSON-PP
	dev-perl/Menlo-Legacy
	dev-perl/Module-CPANfile
	virtual/perl-Module-CoreList
	dev-perl/Path-Tiny
	dev-perl/Try-Tiny
	virtual/perl-parent
"
SRC_TEST="do"
