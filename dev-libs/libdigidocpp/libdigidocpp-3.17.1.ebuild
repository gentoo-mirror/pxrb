# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="DigiDoc digital signature library"
HOMEPAGE="https://id.ee https://github.com/open-eid/libdigidocpp"
SRC_URI="https://github.com/open-eid/libdigidocpp/releases/download/v${PV}/libdigidocpp-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/openssl
	dev-libs/xerces-c
	dev-libs/xml-security-c
	sys-libs/zlib[minizip]
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	>=dev-cpp/xsd-4.2.0_beta4
	app-editors/vim-core
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}
