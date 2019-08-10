#
# Nice git prompt for massive git usage
#
prompt=$(brew --prefix)/etc/bash_completion.d/git-prompt.sh
if [[ -a $prompt ]]
then

  source $prompt

  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=true
  GIT_PS1_SHOWCOLORHINTS=true

  battery_status() {
    $DOT/bin/battery-status
  }


  precmd() {
    __git_ps1 "
$(battery_status)%m:%1~ %n
" "$ " "(%s)"
  }

fi
