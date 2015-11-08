tms() {
  for file in `_tmux_session_files`
  do
    if [ "$1" = `basename $file` ]; then
      run _start_tmux_session_from_file $file
      return
    fi
  done
  echo "'$1' tmux session not found"
  unset file
}

_start_tmux_session_from_file() {
  local session=`basename $1`
  tmux has-session -t $session &> /dev/null

  if [ $? != 0 ]; then
    . $1
  fi

  tmux attach -t $session
}

_tms_completion() {
  _complete_from `_tmux_sessions`
}

complete -F _tms_completion "tms"

_tmux_sessions() {
  for session in `_tmux_session_files` ; do
    basename $session
  done
  unset session
}

_tmux_session_files() {
  find $DOTFILES_HOME -path '*/tmux/sessions/*'
}
