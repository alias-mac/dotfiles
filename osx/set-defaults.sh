# Sets reasonable OS X defaults.
#
# Or, in other words, set shit how I like in OS X.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#
# Run ./set-defaults.sh and you'll be good to go.

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

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true


###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Terminal"; do
    killall "$app" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
