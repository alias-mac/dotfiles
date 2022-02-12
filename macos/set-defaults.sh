# Sets reasonable OS X defaults.
#
# Or, in other words, set shit how I like in OS X.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#
# Run ./set-defaults.sh and you'll be good to go.
#
# more information about other settings can be found:
# 	http://secrets.blacktree.com
#

##
# General
##

# Set the clock settings (System Preferences → Date & Time → Clock)
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  H:mm:ss"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock ShowSeconds -bool true

# Set dark interface on the menu
defaults write -g AppleInterfaceStyle -string "Dark"

# Set Close windows when quitting an app to false
# This will preserve the windows in iTerm2 for example after updating or
# quitting, which is exactly what I need.

defaults write -g NSQuitAlwaysKeepsWindows -bool false

##
# Autocorrect
##

# Turn autocorrect, capitalization, period etc off globally (all apps)
defaults write -g WebAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true

# Turn text completion off on touchbar (no need for that!)
defaults write -g NSAutomaticTextCompletionEnabled -bool false

##
# Screen saver options
##

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

##
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
##

# Trackpad app exposé swipe down
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Magic Mouse: enable 2nd mouse click (System Preferences → Mouse)
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"

# Enable full keyboard access for all controls (System Preferences → Keyboard → Keyboard Shortcuts)
# (e.g. enable Tab in modal dialogs)
defaults write -g AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate (System Preferences → Keyboard)
defaults write -g KeyRepeat -int 5
#defaults write -g InitialKeyRepeat -int 20

# Set language and text formats (System Preferences → Language & Text)
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, and `true` with `false`.
defaults write -g AppleLanguages -array "en-US" "pt" "pt-US"
defaults write -g AppleLocale -string "pt_PT@currency=EUR"
defaults write -g AppleMeasurementUnits -string "Centimeters"
defaults write -g AppleMetricUnits -bool true
defaults write -g AppleTemperatureUnit -string "Celsius"

# Set system time to HH:mm (24h format)
defaults write -g AppleICUForce24HourTime -bool true
#/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings dict' ~/Library/Preferences/.GlobalPreferences.plist
#/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:1 string "HH:mm"' ~/Library/Preferences/.GlobalPreferences.plist
#/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:2 string "HH:mm:ss"' ~/Library/Preferences/.GlobalPreferences.plist
#/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:3 string "HH:mm:ss z"' ~/Library/Preferences/.GlobalPreferences.plist
#/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:4 string "HH:mm:ss zzzz"' ~/Library/Preferences/.GlobalPreferences.plist

# Adds PT keyboard to input sources
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '{InputSourceKind="Keyboard Layout"; "KeyboardLayout Name"="Portuguese"; "KeyboardLayout ID"=10;}'

# Change "Move focus to next window" shortcut to ⌘< (same keys, but PT layout)
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:27:value:parameters:0 60" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# Disable "Select the previous input source" shortcut
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:60:enabled 0" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# Disable "Select next source in Input menu" shortcut
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:61:enabled 0" ~/Library/Preferences/com.apple.symbolichotkeys.plist

defaults write com.apple.HIToolbox AppleFnUsageType -int 1

##
# Control strip (for touchbar)
##

defaults write com.apple.controlstrip.plist MiniCustomized -array \
    "com.apple.system.brightness"\
    "com.apple.system.volume"\
    "com.apple.system.mute"\
    "com.apple.system.screen-lock"

defaults write com.apple.controlstrip.plist FullCustomized -array \
    "com.apple.system.group.brightness"\
    "com.apple.system.mission-control"\
    "com.apple.system.launchpad"\
    "com.apple.system.group.keyboard-brightness"\
    "com.apple.system.group.media"\
    "com.apple.system.group.volume"\
    "com.apple.system.siri"\
    "com.apple.system.screen-lock"

##
# Dock
##

# Minimize on double click (System Preferences → Dock)
defaults write -g AppleMiniaturizeOnDoubleClick -bool true

# Minimize to application (System Preferences → Dock)
defaults write com.apple.dock minimize-to-application -bool true

# Magnification and sizes
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -int 45
defaults write com.apple.dock largesize -int 75

# Don't use auto show/hide on dock
defaults write com.apple.dock autohide -bool false

##
# Finder
##

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show item info below icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and by name on standard view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Enable the warning before emptying trash
defaults write com.apple.finder WarnOnEmptyTrash -bool true

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Open default on my home folder
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

##
# Better Touch Tool
##
defaults write com.hegenberg.BetterTouchTool.plist launchOnStartup -bool true

##
# iCal
##

# timezone support active by default
defaults write com.apple.iCal "TimeZone support enabled" -bool true
# show event times
defaults write com.apple.iCal "Show time in Month View" -bool true
# show week numbers by default
defaults write com.apple.iCal "Show Week Numbers" -bool true

# birthdays on
defaults write com.apple.iCal "display birthdays calendar" -bool true

# default calendar change (change this to your calendar id)
defaults write com.apple.iCal "CalDefaultCalendarSelectedByUser" -bool true
defaults write com.apple.iCal "CalDefaultCalendar" -string "5E11650F-1FBB-4725-84F7-7A5A5A485735"

##
# Safari & WebKit
##

# Show full website address
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Show status bar
defaults write com.apple.Safari ShowStatusBar -bool true

# Show Tab bar
defaults write com.apple.Safari AlwaysShowTabBar -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Always restore session after launch on Safari
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

##
# Terminal
##

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Pro theme by default in Terminal.app
open "$DOT/macos/Bond.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.Terminal "Default Window Settings" -string "Bond"
defaults write com.apple.Terminal "Startup Window Settings" -string "Bond"

# Enable "focus follows mouse" for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

##
# ActivityMonitor
##

# Set dock icon to show CPU history
defaults write com.apple.ActivityMonitor.plist IconType -int 6

##
# iTerm2
##

defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$PWD/Library/Mobile Documents/com~apple~CloudDocs/Apps/iterm2-`scutil --get ComputerName`"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

##
# Kill affected applications
##

for app in "BetterTouchTool" "Dock" "Finder" "Calendar" "Messages" \
    "Safari" "SystemUIServer"; do
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

echo "Terminal has been updated. Please close it and open it again."
