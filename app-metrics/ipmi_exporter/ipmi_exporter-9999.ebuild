# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

### something with fetching the dependencies is not working - with FEATURES="-network-sandbox" it does work...

EAPI=7
inherit go-module systemd

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/prometheus-community/ipmi_exporter.git"
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

DESCRIPTION="Prometheus exporter for IPMI"
HOMEPAGE="https://github.com/prometheus-community/ipmi_exporter"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.13
	    sys-apps/ipmitool"
RDEPEND="acct-group/ipmi_exporter
		 acct-user/ipmi_exporter"
BDEPEND="dev-util/promu"

src_install() {
	dobin ipmi_exporter
	#dodoc src/${EGO_PN}/README.md
	local dir
	for dir in /var/{lib,log}/${PN}; do
		keepdir "${dir}"
		fowners ${PN}:${PN} "${dir}"
	done
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotated" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"
    insinto /etc/ipmi_exporter
    #newins src/${EGO_PN}/ipmi.yml ipmi.yml
}
