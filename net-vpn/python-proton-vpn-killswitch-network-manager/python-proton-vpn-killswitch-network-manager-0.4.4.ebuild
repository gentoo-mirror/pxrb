# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Implements the ProtonVPN killswitch using NetworkManager"
HOMEPAGE="https://protonvpn.com https://github.com/ProtonVPN/python-proton-vpn-killswitch-network-manager"
SRC_URI="https://github.com/ProtonVPN/python-proton-vpn-killswitch-network-manager/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
	net-vpn/python-proton-vpn-killswitch[${PYTHON_USEDEP}]
	net-vpn/python-proton-vpn-logger[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	net-misc/networkmanager
"
