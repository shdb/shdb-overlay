# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=(
	"github.com/prometheus/client_golang 505eaef017263e299324067d40ca2c48f6a2cf50"
	"github.com/prometheus/common cfeb6f9992ffa54aaa4f2170ade4067ee478b250"
	"github.com/beorn7/perks 3a771d992973f24aa725d07868b467d1ddfceafb"
	"github.com/golang/protobuf c823c79ea1570fb5ff454033735a8e68575d1d0f"
	"github.com/matttproud/golang_protobuf_extensions c12348ce28de40eed0136aa2b644d0ee0650e56c"
	"github.com/prometheus/client_model fd36f4220a901265f90734c3183c5f0c91daa0b8"
	"github.com/prometheus/procfs d0f344d83b0c80a1bc03b547a2374a9ec6711144"
	"github.com/sirupsen/logrus dae0fa8d5b0c810a8ab733fbd5510c7cae84eca4"
	"gopkg.in/alecthomas/kingpin.v2 947dcec5ba9c011838740e680966fd7087a71d0d github.com/alecthomas/kingpin"
	"github.com/alecthomas/template a0175ee3bccc567396460bf5acd36800cb10c49c"
	"github.com/alecthomas/units 2efee857e7cfd4f3d0138cc3cbb1b4966962b93a"
	"golang.org/x/crypto a1f597ede03a7bef967a422b5b3a5bd08805a01e github.com/golang/crypto"
	"golang.org/x/sys fead79001313d15903fb4605b4a1b781532cd93e github.com/golang/sys"
)

#inherit golang-build golang-vcs systemd
inherit golang-build golang-vcs-snapshot systemd

EGO_PN="github.com/nlamirault/kodi_exporter"
ARCHIVE_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="${ARCHIVE_URI}
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"

DESCRIPTION="Prometheus exporter for Kodi"
HOMEPAGE="https://github.com/nlamirault/kodi_exporter"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.11
		acct-user/kodi_exporter
		acct-group/kodi_exporter"

src_prepare() {
	pushd src/${EGO_PN} || die
	eapply "${FILESDIR}/export-episodes-${PV}.patch"
	popd || die
	default
}

src_install() {
	dobin kodi_exporter
	dodoc src/${EGO_PN}/README.md
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
	insinto /etc/kodi_exporter
}
