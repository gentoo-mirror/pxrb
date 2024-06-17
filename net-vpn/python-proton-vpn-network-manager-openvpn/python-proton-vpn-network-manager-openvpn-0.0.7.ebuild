# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Provides OpenVPN backend for ProtonVPN"
HOMEPAGE="https://protonvpn.com https://github.com/ProtonVPN/python-proton-vpn-network-manager-openvpn"
SRC_URI="https://github.com/ProtonVPN/python-proton-vpn-network-manager-openvpn/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	net-vpn/python-proton-core[${PYTHON_USEDEP}]
	net-vpn/python-proton-vpn-network-manager[${PYTHON_USEDEP}]
	net-vpn/networkmanager-openvpn
"
