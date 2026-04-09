# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="SANE driver for Brother scanners (brscan5)"
HOMEPAGE="https://support.brother.com/"
SRC_URI="https://download.brother.com/welcome/dlf104033/${PN}-${PV}-0.amd64.deb"
S="${WORKDIR}"

LICENSE="Brother"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk"
RESTRICT="bindist mirror strip"

RDEPEND="
	media-gfx/sane-backends
	dev-libs/libusb-compat
	net-dns/avahi[dbus]
	gtk? ( x11-libs/gtk+:2 )
"

QA_PREBUILT="
	usr/lib64/libLxBs*.so*
	usr/lib64/sane/libsane-brother5.so*
	usr/bin/brsaneconfig5
	usr/bin/brscan_cnetconfig
	usr/bin/brscan_gnetconfig
	usr/bin/setupSaneScan5
"

src_unpack() {
	unpack ${A}
	tar -xJf "${WORKDIR}/data.tar.xz" -C "${S}" || die
}

src_install() {
	local brotherdir=opt/brother/scanner/brscan5

	# Libraries
	dolib.so ${brotherdir}/libLxBs*.so*

	# SANE backend
	insinto /usr/lib64/sane
	insopts -m0755
	doins ${brotherdir}/libsane-brother5.so*

	# Library symlinks
	dosym libLxBsScanCoreApi.so.3.2.1 /usr/lib64/libLxBsScanCoreApi.so
	dosym libLxBsScanCoreApi.so.3.2.1 /usr/lib64/libLxBsScanCoreApi.so.3
	dosym libLxBsNetDevAccs.so.1.0.0 /usr/lib64/libLxBsNetDevAccs.so.1
	dosym libLxBsUsbDevAccs.so.1.0.0 /usr/lib64/libLxBsUsbDevAccs.so.1
	dosym libLxBsDeviceAccs.so.1.0.0 /usr/lib64/libLxBsDeviceAccs.so.1
	dosym libsane-brother5.so.1.0.7 /usr/lib64/sane/libsane-brother5.so.1

	# SANE dll.d configuration
	insinto /etc/sane.d/dll.d
	insopts -m0644
	echo "brother5" > "${T}/brother5.conf" || die
	doins "${T}/brother5.conf"

	# brscan5 configuration
	insinto /etc/opt/brother/scanner/brscan5
	doins ${brotherdir}/brscan5.ini
	doins ${brotherdir}/brsanenetdevice.cfg

	# Model data
	insinto /opt/brother/scanner/brscan5/models
	doins ${brotherdir}/models/*

	# Executables
	exeinto /usr/bin
	doexe ${brotherdir}/setupSaneScan5
	doexe ${brotherdir}/brscan_cnetconfig
	doexe ${brotherdir}/brsaneconfig5
	use gtk && doexe ${brotherdir}/brscan_gnetconfig

	# Backward symlinks so Brother tools find executables at /opt paths
	local bins=( setupSaneScan5 brscan_cnetconfig brsaneconfig5 )
	use gtk && bins+=( brscan_gnetconfig )
	local bin
	for bin in "${bins[@]}"; do
		dosym -r /usr/bin/${bin} /opt/brother/scanner/brscan5/${bin}
	done

	# udev rules (strip deprecated SYSFS entries, install with clean name)
	sed -i '/SYSFS/d' ${brotherdir}/udev-rules/NN-brother-mfp-brscan5-1.0.2-2.rules || die
	udev_newrules ${brotherdir}/udev-rules/NN-brother-mfp-brscan5-1.0.2-2.rules 40-${PN}.rules
}

pkg_postinst() {
	udev_reload
	elog "For network scanner setup, run as root:"
	elog "  brsaneconfig5 -a name=SCANNER model=MODEL ip=IP_ADDRESS"
}

pkg_postrm() {
	udev_reload
}
