# for colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# grep colors
alias grep='grep --color=auto'

# Modern CLI replacements
if command -v bat > /dev/null ; then
  alias cat="bat"
elif command -v batcat > /dev/null ; then
  alias cat="batcat"
fi

if command -v lsd > /dev/null ; then
  alias ls="lsd"
  alias ll='ls -lah'
  alias llg='ls -lahg' # -g shows git status in lsd (slower)
else
  alias ll='ls -lah'
fi

# alias for listing
alias la='ls -a'
alias lt='ls --tree'
alias l='ls -lh'

# alias for disk tools
alias du='du -h'

# alias for copy move and remove
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# reload bash stuff
alias reload='. ~/.zshrc'

# make me a password
alias genpasswd='echo `env LC_CTYPE=C tr -dc "a-zA-Z0-9-_\$\?" < /dev/urandom | head -c 20`'

# copy the public key
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
