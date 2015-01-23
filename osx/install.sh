#
# OS X setup and tweaks
#

if [ "$(uname -s)" != "Darwin" ]
then
  return
fi

$DOT/osx/set-defaults.sh
