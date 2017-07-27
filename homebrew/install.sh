#!/usr/bin/env sh
#
# Homebrew
#
# If we're on a Mac, let's install http://brew.sh and setup some of the common
# dependencies needed (or at least desired) for us.
# If we are on Linux, install Linuxbrew only (no bundle install).
#

if test ! $(which brew)
then

  if test "$(uname -s)" = "Darwin"
  then
    echo "> Installing brew"

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log

    brew bundle
  elif test "$(uname -s)" = "Linux"
  then
    echo "> Installing lixuxbrew"

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"  > /tmp/homebrew-install.log
  fi
fi
