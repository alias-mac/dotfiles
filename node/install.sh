#!/bin/sh

if test ! $(which node) -a $(which brew)
then
  echo "  Installing node for you."
  brew install node > /tmp/node-install.log

  echo "  Installing npm for you."
  curl -L https://npmjs.org/install.sh | sh
fi
