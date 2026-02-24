# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=MIYAGAWA

inherit perl-module

DESCRIPTION="Menlo - A CPAN client"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Dependencies from
# https://metacpan.org/release/MIYAGAWA/Menlo-1.9019/source/META.json

# $.prereqs.configure.requires
DEPEND="
	virtual/perl-ExtUtils-MakeMaker
"

# $.prereqs.configure.sugests
DEPEND="${DEPEND}
	dev-perl/JSON
"

# $.prereqs.runtime.requires
# Desiberately excluding
# - Win32::ShellQuote
# TODO: Write ebuilds for these
# Excluded simply because I haven't encountered a need for them yet
# and I'm tired of writing ebuilds this evening
# "CPAN::Common::Index" : "0.006",
# "Parse::PMFile" : "0.26",

RDEPEND="
	dev-perl/CPAN-DistnameInfo
	virtual/perl-CPAN-Meta
	dev-perl/CPAN-Meta-Check
	virtual/perl-CPAN-Meta-Requirements
	dev-perl/Capture-Tiny
	dev-perl/Class-Tiny
	virtual/perl-Exporter
	dev-perl/ExtUtils-Config
	dev-perl/ExtUtils-Helpers
	dev-perl/ExtUtils-InstallPaths
	virtual/perl-File-Temp
	dev-perl/File-Which
	dev-perl/File-pushd
	virtual/perl-Getopt-Long
	dev-perl/HTTP-Tinyish
	virtual/perl-JSON-PP
	dev-perl/Module-CPANfile
	virtual/perl-Module-CoreList
	virtual/perl-Module-Metadata
	dev-perl/String-ShellQuote
	dev-perl/URI
	dev-perl/local-lib
	virtual/perl-parent
	virtual/perl-version
"

# $.prereqs.runtime.suggests
RDEPEND="${RDEPEND}
	virtual/perl-Archive-Tar
	dev-perl/Archive-Zip
	virtual/perl-Digest-SHA
	dev-perl/File-HomeDir
	dev-perl/libwww-perl
	dev-perl/Module-Signature
"
