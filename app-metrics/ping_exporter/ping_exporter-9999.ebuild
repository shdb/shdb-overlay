# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

### something with fetching the dependencies is not working - with FEATURES="-network-sandbox" it does work...

EAPI=7
inherit golang-vcs-snapshot go-module systemd

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/czerwonk/ping_exporter.git"
	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
	}
else
	SRC_URI="https://github.com/prometheus-community/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	         ${EGO_SUM_SRC_URI}"
	EGO_SUM=(
		"github.com/go-kit/log	v0.2.0/go.mod"
		"github.com/prometheus/client_golang	v1.11.0/go.mod"
		"github.com/prometheus/common	v0.30.0/go.mod"
		"gopkg.in/yaml.v2	v2.4.0/go.mod"
		"gopkg.in/alecthomas/kingpin.v2	v2.2.6/go.mod"
	)
	go-module_set_globals
fi
KEYWORDS="~amd64"

SRC_URI+=" ${EGO_SUM_SRC_URI}"

DESCRIPTION="Prometheus exporter for ICMP echo requests"
HOMEPAGE="https://github.com/czerwonk/ping_exporter"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.13"
RDEPEND="acct-group/ping_exporter
		 acct-user/ping_exporter"

src_compile() {
	ego build
}

src_install() {
	dobin ping_exporter
	#newinitd "${FILESDIR}"/${PN}.initd ${PN}
	#newconfd "${FILESDIR}"/${PN}.confd ${PN}
	#insinto /etc/logrotate.d
	#newins "${FILESDIR}/${PN}.logrotated" "${PN}"
	systemd_dounit "dist/${PN}.service"
	#systemd_dounit "${FILESDIR}/${PN}.service
    insinto /etc/ping_exporter
    newins dist/ping_exporter.yaml config.yml
}
