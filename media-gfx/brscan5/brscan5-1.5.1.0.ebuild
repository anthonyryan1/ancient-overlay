# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker udev

DESCRIPTION="SANE driver for Brother scanners (brscan5)"
HOMEPAGE="https://support.brother.com/g/b/index.aspx"
SRC_URI="https://download.brother.com/welcome/dlf104033/${PN}-$(ver_rs 3 -).amd64.deb"
S="${WORKDIR}/opt/brother/scanner/brscan5"

LICENSE="Brother"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/libusb:1
	media-gfx/sane-backends
	net-dns/avahi[dbus]
	sys-apps/dbus
	virtual/libudev
"

QA_PREBUILT="opt/brother/*"

src_install() {
	# Install the full Brother scanner tree to /opt
	insinto /opt/brother/scanner/brscan5
	doins -r *

	# Mark executables
	local exe
	for exe in brsaneconfig5 brscan_cnetconfig setupSaneScan5; do
		fperms 0755 /opt/brother/scanner/brscan5/${exe}
	done

	# Mark libraries executable
	find "${ED}"/opt/brother/scanner/brscan5 -name '*.so*' -exec chmod 0755 {} + || die

	# Internal Brother libraries are dlopen'd by the SANE backend at runtime.
	# Make them discoverable via ld.so.conf.d rather than symlinking into /usr/lib64.
	echo /opt/brother/scanner/brscan5 > "${T}/50-${PN}.conf" || die
	insinto /etc/ld.so.conf.d
	doins "${T}/50-${PN}.conf"

	# SANE backend symlink
	dosym -r /opt/brother/scanner/brscan5/libsane-brother5.so.1.0.7 \
		/usr/lib64/sane/libsane-brother5.so.1

	# SANE dll.d configuration
	echo "brother5" > "${T}/brother5.conf" || die
	insinto /etc/sane.d/dll.d
	doins "${T}/brother5.conf"

	# brscan5 configuration
	insinto /etc/opt/brother/scanner/brscan5
	doins brscan5.ini
	doins brsanenetdevice.cfg

	# User-facing binary symlink
	dosym -r /opt/brother/scanner/brscan5/brsaneconfig5 /usr/bin/brsaneconfig5

	# udev rules (strip deprecated SYSFS entries, install with clean name)
	sed -i '/SYSFS/d' udev-rules/NN-brother-mfp-brscan5-1.0.2-2.rules || die
	udev_newrules udev-rules/NN-brother-mfp-brscan5-1.0.2-2.rules 40-${PN}.rules
}

pkg_postinst() {
	udev_reload
	ldconfig
	elog "For network scanner setup, run as root:"
	elog "  brsaneconfig5 -a name=SCANNER model=MODEL ip=IP_ADDRESS"
}

pkg_postrm() {
	udev_reload
	ldconfig
}
