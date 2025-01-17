# Copyright 2015-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="A prometheus exporter for qBitorrent. Get metrics from a server and offers them in a prometheus format."
HOMEPAGE="https://github.com/esanchezm/prometheus-qbittorrent-exporter"
SRC_URI="https://github.com/esanchezm/prometheus-qbittorrent-exporter/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ppc ppc64 sparc x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-python/attrdict
        dev-python/qbittorrent-api:=
		dev-python/python-json-logger
		dev-python/prometheus-client"
BDEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

#PATCHES=(
#	"${FILESDIR}/requires-${PV}.patch"
#)
