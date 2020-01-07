# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Additional (link-route / default-gateway) vif scripts for Xen"
HOMEPAGE="https://github.com/GITHUB_REPOSITORY"
LICENSE="GPL-3"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/GITHUB_REPOSITORY"
    EGIT_BRANCH="GITHUB_REF"
else
    SRC_URI="https://github.com/GITHUB_REPOSITORY/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS=""
IUSE="test"
SLOT="0"

RESTRICT="!test? ( test )"

RDEPEND="app-emulation/xen-tools"
DEPEND="test? (
    ${RDEPEND}
    dev-util/bats-assert
    dev-util/bats-file
)"

src_test() {
    bats --tap tests || die "Tests failed"
}

src_install() {
    einstalldocs

    exeinto /etc/xen/scripts
    doexe etc/xen/scripts/*
}
