# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

Sparse_PV=$(ver_rs 3 '-')
Sparse_PN="SuiteSparse-${Sparse_PV}"
DESCRIPTION="Algorithm for matrix permutation into block triangular form"
HOMEPAGE="https://people.engr.tamu.edu/davis/suitesparse.html"
SRC_URI="https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/refs/tags/v${Sparse_PV}.tar.gz -> ${Sparse_PN}.gh.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/2"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

DEPEND="~sci-libs/suitesparseconfig-${PV}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${Sparse_PN}/${PN^^}"

multilib_src_configure() {
	local mycmakeargs=(
		-DNSTATIC=ON
	)
	cmake_src_configure
}
