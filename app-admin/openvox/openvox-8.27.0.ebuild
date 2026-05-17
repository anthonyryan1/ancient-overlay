# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_EXTRAINSTALL="locales"

inherit ruby-fakegem systemd tmpfiles

DESCRIPTION="OpenVox, a community implementation of Puppet configuration management"
HOMEPAGE="https://github.com/OpenVoxProject/openvox"
SRC_URI="https://github.com/OpenVoxProject/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="augeas diff doc ldap selinux shadow sqlite test"

ruby_add_rdepend "
	dev-ruby/concurrent-ruby
	dev-ruby/deep_merge
	dev-ruby/fast_gettext
	dev-ruby/getoptlong
	dev-ruby/hocon
	dev-ruby/json:=
	dev-ruby/locale
	dev-ruby/openfact
	dev-ruby/ostruct
	dev-ruby/racc
	dev-ruby/semantic_puppet
	virtual/ruby-ssl
	augeas? ( dev-ruby/ruby-augeas )
	diff? ( dev-ruby/diff-lcs )
	doc? ( dev-ruby/rdoc )
	ldap? ( dev-ruby/ruby-ldap )
	shadow? ( dev-ruby/ruby-shadow )
	sqlite? ( dev-ruby/sqlite3 )
"

ruby_add_bdepend "
	doc? ( dev-ruby/yard )
	test? (
		dev-ruby/json-schema:0
		dev-ruby/mocha
		dev-ruby/rack
		dev-ruby/rspec-its
		dev-ruby/vcr:6
		dev-ruby/webrick
		dev-ruby/webmock:3
	)
"

RDEPEND+="
	acct-group/puppet
	acct-user/puppet
	>=app-portage/eix-0.18.0
	!app-admin/puppet
	!app-admin/puppet-agent
	selinux? (
		sec-policy/selinux-puppet
		sys-libs/libselinux[ruby]
	)
"

PATCHES=(
	"${FILESDIR}/openvox-systemd.patch"
	"${FILESDIR}/openvox-spec-load-path.patch"
)

all_ruby_install() {
	all_fakegem_install

	# systemd unit
	systemd_dounit "${WORKDIR}/all/${P}/ext/systemd/puppet.service"

	# tmpfiles
	newtmpfiles "${FILESDIR}/tmpfiles.d" "puppet.conf"

	# openrc init
	newinitd "${FILESDIR}/openvox.init" puppet

	keepdir /etc/puppetlabs/puppet/ssl

	keepdir /var/lib/puppet/facts
	keepdir /var/lib/puppet/files
	fowners -R puppet:puppet /var/lib/puppet

	fperms 0750 /var/lib/puppet

	fperms 0750 /etc/puppetlabs{,/puppet,/puppet/ssl}
	fowners -R :puppet /etc/puppetlabs

	# ext and examples files
	local f
	while IFS= read -r -d '' f ; do
		docinto "$(dirname "${f}")"
		dodoc "${f}"
	done < <(find ext examples -type f -print0)
}

pkg_postinst() {
	tmpfiles_process puppet.conf

	elog
	elog "OpenVox is a community fork of Puppet."
	elog "All existing Puppet documentation and modules are compatible."
	elog
	elog "Please, *don't* include the --ask option in EMERGE_EXTRA_OPTS as this could"
	elog "cause puppet to hang while installing packages."
	elog
	elog "Portage Puppet module with Gentoo-specific resources:"
	elog "http://forge.puppetlabs.com/gentoo/portage"
	elog
}
