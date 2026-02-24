# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="SANE driver for Brother scanners (brscan5)"
HOMEPAGE="https://www.brother.com/"
#SRC_URI="file:///var/cache/distfiles/${PN}-1.3.10-7.amd64.deb"
SRC_URI="https://download.brother.com/welcome/dlf104033/${PN}-1.5.1-0.amd64.deb"

LICENSE="Brother-EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip mirror"

RDEPEND="
    media-gfx/sane-backends
    net-dns/avahi[dbus]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
    # Extract .deb contents
    unpack ${A}
    # Extract data.tar.xz
    tar -xJf "${WORKDIR}/data.tar.xz" -C "${S}" || die "Failed to extract data.tar.xz"
}

src_install() {
    # Install libraries
    dolib.so opt/brother/scanner/brscan5/libLxBs*.so*

    # Install SANE backend
    insinto /usr/lib64/sane
    insopts -m0755
    doins opt/brother/scanner/brscan5/libsane-brother5.so*

    # Create symlinks for libraries
    dosym libLxBsScanCoreApi.so.3.2.1 /usr/lib64/libLxBsScanCoreApi.so
    dosym libLxBsScanCoreApi.so.3.2.1 /usr/lib64/libLxBsScanCoreApi.so.3
    dosym libLxBsNetDevAccs.so.1.0.0 /usr/lib64/libLxBsNetDevAccs.so.1
    dosym libLxBsUsbDevAccs.so.1.0.0 /usr/lib64/libLxBsUsbDevAccs.so.1
    dosym libLxBsDeviceAccs.so.1.0.0 /usr/lib64/libLxBsDeviceAccs.so.1
    dosym libsane-brother5.so.1.0.7 /usr/lib64/sane/libsane-brother5.so.1

    # Install SANE configuration
    insinto /etc/sane.d/dll.d
    insopts -m0644
    doins "${FILESDIR}/brother5.conf"

    # Install brscan5 configuration
    insinto /etc/opt/brother/scanner/brscan5
    insopts -m0644
    doins opt/brother/scanner/brscan5/brscan5.ini
    doins opt/brother/scanner/brscan5/brsanenetdevice.cfg

    # Install models
    insinto /opt/brother/scanner/brscan5/models
    doins opt/brother/scanner/brscan5/models/*

    # Install executables
    exeinto /usr/bin
    doexe opt/brother/scanner/brscan5/setupSaneScan5
    doexe opt/brother/scanner/brscan5/brscan_gnetconfig
    doexe opt/brother/scanner/brscan5/brscan_cnetconfig
    doexe opt/brother/scanner/brscan5/brsaneconfig5

    # Install udev rules (adjust path if different)
    udev_dorules opt/brother/scanner/brscan5/udev-rules/NN-brother-mfp-brscan5-1.0.2-2.rules
}
