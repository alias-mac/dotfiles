#
# Global commands installed by yarn
# https://yarnpkg.com
#

type -P atom &>/dev/null && export PATH="$PATH:`yarn global bin`"
