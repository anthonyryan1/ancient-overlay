# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby27"

RUBY_FAKEGEM_EXTRAINSTALL="data config"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Configurable tool for writing clean and consistent SCSS"
HOMEPAGE="https://github.com/sds/scss-lint"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? (
	dev-ruby/simplecov
)"

ruby_add_rdepend "dev-ruby/sass"
