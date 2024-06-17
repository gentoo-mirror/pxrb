# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Contains core logic used by the other ProtonVPN components."
HOMEPAGE="https://protonvpn.com https://github.com/ProtonVPN/python-proton-core"
SRC_URI="https://github.com/ProtonVPN/python-proton-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	dev-python/python-gnupg[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
"
