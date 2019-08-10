
type -P vi &>/dev/null && export EDITOR='vi'
type -P vim &>/dev/null && export EDITOR='vim'
type -P subl &>/dev/null && export EDITOR='subl'
type -P atom &>/dev/null && export EDITOR='atom'
type -P code &>/dev/null && export EDITOR='code'

# your projects folder
export CODE=~/Code

HISTFILE=~/.zsh_history
# big big history
HISTSIZE=100000
SAVEHIST=100000

# history like it should always be
# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt HIST_VERIFY # don’t execute the line directly
setopt EXTENDED_HISTORY # add timestamps to history
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS # don't record dupes in history
setopt HIST_REDUCE_BLANKS # remove superfluous blanks

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

setopt PROMPT_SUBST
setopt IGNORE_EOF # prevents closing the shell by mistake with `ctrl + d`
