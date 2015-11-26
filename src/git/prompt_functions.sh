git_branch() {
  GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  [ -n "$GIT_BRANCH" ] && echo $GIT_BRANCH
}

git_repo() {
  GIT_REPO=$(basename `git rev-parse --show-toplevel 2>/dev/null` 2>/dev/null) || return
  [ -n "$GIT_REPO" ] && echo $GIT_REPO
}

git_branch_status() {
  git rev-parse @{u} &>/dev/null
  if [ $? -gt 0 ]; then
    echo "Not tracking remote"
    return
  fi

  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u})
  BASE=$(git merge-base @ @{u})

  if [ $LOCAL = $REMOTE ]; then
    git diff-index --quiet @ --
    if [ $? -gt 0 ]; then
      echo "* Uncommitted changes"
    else
      echo "= Up to date"
    fi
  elif [ $LOCAL = $BASE ]; then
    echo "< Behind origin"
  elif [ $REMOTE = $BASE ]; then
    echo "> Ahead of origin"
  else
    echo "<> Diverged"
  fi
}
