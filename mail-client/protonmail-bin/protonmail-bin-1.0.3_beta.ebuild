# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Official Proton Mail Linux app"
HOMEPAGE="https://proton.me https://github.com/ProtonMail/inbox-desktop"
SRC_URI="https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pulseaudio"
RESTRICT="test"

DEPEND="
	gui-libs/gtk
	x11-libs/libnotify
	dev-libs/nss
	media-libs/alsa-lib
	x11-misc/xdg-utils
        || (
		gnome-base/gvfs
		app-misc/trash-cli
		kde-plasma/kde-cli-tools
	)
        pulseaudio? (
                || (
                        media-libs/libpulse
                        media-sound/apulse
                )
        )

"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mkdir "${S}"
	unpack "${WORKDIR}/data.tar.xz"
	mv "${WORKDIR}/usr" "${S}"
}

src_install() {
	dodoc usr/share/doc/proton-mail/copyright
        rm -rf "${S}"/usr/share/{doc,lintian} || die "Failed to remove /usr/share/{doc,lintian}!"
	cp -R "${S}/usr" "${D}/" || die "Install failed!"
}
