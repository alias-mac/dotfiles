# Sets reasonable OS X defaults.
#
# Or, in other words, set shit how I like in OS X.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#
# Run ./set-defaults.sh and you'll be good to go.

##
# General
##

# Menu bar: show TextInput, Displays, User, etc.
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Displays.menu" "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu" "/System/Library/CoreServices/Menu Extras/TextInput.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/User.menu"


# Set the clock settings (System Preferences → Date & Time → Clock)
defaults write com.apple.menuextra.clock DateFormat -string "EE H:mm:ss"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Enable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true
defaults write NSGlobalDomain NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true

##
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
##

# Magic Mouse: enable 2nd mouse click (System Preferences → Mouse)
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"

# Enable full keyboard access for all controls (System Preferences → Keyboard → Keyboard Shortcuts)
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate (System Preferences → Keyboard)
defaults write NSGlobalDomain KeyRepeat -int 0

# Set language and text formats (System Preferences → Language & Text)
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "pt_PT" "pt"
#defaults write NSGlobalDomain AppleLocale -string "pt_PT@currency=EUR"
#defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
#defaults write NSGlobalDomain AppleMetricUnits -bool true

##
# Dock
##

# Minimize on double click (System Preferences → Dock)
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool true

# Minimize to application (System Preferences → Dock)
defaults write com.apple.dock minimize-to-application -bool true

# Magnification and sizes
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -int 45
defaults write com.apple.dock largesize -int 75

##
# Finder
##

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

##
# Better Touch Tool
##
defaults write launchOnStartup -bool true

##
# iChat
##

# make it more silent on some events
osascript "$DOT/osx/iChat-prefs.scpt"

##
# Terminal
##

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Pro theme by default in Terminal.app
open "$DOT/osx/Bond.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal "Default Window Settings" -string "Bond"
defaults write com.apple.terminal "Startup Window Settings" -string "Bond"

# Enable "focus follows mouse" for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true



##
# Kill affected applications
##

for app in "Dock" "Finder" "BetterTouchTool"; do
    killall "$app" > /dev/null 2>&1
done

##
# Open background affected applications
##
for app in "BetterTouchTool"; do
    if [[ -a /Applications/"$app".app ]]
    then
        open /Applications/"$app".app
	fi
done

echo "Done. Note that some of these changes require a logout/restart to take effect."

# Terminal goes at the end
killall Terminal > /dev/null 2>&1
