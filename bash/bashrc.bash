
export EDITOR='subl'

# your projects folder
export WORKS=~/Works

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# autocomplete for sudo
complete -c -f command sudo
# autocomplete for ssh hosts
complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | grep -v “[?*]” | cut -d" " -f2)" scp sftp ssh

alias mkpasswd='echo `env LC_CTYPE=C tr -dc "a-zA-Z0-9-_\$\?" < /dev/urandom | head -c 10`'
