_dotfiles_mode_completion() {
  _complete_from ${DOTFILES_MODES[@]}
}

complete -F _dotfiles_mode_completion "dotfiles_mode"
