# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

DESCRIPTION="Content of the KnotInfo & LinkInfo databases as lists of dictionaries"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
HOMEPAGE="https://pypi.org/project/database-knotinfo/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
IUSE="test"

LICENSE="GPL-3"
SLOT="0"

DEPEND="test? ( >=sci-mathematics/sage-9.7 )"
RDEPEND=""
BDEPEND=""

RESTRICT="!test? ( test )"