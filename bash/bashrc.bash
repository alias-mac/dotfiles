
type -P vi &>/dev/null && export EDITOR='vi'
type -P vim &>/dev/null && export EDITOR='vim'
type -P subl &>/dev/null && export EDITOR='subl'
type -P atom &>/dev/null && export EDITOR='atom'
type -P code &>/dev/null && export EDITOR='code'

# your projects folder
export PROJECTS=~/Code

# history like it should always be (no duplicate entries)
export HISTCONTROL=ignoredups:erasedups
# big big history
export HISTSIZE=100000
export HISTFILESIZE=100000
# append to history, don't overwrite it
shopt -s histappend

# Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# load all functions
if [[ -d $DOT/functions/ ]]
then
    for file in `ls $DOT/functions/`
    do
        source $DOT/functions/$file
    done
fi


# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi
