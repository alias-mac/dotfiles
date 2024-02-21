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

  echo "> Installing brew"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /tmp/homebrew-install.log
fi
