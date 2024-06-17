# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multiprocessing

DESCRIPTION="A collection of C++ libraries (successor of libcult)"
HOMEPAGE="https://www.codesynthesis.com/projects/libcutl/"
SRC_URI="https://git.codesynthesis.com/cgit/libcutl/libcutl/snapshot/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs doc test"
RESTRICT="!test? ( test )"

BDEPEND=">=dev-util/build2-0.14.0"

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
