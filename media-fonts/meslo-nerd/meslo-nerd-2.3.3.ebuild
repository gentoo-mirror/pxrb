# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Customized version of Apple's Menlo font, patched by romkatv"
HOMEPAGE="https://github.com/romkatv/powerlevel10k-media"
SRC_URI="https://github.com/romkatv/powerlevel10k-media/releases/download/v${PV}/meslo-lgs-nf.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

FONT_SUFFIX="ttf"
