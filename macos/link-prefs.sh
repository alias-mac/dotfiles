#
# This installs Mac OS X preferences.
#
# Pass the folder you want to use to keep them in sync.
#
# E.g.: if you want to use Dropbox
# preferences ~/Dropbox
#

PREFERENCES_ROOT="$DOT/macos/preferences"

function abspath() {
  pushd . > /dev/null;
  if [ -d "$1" ]; then
    cd "$1"
    dirs -l +0
  else
    cd "`dirname \"$1\"`"
    cur_dir=`dirs -l +0`
    if [ "$cur_dir" == "/" ]; then
      return "$cur_dir`basename \"$1\"`";
    else
      return "$cur_dir/`basename \"$1\"`";
    fi
  fi
  popd > /dev/null
}

export DOTPREF="$(abspath $1)"

source $DOT/functions/interaction

set -e

echo ''

# TODO fix duplicated code
link_file () {

  source $DOT/functions/interaction

  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc=$(readlink "$dst")

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"

        read -n 1 action < /dev/tty

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then

    if [ ! -e "$src" ]; then
      fail "unable to link $src to $dst"
    fi

    ln -s "$src" "$dst"
    success "linked $src to $dst"
  fi
}

export -f link_file

inform 'installing preferences'

find "$DOT/macos/preferences/" -type f | while read installer ; do bash -c "${installer}" ; done

echo ''
echo '  Preferences installed!'
