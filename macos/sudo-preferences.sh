#!/usr/bin/env bash
#
# macOS preferences that require user password.
# Run manually once per machine: ./macos/sudo-preferences.sh
#

set -euo pipefail

echo "==> Setting macOS preferences (requires password)"

# Require password immediately after screen saver / display off
sysadminctl -screenLock immediate -password -

echo "==> Done"
