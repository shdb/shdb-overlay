# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="user for ping_exporter"
ACCT_USER_ID=1117
ACCT_USER_GROUPS=( ping_exporter )
ACCT_USER_HOME=/dev/null

acct-user_add_deps
