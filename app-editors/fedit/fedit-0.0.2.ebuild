# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A simple to use text editor, closely related to vim"
HOMEPAGE="https://github.com/failex234/fedit"
SRC_URI="https://dl.failex.de/Stuff/private/fedit-0.0.2-pre.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	mkdir -p "${D}/usr/bin"
	emake DESTDIR="${D}" install
}
