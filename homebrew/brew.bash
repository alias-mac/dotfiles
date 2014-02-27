type -P brew &>/dev/null || return

# Sources a file
# Accepts 1 param which is the file we want include
function __open_war_loadifexists() {

    if [ -f $1 ]; then
        . $1
    fi
}

__open_war_loadifexists "`brew --prefix`/etc/grc.bashrc"
