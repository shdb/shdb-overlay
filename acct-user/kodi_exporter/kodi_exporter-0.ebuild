# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for kodi_exporter"
ACCT_USER_ID=118
ACCT_USER_GROUPS=( kodi_exporter )
ACCT_USER_HOME=/dev/null

acct-user_add_deps
