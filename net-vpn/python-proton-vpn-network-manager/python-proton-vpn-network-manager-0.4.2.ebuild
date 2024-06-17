# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Provides components for ProtonVPN to interact with NetworkManager"
HOMEPAGE="https://protonvpn.com https://github.com/ProtonVPN/python-proton-vpn-network-manager"
SRC_URI="https://github.com/ProtonVPN/python-proton-vpn-network-manager/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	net-vpn/python-proton-core[${PYTHON_USEDEP}]
	net-vpn/python-proton-vpn-connection[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	net-misc/networkmanager
"
