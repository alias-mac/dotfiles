#!/usr/bin/env bash
#
# Homebrew
#
# This installs the git default configuration. You are free to change it after
# and keep it in sync if you want.
#

if ! [ -f git/gitconfig.symlink ]
then
  inform 'setup gitconfig'

  git_credential='cache'
  if [ "$(uname -s)" == "Darwin" ]
  then
    git_credential='osxkeychain'
  fi

  user ' - What is your github author name?'
  read -e git_authorname < /dev/tty
  user ' - What is your github author email?'
  read -e git_authoremail < /dev/tty

  sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.symlink.example > git/gitconfig.symlink

  success 'gitconfig generated'
fi
