#
# Load nvm
#

# support original install
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# and brew install
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] &&  . "$(brew --prefix)/opt/nvm/nvm.sh"
