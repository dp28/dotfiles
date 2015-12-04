autoload -U promptinit && promptinit
autoload -U colors && colors

colour_string() {
  echo "%{$fg_bold[$1]%}$2%{$reset_color%}"
}

precmd() {
  in_git=`git symbolic-ref --short HEAD 2>/dev/null`
  if [ -n "$in_git" ] ; then
    repo=`colour_string blue "$(git_repo)"`
    branch=`colour_string green "$(git_branch)"`
    git_status=`colour_string yellow "$(git_branch_status)"`
    PROMPT="$repo|$branch|$git_status"
  else
    PROMPT="%n@%m"
  fi

  PROMPT="`date +%H:%M`|$PROMPT
\$ "
  RPROMPT="%(?..[`colour_string red "%?"`])"
}
