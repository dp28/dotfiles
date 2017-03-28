gsh() {
  if [ $# -eq 0 ]; then
    echo "git shortlog origin/master..HEAD"
    git shortlog origin/master..HEAD
  else
    git shortlog "$@"
  fi
}

wip() {
  git commit -am "[WIP] $1"
}

grh() {
  git fetch
  if [ $# -eq 0 ]; then
    branch=`git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)`
  else
    branch="$1"
  fi
  git reset --hard $branch
}

gri() {
  if [ $# -eq 0 ]; then
    args="origin/master"
  else
    args="$@"
  fi
  run gitg & run git rebase -i $args
}

gbmr() {
  if [ $# -eq 0 ]; then number=5; else number="$1"; fi
  git for-each-ref --sort=committerdate refs/heads/ \
    --format='%(committerdate:iso8601)%09 %(committerdate:relative)%09 %(refname)' \
    | sed 's/refs\/heads\///g' \
    | tail -n $number
}

gbmrr() {
  for branch in `git branch -r | grep -v HEAD`; do
    echo -e `git show --format="%ci       %cr" $branch | head -n 1` \\t$branch
  done | sort -r
}

gint() {
  if [ $# -eq 0 ]; then
    current_branch=`gsw -c`
    branch="${current_branch/djp/int}"
  else
    branch="$1"
  fi
  echo "git rebase -i $branch"
  gri $branch
  echo "git branch -f $branch"
  git branch -f $branch
  echo "Push integration branch '$branch'? (y/n)"
  read answer
  if [ $answer == "y" ]; then
    echo "git push origin $branch"
    git push origin $branch
  fi
}

gbb() {
  args=("$@")
  branch=`gsw -c`
  suffix="$1"
  run git branch "${branch}_${suffix}" "${args[@]:1}"
}

dev_branch() {
  git checkout development
  git pull
  local branch_name="PT$1-$2"
  echo "Switching to new branch off development: $branch_name"
  git checkout -b $branch_name
}
