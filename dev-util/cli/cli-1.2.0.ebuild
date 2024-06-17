# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multiprocessing

DESCRIPTION="Command Line Interface compiler for C++"
HOMEPAGE="https://www.codesynthesis.com/projects/cli"
SRC_URI="https://git.codesynthesis.com/cgit/cli/cli/snapshot/v${PV}.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}/v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs doc test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-cpp/libcutl-1.11.0_beta9:="

DEPEND="${RDEPEND}"

BDEPEND=">=dev-util/build2-0.15"

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
		configure: cli/
}

src_compile() {
	tc-is-gcc && local -x CCACHE_DISABLE=1
	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake cli/
}

src_test() {
	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs)" \
	emake test
}

src_install() {
	MAKE=b \
	MAKEOPTS="--jobs $(makeopts_jobs) --verbose 3" \
	emake install: cli/
	if use doc ; then
		einstalldocs
		mkdir -p "${ED}"/usr/share/doc/${PF}/html
		mv -f "${ED}"/usr/share/doc/${PF}/*.xhtml "${ED}"/usr/share/doc/${PF}/html
	fi
}
