# Copyright 2015-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1
export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}


DESCRIPTION="Python client implementation for qBittorrent Web API"
HOMEPAGE="https://github.com/rmartin16/qbittorrent-api"
SRC_URI="https://github.com/rmartin16/qbittorrent-api/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ppc ppc64 sparc x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )
		 dev-python/setuptools[${PYTHON_USEDEP}]"
