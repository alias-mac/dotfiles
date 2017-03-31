#!/bin/sh

if test ! $(which node) -a $(which brew)
then
  inform 'Installing node for you.'
  brew install node > /tmp/node-install.log
fi
