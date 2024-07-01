# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

# very very weird versioning scheme for the tarballs
MY_PV="${PV}.642-2004"

DESCRIPTION="Web eID native browser extension"
HOMEPAGE="https://web-eid.eu https://github.com/web-eid/web-eid-app"
SRC_URI="https://github.com/web-eid/web-eid-app/releases/download/v${PV}/web-eid_${MY_PV}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	sys-apps/pcsc-lite
	dev-libs/openssl
	dev-qt/qtbase[gui,network,widgets]
	dev-qt/qt5compat
	dev-qt/qtsvg
"

RDEPEND="
	${DEPEND}
	dev-libs/opensc[pcsc-lite]
"

BDEPEND="
	dev-qt/qttools:6[linguist]
"

PATCHES=(
	"${FILESDIR}"/"${PN}"-tests.diff
)
