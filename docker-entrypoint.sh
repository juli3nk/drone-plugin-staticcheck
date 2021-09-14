#!/bin/sh

set_var() {
	local result=$2

	if [ -n "$1" ]; then
		result=$1
	fi

	echo $result
}

test $(git diff-tree --no-commit-id --name-only -r $DRONE_COMMIT | grep ".go$" | wc -l) -gt 0 || { echo "go files have not changed"; exit 0; }

SCRIPT_NETRC_ENABLED=$(set_var $PLUGIN_NETRC_ENABLED "false")
SCRIPT_NETRC_MACHINE=$(set_var $PLUGIN_NETRC_MACHINE "github.com")
SCRIPT_NETRC_LOGIN=$(set_var $NETRC_LOGIN $DRONE_GIT_USERNAME)
SCRIPT_NETRC_PASSWORD=$(set_var $NETRC_PASSWORD $DRONE_GIT_PASSWORD)

STATICCHECK_PACKAGE=$(set_var $PLUGIN_PACKAGE_NAME "./...")

test "$SCRIPT_NETRC_ENABLED" && printf "machine ${SCRIPT_NETRC_MACHINE}\nlogin ${SCRIPT_NETRC_LOGIN}\npassword ${SCRIPT_NETRC_PASSWORD}\n" >> /root/.netrc \
	&& chmod 600 /root/.netrc

staticcheck $STATICCHECK_PACKAGE
