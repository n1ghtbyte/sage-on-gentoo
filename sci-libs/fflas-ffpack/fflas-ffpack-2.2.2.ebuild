# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools toolchain-funcs eutils

DESCRIPTION="FFLAS-FFPACK is a library for dense linear algebra over word-size finite fields."
HOMEPAGE="https://linbox-team.github.io/fflas-ffpack/"
SRC_URI="https://github.com/linbox-team/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-macos"
IUSE="static-libs openmp cpu_flags_x86_sse4_1 cpu_flags_x86_avx cpu_flags_x86_avx2 bindist"

REQUIRED_USE="bindist? ( !cpu_flags_x86_sse4_1 !cpu_flags_x86_avx !cpu_flags_x86_avx2 )"

RESTRICT="mirror"

DEPEND="virtual/cblas
	virtual/lapack
	>=dev-libs/gmp-4.0[cxx]
	~sci-libs/givaro-4.0.2"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-2.2.2-blaslapack.patch"
	)

pkg_pretend() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

pkg_setup(){
	tc-export PKG_CONFIG
}

src_prepare(){
	epatch "${PATCHES[@]}"
	default

	eautoreconf
}

src_configure() {
	local avx_opt="--disable-avx"
	if( (use cpu_flags_x86_avx) || (use cpu_flags_x86_avx2) ); then
		avx_opt="--enable-avx"
	fi

	econf \
		--enable-optimization \
		--enable-precompilation \
		$(use_enable openmp) \
		$(use_enable cpu_flags_x86_sse4_1 sse) \
		${avx_opt} \
		$(use_enable static-libs static)
}