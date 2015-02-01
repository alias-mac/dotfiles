#
# OS X setup and tweaks
#

if [ "$(uname -s)" != "Darwin" ]
then
  return
fi

$DOT/osx/set-defaults.sh

user ' - Do you want to enable Remote Login with SSH?'
read -n 1 ssh_login

if [ ssh_login ]
then
  sudo systemsetup -setremotelogin on
fi
