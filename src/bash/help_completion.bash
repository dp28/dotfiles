_dotfiles_help_completion() {
  _complete_from `dotfiles_commands`
}

complete -F _dotfiles_help_completion "dotfiles_help"
