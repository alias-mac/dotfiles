#!/usr/bin/env bash
#
# Sets macOS preferences.
#
# Run via chezmoi's run_onchange script, or manually:
#   ./macos/preferences.sh
#

set -euo pipefail

echo "==> Setting macOS defaults"


# Set a default if it differs from the expected value.
# Usage: set_default <domain> <key> <type> <value> [FLAG_VAR]
# For bools: value should be 1 or 0 (matches defaults read output)
set_default() {
  local domain="$1" key="$2" type="$3" value="$4" flag_var="${5:-}"
  local current
  current="$(defaults read "$domain" "$key" 2>/dev/null || echo "")"

  if [[ "$current" != "$value" ]]; then
    local write_value="$value"
    if [[ "$type" == "bool" ]]; then
      [[ "$value" == "1" ]] && write_value="true" || write_value="false"
    fi
    defaults write "$domain" "$key" "-$type" "$write_value"
    if [[ -n "$flag_var" ]]; then eval "$flag_var=true"; fi
  fi
}

##
# Appearance
##

# Dark mode
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'

##
# Date & Time
##

NEEDS_CONTROLCENTER_RESTART=false

# 24-hour time
set_default NSGlobalDomain AppleICUForce24HourTime bool 1 NEEDS_CONTROLCENTER_RESTART

##
# Language & Region
##

NEEDS_LOGOUT=false

# Set languages (English + Portuguese)
if ! defaults read -g AppleLanguages 2>/dev/null | grep -q "pt"; then
  defaults write -g AppleLanguages -array "en-US" "pt" "pt-US"
  defaults write -g AppleLocale -string "en_US@currency=EUR"
  NEEDS_LOGOUT=true
fi

# Metric system and Celsius
set_default NSGlobalDomain AppleTemperatureUnit string Celsius
set_default NSGlobalDomain AppleMeasurementUnits string Centimeters
set_default NSGlobalDomain AppleMetricUnits bool 1

##
# Keyboard
##

# Ensure Portuguese keyboard is available alongside U.S.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENABLE_INPUT_SOURCE=$(mktemp /tmp/enable-input-source-XXXXXX)
swiftc "${SCRIPT_DIR}/enable-input-source.swift" -o "$ENABLE_INPUT_SOURCE" -framework Carbon
"$ENABLE_INPUT_SOURCE" com.apple.keylayout.Portuguese
rm -f "$ENABLE_INPUT_SOURCE"

# Show input menu in menu bar
set_default com.apple.TextInputMenu visible bool 1 NEEDS_LOGOUT

# Press 🌐 key to: Change Input Source (1 = input source, 2 = emoji, 3 = dictation)
set_default com.apple.HIToolbox AppleFnUsageType int 1

# Enable dictation with "Press 🌐 Twice" shortcut
defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs \
  DictationIMMasterDictationEnabled -bool true
defaults write com.apple.HIToolbox AppleDictationAutoEnable -int 1
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 164 \
  "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>8388608</integer><integer>4286578687</integer></array><key>type</key><string>modifier</string></dict></dict>"

# Disable "Select previous input source" (^Space) and "Select next source in Input menu" (^⌥Space)
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:60:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null \
  || /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:enabled bool false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:61:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null \
  || /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:enabled bool false" ~/Library/Preferences/com.apple.symbolichotkeys.plist

# "Move focus to next window" shortcut: ⌘< (for PT keyboard layout)
# 60 = '<' key code, 50 = key scan code, 1048576 = ⌘ modifier
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 \
  "<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>60</integer><integer>50</integer><integer>1048576</integer></array></dict></dict>"

# Use F1, F2, etc. as standard function keys
set_default NSGlobalDomain com.apple.keyboard.fnState bool 1

# Keyboard navigation (tab through all controls)
set_default NSGlobalDomain AppleKeyboardUIMode int 3

# Disable accent popup, enable key repeat
set_default NSGlobalDomain ApplePressAndHoldEnabled bool 0

# Disable autocorrect, capitalization, and period substitution
set_default NSGlobalDomain NSAutomaticSpellingCorrectionEnabled bool 0
set_default NSGlobalDomain WebAutomaticSpellingCorrectionEnabled bool 0
set_default NSGlobalDomain NSAutomaticCapitalizationEnabled bool 0
set_default NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled bool 0

##
# Finder
##

NEEDS_FINDER_RESTART=false

set_default com.apple.finder AppleShowAllFiles bool 1 NEEDS_FINDER_RESTART
set_default NSGlobalDomain AppleShowAllExtensions bool 1 NEEDS_FINDER_RESTART
set_default com.apple.finder ShowStatusBar bool 1 NEEDS_FINDER_RESTART
set_default com.apple.finder ShowPathbar bool 1 NEEDS_FINDER_RESTART
set_default com.apple.finder FXDefaultSearchScope string SCcf NEEDS_FINDER_RESTART
set_default com.apple.desktopservices DSDontWriteNetworkStores bool 1
set_default com.apple.finder FXPreferredViewStyle string clmv NEEDS_FINDER_RESTART
set_default com.apple.finder WarnOnEmptyTrash bool 1
set_default com.apple.finder NewWindowTargetPath string "file://${HOME}" NEEDS_FINDER_RESTART
# Icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist

##
# Dock
##

NEEDS_DOCK_RESTART=false

# Minimize on double click
set_default NSGlobalDomain AppleMiniaturizeOnDoubleClick bool 1 NEEDS_DOCK_RESTART
set_default com.apple.dock minimize-to-application bool 1 NEEDS_DOCK_RESTART
set_default com.apple.dock magnification bool 1 NEEDS_DOCK_RESTART
set_default com.apple.dock tilesize int 45 NEEDS_DOCK_RESTART
set_default com.apple.dock largesize int 75 NEEDS_DOCK_RESTART
set_default com.apple.dock autohide bool 0 NEEDS_DOCK_RESTART
set_default com.apple.dock showAppExposeGestureEnabled bool 1 NEEDS_DOCK_RESTART
# Mission Control: group windows by application
set_default com.apple.dock expose-group-apps bool 1 NEEDS_DOCK_RESTART

##
# Safari
##

# Show full URL (including https:// and path) in address bar
set_default com.apple.Safari ShowFullURLInSmartSearchField bool 1

##
# Activity Monitor
##

defaults write com.apple.ActivityMonitor IconType -int 6

##
# Terminal.app
##

if [[ "$(defaults read com.apple.Terminal 'Default Window Settings' 2>/dev/null)" != "Bond" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  open "${SCRIPT_DIR}/Bond.terminal"
  sleep 1
  defaults write com.apple.Terminal "Default Window Settings" -string "Bond"
  defaults write com.apple.Terminal "Startup Window Settings" -string "Bond"
fi

##
# Restart affected services
##

# Activate symbolic hotkeys changes
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
killall -HUP DictationIM 2>/dev/null || true

if $NEEDS_FINDER_RESTART; then
  killall Finder 2>/dev/null || true
fi

if $NEEDS_DOCK_RESTART; then
  killall Dock 2>/dev/null || true
fi

if $NEEDS_CONTROLCENTER_RESTART; then
  killall ControlCenter 2>/dev/null || true
fi

echo "==> macOS defaults applied"

if $NEEDS_LOGOUT; then
  echo "==> NOTE: Some changes require a logout/login to take effect."
fi
