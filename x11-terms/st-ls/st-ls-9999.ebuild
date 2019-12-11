# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop git-r3 multilib savedconfig toolchain-funcs

DESCRIPTION="Luke Smiths fork of the suckless terminal"
HOMEPAGE="https://github.com/LukeSmithxyz/st"
EGIT_REPO_URI="https://github.com/LukeSmithxyz/st.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="savedconfig st-underline st-bar st-snowman st-large st-bell"

RDEPEND="
	>=sys-libs/ncurses-6.0:0=
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
"

src_prepare() {
	default

	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^STLDFLAGS/s|= .*|= $(LDFLAGS) $(LIBS)|g' \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die
	sed -i \
		-e '/tic/d' \
		Makefile || die

	restore_config config.h

	if use st-underline; then
		sed -i 's/cursorshape = 2/cursorshape = 4/' config.h
	elif use st-bar; then
		sed -i 's/cursorshape = 2/cursorshape = 6/' config.h
	elif use st-snowman; then
		sed -i 's/cursorshape = 2/cursorshape = 8/' config.h
	fi

	if use st-large; then
		sed -i 's/cols = 80/cols = 120/' config.h
		sed -i 's/rows = 24/rows = 32/' config.g
	fi

	if use st-bell; then
		sed -i 's/bellvolume = 0/bellvolume = 100/' config.h
	fi
}

src_configure() {
	sed -i \
		-e "s|pkg-config|$(tc-getPKG_CONFIG)|g" \
		config.mk || die

	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install

	make_desktop_entry ${PN} simpleterm utilities-terminal 'System;TerminalEmulator;' ''

	save_config config.h
}

pkg_postinst() {
	if ! [[ "${REPLACING_VERSIONS}" ]]; then
		elog "Please ensure a usable font is installed, like"
		elog "    media-fonts/corefonts"
		elog "    media-fonts/dejavu"
		elog "    media-fonts/urw-fonts"
	fi
}
