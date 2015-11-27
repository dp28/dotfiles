pf() {
  ps aux | grep "$@" | grep -v "grep"
}

pfp() {
   ps ax | grep "$@" | grep -v "grep"  | grep -Po '^\s*\d+\s'
}
