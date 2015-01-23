#!/bin/sh

if test ! $(which node) -a $(which brew)
then
  info 'Installing node for you.'
  brew install node > /tmp/node-install.log

  info 'Installing npm for you.'
  curl -L https://npmjs.org/install.sh | sh
fi
