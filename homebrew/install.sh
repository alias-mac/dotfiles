#!/usr/bin/env bash
#
# Homebrew
#
# If we're on a Mac, let's install http://brew.sh and setup some of the common
# dependencies needed (or at least desired) for us.
#

if [ "$(uname -s)" != "Darwin" ]
then
  return
fi

# Check if we already have Homebrew installed
type -P brew &>/dev/null ||
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log

# Replace git with the brew version (always latest)
brew install git

# Install homebrew packages
brew install grc wget hub gist #spark

# Good for gnu utils
brew install coreutils

# Required to use notify functions
brew install terminal-notifier 

# Add file command from gnu
brew install file-formula
ln -s `brew --prefix file-formula`/bin/file `brew --prefix`/bin/gfile
