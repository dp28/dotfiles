build_prompt() {
  IN_GIT=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$IN_GIT" ]
  then
    repo='\[\e[1;34m\]$(git_repo)\[\e[m\]'
    branch='\[\e[1;32m\]$(git_branch)\[\e[m\]'
    status='\[\e[1;33m\]$(git_branch_status)\[\e[00m\]'
    PS1="$repo|$branch|$status"

    local repo_path=$(git rev-parse --show-toplevel)
    local current_path=$(pwd)
    if [ $repo_path != $current_path ] ; then
      local repo_path="$repo_path/"
      PS1="$repo/${current_path/$repo_path/}|$branch|$status"
    fi
  else
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w '
  fi
  PS1="`date +%H:%M`|$PS1\n\$ "
}
PROMPT_COMMAND='build_prompt'
