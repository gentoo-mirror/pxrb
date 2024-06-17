# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multiprocessing

DESCRIPTION="An open-source, cross-platform W3C XML Schema to C++ data binding compiler"
HOMEPAGE="https://codesynthesis.com/products/xsd/"
SRC_URI="https://git.codesynthesis.com/cgit/xsd/xsd/snapshot/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test zlib"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/xerces-c-3.0.0
	dev-libs/boost
	>=dev-cpp/libcutl-1.11.0_beta9:=
	>=dev-cpp/libxsd-frontend-2.1.0_beta2:=
	zlib? ( sys-libs/zlib )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	>=dev-util/build2-0.15
	dev-util/cli
	doc? ( app-text/doxygen )
"

# xsd-tests doesn't want to build for some reason so we have to remove it, remove other tests and examples as well
PATCHES=( "${FILESDIR}/tests.diff" )

src_configure() {
	local _c='gcc'
	tc-is-clang && _c='clang'
	local myconfigargs=(
		config.cxx="$(tc-getCXX)"
		config.cxx.id="${_c}"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.bin.ar="$(tc-getAR)"
		config.bin.ranlib="$(tc-getRANLIB)"
		# i am forced to use ${ED}
		config.install.root="${ED}/usr/"
		config.install.doc="data_root/share/doc/${PF}"
		config.install.legal="${T}"
	)

	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake \
		"${myconfigargs[@]}" \
		configure: libxsd/ xsd/
}

src_compile() {
	export CCACHE_DISABLE=1
	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake libxsd/ xsd/
}

src_install() {
	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake install
}
