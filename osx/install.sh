#
# OS X setup and tweaks
#

if [ "$(uname -s)" != "Darwin" ]
then
  return
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

$DOT/osx/set-defaults.sh

user ' - Do you want to enable Remote Login with SSH?'
read -n 1 ssh_login

if [ ssh_login ]
then
  sudo systemsetup -setremotelogin on
fi

user ' - Do you want to enable File sharing?'
read -n 1 afp

if [ afp ]
then
  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
fi
