# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multiprocessing

DESCRIPTION="A compiler frontend for the W3C XML Schema definition language"
HOMEPAGE="https://www.codesynthesis.com/projects/libxsd-frontend/"
SRC_URI="https://git.codesynthesis.com/cgit/libxsd-frontend/libxsd-frontend/snapshot/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/v${PV}"

LICENSE="GPL-2"
SLOT="0/2.1"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test doc"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/xerces-c-3.0.0
	dev-libs/boost[threads(+)]
	>=dev-cpp/libcutl-1.11.0_beta9:=
"

DEPEND="${RDEPEND}"

BDEPEND="dev-util/build2"

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
		config.bin.lib="$(usex static-libs both shared)"
		config.install.root="${ED}/usr/"
		config.install.lib="exec_root/$(get_libdir)"
		config.install.doc="data_root/share/doc/${PF}"
	)

	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake \
		"${myconfigargs[@]}" \
		configure
}

src_compile() {
	tc-is-gcc && export CCACHE_DISABLE=1
	set -- b --jobs $(makeopts_jobs) --verbose 3
	echo "${@}"
	"${@}" || die "b failed"
}

src_test() {
	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs)" \
	emake test
}

src_install() {
	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake install
	use doc && einstalldocs
}
