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

# Menu bar: show TextInput, Displays, User, etc.
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Displays.menu" "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu" "/System/Library/CoreServices/Menu Extras/TextInput.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/User.menu"


# Set the clock settings (System Preferences → Date & Time → Clock)
defaults write com.apple.menuextra.clock DateFormat -string "EEE H:mm:ss"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Enable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true
defaults write NSGlobalDomain NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true

##
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
##

# Trackpad app exposé swipe down
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Magic Mouse: enable 2nd mouse click (System Preferences → Mouse)
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"

# Enable full keyboard access for all controls (System Preferences → Keyboard → Keyboard Shortcuts)
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Change "Move focus to next window" shortcut to ⌘§
#/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:51:value:parameters:0 167" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# and "Move focus to the widnow drawer" shorcut to ⌥⌘§
#/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:51:value:parameters:1 10" ~/Library/Preferences/com.apple.symbolichotkeys.plist

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate (System Preferences → Keyboard)
defaults write NSGlobalDomain KeyRepeat -int 5
#defaults write NSGlobalDomain InitialKeyRepeat -int 20

# Set language and text formats (System Preferences → Language & Text)
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "pt_PT" "pt"
#defaults write NSGlobalDomain AppleLocale -string "pt_PT@currency=EUR"
#defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
#defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set system time to HH:mm (24h format)
/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings dict' ~/Library/Preferences/.GlobalPreferences.plist
/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:1 string "HH:mm"' ~/Library/Preferences/.GlobalPreferences.plist
/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:2 string "HH:mm:ss"' ~/Library/Preferences/.GlobalPreferences.plist
/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:3 string "HH:mm:ss z"' ~/Library/Preferences/.GlobalPreferences.plist
/usr/libexec/PlistBuddy -c 'Add :AppleICUTimeFormatStrings:4 string "HH:mm:ss zzzz"' ~/Library/Preferences/.GlobalPreferences.plist

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

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Open default on my home folder
defaults write com.apple.finder NewWindowTargetPath -string "file://localhost${HOME}"

##
# Address Book
##

# Show first name before last name
defaults write com.apple.AddressBook ABNameDisplay -int 0

# Sort by First name and then Last name
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"

# Show Nickname, JobTitle, Department
defaults write com.apple.AddressBook ABNicknameVisible -int 1
defaults write com.apple.AddressBook ABJobTitleVisible -int 1
defaults write com.apple.AddressBook ABDepartmentVisible -int 1

# Show Related Names, Birthday and other dates on templates
defaults write com.apple.AddressBook ABBirthDayVisible -int 1
defaults write com.apple.AddressBook ABDatesVisible -int 1
defaults write com.apple.AddressBook ABRelatedRecordsVisible -int 1
defaults write com.apple.AddressBook ABSocialProfilesVisible -bool true

##
# Better Touch Tool
##
defaults write launchOnStartup -bool true

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
# iChat
##

# make it more silent on buddy in/out
#/usr/libexec/PlistBuddy -c "Set :EventActions:BuddyAvailable:PlaySound false" ~/Library/Preferences/com.apple.iChat.plist
#/usr/libexec/PlistBuddy -c "Set :EventActions:BuddyUnavailable:PlaySound false" ~/Library/Preferences/com.apple.iChat.plist

##
# Safari & WebKit
##

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
# Twitter.app
##

# Disable smart quotes as it’s annoying for code tweets
defaults write com.twitter.twitter-mac AutomaticQuoteSubstitutionEnabled -bool false

# Show the app window when clicking the menu icon
defaults write com.twitter.twitter-mac MenuItemBehavior -int 1

# Enable the hidden ‘Develop’ menu
defaults write com.twitter.twitter-mac ShowDevelopMenu -bool true

# Open links in the background
defaults write com.twitter.twitter-mac openLinksInBackground -bool true

# Allow closing the ‘new tweet’ window by pressing `Esc`
defaults write com.twitter.twitter-mac ESCClosesComposeWindow -bool true

# Show full names rather than Twitter handles
defaults write com.twitter.twitter-mac ShowFullNames -bool true

# Hide the app in the background if it’s not the front-most window
defaults write com.twitter.twitter-mac HideInBackground -bool true

##
# GPG tools (Mail)
##
defaults write org.gpgtools.gpgmail DefaultSecurityMethod -int 2

##
# Kill affected applications
##

for app in "BetterTouchTool" "Dock" "Finder" "iCal" "Messages" \
    "Safari" "SystemUIServer" "Transmission" "Twitter"; do
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
