# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Apache C++ XML security libraries"
HOMEPAGE="https://santuario.apache.org"
SRC_URI="https://dlcdn.apache.org/santuario/c-library/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples static-libs"

RDEPEND="
	>=dev-libs/xerces-c-3.2
	dev-libs/openssl
	dev-libs/nss
"
DEPEND="${RDEPEND}"

BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		--with-openssl
		$(use_enable static-libs static)
		$(use_enable debug)
		--without-xalan
		--with-nss
	)
	econf "${econfargs[@]}"
}

src_install() {
	default
	use examples || return
	docinto examples
	dodoc xsec/samples/*.cpp
}
