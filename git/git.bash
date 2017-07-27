#
# Nice git prompt for massive git usage
#

prompt=$(brew --prefix)/etc/bash_completion.d/git-prompt.sh
if [[ -a $prompt ]]
then

  type -P hub &>/dev/null && [ -d .git ] && $(git rev-parse) &&
    eval "git remote -v show | grep github &>/dev/null" &&
    test -n $? && ci_status=$(hub ci-status < /dev/null)

  case $ci_status in
    *success) ci_status="\[\e[01;32m\]✔\[\e[m\] ";; # green
    *error)   ci_status="\[\e[01;31m\]✘\[\e[m\] ";; # red
    *failure) ci_status="\[\e[01;31m\]✘\[\e[m\] ";; # red
    *pending) ci_status="\[\e[01;33m\]⁇\[\e[m\] ";; # yellow
    *)        ci_status="" #unknown
  esac

  source $prompt
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=true
  GIT_PS1_SHOWCOLORHINTS=true
  PROMPT_COMMAND='__git_ps1 "\h:\W \u" "$ci_status\\\$ "'
  return
fi
