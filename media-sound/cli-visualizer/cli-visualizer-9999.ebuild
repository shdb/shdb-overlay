# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Command line audio visualizer"
HOMEPAGE="https://github.com/blshkv/cli-visualizer"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sys-libs/ncurses
	sci-libs/fftw
"

DEPEND="${RDEPEND}"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/blshkv/cli-visualizer.git"
else
	SRC_URI="https://github.com/blshkv/cli-visualizer/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

