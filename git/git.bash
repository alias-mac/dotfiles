#
# Nice git prompt for massive git usage
#

prompt=/usr/local/etc/bash_completion.d/git-prompt.sh
if [[ -a $prompt ]]
then
  source $prompt
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=true
  GIT_PS1_SHOWCOLORHINTS=true
  PROMPT_COMMAND='__git_ps1 "\h:\W \u" "\\\$ "'
  return
fi
