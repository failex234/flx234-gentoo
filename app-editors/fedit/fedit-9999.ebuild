# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="A simple to use text editor, closely related to vim"
HOMEPAGE="https://github.com/failex234/fedit"
EGIT_REPO_URI="https://github.com/failex234/fedit.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	mkdir -p ${D}/usr/bin
	emake DESTDIR="${D}" install
}
