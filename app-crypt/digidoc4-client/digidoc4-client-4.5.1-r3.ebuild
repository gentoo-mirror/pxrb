# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="DigiDoc4 Client is an application for digitally signing and encrypting documents"
HOMEPAGE="https://id.ee https://github.com/open-eid/DigiDoc4-Client"
SRC_URI="https://github.com/open-eid/DigiDoc4-Client/releases/download/v${PV}/qdigidoc4-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qdigidoc4-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+web"

DEPEND="
	>=dev-libs/libdigidocpp-3.17
	sys-apps/pcsc-lite
	net-nds/openldap
	dev-libs/openssl
	dev-qt/qtbase[gui,network,widgets]
	dev-qt/qt5compat
	dev-qt/qtsvg
	dev-qt/qtprintsupport
	dev-qt/qttranslations
	dev-libs/flatbuffers
	sys-libs/zlib
"

RDEPEND="
	${DEPEND}
	dev-libs/opensc[pcsc-lite]
        web? ( www-plugins/web-eid )
"

BDEPEND="
	dev-qt/qttools:6[linguist]
"

PATCHES=(
	"${FILESDIR}"/"${PN}"-sandbox-compat.diff
	"${FILESDIR}"/"${PN}"-optional.diff
)

src_prepare() {
	cmake_src_prepare
	cp "${FILESDIR}"/{TSL.qrc,EE.xml,eu-lotl.xml} "${S}"/client/
	cp "${FILESDIR}"/config.{json,rsa,pub} "${S}"/common/
}
